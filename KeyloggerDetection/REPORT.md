# Project Report: Keylogger Detection & Threat Simulation Platform

## 1. Project Overview
The **Keylogger Detection & Threat Simulation Platform** is a full-stack security application designed to simulate, capture, and analyze malicious keylogging activities and process anomalies in real time. The platform provides security analysts and administrators with a centralized dashboard to monitor endpoint telemetry, evaluate threat severity through automated anomaly scoring, and investigate security alerts.

---

## 2. System Architecture & Components

* **Backend Engine:** Built using **Java Spring Boot** and Spring Data JPA to handle robust RESTful APIs, business logic, and database persistence.
* **Database Layer:** Uses a **MySQL** relational database to store detailed alert logs, device identifiers, timestamps, process names, and anomaly scores. Explicit column mapping (`@Column` annotations) ensures seamless data mapping between Hibernate entities and relational tables.
* **Frontend Dashboard:** Developed using **React**, **Vite**, and **Tailwind CSS** to deliver a fully mobile-responsive, modern user interface for real-time alert monitoring and event filtration.
* **Threat Simulation:** Integrates simulated telemetry scripts to generate event data mimicking unauthorized keystroke capturing and suspicious background processes.

---

## 3. Key Features

* **Real-Time Alert Logging:** Instantly ingests and records security events, tracking metrics such as device ID, timestamp, process name, event type, and raw forensic details.
* **Automated Anomaly Scoring:** Evaluates incoming endpoint telemetry and assigns numerical anomaly scores alongside severity ratings (`Low`, `Medium`, `High`, `Critical`).
* **Interactive Operator Dashboard:** Displays live feeds of security breaches, enabling rapid assessment and forensic review.
* **Configurable Network Services:** Supports customizable server ports (e.g., standard port `8080` or alternative configurations) to resolve deployment conflicts locally.

---

## 4. Technology Stack

* **Backend:** Java, Spring Boot, Spring Data JPA, Hibernate, Maven
* **Frontend:** JavaScript (ES6+), React, Tailwind CSS, Vite
* **Database & Management:** MySQL, phpMyAdmin, XAMPP
* **Development Tools:** Visual Studio Code, Git, GitHub, PowerShell

---

## 5. Conclusion & Next Steps
The Keylogger Detection & Threat Simulation Platform successfully demonstrates the integration of endpoint telemetry monitoring with automated severity scoring in a lightweight web application. Future development phases will incorporate machine learning-based heuristic analysis to detect zero-day keylogging variants and expand automated incident-response workflows.
