# DataScape: Mastering Database Design - Task 0

## Entities and Attributes
1. **User**:
   - user_id (Integer, Primary Key)
   - first_name (String)
   - last_name (String)
   - email (String, Unique)
   - phone_number (String)
   - date_of_birth (Date)
   - created_at (Timestamp)
   - is_host (Boolean)
2. **Property**:
   - property_id (Integer, Primary Key)
   - host_id (Integer, Foreign Key referencing User.user_id)
   - title (String)
   - description (Text)
   - location (String)
   - price_per_night (Decimal)
   - max_guests (Integer)
   - created_at (Timestamp)
3. **Booking**:
   - booking_id (Integer, Primary Key)
   - property_id (Integer, Foreign Key referencing Property.property_id)
   - guest_id (Integer, Foreign Key referencing User.user_id)
   - check_in_date (Date)
   - check_out_date (Date)
   - total_price (Decimal)
   - booking_status (String)
   - created_at (Timestamp)
4. **Payment**:
   - payment_id (Integer, Primary Key)
   - booking_id (Integer, Foreign Key referencing Booking.booking_id)
   - amount (Decimal)
   - payment_method (String)
   - payment_status (String)
   - created_at (Timestamp)
5. **Review**:
   - review_id (Integer, Primary Key)
   - property_id (Integer, Foreign Key referencing Property.property_id)
   - guest_id (Integer, Foreign Key referencing User.user_id)
   - rating (Integer)
   - comment (Text)
   - created_at (Timestamp)

## Relationships
1. **User to Property**: One-to-Many. A user (host) can own multiple properties, but each property has one host. Represented by `host_id` (FK) in Property.
2. **Property to Booking**: One-to-Many. A property can have multiple bookings, but each booking is for one property. Represented by `property_id` (FK) in Booking.
3. **User to Booking**: One-to-Many. A user (guest) can make multiple bookings, but each booking is made by one guest. Represented by `guest_id` (FK) in Booking.
4. **Booking to Payment**: One-to-Many. A booking can have multiple payments, but each payment is tied to one booking. Represented by `booking_id` (FK) in Payment.
5. **Property and User to Review**: Many-to-One. A property can have multiple reviews, and a user can write multiple reviews. Each review is tied to one property and one user. Represented by `property_id` (FK) and `guest_id` (FK) in Review.

## ERmaking/ER Diagram Description
The ER diagram visualizes the Airbnb-like database with five entities: User, Property, Booking, Payment, and Review. Each entity is represented as a rectangle with attributes listed, primary keys underlined, and foreign keys marked. Relationships are shown as lines connecting entities, with cardinality (1:N) indicated. The diagram was created using Draw.io and exported as `airbnb_erd.pdf`.

## Tool Used
- Draw.io (https://app.diagrams.net/)
