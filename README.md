# 📦 UiTM Mobile SecOps Challenge - Tryple Team
<div align="justify">
This mobile prototype was developed as a requirement for the UiTM Mobile SecOps 21 Days Challenge. A secure, intelligent application was built by blending front-end usability with back-end integrity based on the Rentverse architecture. Real-world DevSecOps environments were simulated to demonstrate secure software engineering across the full stack. <br/>
</div>
<br/>
<div align="justify">
The system was designed to foster a DevSecOps mindset, with a specific focus on Mobile Defense and Intelligence. Advanced security mechanisms, including JWT-based authentication and role-based access control, were integrated to ensure data protection and session integrity. Additionally, a rule-based Threat Intelligence System was incorporated to detect unusual access patterns and mitigate potential intrusion attempts.<br/>
</div>


📌 Quick Metadata

Organizer: UiTM Cawangan Perak, Kampus Tapah. <br/>

Industry Partner: Metairflow R&D Sdn. Bhd. <br/>

Theme: "Mobile Defense and Intelligence: Build Fast, Defend Smarter". <br/>

👥 Our group members:

1. Khaleeda binti Mohamad Zoher <br/>

2. Siti Aisyah binti Idris <br/>

3. Nur Arief Danial bin Zorkarnain <br/>


🐞 Members' Tasks

| Member | Tasks |
| :--- | :--- |
| **Aisyah** | **Flutter Integration Lead**: Login and MFA implementation, tenant property browsing, rent flow development, and API integration. |
| **Arief** | **Owner Features**: Property upload and editing, listing management, role-based access control, and secure backend API development. |
| **Khaleeda** | **Admin & Alerts**: Anomaly detection, system logs, activity dashboards, AI-based monitoring, and payment flow integration. |


## 🧪 Project Overview
<div align="justify">
A secure mobile prototype was developed for the UiTM Mobile SecOps 21 Days Challenge. DevSecOps principles were integrated into the Rentverse architecture to simulate real-world defensive environments. Front-end usability, back-end integrity, and AI-driven defense mechanisms were blended to create a resilient system. <br/>
</div>


## 🔑 Core Modules Implemented

🔗 Secure Authentication: MFA logins were implemented with role-based access control. 

🔗 Secure API Gateway: Communication was secured using HTTPS and JWT tokens.

🔗 Digital Agreement: A mobile module for digital signatures was created with workflow validation.

🔗 DevSecOps Monitoring: Real-time logging of user activities and failed login attempts was established for threat visualization.

## 🛠️ Security Feature

🔗 Threat Intelligence System

A lightweight, rule-based intelligence module was developed to identify and mitigate potential security threats.

* Anomaly Detection: Unusual access patterns and repeated failed login attempts are actively detected by the backend system.

* Incident Identification: Suspicious usage patterns are identified to prevent unauthorized access or brute-force intrusion attempts.

* Real-Time Monitoring: All failed authentication events are logged to ensure system accountability and threat visualization.

* Automated Alerting: Suspicious activities are flagged within the system to provide visibility into potential security risks.

## 📲 Implementation Details (Technical Explanation)

The following logic was implemented within the Node.js and Prisma environment:

🔗 Log Capture: Every failed login attempt is recorded in the database with a timestamp and the associated user email or phone number.

🔗 Threshold Enforcement: A rule-based threshold is applied; if a specific number of failed attempts is reached within <br/>

a defined window, the activity is flagged as a potential threat.

## 🌐 Technical Stack

🔗 Frontend: Flutter (Mobile Prototype).

🔗 Backend: Node.js with Prisma ORM and PostgreSQL database.

🔗 Database: pgAdmin was used for database management and table visualization.

🔗 Security: JWT, Bcrypt hashing, and MFA/OTP verification.



