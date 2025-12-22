# 📦 UiTM Mobile SecOps Challenge - Tryple Team
<div align="justify">
This mobile prototype was developed as a requirement for the UiTM Mobile SecOps 21 Days Challenge. A secure, intelligent application was built by blending front-end usability with back-end integrity based on the Rentverse architecture. Real-world DevSecOps environments were simulated to demonstrate secure software engineering across the full stack. <br/>
</div>
<br/>
<div align="justify">
The system was designed to foster a DevSecOps mindset, with a specific focus on Mobile Defense and Intelligence. Advanced security mechanisms, including JWT-based authentication and role-based access control, were integrated to ensure data protection and session integrity. Additionally, a rule-based Threat Intelligence System was incorporated to detect unusual access patterns and mitigate potential intrusion attempts.<br/>
</div>


## 📌 Quick Metadata

| <p align="center">Category</p> | <p align="center">Details</p> |
| :--- | :--- |
| **Organizer** | UiTM Cawangan Perak, Kampus Tapah |
| **Industry Partner** | Metairflow R&D Sdn.Bhd. |
| **Theme** | "Mobile Defense and Intelligence: Build Fast, Defend Smarter" |


## 👥 Our group members:

| <p align="center">Student ID</p> | <p align="center">Name</p> |
| :--- | :--- |
| 2024779559 | Khaleeda binti Mohamad Zoher |
| 2024916815 | Siti Aisyah binti Idris |
| 2024905789 | Nur Arief Danial bin Zorkarnain |


## 🐞 Members' Tasks

| <p align="center">Member</p> | <p align="center">Tasks</p> |
| :--- | :--- |
| **Aisyah** | **Flutter Integration Lead**: Login and MFA implementation, tenant property browsing, rent flow development, and API integration. |
| **Arief** | **Owner Features**: Property upload and editing, listing management, role-based access control, and secure backend API development. |
| **Khaleeda** | **Admin & Alerts**: Anomaly detection, system logs, activity dashboards, AI-based monitoring, and payment flow integration.  |


## 🧪 Project Overview
<div align="justify">
A secure mobile prototype was developed for the UiTM Mobile SecOps 21 Days Challenge. DevSecOps principles were integrated into the Rentverse architecture to simulate real-world defensive environments. Front-end usability, back-end integrity, and AI-driven defense mechanisms were blended to create a resilient system. <br/>
</div>


## 🔑 Core Modules Implemented

<div align="center">


| <p align="center">Module</p> | <p align="center">Description</p> | 
| :--- | :--- | 
| **1. Secure Login & MFA** | <br/>MFA/OTP-based login was created with role-based access control | Access was restricted to verified identities during critical actions.<br/> | 
| **2. Secure API Gateway** | <br/>HTTPS, JWT tokens, and access validation were applied. | Secure communication was maintained according to OWASP M1-M3 and M5-M6.<br/> | 
| **3. Digital Agreement** | <br/>The Rentverse module was reused with added secure signature validation. | Data integrity and workflow validation were enforced through access permissions.<br/> | 
| **4. Smart Notification** | <br/>A system for alerts and notifications was implemented for critical events | Real-time visibility was provided for system security alerts.<br/> | 
| **5. Activity Log Dashboard** | <br/>User activities were logged to detect suspicious patterns and failed logins. | Threat visualization and incident detection were enabled for admin accountability.<br/> | 
| **6. CI/CD Security Testing** | <br/>GitHub Actions were integrated for automated static code analysis (SAST). | Vulnerability scans were conducted prior to each deployment.<br/> | 

</div>

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

## 📩 How To Use Instructions 

### 1. Initial Setup: Environment & VS Code 
Since the project is provided as a zip file, it must be extracted and configured correctly 
within your IDE. 
* **Extract the Zip File**: Extract the uitm-devops-challenge_tryple.zip to a dedicated 
folder on your desktop. 
* **Open in VS Code**: - Launch **VS Code**. - Go to File > Open Folder... and select the extracted project folder. 
* **Install Required Extensions**: - Open the **Extensions** view (Ctrl+Shift+X) and install the following: 
- **Flutter** (This also installs **Dart**). - **ESLint** (for backend code quality). - **Prisma** (for database schema viewing). 
### 2. Backend & Database Setup 
The backend must be running for the mobile app to communicate with the database. 
* **Install Node.js Dependencies**: - Open the integrated terminal in VS Code. - Navigate to the backend directory: ***cd rentverse-backend-main***. - Run ***npm install*** to download all necessary packages. 
* **Configure Database**: - Open the ***.env*** file in the backend folder. - Ensure your DATABASE_URL matches your local PostgreSQL credentials (e.g., 
postgresql://postgres:password@localhost:5432/rentverse_db). 
* **Sync Schema & Seed Data**: 
- Run ***npx prisma migrate dev*** to create the tables. - Run ***pnpm db:seed*** (or ***node prisma/seed.js***) to populate the database with 
the Admin, Owner, and Tenant test accounts. 
* **Start Backend**: - Run ***npm start*** or ***npm run dev***. - The terminal should display:         
Server running at http://0.0.0.0:3000. 
### 3. Mobile App Setup (Android Emulator) 
The mobile app requires **Android Studio** to provide the emulator environment. 
* **Configure Android Studio**: - Launch **Android Studio** and open the Virtual Device Manager. - Create a new virtual device (e.g., Pixel 6) and click **Run** to launch the emulator. 
* **Install Flutter Dependencies**: - In the VS Code terminal, navigate to the frontend directory: cd rentverse-mobile. 
- Run flutter pub get to fetch app packages. 
* **Run the Mobile App**: - Ensure the emulator is detected in the bottom-right corner of VS Code. - Press **F5** or run flutter run in the terminal. 
* **4. How to Use the App (Role-Based Testing)** 
Once the app is running on the emulator, test the following pages using the credentials 
seeded earlier: 
**A. Tenant Role (Primary User)** - **Login**: Enter tenant credentials and verify the **MFA/OTP** screen. - **Function**: Browse the property list, view details (price, location), and submit a rental 
request. - **Action**: Sign the **Digital Rental Agreement** on the mobile screen to test data 
integrity. 
**B. Owner Role (Property Manager)** - **Login**: Re-login using owner credentials. 
- **Function**: Navigate to the "Manage Listings" page. - **Action**: Use the Upload Property feature to add a new house listing with images and 
descriptions. 
**C. Admin Role (Security & Monitoring)** - **Login**: Login as an admin to access restricted security features. - **Function**: View the Activity Log Dashboard to see recent login attempts. - **Security Check**: Intentionally fail a login attempt 5 times. Access the **Anomaly 
Alert** screen to see if the **AI-based monitoring** flags the suspicious behavior.


