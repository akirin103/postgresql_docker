CREATE DATABASE test;

\c test;

CREATE SCHEMA testschema;

CREATE TABLE testschema.users (
  user_id SERIAL PRIMARY KEY,
  username VARCHAR(50) NOT NULL,
  email VARCHAR(50) NOT NULL,
  password VARCHAR(50) NOT NULL
);

CREATE TABLE testschema.products (
  product_id SERIAL PRIMARY KEY,
  product_name VARCHAR(50) NOT NULL,
  price NUMERIC(10, 2) NOT NULL,
  description TEXT
);

CREATE TABLE testschema.orders (
  order_id SERIAL PRIMARY KEY,
  user_id INT NOT NULL,
  order_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (user_id) REFERENCES testschema.users (user_id)
);

CREATE TABLE testschema.order_items (
  order_item_id SERIAL PRIMARY KEY,
  order_id INT NOT NULL,
  product_id INT NOT NULL,
  quantity INT NOT NULL,
  price NUMERIC(10, 2) NOT NULL,
  FOREIGN KEY (order_id) REFERENCES testschema.orders (order_id),
  FOREIGN KEY (product_id) REFERENCES testschema.products (product_id)
);

INSERT INTO testschema.users (username, email, password) VALUES
  ('alice', 'alice@example.com', 'pass123'),
  ('bob', 'bob@example.com', 'pass456'),
  ('charlie', 'charlie@example.com', 'pass789');

INSERT INTO testschema.products (product_name, price, description) VALUES
  ('Product A', 1000.00, 'This is product A'),
  ('Product B', 2000.00, 'This is product B'),
  ('Product C', 3000.00, 'This is product C');

INSERT INTO testschema.orders (user_id, order_date) VALUES
  (1, '2022-02-15 10:30:00'),
  (2, '2022-02-16 11:45:00'),
  (1, '2022-02-17 12:00:00');

INSERT INTO testschema.order_items (order_id, product_id, quantity, price) VALUES
  (1, 1, 2, 2000.00),
  (1, 2, 1, 2000.00),
  (2, 3, 3, 9000.00),
  (3, 1, 3, 3000.00),
  (3, 2, 2, 4000.00);
