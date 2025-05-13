# Clinic Booking System

## 📌 Project Title

**Clinic Booking System Using MySQL**

## 📄 Description

This project implements a full-featured relational database system for managing a clinic's daily operations. It covers essential components such as patient records, doctor schedules, appointments, prescriptions, and medication tracking. The database enforces data integrity through foreign keys and constraints, supports many-to-many relationships (e.g., prescriptions and medications), and prevents duplicate bookings.

## 🛠️ How to Run / Setup the Project

### Requirements:

* MySQL Server (v5.7+ recommended)
* MySQL Workbench or any MySQL-compatible GUI/CLI tool

### Setup Steps:

1. Clone this repository to your local machine.
2. Open MySQL Workbench or your preferred SQL tool.
3. Run the script in `sql/create_tables.sql` to create the database schema.
4. (Optional) Populate the tables with sample data for testing.
5. Run `sql/test_queries.sql` to execute and test pre-defined queries.

## 📁 Repository Contents

```
clinic-booking-system/
│
├── sql/
│   ├── create_tables.sql         # Contains all CREATE TABLE statements
│   └── test_queries.sql          # Contains SELECT queries to test the DB
│
├── README.md                     # This file
└── erd.png                       # Entity Relationship Diagram of the system
```

## 📸 ERD (Entity Relationship Diagram)

Please refer to `erd.png` in the repository for the complete database schema design.

## ✅ Features

* Patient and doctor management
* Specializations linked to doctors
* Appointment scheduling with conflict checks
* Prescriptions with support for multiple medications per visit
* Query-ready for analytics (e.g., appointments per doctor/specialization)

## 🙌 Author

* \[Shadrack Okoth] 

---


