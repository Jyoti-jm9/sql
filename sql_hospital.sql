-- Creating the 'Department' table
CREATE TABLE Department (
    DepartmentID INT PRIMARY KEY AUTO_INCREMENT,
    DepartmentName VARCHAR(50) NOT NULL,
    Location VARCHAR(100)
);

-- Creating the 'Doctor' table
CREATE TABLE Doctor (
    DoctorID INT PRIMARY KEY AUTO_INCREMENT,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Specialty VARCHAR(50),
    PhoneNumber VARCHAR(15),
    Email VARCHAR(100),
    DepartmentID INT,
    FOREIGN KEY (DepartmentID) REFERENCES Department(DepartmentID)
);

-- Creating the 'Nurse' table
CREATE TABLE Nurse (
    NurseID INT PRIMARY KEY AUTO_INCREMENT,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    PhoneNumber VARCHAR(15),
    Email VARCHAR(100),
    DepartmentID INT,
    FOREIGN KEY (DepartmentID) REFERENCES Department(DepartmentID)
);

-- Creating the 'Patient' table
CREATE TABLE Patient (
    PatientID INT PRIMARY KEY AUTO_INCREMENT,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Gender ENUM('Male', 'Female', 'Other'),
    DateOfBirth DATE,
    PhoneNumber VARCHAR(15),
    Email VARCHAR(100),
    Address VARCHAR(255),
    EmergencyContact VARCHAR(15),
    InsuranceProvider VARCHAR(100)
);

-- Creating the 'Appointment' table
CREATE TABLE Appointment (
    AppointmentID INT PRIMARY KEY AUTO_INCREMENT,
    PatientID INT,
    DoctorID INT,
    AppointmentDate DATE,
    AppointmentTime TIME,
    Status ENUM('Scheduled', 'Completed', 'Cancelled'),
    FOREIGN KEY (PatientID) REFERENCES Patient(PatientID),
    FOREIGN KEY (DoctorID) REFERENCES Doctor(DoctorID)
);

-- Creating the 'Treatment' table
CREATE TABLE Treatment (
    TreatmentID INT PRIMARY KEY AUTO_INCREMENT,
    TreatmentName VARCHAR(100) NOT NULL,
    Description TEXT,
    Cost DECIMAL(10, 2)
);

-- Creating the 'PatientTreatment' table to link Patients with Treatments
CREATE TABLE PatientTreatment (
    PatientTreatmentID INT PRIMARY KEY AUTO_INCREMENT,
    PatientID INT,
    TreatmentID INT,
    DoctorID INT,
    TreatmentDate DATE,
    FOREIGN KEY (PatientID) REFERENCES Patient(PatientID),
    FOREIGN KEY (TreatmentID) REFERENCES Treatment(TreatmentID),
    FOREIGN KEY (DoctorID) REFERENCES Doctor(DoctorID)
);

-- Creating the 'Room' table
CREATE TABLE Room (
    RoomID INT PRIMARY KEY AUTO_INCREMENT,
    RoomNumber VARCHAR(10) NOT NULL,
    RoomType ENUM('General', 'Private', 'ICU'),
    Status ENUM('Available', 'Occupied', 'Maintenance')
);

-- Creating the 'PatientRoom' table to track which patients are in which rooms
CREATE TABLE PatientRoom (
    PatientRoomID INT PRIMARY KEY AUTO_INCREMENT,
    PatientID INT,
    RoomID INT,
    CheckInDate DATE,
    CheckOutDate DATE,
    FOREIGN KEY (PatientID) REFERENCES Patient(PatientID),
    FOREIGN KEY (RoomID) REFERENCES Room(RoomID)
);

-- Creating the 'Bill' table
CREATE TABLE Bill (
    BillID INT PRIMARY KEY AUTO_INCREMENT,
    PatientID INT,
    Amount DECIMAL(10, 2),
    BillingDate DATE,
    Status ENUM('Paid', 'Unpaid', 'Pending'),
    FOREIGN KEY (PatientID) REFERENCES Patient(PatientID)
);

-- Creating the 'BillDetails' table to detail each item in the bill
CREATE TABLE BillDetails (
    BillDetailsID INT PRIMARY KEY AUTO_INCREMENT,
    BillID INT,
    TreatmentID INT,
    Quantity INT,
    CostPerUnit DECIMAL(10, 2),
    TotalCost DECIMAL(10, 2),
    FOREIGN KEY (BillID) REFERENCES Bill(BillID),
    FOREIGN KEY (TreatmentID) REFERENCES Treatment(TreatmentID)
);

