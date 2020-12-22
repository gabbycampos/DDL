-- from the terminal run:
-- psql < air_traffic.sql

DROP DATABASE IF EXISTS air_traffic;

CREATE DATABASE air_traffic;

\c air_traffic

CREATE TABLE tickets
(
  id SERIAL PRIMARY KEY,
  first_name TEXT NOT NULL,
  last_name TEXT NOT NULL,
  seat TEXT NOT NULL,
  departure TIMESTAMP NOT NULL,
  arrival TIMESTAMP NOT NULL,
  airline TEXT NOT NULL,
  from_city TEXT NOT NULL,
  from_country TEXT NOT NULL,
  to_city TEXT NOT NULL,
  to_country TEXT NOT NULL
);

INSERT INTO tickets
  (first_name, last_name, seat, departure, arrival, airline, from_city, from_country, to_city, to_country)
VALUES
  ('Jennifer', 'Finch', '33B', '2018-04-08 09:00:00', '2018-04-08 12:00:00', 'United', 'Washington DC', 'United States', 'Seattle', 'United States'),
  ('Thadeus', 'Gathercoal', '8A', '2018-12-19 12:45:00', '2018-12-19 16:15:00', 'British Airways', 'Tokyo', 'Japan', 'London', 'United Kingdom'),
  ('Sonja', 'Pauley', '12F', '2018-01-02 07:00:00', '2018-01-02 08:03:00', 'Delta', 'Los Angeles', 'United States', 'Las Vegas', 'United States'),
  ('Jennifer', 'Finch', '20A', '2018-04-15 16:50:00', '2018-04-15 21:00:00', 'Delta', 'Seattle', 'United States', 'Mexico City', 'Mexico'),
  ('Waneta', 'Skeleton', '23D', '2018-08-01 18:30:00', '2018-08-01 21:50:00', 'TUI Fly Belgium', 'Paris', 'France', 'Casablanca', 'Morocco'),
  ('Thadeus', 'Gathercoal', '18C', '2018-10-31 01:15:00', '2018-10-31 12:55:00', 'Air China', 'Dubai', 'UAE', 'Beijing', 'China'),
  ('Berkie', 'Wycliff', '9E', '2019-02-06 06:00:00', '2019-02-06 07:47:00', 'United', 'New York', 'United States', 'Charlotte', 'United States'),
  ('Alvin', 'Leathes', '1A', '2018-12-22 14:42:00', '2018-12-22 15:56:00', 'American Airlines', 'Cedar Rapids', 'United States', 'Chicago', 'United States'),
  ('Berkie', 'Wycliff', '32B', '2019-02-06 16:28:00', '2019-02-06 19:18:00', 'American Airlines', 'Charlotte', 'United States', 'New Orleans', 'United States'),
  ('Cory', 'Squibbes', '10D', '2019-01-20 19:30:00', '2019-01-20 22:45:00', 'Avianca Brasil', 'Sao Paolo', 'Brazil', 'Santiago', 'Chile');



-- *********   MY CODE   **************
ALTER TABLE tickets DROP COLUMN departure;
ALTER TABLE tickets DROP COLUMN arrival;
ALTER TABLE tickets DROP COLUMN from_country;
ALTER TABLE tickets DROP COLUMN to_country;
ALTER TABLE tickets DROP COLUMN from_city;
ALTER TABLE tickets DROP COLUMN to_city;

CREATE TABLE locations
(
  id SERIAL PRIMARY KEY,
  from_city TEXT NOT NULL,
  from_country TEXT NOT NULL,
  to_city TEXT NOT NULL,
  to_country TEXT NOT NULL,
  ticket_id INTEGER REFERENCES tickets(id) ON DELETE SET NULL
);

INSERT INTO locations
  (from_city, from_country, to_city, to_country, ticket_id)
VALUES 
  ('Washington DC', 'United State', 'Seattle', 'United States', 1),
  ('Tokyo', 'Japan', 'London', 'United Kingdom', 2),
  ('Los Angeles', 'United States', 'Las Vegas', 'United States', 3),
  ('Seattle', 'United States', 'Mexico City', 'Mexico', 4),
  ('Paris', 'France', 'Casablanca', 'Morocco', 5),
  ('Dubai', 'UAE', 'Beijing', 'China', 6),
  ('New York', 'United States', 'Charlotte', 'United States', 7),
  ('Cedar Rapids', 'United States', 'Chicago', 'United States', 8),
  ('Charlotte', 'United States', 'New Orleans', 'United States', 9),
  ('Sao Paolo', 'Brazil', 'Santiago', 'Chile', 10);

CREATE TABLE time_of_travel
(
  id SERIAL PRIMARY KEY,
  departure TIMESTAMP NOT NULL,
  arrival TIMESTAMP NOT NULL,
  ticket_id INTEGER REFERENCES tickets(id) ON DELETE SET NULL
);

INSERT INTO time_of_travel
  (departure, arrival, ticket_id)
VALUES 
  ('2018-04-08 09:00:00', '2018-04-08 12:00:00', 1),
  ('2018-12-19 12:45:00', '2018-12-19 16:15:00', 2),
  ('2018-01-02 07:00:00', '2018-01-02 08:03:00', 3),
  ('2018-04-15 16:50:00', '2018-04-15 21:00:00', 4),
  ('2018-08-01 18:30:00', '2018-08-01 21:50:00', 5),
  ('2018-10-31 01:15:00', '2018-10-31 12:55:00', 6),
  ('2019-02-06 06:00:00', '2019-02-06 07:47:00', 7),
  ('2018-12-22 14:42:00', '2018-12-22 15:56:00', 8),
  ('2019-02-06 16:28:00', '2019-02-06 19:18:00', 9),
  ('2019-01-20 19:30:00', '2019-01-20 22:45:00', 10);