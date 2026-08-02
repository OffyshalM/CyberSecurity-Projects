# Offy Digital Vault: Penetration Testing Report

## Overview

Offy Digital Vault is a full stack banking web application that I designed and built myself, then went back and penetration tested from start to finish. The idea was simple. Build something realistic, then attack it the way a real tester would, and document everything honestly, including what worked and what did not.

The app was built with React and Tailwind CSS on the frontend, Java Spring Boot on the backend, and MySQL for the database. It has two separate portals, a user dashboard for balances and transfers, and an admin dashboard for oversight. Everything was tested locally, using a Kali Linux VM and the Windows machine running the app on the same private network. Nothing was exposed publicly at any point.

## Methodology

I followed the standard penetration testing flow from start to finish.

1. Reconnaissance
2. Enumeration
3. Exploitation
4. Post Exploitation
5. Reporting

Every finding was confirmed manually first, using curl or the browser directly, before I automated anything with a tool. That way I could be confident the results were real and not false positives.

## Tools Used

* Nmap, for scanning open ports and identifying running services
* Nikto, for checking the web server configuration and missing security headers
* Burp Suite, for intercepting traffic, mapping the API, and tampering with requests
* SQLmap, for confirming and automating SQL injection
* Hydra and a custom Python script, for testing login brute force protection
* A custom Python fuzzer, for discovering hidden API endpoints

## Key Findings

### 1. Insecure Direct Object Reference (IDOR)

The account endpoint did not check whether the logged in user actually owned the account they were requesting. By simply changing the account ID in a Burp Suite request, I was able to view another user's balance and account details using my own session.

### 2. Mass Data Exposure

The users endpoint returned every user in the system to any authenticated caller, regardless of role. This included usernames, account numbers, balances, and passwords stored in plain text.

### 3. SQL Injection

The user search endpoint built its database query by directly joining the search input into the SQL string, with no sanitization. A simple boolean bypass payload was enough to pull the entire users table in one request. SQLmap was used afterward to confirm and automate the extraction.

### 4. Plaintext Password Storage

Passwords in the database were stored as plain text, with no hashing or salting at all. Combined with the SQL injection finding, this meant every account's real password was exposed the moment the data was read.

### 5. No Brute Force Protection

The login endpoint accepted unlimited login attempts with no lockout or rate limiting. I initially tried Hydra, but its http post form module struggled with the JSON body this endpoint expects, so I wrote a small Python script instead, which successfully recovered a valid password from a wordlist.

## Impact

Taken together, these issues meant an attacker could read any user's balance, pull the entire user database including plain text passwords, and brute force logins with no resistance from the application at all. For a banking style application, this represents a complete compromise of user data and account security.

## Remediation Recommendations

* Enforce ownership and role checks on every endpoint that returns account or user data
* Use parameterized queries everywhere, never build SQL strings through direct concatenation
* Store passwords using a proper hashing algorithm such as bcrypt or Argon2id, with unique salts
* Add rate limiting and account lockout to the login endpoint
* Apply standard security headers across the application

## Final Thoughts

This project let me practice both sides of the same coin, building a real application the right way, then testing it the way an attacker actually would. Every vulnerability listed here was confirmed and reproduced personally, and the full detailed writeup with evidence and screenshots is available in the accompanying penetration testing report.