-- Inserting sample data into the 'Department' table
INSERT INTO Department (DepartmentName, Location) VALUES 
('Cardiology', 'Block A, Floor 2'),
('Neurology', 'Block B, Floor 3'),
('Orthopedics', 'Block C, Floor 1'),
('Pediatrics', 'Block D, Floor 2'),
('General Surgery', 'Block E, Floor 1');

-- Inserting sample data into the 'Doctor' table
INSERT INTO Doctor (FirstName, LastName, Specialty, PhoneNumber, Email, DepartmentID) VALUES
('John', 'Doe', 'Cardiology', '123-456-7890', 'john.doe@hospital.com', 1),
('Jane', 'Smith', 'Neurology', '234-567-8901', 'jane.smith@hospital.com', 2),
('Emily', 'Johnson', 'Orthopedics', '345-678-9012', 'emily.johnson@hospital.com', 3),
('Michael', 'Brown', 'Pediatrics', '456-789-0123', 'michael.brown@hospital.com', 4),
('Sarah', 'Davis', 'General Surgery', '567-890-1234', 'sarah.davis@hospital.com', 5);

-- Inserting sample data into the 'Nurse' table
INSERT INTO Nurse (FirstName, LastName, PhoneNumber, Email, DepartmentID) VALUES
('Alice', 'White', '678-901-2345', 'alice.white@hospital.com', 1),
('Bob', 'Miller', '789-012-3456', 'bob.miller@hospital.com', 2),
('Claire', 'Wilson', '890-123-4567', 'claire.wilson@hospital.com', 3),
('David', 'Moore', '901-234-5678', 'david.moore@hospital.com', 4),
('Eva', 'Taylor', '012-345-6789', 'eva.taylor@hospital.com', 5);

-- Inserting sample data into the 'Patient' table
INSERT INTO Patient (FirstName, LastName, Gender, DateOfBirth, PhoneNumber, Email, Address, EmergencyContact, InsuranceProvider) VALUES
('Tom', 'Harris', 'Male', '1990-05-15', '555-1234', 'tom.harris@patient.com', '123 Elm Street', '555-5678', 'MediCare'),
('Lucy', 'Williams', 'Female', '1985-08-22', '555-2345', 'lucy.williams@patient.com', '456 Oak Avenue', '555-6789', 'HealthFirst'),
('Jack', 'Jones', 'Male', '2001-11-30', '555-3456', 'jack.jones@patient.com', '789 Maple Road', '555-7890', 'WellCare');

-- Inserting sample data into the 'Appointment' table
INSERT INTO Appointment (PatientID, DoctorID, AppointmentDate, AppointmentTime, Status) VALUES
(1, 2, '2024-09-08', '10:30:00', 'Scheduled'),
(2, 3, '2024-09-09', '11:00:00', 'Scheduled'),
(3, 1, '2024-09-10', '14:00:00', 'Scheduled');

-- Inserting sample data into the 'Treatment' table
INSERT INTO Treatment (TreatmentName, Description, Cost) VALUES
('MRI Scan', 'Magnetic Resonance Imaging', 500.00),
('X-Ray', 'Radiographic Imaging', 100.00),
('Blood Test', 'Comprehensive Blood Analysis', 50.00),
('Surgery', 'General Surgery Procedure', 1500.00);

-- Inserting sample data into the 'PatientTreatment' table
INSERT INTO PatientTreatment (PatientID, TreatmentID, DoctorID, TreatmentDate) VALUES
(1, 2, 2, '2024-09-08'),
(2, 1, 3, '2024-09-09'),
(3, 4, 1, '2024-09-10');

-- Inserting sample data into the 'Room' table
INSERT INTO Room (RoomNumber, RoomType, Status) VALUES
('101', 'General', 'Available'),
('102', 'Private', 'Occupied'),
('201', 'ICU', 'Maintenance');

-- Inserting sample data into the 'PatientRoom' table
INSERT INTO PatientRoom (PatientID, RoomID, CheckInDate, CheckOutDate) VALUES
(1, 102, '2024-09-07', NULL),
(2, 101, '2024-09-08', '2024-09-10');

