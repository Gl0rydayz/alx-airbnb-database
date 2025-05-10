-- seed.sql
-- SQL DML to populate the Airbnb-like database with sample data
-- Author: [Your Name]
-- Date: May 10, 2025

-- Insert Users
INSERT INTO "User" (first_name, last_name, email, phone_number, date_of_birth, is_host) VALUES
('Alice', 'Smith', 'alice.smith@example.com', '+12345678901', '1985-03-15', TRUE),
('Bob', 'Johnson', 'bob.johnson@example.com', '+12345678902', '1990-07-22', TRUE),
('Charlie', 'Brown', 'charlie.brown@example.com', '+12345678903', '1988-11-10', TRUE),
('David', 'Wilson', 'david.wilson@example.com', '+12345678904', '1995-02-28', FALSE),
('Emma', 'Davis', 'emma.davis@example.com', '+12345678905', '1992-09-05', FALSE);

-- Insert Properties
INSERT INTO Property (host_id, title, description, location, price_per_night, max_guests) VALUES
(1, 'Cozy Apartment in Downtown', 'A modern apartment with great views.', 'New York, NY', 120.00, 4),
(1, 'Beachfront Villa', 'Spacious villa with private beach access.', 'Miami, FL', 250.00, 6),
(2, 'Charming Paris Loft', 'A cozy loft in the heart of Paris.', 'Paris, France', 180.00, 3),
(2, 'Rustic Cabin Retreat', 'A peaceful cabin in the mountains.', 'Aspen, CO', 150.00, 5),
(3, 'Luxury London Flat', 'Elegant flat near major attractions.', 'London, UK', 200.00, 4),
(3, 'Sunny Barcelona Studio', 'Bright studio with a balcony.', 'Barcelona, Spain', 130.00, 2);

-- Insert Bookings
INSERT INTO Booking (property_id, guest_id, check_in_date, check_out_date, total_price, booking_status) VALUES
(1, 4, '2025-06-01', '2025-06-05', 480.00, 'confirmed'), -- 4 nights * 120
(2, 5, '2025-07-10', '2025-07-15', 1250.00, 'confirmed'), -- 5 nights * 250
(3, 4, '2025-08-01', '2025-08-03', 360.00, 'pending'), -- 2 nights * 180
(4, 5, '2025-09-05', '2025-09-10', 750.00, 'confirmed'), -- 5 nights * 150
(5, 1, '2025-10-01', '2025-10-04', 600.00, 'cancelled'), -- 3 nights * 200
(6, 4, '2025-11-01', '2025-11-03', 260.00, 'confirmed'), -- 2 nights * 130
(1, 5, '2025-12-01', '2025-12-07', 720.00, 'pending'), -- 6 nights * 120
(3, 1, '2025-12-15', '2025-12-18', 540.00, 'confirmed'); -- 3 nights * 180

-- Insert Payments
INSERT INTO Payment (booking_id, amount, payment_method, payment_status) VALUES
(1, 480.00, 'credit_card', 'completed'),
(2, 625.00, 'paypal', 'completed'), -- Partial payment
(2, 625.00, 'paypal', 'completed'), -- Remaining payment
(3, 360.00, 'credit_card', 'pending'),
(4, 750.00, 'bank_transfer', 'completed'),
(5, 600.00, 'credit_card', 'failed'),
(6, 260.00, 'paypal', 'completed'),
(7, 360.00, 'credit_card', 'pending'), -- Partial payment
(7, 360.00, 'credit_card', 'pending'), -- Remaining payment
(8, 540.00, 'bank_transfer', 'completed');

-- Insert Reviews
INSERT INTO Review (property_id, guest_id, rating, comment) VALUES
(1, 4, 4, 'Great location, very clean!'),
(2, 5, 5, 'Amazing villa, perfect for vacation.'),
(4, 5, 4, 'Cozy cabin, loved the scenery.'),
(6, 4, 3, 'Nice studio, but a bit small.'),
(3, 1, 5, 'Fantastic loft, highly recommend!');
