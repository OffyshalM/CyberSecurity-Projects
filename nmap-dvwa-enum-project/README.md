# Nmap DVWA Enumeration

## 📌 Overview
This is part of my Cyber Security Projects.  
I used **Nmap** and **NSE scripts** to enumerate services running on DVWA (Damn Vulnerable Web Application) hosted locally in my lab.  
The goal was to practice ethical scanning, service enumeration, and reporting.

## 🔍 Tools Used
- Kali Linux
- Nmap + NSE scripts
- DVWA (local target)

## ⚙️ Scope
- Host: 127.0.0.1 (localhost)
- Services scanned: HTTP, FTP, SSH, NetBIOS-SSN, MySQL

## 🚀 Key Findings
- **HTTP (80/tcp):** Apache 2.4.62 (Debian); headers + methods exposed  
- **FTP (21/tcp):** Anonymous login allowed (vsftpd 3.0.3); plaintext data  
- **SSH (22/tcp):** Open; risk of brute force  
- **NetBIOS-SSN (139/tcp):** SMB stack present  
- **MySQL (3306/tcp):** MariaDB; weak creds (lab only); databases: dvwa, information_schema  

## 📂 Repository Structure
nmap-dvwa-enum/
├─ README.md 
├─ REPORT.md 
├─ scans/ 
├─ evidence/ 
├─ .gitignore
└─ LICENSE


## Highlights

* HTTP: Apache 2.4.62 (Debian), headers and methods exposed
* FTP: Anonymous login allowed; vsftpd 3.0.3; plaintext data
* MySQL: MariaDB; mysql\_native\_password; weak creds in lab; dvwa & information\_schema

## Evidence

See `evidence/` for screenshots and `scans/` for text outputs.

## Legal

Lab only. Do not replicate on systems you do not own.

````
