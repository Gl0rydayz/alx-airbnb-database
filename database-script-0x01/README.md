# DataScape: Mastering Database Design - Task 2: Design Database Schema (DDL)

## Overview
This directory (`database-script-0x01`) contains the SQL Data Definition Language (DDL) scripts for creating the database schema of an Airbnb-like application. The schema defines tables, constraints, and indexes to support users, properties, bookings, payments, and reviews, ensuring data integrity and query performance.

## Files
- **schema.sql**: SQL script containing `CREATE TABLE` statements for the database schema, including primary keys, foreign keys, constraints, and indexes.
- **README.md**: This file, providing an overview and instructions.

## Schema Description
The database consists of five tables, designed to be in Third Normal Form (3NF) as per Task 1:

1. **User**: Stores user information (hosts and guests).
   - Primary Key: `user_id`
   - Unique: `email`
   - Attributes: `first_name`, `last_name`, `phone_number`, `date_of_birth`, `created_at`, `is_host`
2. **Property**: Stores property listings created by hosts.
   - Primary Key: `property_id`
   - Foreign Key: `host_id` (references `User.user_id`)
   - Attributes: `title`, `description`, `location`, `price_per_night`, `max_guests`, `created_at`
3. **Booking**: Stores booking details for properties.
   - Primary Key: `booking_id`
   - Foreign Keys: `property_id` (references `Property.property_id`), `guest_id` (references `User.user_id`)
   - Attributes: `check_in_date`, `check_out_date`, `total_price`, Bax
   - booking_status`, `created_at`
4. **Payment**: Stores payment records for bookings.
   - Primary Key: `payment_id`
   - Foreign Key: `booking_id` (references `Booking.booking_id`)
   - Attributes: `amount`, `payment_method`, `payment_status`, `created_at`
5. **Review**: Stores guest reviews for properties.
   - Primary Key: `review_id`
   - Foreign Keys: `property_id` (references `Property.property_id`), `guest_id` (references `User.user_id`)
   - Unique Constraint: `(property_id, guest_id)` to prevent duplicate reviews
   - Attributes: `rating`, `comment`, `created_at`

## Constraints
- **NOT NULL**: Ensures mandatory fields (e.g., `first_name`, `title`) are populated.
- **UNIQUE**: Enforces unique `email` in `User` and unique `(property_id, guest_id)` in `Review`.
- **CHECK**: Validates data (e.g., `price_per_night >= 0`, `rating BETWEEN 1 AND 5`, `check_out_date > check_in_date`).
- **FOREIGN KEY**: Maintains referential integrity with `ON DELETE RESTRICT` and `ON UPDATE CASCADE`.

## Indexes
Indexes are created to optimize query performance:
- `User.email`: Fast login and lookup.
- `Property.host_id`, `Property.location`: Efficient host queries and location searches.
- `Booking.property_id`, `Booking.guest_id`, `Booking(check_in_date, check_out_date)`: Fast joins and availability checks.
- `Payment.booking_id`: Efficient payment queries.
- `Review.property_id`, `Review.guest_id`: Fast review retrieval.

## Usage
To create the database schema:
1. Use a PostgreSQL-compatible database system.
2. Execute the `schema.sql` script:
   ```bash
   psql -U your_username -d your_database -f schema.sql
