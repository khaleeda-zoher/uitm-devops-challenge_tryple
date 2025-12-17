# 📦 UiTM Mobile SecOps Challenge - Tryple Team

Our group members:
1. Khaleeda binti Mohamad Zoher 
2. Siti Aisyah binti Idris
3. Nur Arief Danial bin Zorkarnain

# 🧪 Project Overview

A secure mobile prototype was developed for the UiTM Mobile SecOps 21 Days Challenge. DevSecOps principles were integrated into the Rentverse architecture 
to simulate real-world defensive environments. Front-end usability, back-end integrity, and AI-driven defense mechanisms were blended to create a resilient system.

# 🔑 Core Modules Implemented

🔗 Secure Authentication: MFA logins were implemented with role-based access control. 

🔗 Secure API Gateway: Communication was secured using HTTPS and JWT tokens.

🔗 Digital Agreement: A mobile module for digital signatures was created with workflow validation.

🔗 DevSecOps Monitoring: Real-time logging of user activities and failed login attempts was established for threat visualization.

# 🛠️ Security Feature

🔗 Threat Intelligence System

A lightweight, rule-based intelligence module was developed to identify and mitigate potential security threats.

> Anomaly Detection: Unusual access patterns and repeated failed login attempts are actively detected by the backend system.

> Incident Identification: Suspicious usage patterns are identified to prevent unauthorized access or brute-force intrusion attempts.

> Real-Time Monitoring: All failed authentication events are logged to ensure system accountability and threat visualization.

> Automated Alerting: Suspicious activities are flagged within the system to provide visibility into potential security risks.

# 📲 Implementation Details (Technical Explanation)

The following logic was implemented within the Node.js and Prisma environment:

🔗 Log Capture: Every failed login attempt is recorded in the database with a timestamp and the associated user email or phone number.

🔗 Threshold Enforcement: A rule-based threshold is applied; if a specific number of failed attempts is reached within a defined window, the activity is flagged as a potential threat.

# 🌐 Technical Stack

🔗 Frontend: Flutter (Mobile Prototype).

🔗 Backend: Node.js with Prisma ORM and PostgreSQL database.

🔗 Database: pgAdmin was used for database management and table visualization.

🔗 Security: JWT, Bcrypt hashing, and MFA/OTP verification.

