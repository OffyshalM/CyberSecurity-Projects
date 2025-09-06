#!/bin/bash
# Run all scans against DVWA (localhost)

TARGET="127.0.0.1"
OUTDIR="scans"
mkdir -p $OUTDIR

# Service discovery
nmap -sV -O $TARGET -oN $OUTDIR/01-services.txt

# FTP
nmap -p 21 --script ftp-anon,ftp-syst $TARGET -oN $OUTDIR/02-ftp.txt

# HTTP
nmap -p 80 --script http-title,http-headers,http-methods $TARGET -oN $OUTDIR/03-http.txt

# MySQL
nmap -p 3306 --script mysql-info,mysql-brute $TARGET -oN $OUTDIR/04-mysql.txt
