# Nmap + Wireshark Enumeration of DVWA

**Author:** Okunrobo Moses Emmanuel  
**Date:** Sept 2025  
**Lab Target:** DVWA (127.0.0.1)  
**Tools:** Nmap + NSE scripts, Wireshark  

---

## 1) Executive Summary
This project combined **Nmap enumeration** with **Wireshark packet analysis**.  
The goal was to simulate how attackers identify misconfigurations (FTP anonymous login, verbose HTTP headers, weak MySQL credentials) and then analyze the traffic on the wire.  
All activity was carried out on my **personal DVWA lab**, making it fully ethical and legal.


## 2) Methodology
1. **Service Scan** – `nmap -sV -O 127.0.0.1`  
   → Found FTP, SSH, HTTP, NetBIOS, MySQL open. OS fingerprint: Unix/Linux, CPE Linux kernel.  

2. **FTP Enumeration** – `ftp-anon`, 
   - NSE script showed **anonymous login allowed**.  
   - Wireshark confirmed login handshake:  
     - `220` Service ready  
     - `USER anonymous` → `331 Please specify password`  
     - `PASS IEUser!` → `230 Login successful`  
     - `227 Entering passive mode`  
     - `150 Here comes the directory` → `226 Directory send OK`  
     - `QUIT` → `221 Goodbye`  
   - I manually logged in with `ftp 127.0.0.1` and confirmed login.  
   - Attempting `ls` showed "Permission denied".  

   **Risk:** Anonymous login exposes files to anyone.  
   **Fix:** Disable `anonymous_enable` in vsftpd or restrict to read-only sandbox.  

3. **HTTP Enumeration**  
   - Scripts run: `http-title`, `http-headers`, `http-methods`  
   - Title: *Apache2 Debian Default Page: It Works*  
   - Headers included `Date`, `Last-Modified`, `Accept-Ranges: bytes`, `Vary: Accept-Encoding`, `Connection: close`, `Content-Type: text/html`  
   - Methods: `GET, POST, HEAD, OPTIONS`  
   - Issue: `http-enum` script crashed (`lua_state assertion failed`).  
   - Issue: `http-brute` did not work on `/login.php` with localhost expression.  

   **Risk:** Verbose headers and unnecessary methods leak information.  
   **Fix:** Harden Apache (`ServerTokens Prod`, `ServerSignature Off`). Limit methods.  

4. **MySQL Enumeration**  
   - Script: `mysql-info` →  
     - Protocol: 10  
     - Thread ID: 33  
     - Capabilities: 65534  
     - Status: AutoCommit  
     - Auth plugin: `mysql_native_password`  
   - Script: `mysql-brute` → found **weak creds**: `admin:password` in ~45k guesses / 134s.  
   - Script: `mysql-query` gave no useful result.  
   - Wireshark: Captured a packet (ICMPv6 Router Solicitation), unrelated to DB traffic.  

   **Risk:** Weak MySQL credentials allow full DB access.  
   **Fix:** Strong passwords, bind MySQL to `127.0.0.1`, disable remote root.  


## 3) Findings Summary
| Service  | Finding                  | Risk   | Fix |
|----------|--------------------------|--------|-----|
| FTP      | Anonymous login allowed  | High   | Disable anonymous, use SFTP |
| HTTP     | Verbose headers & methods| Medium | Hide version, limit methods |
| SSH      | Open but not tested      | Medium | Keys only, restrict IPs |
| MySQL    | Weak admin credentials   | High   | Strong creds, localhost only |
| NetBIOS  | Open (unused)            | Medium | Close if not required |


## 4) Wireshark Insights
- **FTP:** confirmed anonymous login, cleartext credentials (`USER anonymous / PASS IEUser!`) visible.  
- **HTTP:** headers visible in plaintext.  
- **MySQL:** not much captured, but in real cases, credentials and queries can leak if not encrypted.  


## 5) Conclusion
This project shows how **Nmap scripts + Wireshark** provide a full picture:  
- **Nmap** reveals services, banners, weak configs.  
- **Wireshark** shows how those configs expose sensitive data on the wire.  

Together, they demonstrate why even lab services like FTP and MySQL must be secured.  
