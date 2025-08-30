# Nmap DVWA Enumeration – Project Report

**Author:** Okunrobo Moses Emmanuel
**Date:** 29 Aug 2025
**Lab Target:** DVWA hosted locally
**Scanner:** Nmap + NSE scripts

---

## 1) Executive Summary

This project demonstrates structured service discovery and enumeration of a deliberately vulnerable web application (DVWA) using Nmap and key NSE scripts. I focused on HTTP, FTP, and MySQL, performed banner grabbing, and validated common misconfigurations (e.g., anonymous FTP, informative HTTP headers, weak MySQL credentials). All testing was conducted in a lawful, controlled lab on **localhost (127.0.0.1)**.

**Key Findings (high level):**

* **HTTP (80/tcp):** Apache **2.4.62 (Debian)** disclosed via headers; typical methods enabled (GET, POST, OPTIONS). Response headers leak stack details.
* **FTP (21/tcp):** **Anonymous login allowed**; service is **vsftpd 3.0.3**; data connections in **plain text**; session timeout 300s.
* **SSH (22/tcp):** Open (banner grabbed during scan); used as a reference for host exposure.
* **NetBIOS-SSN (139/tcp):** Detected open; indicates SMB stack present on host/network segment.
* **MySQL (3306/tcp):** Reachable; **MariaDB**; authentication plugin **mysql\_native\_password**; weak credentials discovered by `mysql-brute`; databases include **dvwa** and **information\_schema**.

**Risk Themes:** Excessive service exposure, verbose banners, anonymous/weak auth, plaintext protocols.

---

## 2) Scope, Rules of Engagement & Lab Topology

* **Scope:** Single host running DVWA on **127.0.0.1**. Services enumerated: HTTP, FTP, SSH, NetBIOS-SSN, MySQL.
* **Permissions:** Personal lab only; *no* external/third‑party systems scanned.
* **Goal:** Demonstrate practical use of Nmap + NSE for identification of misconfigurations and articulate remediations.

**Environment Notes**

* Host OS identified by Nmap banner: *Unix/Linux* (`cpe:/o:linux:linux_kernel`).
* Web server: **Apache 2.4.62 (Debian)** (the original note said *12.4.62*; corrected to **2.4.62** which matches Apache’s version scheme).

---

## 3) Methodology

1. **Host Discovery & Port Scanning:** Version detection and banner grabbing.
2. **Service‑Specific Enumeration:** Targeted NSE scripts for HTTP, FTP, and MySQL.
3. **Validation:** Manual checks (headers, login behavior) and review of NSE output.
4. **Risk Mapping:** Link each finding to likely impact and remediation.

**Representative Commands** *(run against localhost / lab IP)*

```bash
# Wide discovery + versions
nmap -sV -O 127.0.0.1

# Banner grabbing (common ports)
nmap -sV --script banner -p 21,22,80,139,3306 127.0.0.1

# HTTP enumeration
nmap -p 80 --script http-title,http-headers,http-methods,http-enum 127.0.0.1

# FTP anonymous & system info
nmap -p 21 --script ftp-anon,ftp-syst 127.0.0.1

# MySQL information and brute (lab only)
nmap -p 3306 --script mysql-info 127.0.0.1
nmap -p 3306 --script mysql-brute 127.0.0.1

# If credentials available (example)
nmap -p 3306 --script mysql-databases \
  --script-args "mysqluser=admin,mysqlpass=password" 127.0.0.1
```

---

## 4) Detailed Findings

### 4.1 HTTP (80/tcp)

* **Server:** Apache **2.4.62 (Debian)**
* **Observed Methods:** **GET, POST, OPTIONS** *(original note listed “END”; likely meant **HEAD**; common enabled set is GET/POST/HEAD/OPTIONS)*
* **Headers (highlights):**

  * `Date: <server date>`
  * `Last-Modified: <timestamp>`
  * `Accept-Ranges: bytes` *(corrected from “Acceptance-ranges”)*
  * `Vary: Accept-Encoding`
  * `Connection: close`
  * `Content-Type: text/html`

**Risk:**

* Version disclosure aids targeted exploits.
* Methods like `OPTIONS` may reveal unusual verbs if enabled.
* Verbose headers leak stack details (frameworks, caching behavior).

**Recommendations:**

* In Apache, set minimal server tokens:

  ```
  ServerTokens Prod
  ServerSignature Off
  ```
* Review and limit HTTP methods to the minimum required (typically GET/POST, and HEAD implicitly).
* Consider a WAF or reverse proxy to normalize headers.
* Keep Apache and PHP fully patched.

---

### 4.2 FTP (21/tcp)

* **Anonymous login:** **Allowed** (`ftp-anon`)
* **Service:** **vsftpd 3.0.3** — *“secure, fast, stable”*
* **Session details (ftp-syst):**

  * Connected to: `ffff:127.0.0.1` *(IPv6‑mapped localhost form)*
  * Logged in as: `ftp` (anonymous)
  * Session timeout: **300** seconds
  * **No session bandwidth limit**
  * Data connections: **plain text**
  * Client count: **1**
  * Platform: **Unix**

**Risk:**

* Anonymous FTP exposes directory listings and files to anyone on the network.
* Plaintext credentials and data are easily intercepted on untrusted networks.

**Recommendations:**

* **Disable anonymous** access unless strictly needed:

  ```
  anonymous_enable=NO
  ```
* Prefer **SFTP (over SSH)** or **FTPS** if file transfer must cross untrusted networks.
* If FTP must remain, enforce read‑only, restrict to specific directories (chroot), and use firewall to limit source IPs.

---

### 4.3 SSH (22/tcp)

