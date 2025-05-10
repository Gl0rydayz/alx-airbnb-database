-- schema.sql
-- SQL DDL to create tables for an Airbnb-like database
-- Author: [Your Name]
-- Date: May 10, 2025

-- Drop tables if they exist to ensure clean schema creation
DROP TABLE IF EXISTS Review CASCADE;
DROP TABLE IF EXISTS Payment CASCADE;
DROP TABLE IF EXISTS Booking CASCADE;
DROP TABLE IF EXISTS Property CASCADE;
DROP TABLE IF EXISTS "User" CASCADE;

-- Create User table
CREATE TABLE "User" (
    user_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    phone_number VARCHAR(20),
    date_of_birth DATE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    is_host BOOLEAN DEFAULT FALSE NOT NULL
);

-- Create Property table
CREATE TABLE Property (
    property_id SERIAL PRIMARY KEY,
    host_id INTEGER NOT NULL REFERENCES "User"(user_id) ON DELETE RESTRICT ON UPDATE CASCADE,
    title VARCHAR(100) NOT NULL,
    description TEXT,
    location VARCHAR(100) NOT NULL,
    price_per_night DECIMAL(10, 2) NOT NULL CHECK (price_per_night >= 0),
    max_guests INTEGER NOT NULL CHECK (max_guests > 0),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL
);

-- Create Booking table
CREATE TABLE Booking (
    booking_id SERIAL PRIMARY KEY,
    property_id INTEGER NOT NULL REFERENCES Property(property_id) ON DELETE RESTRICT ON UPDATE CASCADE,
    guest_id INTEGER NOT NULL REFERENCES "User"(user_id) ON DELETE RESTRICT ON UPDATE CASCADE,
    check_in_date DATE NOT NULL,
    check_out_date DATE NOT NULL,
    total_price DECIMAL(10, 2) NOT NULL CHECK (total_price >= 0),
    booking_status VARCHAR(20) NOT NULL CHECK (booking_status IN ('pending', 'confirmed', 'cancelled')),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    CONSTRAINT valid_dates CHECK (check_out_date > check_in_date)
);

-- Create Payment table
CREATE TABLE Payment (
    payment_id SERIAL PRIMARY KEY,
    booking_id INTEGER NOT NULL REFERENCES Booking(booking_id) ON DELETE RESTRICT ON UPDATE CASCADE,
    amount DECIMAL(10, 2) NOT NULL CHECK (amount >= 0),
    payment_method VARCHAR(50) NOT NULL CHECK (payment_method IN ('credit_card', 'paypal', 'bank_transfer')),
    payment_status VARCHAR(20) NOT NULL CHECK (payment_status IN ('pending', 'completed', 'failed')),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL
);

-- Create Review table
CREATE TABLE Review (
    review_id SERIAL PRIMARY KEY,
    property_id INTEGER NOT NULL REFERENCES Property(property_id) ON DELETE RESTRICT ON UPDATE CASCADE,
    guest_id INTEGER NOT NULL REFERENCES "User"(user_id) ON DELETE RESTRICT ON UPDATE CASCADE,
    rating INTEGER NOT NULL CHECK (rating BETWEEN 1 AND 5),
    comment TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    CONSTRAINT unique_review UNIQUE (property_id, guest_id)
);

-- Create indexes for performance optimization
CREATE INDEX idx_user_email ON "User"(email);
CREATE INDEX idx_property_host_id ON Property(host_id);
CREATE INDEX idx_property_location ON Property(location);
CREATE INDEX idx_booking_property_id ON Booking(property_id);
CREATE INDEX idx_booking_guest_id ON Booking(guest_id);
CREATE INDEX idx_booking_dates ON Booking(check_in_date, check_out_date);
CREATE INDEX idx_payment_booking_id ON Payment(booking_id);
CREATE INDEX idx_review_property_id ON Review(property_id);
CREATE INDEX idx_review_guest_id ON Review(guest_id);
