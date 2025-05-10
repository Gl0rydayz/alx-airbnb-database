# DataScape: Mastering Database Design - Task 3: Seed the Database with Sample Data

## Overview
This directory (`database-script-0x02`) contains SQL Data Manipulation Language (DML) scripts to populate the Airbnb-like database with sample data. The data simulates real-world usage, including users, properties, bookings, payments, and reviews, to test the schema defined in Task 2.

## Files
- **seed.sql**: SQL script containing `INSERT` statements to populate the User, Property, Booking, Payment, and Review tables.
- **README.md**: This file, providing an overview and instructions.

## Sample Data Description
The sample data reflects an Airbnb-like system with the following:

1. **User** (5 records):
   - 3 hosts (Alice, Bob, Charlie) and 2 guests (David, Emma).
   - Includes realistic names, emails, phone numbers, and birth dates.
   - `is_host` is TRUE for hosts, FALSE for guests-only.

2. **Property** (6 records):
   - 2 properties per host, located in cities like New York, Paris, and Miami.
   - Prices range from $120 to $250 per night; guest capacities from 2 to 6.
   - Descriptive titles and descriptions.

3. **Booking** (8 records):
   - Bookings by David, Emma, and Alice (as a guest) across various properties.
   - Dates in 2025, with `total_price` calculated as `price_per_night * nights`.
   - Statuses: 5 confirmed, 2 pending, 1 cancelled.

4. **Payment** (10 records):
   - Payments for bookings, including split payments for bookings 2 and 7.
   - Methods: credit_card, paypal, bank_transfer.
   - Statuses: completed, pending, failed.

5. **Review** (5 records):
   - Reviews by guests for properties they booked (post-check-out).
   - Ratings from 3 to 5, with realistic comments.
   - Adheres to the UNIQUE (property_id, guest_id) constraint.

## Data Integrity
- All foreign keys (`host_id`, `guest_id`, `property_id`, `booking_id`) reference valid records.
- Data respects constraints:
  - `check_out_date > check_in_date` in Booking.
  - `rating BETWEEN 1 AND 5` in Review.
  - Valid `booking_status` and `payment_status` values.
  - Non-negative prices and amounts.
- The `total_price` in Booking is stored to preserve booking-time prices, as justified in Task 1.

## Usage
To populate the database:
1. Ensure the schema from Task 2 (`database-script-0x01/schema.sql`) is executed in a PostgreSQL-compatible database.
2. Execute the `seed.sql` script:
   ```bash
   psql -U your_username -d your_database -f seed.sql
