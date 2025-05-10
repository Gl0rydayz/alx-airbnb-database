# DataScape: Mastering Database Design - Task 1: Normalize Your Database Design

## Objective
This task applies normalization principles to ensure the Airbnb-like database schema is in the Third Normal Form (3NF), eliminating redundancies and anomalies while maintaining functionality.

## Schema Review
The initial schema from Task 0 includes the following entities and attributes:

1. **User**:
   - user_id (Integer, Primary Key), first_name (String), last_name (String), email (String, Unique), phone_number (String), date_of_birth (Date), created_at (Timestamp), is_host (Boolean)
2. **Property**:
   - property_id (Integer, Primary Key), host_id (Integer, Foreign Key referencing User.user_id), title (String), description (Text), location (String), price_per_night (Decimal), max_guests (Integer), created_at (Timestamp)
3. **Booking**:
   - booking_id (Integer, Primary Key), property_id (Integer, Foreign Key referencing Property.property_id), guest_id (Integer, Foreign Key referencing User.user_id), check_in_date (Date), check_out_date (Date), total_price (Decimal), booking_status (String), created_at (Timestamp)
4. **Payment**:
   - payment_id (Integer, Primary Key), booking_id (Integer, Foreign Key referencing Booking.booking_id), amount (Decimal), payment_method (String), payment_status (String), created_at (Timestamp)
5. **Review**:
   - review_id (Integer, Primary Key), property_id (Integer, Foreign Key referencing Property.property_id), guest_id (Integer, Foreign Key referencing User.user_id), rating (Integer), comment (Text), created_at (Timestamp)

## Normalization Process

### First Normal Form (1NF)
**Requirements**: All attributes must be atomic, each table must have a primary key, and there should be no repeating groups.

**Evaluation**:
- All attributes (e.g., `first_name`, `location`, `total_price`) are atomic and single-valued.
- Each table has a unique primary key (e.g., `user_id`, `booking_id`).
- No repeating groups or multi-valued attributes exist.

**Conclusion**: The schema is in **1NF**.

### Second Normal Form (2NF)
**Requirements**: The table must be in 1NF, and all non-key attributes must be fully functionally dependent on the entire primary key (no partial dependencies).

**Evaluation**:
- All tables have single-column primary keys (`user_id`, `property_id`, etc.), so partial dependencies are not applicable.
- In the **Booking** table, `total_price` depends on `booking_id` but is derived from `check_in_date`, `check_out_date`, and `Property.price_per_night`. This is not a partial dependency, as `total_price` is specific to each booking instance.
- The **Review** table’s attributes (`rating`, `comment`) depend on `review_id`, not just `property_id` or `guest_id`.

**Conclusion**: The schema is in **2NF**, as no partial dependencies exist.

### Third Normal Form (3NF)
**Requirements**: The table must be in 2NF, and there should be no transitive dependencies (non-key attributes must not depend on other non-key attributes).

**Evaluation**:
- **User**: All attributes depend directly on `user_id`. No transitive dependencies (e.g., `email` does not determine `phone_number`).
- **Property**: Attributes depend on `property_id`. The `host_id` (FK) is a key dependency, not transitive.
- **Booking**: The `total_price` attribute is derived from `check_in_date`, `check_out_date`, and `Property.price_per_night`. This could suggest a transitive dependency, as `total_price` is influenced by non-key attributes. However:
  - In an Airbnb-like system, `total_price` is stored to lock in the booking price at the time of the transaction, preventing inconsistencies if `price_per_night` changes.
  - This is a design choice to ensure data integrity for historical bookings, not a strict transitive dependency.
- **Payment**: Attributes depend on `payment_id`. The `amount` relates to `Booking.total_price` but is specific to the payment instance.
- **Review**: Attributes depend on `review_id`. No transitive dependencies.

**Decision**:
- Retain `total_price` in the **Booking** table to preserve the agreed-upon price for each booking, avoiding anomalies due to price changes in the Property table.
- Alternatively, `total_price` could be calculated dynamically using a view (e.g., `SELECT price_per_night * DATEDIFF(check_out_date, check_in_date)`), but storing it is justified for performance and consistency in this context.
- No other transitive dependencies were found.

**Conclusion**: The schema is in **3NF**, with the `total_price` retention justified as a practical design choice.

## Final Schema
No structural changes are needed. The schema remains as defined in Task 0:
- **User**, **Property**, **Payment**, **Review**: Fully normalized to 3NF.
- **Booking**: Includes `total_price` as a stored attribute to ensure price consistency, with the rationale explained above.

## Summary
The database schema was reviewed and found to be in 1NF (atomic attributes, primary keys), 2NF (no partial dependencies), and 3NF (no transitive dependencies, with `total_price` retained for practical reasons). The design is optimized for an Airbnb-like system, balancing normalization principles with real-world requirements.