* **State:** Open (banner grabbed).
* **Risk:** Exposed administrative interface; targets frequent brute‑force attempts.

**Recommendations:**

* Disable password login; use **SSH keys** only.
* Change default port **only** as a low‑value noise reduction (security comes from keys, not obscurity).
* Add **Fail2Ban** / rate‑limiting; restrict by IP where possible.

---

### 4.4 NetBIOS‑SSN (139/tcp)

* **State:** Open.
* **Implication:** SMB/NetBIOS stack present (file/printer sharing). On Linux, may indicate Samba configuration.

**Recommendations:**

* If not needed, **stop/disable SMB** and close associated ports (139/445).
* If required for lab only, firewall to localhost or lab subnet.

---

### 4.5 MySQL / MariaDB (3306/tcp)

* **Version:** MariaDB (exact minor not captured in note)
* **Protocol:** **10**
* **Thread ID:** **32**
* **Capabilities flag:** **65534**
* **Status:** **Auto‑commit**
* **Auth plugin:** **mysql\_native\_password** *(corrected from “mysql\_natove\_password”)*
* **Databases discovered (with creds/brute):** **dvwa**, **information\_schema**
* **Brute‑force run:** \~**45,014** guesses in **91** seconds ⇒ weak or default credentials were present for the lab.

**Risk:**

* Exposed database service allows credential guessing and metadata enumeration.
* `mysql_native_password` is widely supported but susceptible to offline cracking if hashes leak; weak passwords greatly increase risk.

**Recommendations:**

* Bind MySQL to **127.0.0.1** unless remote connections are required:

  ```ini
  bind-address = 127.0.0.1
  ```
* Create **least‑privilege** accounts scoped to specific databases/hosts; **disable remote root**.
* Enforce **strong passwords**; consider shorter lockout windows and monitoring.
* Restrict **firewall** to trusted IPs if remote access is necessary.
* Keep MariaDB updated. Consider switching to stronger auth where supported.

---

## 5) Risk Rating & Recommendations Summary

| Service     | Risk   | Why it matters                                         | Top Fixes                                                           |
| ----------- | ------ | ------------------------------------------------------ | ------------------------------------------------------------------- |
| HTTP        | Medium | Version & method disclosure encourage targeted attacks | Hide banners, limit methods, patch regularly                        |
| FTP         | High   | Anonymous + plaintext → data exposure/abuse            | Disable anonymous, move to SFTP/FTPS, segment network               |
| SSH         | Medium | Common brute target                                    | Keys‑only auth, Fail2Ban, IP restrict                               |
| NetBIOS‑SSN | Medium | Unnecessary exposure of SMB                            | Disable if unneeded; firewall scope                                 |
| MySQL       | High   | Weak creds + remote exposure                           | Bind to localhost, strong creds, least privilege, firewall restrict |

---

## 6) Evidence Pack (Screenshots & Outputs)


| ID | File                          | Description                                                          |
| -- | ----------------------------- | -------------------------------------------------------------------- |
| E1 | `evidence/http-headers.png`   | `http-headers` NSE output with Apache 2.4.62 and headers             |
| E2 | `evidence/http-methods.png`   | `http-methods` output showing GET/POST/OPTIONS (and HEAD if present) |
| E3 | `evidence/ftp-anon.png`       | `ftp-anon` showing anonymous login allowed                           |
| E4 | `evidence/ftp-syst.png`       | `ftp-syst` output (timeout, plaintext data, vsftpd 3.0.3)            |
| E5 | `evidence/mysql-info.png`     | `mysql-info` protocol 10, mysql\_native\_password, MariaDB           |
| E6 | `evidence/mysql-brute.png`    | `mysql-brute` summary (45014 guesses/91s; redacted creds)            |
| E7 | `evidence/ports-overview.png` | `nmap -sV -O` overview (21,22,80,139,3306 open)                      |

*(Redact any actual usernames/passwords before publishing.)*

---

## 7) Commands Use

```bash
# 1) Host discovery & services
nmap -sV -O 127.0.0.1 -oN scans/01-services.txt

# 2) Banner grabbing
nmap -sV --script banner -p 21,22,80,139,3306 127.0.0.1 -oN scans/02-banners.txt

# 3) HTTP details
nmap -p 80 --script http-title,http-headers,http-methods,http-enum \
  127.0.0.1 -oN scans/03-http.txt

# 4) FTP checks
nmap -p 21 --script ftp-anon,ftp-syst 127.0.0.1 -oN scans/04-ftp.txt

# 5) MySQL info & brute (lab only)
nmap -p 3306 --script mysql-info 127.0.0.1 -oN scans/05-mysql-info.txt
nmap -p 3306 --script mysql-brute 127.0.0.1 -oN scans/06-mysql-brute.txt

# 6) If creds available, enumerate DBs
nmap -p 3306 --script mysql-databases \
  --script-args "mysqluser=admin,mysqlpass=password" \
  127.0.0.1 -oN scans/07-mysql-databases.txt
```

---

## 8) Ethical & Legal Notes

* All scans performed against **my own lab (DVWA)** on **localhost**.
* Never run brute‑force or aggressive NSE scripts against systems without explicit permission.
* When publishing, **redact credentials and sensitive hostnames/IPs**.

---



## A) Suggested Repository Structure


**`.gitignore` (example):**

```
# ignore accidental secrets/dumps
*.pcap
*.sql
*.zip
*.gz
*.7z
secrets.txt
.env

# OS/editor noise
.DS_Store
Thumbs.db
*.swp
```

**`LICENSE`:** MIT is fine for a student project, or choose CC BY‑SA if you prefer.

---
