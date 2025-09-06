# DVWA Enumeration with Nmap + Wireshark

This repository contains my second cybersecurity lab project.  
I used **Nmap NSE scripts** together with **Wireshark** to enumerate services running on **DVWA (Damn Vulnerable Web Application)** hosted locally on `127.0.0.1`.  

## 🔎 Services Discovered
- FTP (21/tcp)
- SSH (22/tcp)
- HTTP (80/tcp)
- NetBIOS-SSN (139/tcp)
- MySQL (3306/tcp)

## 🛠 Tools Used
- **Nmap** (service discovery, NSE enumeration, brute force)
- **Wireshark** (packet capture, traffic analysis)

## 📂 Project Structure
dvwa-nmap-wireshark/
├─ README.md
├─ REPORT.md
├─ scans/ # raw Nmap outputs
├─ evidence/ # screenshots, Wireshark captures
├─ scripts/
│ └─ run-all.sh
├─ .gitignore
└─ LICENSE

## ⚠️ Legal
All scans and captures were done **only on my own DVWA lab environment**.  
Do not run these scans against systems you don’t own or without written permission.
