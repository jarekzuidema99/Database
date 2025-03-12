.header on
.mode column
.nullvalue "NULL"

DROP TABLE IF EXISTS tickets;

CREATE TABLE tickets(
    ticket_id INTEGER
    price REAL
    event_date DATE
    event_time TIME
    PRIMARY KEY(ticket_id)
);

CREATE TABLE VIP_tickets(
    ticket_id INTEGER
    price REAL
    event_date DATE
    event_time TIME
    PRIMARY KEY(ticket_id)
    FOREIGN KEY ticket_id REFERENCES tickets(ticket_id)
    FOREIGN KEY price REFERENCES tickets(price)
    FOREIGN KEY event_date REFERENCES tickets(event_date)
    FOREIGN KEY event_time REFERENCES tickets(event_time)
);

CREATE TABLE normal_tickets(
    ticket_id INTEGER
    price REAL
    event_date DATE
    event_time TIME
    PRIMARY KEY(ticket_id)
    FOREIGN KEY ticket_id REFERENCES tickets(ticket_id)
    FOREIGN KEY price REFERENCES tickets(price)
    FOREIGN KEY event_date REFERENCES tickets(event_date)
    FOREIGN KEY event_time REFERENCES tickets(event_time)
);

CREATE TABLE buys(
    ticket_id INTEGER
    event_date DATE
    event_time TIME
    price REAL
    customer_id INTEGER
    PRIMARY KEY(customer_id, ticket_id)
    FOREIGN KEY customer_id REFERENCES customer(customer_id)
    FOREIGN KEY price REFERENCES tickets(price)
    FOREIGN KEY event_date REFERENCES tickets(event_date)
    FOREIGN KEY event_time REFERENCES tickets(event_time)
    ON DELETE RESTRICT
);

CREATE TABLE customer(
    customer_id INTEGER
    name TEXT NOT NULL
    age INTEGER
    check_by INTEGER NOT NULL
    PRIMARY KEY(customer_id)
    FOREIGN KEY check_by REFERENCES employee(employee_id)
    ON DELETE RESTRICT
);

CREATE TABLE employee(
    employee_id INTEGER
    name TEXT NOT NULL
    age INTEGER
    works_at TEXT NOT NULL
    PRIMARY KEY(employee_id)
    FOREIGN KEY works_at REFERENCES music_hall(hall_num)
);

CREATE TABLE security(
    employee_id INTEGER
    name TEXT NOT NULL
    age INTEGER
    PRIMARY KEY(employee_id)
    FOREIGN KEY employee_id REFERENCES employee(employee_id)
    FOREIGN KEY name REFERENCES employee(name)
    FOREIGN KEY age REFERENCES employee(age)
);

CREATE TABLE sound_technician(
    employee_id INTEGER
    name TEXT NOT NULL
    age INTEGER
    PRIMARY KEY(employee_id)
    FOREIGN KEY employee_id REFERENCES employee(employee_id)
    FOREIGN KEY name REFERENCES employee(name)
    FOREIGN KEY age REFERENCES employee(age)
);

CREATE TABLE artist(
    artist_id INTEGER
    name TEXT UNIQUE
    PRIMARY KEY(artist_id)
    check_by INTEGER NOT NULL
    FOREIGN KEY check_by REFERENCES employee(employee_id)
    ON CASCADE RESTRICT
);

CREATE TABLE plays_at(
    event_date DATE NOT NULL
    event_time TIME NOT NULL
    artist_id INTEGER UNIQUE
    hall_num INTEGER UNIQUE
    PRIMARY KEY(artist_id, hall_num)
    FOREIGN KEY artist_id REFERENCES artist(artist_id)
    FOREIGN KEY hall_num REFERENCES music_hall(hall_num)
    FOREIGN KEY event_date REFERENCES tickets(event_date)
    FOREIGN KEY event_time REFERENCES tickets(event_time)
    ON DELETE CASCADE
);

CREATE TABLE music_hall(
    name TEXT NOT NULL UNIQUE
    hall_num INTEGER NOT NULL UNIQUE
    PRIMARY KEY(name, hall_num)
);