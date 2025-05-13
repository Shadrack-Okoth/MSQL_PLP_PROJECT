-- Create the main database
CREATE DATABASE clinic_booking_system;

-- Use the created database
USE clinic_booking_system;
-- ============================
-- Clinic Booking System Schema
-- ============================

-- ============================
-- Table: Specializations
-- ============================
-- Stores medical specialties (e.g., Cardiologist, Dentist)
CREATE TABLE Specializations (
    specialization_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE
);

-- ============================
-- Table: Doctors
-- ============================
-- Stores information about doctors
CREATE TABLE Doctors (
    doctor_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    phone VARCHAR(20),
    specialization_id INT,
    FOREIGN KEY (specialization_id) REFERENCES Specializations(specialization_id)
);

-- ============================
-- Table: Patients
-- ============================
-- Stores patient personal information
CREATE TABLE Patients (
    patient_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    date_of_birth DATE,
    email VARCHAR(100) NOT NULL UNIQUE,
    phone VARCHAR(20),
    gender ENUM('Male', 'Female', 'Other')
);

-- ============================
-- Table: Appointments
-- ============================
-- Stores appointment bookings between doctors and patients
CREATE TABLE Appointments (
    appointment_id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT NOT NULL,
    doctor_id INT NOT NULL,
    appointment_date DATETIME NOT NULL,
    reason TEXT,
    status ENUM('Scheduled', 'Completed', 'Cancelled') DEFAULT 'Scheduled',
    FOREIGN KEY (patient_id) REFERENCES Patients(patient_id),
    FOREIGN KEY (doctor_id) REFERENCES Doctors(doctor_id),
    UNIQUE (patient_id, doctor_id, appointment_date) -- Avoid duplicate bookings
);

-- ============================
-- Table: Prescriptions
-- ============================
-- Stores prescriptions given at appointments
CREATE TABLE Prescriptions (
    prescription_id INT AUTO_INCREMENT PRIMARY KEY,
    appointment_id INT NOT NULL UNIQUE, -- One prescription per appointment
    issued_date DATE NOT NULL,
    notes TEXT,
    FOREIGN KEY (appointment_id) REFERENCES Appointments(appointment_id)
);

-- ============================
-- Table: Medications
-- ============================
-- Stores information about medications
CREATE TABLE Medications (
    medication_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE,
    description TEXT
);

-- ============================
-- Table: Prescription_Medication
-- ============================
-- Many-to-Many relationship between Prescriptions and Medications
CREATE TABLE Prescription_Medication (
    prescription_id INT NOT NULL,
    medication_id INT NOT NULL,
    dosage VARCHAR(50) NOT NULL,
    frequency VARCHAR(50),
    PRIMARY KEY (prescription_id, medication_id),
    FOREIGN KEY (prescription_id) REFERENCES Prescriptions(prescription_id),
    FOREIGN KEY (medication_id) REFERENCES Medications(medication_id)
);
-- =======================================
-- SAMPLE DATA FOR CLINIC BOOKING SYSTEM
-- =======================================

-- Specializations (10)
INSERT INTO Specializations (name) VALUES
('Cardiology'),
('Pediatrics'),
('Dermatology'),
('Neurology'),
('Orthopedics'),
('Gynecology'),
('Urology'),
('Endocrinology'),
('Psychiatry'),
('General Medicine');

-- Doctors (10)
INSERT INTO Doctors (first_name, last_name, email, phone, specialization_id) VALUES
('Alice', 'Smith', 'alice.smith@clinic.com', '1234567890', 1),
('Bob', 'Jones', 'bob.jones@clinic.com', '0987654321', 2),
('Charlie', 'Brown', 'charlie.brown@clinic.com', '1112223333', 3),
('Diane', 'White', 'diane.white@clinic.com', '2223334444', 4),
('Edward', 'Black', 'edward.black@clinic.com', '3334445555', 5),
('Fiona', 'Green', 'fiona.green@clinic.com', '4445556666', 6),
('George', 'Adams', 'george.adams@clinic.com', '5556667777', 7),
('Hannah', 'Lee', 'hannah.lee@clinic.com', '6667778888', 8),
('Ian', 'Clark', 'ian.clark@clinic.com', '7778889999', 9),
('Julia', 'Wong', 'julia.wong@clinic.com', '8889990000', 10);

-- Patients (10)
INSERT INTO Patients (first_name, last_name, date_of_birth, email, phone, gender) VALUES
('John', 'Doe', '1990-01-15', 'john.doe@example.com', '5551230001', 'Male'),
('Jane', 'Miller', '1985-06-30', 'jane.miller@example.com', '5551230002', 'Female'),
('Mike', 'Davis', '2000-03-12', 'mike.davis@example.com', '5551230003', 'Male'),
('Emily', 'Wilson', '1992-09-22', 'emily.wilson@example.com', '5551230004', 'Female'),
('Chris', 'Taylor', '1988-12-10', 'chris.taylor@example.com', '5551230005', 'Male'),
('Sarah', 'Johnson', '1995-07-08', 'sarah.johnson@example.com', '5551230006', 'Female'),
('David', 'Moore', '1982-11-25', 'david.moore@example.com', '5551230007', 'Male'),
('Laura', 'Thomas', '1993-05-14', 'laura.thomas@example.com', '5551230008', 'Female'),
('Brian', 'Anderson', '1989-04-18', 'brian.anderson@example.com', '5551230009', 'Male'),
('Anna', 'Scott', '1991-08-20', 'anna.scott@example.com', '5551230010', 'Female');

