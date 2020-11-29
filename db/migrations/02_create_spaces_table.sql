CREATE TABLE spaces (id SERIAL PRIMARY KEY, owner INT references users(id), name VARCHAR(140), description VARCHAR, price NUMERIC, from_date DATE, to_date DATE);