-- Inserting sample data into the 'Bill' table
INSERT INTO Bill (PatientID, Amount, BillingDate, Status) VALUES
(1, 550.00, '2024-09-08', 'Unpaid'),
(2, 1600.00, '2024-09-09', 'Paid');

-- Inserting sample data into the 'BillDetails' table
INSERT INTO BillDetails (BillID, TreatmentID, Quantity, CostPerUnit, TotalCost) VALUES
(1, 2, 1, 100.00, 100.00),
(1, 1, 1, 500.00, 500.00),
(2, 4, 1, 1500.00, 1500.00);

-- Creating views for quick access to key information
-- View for Doctor details with Department information
CREATE VIEW DoctorDetails AS
SELECT 
    Doctor.DoctorID,
    Doctor.FirstName,
    Doctor.LastName,
    Doctor.Specialty,
    Doctor.PhoneNumber,
    Doctor.Email,
    Department.DepartmentName
FROM 
    Doctor
JOIN 
    Department ON Doctor.DepartmentID = Department.DepartmentID;

-- View for Patient details with assigned rooms
CREATE VIEW PatientRoomDetails AS
SELECT 
    Patient.PatientID,
    Patient.FirstName,
    Patient.LastName,
    Room.RoomNumber,
    Room.RoomType,
    PatientRoom.CheckInDate,
    PatientRoom.CheckOutDate
FROM 
    Patient
JOIN 
    PatientRoom ON Patient.PatientID = PatientRoom.PatientID
JOIN 
    Room ON PatientRoom.RoomID = Room.RoomID;

-- View for billing details showing each item in the bill
CREATE VIEW BillSummary AS
SELECT 
    Bill.BillID,
    Patient.FirstName AS PatientFirstName,
    Patient.LastName AS PatientLastName,
    Bill.Amount AS TotalAmount,
    Bill.BillingDate,
    Bill.Status AS PaymentStatus,
    BillDetails.TreatmentID,
    Treatment.TreatmentName,
    BillDetails.Quantity,
    BillDetails.CostPerUnit,
    BillDetails.TotalCost
FROM 
    Bill
JOIN 
    BillDetails ON Bill.BillID = BillDetails.BillID
JOIN 
    Patient ON Bill.PatientID = Patient.PatientID
JOIN 
    Treatment ON BillDetails.TreatmentID = Treatment.TreatmentID;

-- Adding triggers for automatic updates
-- Trigger to update room status when a patient is checked in
CREATE TRIGGER UpdateRoomStatusOnCheckIn
AFTER INSERT ON PatientRoom
FOR EACH ROW
BEGIN
    UPDATE Room
    SET Status = 'Occupied'
    WHERE RoomID = NEW.RoomID;
END;

-- Trigger to update room status when a patient checks out
CREATE TRIGGER UpdateRoomStatusOnCheckOut
AFTER UPDATE ON PatientRoom
FOR EACH ROW
BEGIN
    IF NEW.CheckOutDate IS NOT NULL THEN
        UPDATE Room
        SET Status = 'Available'
        WHERE RoomID = NEW.RoomID;
    END IF;
END;

-- Adding stored procedures for common operations
-- Procedure to add a new patient
DELIMITER $$
CREATE PROCEDURE AddNewPatient (
    IN firstName VARCHAR(50), 
    IN lastName VARCHAR(50), 
    IN gender ENUM('Male', 'Female', 'Other'), 
    IN dob DATE, 
    IN phone VARCHAR(15), 
    IN email VARCHAR(100), 
    IN address VARCHAR(255), 
    IN emergencyContact VARCHAR(15), 
    IN insuranceProvider VARCHAR(100)
)
BEGIN
    INSERT INTO Patient (FirstName, LastName, Gender, DateOfBirth, PhoneNumber, Email, Address, EmergencyContact, InsuranceProvider)
    VALUES (firstName, lastName, gender, dob, phone, email, address, emergencyContact, insuranceProvider);
END $$
DELIMITER ;

-- Procedure to generate a bill for a patient
DELIMITER $$
CREATE PROCEDURE GenerateBill (
    IN patientID INT
)
BEGIN
    DECLARE totalAmount DECIMAL(10,2) DEFAULT 0;
    
    SELECT SUM(TotalCost)
    INTO totalAmount
    FROM BillDetails
    WHERE BillID = (SELECT BillID FROM Bill WHERE PatientID = patientID);
    
    UPDATE Bill
    SET Amount = totalAmount
    WHERE PatientID = patientID;
END $$
DELIMITER ;