-- Appointments (10)
INSERT INTO Appointments (patient_id, doctor_id, appointment_date, reason, status) VALUES
(1, 1, '2025-05-15 10:00:00', 'Heart pain and fatigue', 'Scheduled'),
(2, 2, '2025-05-16 11:30:00', 'Routine checkup', 'Scheduled'),
(3, 3, '2025-05-17 09:00:00', 'Skin rash', 'Scheduled'),
(4, 4, '2025-05-18 13:00:00', 'Headache and dizziness', 'Scheduled'),
(5, 5, '2025-05-19 14:00:00', 'Joint pain', 'Scheduled'),
(6, 6, '2025-05-20 10:30:00', 'Menstrual issues', 'Scheduled'),
(7, 7, '2025-05-21 15:00:00', 'Urinary infection', 'Scheduled'),
(8, 8, '2025-05-22 16:00:00', 'Thyroid check', 'Scheduled'),
(9, 9, '2025-05-23 11:00:00', 'Anxiety and stress', 'Scheduled'),
(10, 10, '2025-05-24 09:30:00', 'Fever and cough', 'Scheduled');

-- Prescriptions (10)
INSERT INTO Prescriptions (appointment_id, issued_date, notes) VALUES
(1, '2025-05-15', 'Monitor blood pressure daily'),
(2, '2025-05-16', 'Continue vitamin intake'),
(3, '2025-05-17', 'Apply ointment twice daily'),
(4, '2025-05-18', 'MRI scan recommended'),
(5, '2025-05-19', 'Physical therapy advised'),
(6, '2025-05-20', 'Ultrasound scheduled'),
(7, '2025-05-21', 'Take antibiotics for 5 days'),
(8, '2025-05-22', 'Start hormone treatment'),
(9, '2025-05-23', 'Counseling sessions weekly'),
(10, '2025-05-24', 'Paracetamol and rest');

-- Medications (10)
INSERT INTO Medications (name, description) VALUES
('Aspirin', 'Used to reduce pain and inflammation'),
('Multivitamins', 'General health supplement'),
('Hydrocortisone Cream', 'Topical steroid for inflammation'),
('Paracetamol', 'Fever reducer and pain reliever'),
('Antibiotic A', 'Generic broad-spectrum antibiotic'),
('Ibuprofen', 'NSAID pain relief'),
('Hormone Tablet', 'Used in hormone therapy'),
('Vitamin D', 'Bone and immune health'),
('Anti-anxiety Pill', 'Used for mild anxiety'),
('Cough Syrup', 'Used to relieve cough');

-- Prescription_Medication (10)
INSERT INTO Prescription_Medication (prescription_id, medication_id, dosage, frequency) VALUES
(1, 1, '100mg', 'Once daily'),
(2, 2, '1 tablet', 'Every morning'),
(3, 3, 'Apply thin layer', 'Twice daily'),
(4, 4, '500mg', 'Every 6 hours'),
(5, 5, '250mg', 'Twice a day'),
(6, 6, '400mg', 'After meals'),
(7, 5, '500mg', 'Three times daily'),
(8, 7, '1 tablet', 'Daily'),
(9, 9, '1 tablet', 'Night only'),
(10, 10, '10ml', 'Every 4 hours');
-- Test Queries 
-- All Appointments with Patient and Doctor Info
SELECT 
    a.appointment_id,
    p.first_name AS patient_first_name,
    p.last_name AS patient_last_name,
    d.first_name AS doctor_first_name,
    d.last_name AS doctor_last_name,
    s.name AS specialization,
    a.appointment_date,
    a.reason,
    a.status
FROM Appointments a
JOIN Patients p ON a.patient_id = p.patient_id
JOIN Doctors d ON a.doctor_id = d.doctor_id
JOIN Specializations s ON d.specialization_id = s.specialization_id
ORDER BY a.appointment_date;
-- Medications Prescribed for Each Appointment
SELECT 
    a.appointment_id,
    p.first_name AS patient,
    d.first_name AS doctor,
    m.name AS medication,
    pm.dosage,
    pm.frequency
FROM Prescriptions pr
JOIN Appointments a ON pr.appointment_id = a.appointment_id
JOIN Patients p ON a.patient_id = p.patient_id
JOIN Doctors d ON a.doctor_id = d.doctor_id
JOIN Prescription_Medication pm ON pr.prescription_id = pm.prescription_id
JOIN Medications m ON pm.medication_id = m.medication_id;
-- Upcoming Appointments for a Specific Doctor
SELECT 
    a.appointment_id,
    a.appointment_date,
    p.first_name AS patient_first_name,
    p.last_name AS patient_last_name,
    a.reason
FROM Appointments a
JOIN Patients p ON a.patient_id = p.patient_id
WHERE a.doctor_id = 1 -- Replace with actual doctor_id
  AND a.appointment_date > NOW()
ORDER BY a.appointment_date;
-- Number of Appointments per Specialization
SELECT 
    s.name AS specialization,
    COUNT(*) AS total_appointments
FROM Appointments a
JOIN Doctors d ON a.doctor_id = d.doctor_id
JOIN Specializations s ON d.specialization_id = s.specialization_id
GROUP BY s.name
ORDER BY total_appointments DESC;
-- Patients Prescribed Antibiotics
SELECT DISTINCT
    p.first_name,
    p.last_name,
    m.name AS medication
FROM Prescription_Medication pm
JOIN Prescriptions pr ON pm.prescription_id = pr.prescription_id
JOIN Appointments a ON pr.appointment_id = a.appointment_id
JOIN Patients p ON a.patient_id = p.patient_id
JOIN Medications m ON pm.medication_id = m.medication_id
WHERE m.name LIKE '%Antibiotic%';





