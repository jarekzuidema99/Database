.header on
.mode column
.nullvalue "NULL"

DROP TABLE IF EXISTS tickets;
DROP TABLE IF EXISTS buys;
DROP TABLE IF EXISTS customer;
DROP TABLE IF EXISTS employee;
DROP TABLE IF EXISTS security;
DROP TABLE IF EXISTS sound_technician;
DROP TABLE IF EXISTS artist;
DROP TABLE IF EXISTS plays_at;
DROP TABLE IF EXISTS sound_check;
DROP TABLE IF EXISTS music_hall;
DROP TABLE IF EXISTS works_at;

CREATE TABLE tickets (
    ticket_id INTEGER,
    price REAL,
    event_date DATE,
    event_time TIME,
    PRIMARY KEY(ticket_id)
);


CREATE TABLE buys (
    ticket_id INTEGER,
    event_date DATE,
    event_time TIME,
    price REAL,
    customer_id INTEGER,
    PRIMARY KEY(customer_id, ticket_id),
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
    FOREIGN KEY (ticket_id) REFERENCES tickets(ticket_id),
    FOREIGN KEY (price) REFERENCES tickets(price),
    FOREIGN KEY (event_date) REFERENCES tickets(event_date),
    FOREIGN KEY (event_time) REFERENCES tickets(event_time)
    ON DELETE RESTRICT
);

CREATE TABLE customer (
    customer_id INTEGER,
    name TEXT NOT NULL,
    age INTEGER,
    check_by INTEGER NOT NULL,
    PRIMARY KEY(customer_id),
    FOREIGN KEY (check_by) REFERENCES employee(employee_id)
    ON DELETE RESTRICT
);

CREATE TABLE employee (
    employee_id INTEGER,
    name TEXT NOT NULL,
    age INTEGER,
    PRIMARY KEY(employee_id)
);

CREATE TABLE security (
    employee_id INTEGER,
    name TEXT NOT NULL,
    age INTEGER,
    PRIMARY KEY(employee_id),
    FOREIGN KEY (employee_id) REFERENCES employee(employee_id),
    FOREIGN KEY (name) REFERENCES employee(name),
    FOREIGN KEY (age) REFERENCES employee(age)
);

CREATE TABLE sound_technician (
    employee_id INTEGER,
    name TEXT NOT NULL,
    age INTEGER,
    PRIMARY KEY(employee_id),
    FOREIGN KEY (employee_id) REFERENCES employee(employee_id),
    FOREIGN KEY (name) REFERENCES employee(name),
    FOREIGN KEY (age) REFERENCES employee(age)
);

CREATE TABLE artist (
    artist_id INTEGER,
    name TEXT UNIQUE,
    check_by INTEGER NOT NULL,
    PRIMARY KEY(artist_id),
    FOREIGN KEY (check_by) REFERENCES employee(employee_id)
    ON DELETE RESTRICT
);

CREATE TABLE plays_at (
    event_date DATE NOT NULL,
    event_time TIME NOT NULL,
    artist_id INTEGER UNIQUE,
    hall_num INTEGER UNIQUE,
    PRIMARY KEY(artist_id, hall_num),
    FOREIGN KEY (artist_id) REFERENCES artist(artist_id),
    FOREIGN KEY (hall_num) REFERENCES music_hall(hall_num),
    FOREIGN KEY (event_date) REFERENCES tickets(event_date),
    FOREIGN KEY (event_time) REFERENCES tickets(event_time)
    ON DELETE CASCADE
);

CREATE TABLE sound_check (
    employee_id INTEGER,
    hall_num INTEGER NOT NULL,
    check_date DATE,
    check_time TIME,
    PRIMARY KEY(employee_id, hall_num),
    FOREIGN KEY (employee_id) REFERENCES employee(employee_id),
    FOREIGN KEY (hall_num) REFERENCES music_hall(hall_num)
);

CREATE TABLE music_hall (
    hall_num INTEGER NOT NULL UNIQUE,
    PRIMARY KEY(hall_num)
);

CREATE TABLE works_at (
    employee_id INTEGER,
    hall_num INTEGER,
    PRIMARY KEY (employee_id, hall_num),
    FOREIGN KEY (employee_id) REFERENCES employee(employee_id),
    FOREIGN KEY (hall_num) REFERENCES music_hall(hall_num)
);

INSERT INTO tickets(ticket_id, price, event_time, event_date) VALUES ('00203988747', '69,99','19:00', '20-03-2026');
INSERT INTO tickets(ticket_id, price, event_time, event_date) VALUES ('00034928398', '149,99','20:15', '13-07-2025');
INSERT INTO tickets(ticket_id, price, event_time, event_date) VALUES ('00035724895', '44,99', '18:30', '23-04-2025');
INSERT INTO tickets(ticket_id, price, event_time, event_date) VALUES ('00189384920', '34,99','17:55', '29-09-2025');
INSERT INTO tickets(ticket_id, price, event_time, event_date) VALUES ('00638295857', '64,99', '21:30', '27-05-2025');

INSERT INTO buys(customer_id, ticket_id) VALUES ('0', '00035724895');
INSERT INTO buys(customer_id, ticket_id) VALUES ('1', '00638295857');
INSERT INTO buys(customer_id, ticket_id) VALUES ('2', '00189384920');
INSERT INTO buys(customer_id, ticket_id) VALUES ('3', '00034928398');
INSERT INTO buys(customer_id, ticket_id) VALUES ('4', '00203988747');

INSERT INTO customer(customer_id, name, age, check_by) VALUES ('0', 'Bob', '38', '052727');
INSERT INTO customer(customer_id, name, age, check_by) VALUES ('1', 'Mary', '24', '057349');
INSERT INTO customer(customer_id, name, age, check_by) VALUES ('2', 'Nigel', '27', '058948');
INSERT INTO customer(customer_id, name, age, check_by) VALUES ('3', 'Marquerius The 3rd', '22', '053829');
INSERT INTO customer(customer_id, name, age, check_by) VALUES ('4', 'Ashanta', '28', '058129');

INSERT INTO employee(employee_id, name, age) VALUES ('052727', 'Guus', '23');
INSERT INTO employee(employee_id, name, age) VALUES ('057349', 'Henk', '58');
INSERT INTO employee(employee_id, name, age) VALUES ('058948', 'Tanja', '43');
INSERT INTO employee(employee_id, name, age) VALUES ('053829', 'Shaq', '32');
INSERT INTO employee(employee_id, name, age) VALUES ('058129', 'Melania', '47');
INSERT INTO employee(employee_id, name, age) VALUES ('056666', 'Miguel', '39');
INSERT INTO employee(employee_id, name, age) VALUES ('053434', 'Bartje', '59');
INSERT INTO employee(employee_id, name, age) VALUES ('051948', 'Dontavius', '34');
INSERT INTO employee(employee_id, name, age) VALUES ('058372', 'Fleur', '20');
INSERT INTO employee(employee_id, name, age) VALUES ('051188', 'Pjotr', '41');

INSERT INTO security(employee_id, name, age) VALUES ('053829', 'Shaq', '32');
INSERT INTO security(employee_id, name, age) VALUES ('057349', 'Henk', '58');
INSERT INTO security(employee_id, name, age) VALUES ('058129', 'Melania', '47');
INSERT INTO security(employee_id, name, age) VALUES ('056666', 'Miguel', '39');
INSERT INTO security(employee_id, name, age) VALUES ('053434', 'Bartje', '59');

INSERT INTO sound_technician(employee_id, name, age) VALUES ('052727', 'Guus', '23');
INSERT INTO sound_technician(employee_id, name, age) VALUES ('058948', 'Tanja', '43');
INSERT INTO sound_technician(employee_id, name, age) VALUES ('051948', 'Dontavius', '34');
INSERT INTO sound_technician(employee_id, name, age) VALUES ('058372', 'Fleur', '20');
INSERT INTO sound_technician(employee_id, name, age) VALUES ('051188', 'Pjotr', '41');

INSERT INTO artist(artist_id, name, check_by) VALUES ('101', 'Kendrick Lamar', '053829');
INSERT INTO artist(artist_id, name, check_by) VALUES ('345', 'Tyler, The Creator', '053434');
INSERT INTO artist(artist_id, name, check_by) VALUES ('235', 'Radiohead', '057349');
INSERT INTO artist(artist_id, name, check_by) VALUES ('594', 'Pierce The Veil', '056666');
INSERT INTO artist(artist_id, name, check_by) VALUES ('994', 'Deftones', '058129');

INSERT INTO plays_at(artist_id, hall_num, event_time, event_date) VALUES('101', '1', '20:15', '13-07-2025');
INSERT INTO plays_at(artist_id, hall_num, event_time, event_date) VALUES('345', '2', '19:00', '20-03-2026');
INSERT INTO plays_at(artist_id, hall_num, event_time, event_date) VALUES('235', '3', '18:30', '23-04-2025');
INSERT INTO plays_at(artist_id, hall_num, event_time, event_date) VALUES('594', '4', '17:55', '29-09-2025');
INSERT INTO plays_at(artist_id, hall_num, event_time, event_date) VALUES('994', '5', '21:30', '27-05-2025');

INSERT INTO sound_check(employee_id, hall_num, check_time, check_date) VALUES ('052727', '3', '12:30', '22-04-2025');
INSERT INTO sound_check(employee_id, hall_num, check_time, check_date) VALUES ('052727', '1', '13:45', '10-07-2025');
INSERT INTO sound_check(employee_id, hall_num, check_time, check_date) VALUES ('058948', '4', '15:00', '27-09-2025');
INSERT INTO sound_check(employee_id, hall_num, check_time, check_date) VALUES ('058948', '5', '11:30', '12-05-2025');
INSERT INTO sound_check(employee_id, hall_num, check_time, check_date) VALUES ('051188', '2', '17:55', '15-02-2026');

INSERT INTO music_hall(hall_num) VALUES ('1');
INSERT INTO music_hall(hall_num) VALUES ('2');
INSERT INTO music_hall(hall_num) VALUES ('3');
INSERT INTO music_hall(hall_num) VALUES ('4');
INSERT INTO music_hall(hall_num) VALUES ('5');

INSERT INTO works_at (employee_id, hall_num) VALUES ('053829', '1');
INSERT INTO works_at (employee_id, hall_num) VALUES ('057349', '5');
INSERT INTO works_at (employee_id, hall_num) VALUES ('058129', '2');
INSERT INTO works_at (employee_id, hall_num) VALUES ('056666', '4');
INSERT INTO works_at (employee_id, hall_num) VALUES ('053434', '3');
INSERT INTO works_at (employee_id, hall_num) VALUES ('052727', '3');
INSERT INTO works_at (employee_id, hall_num) VALUES ('058948', '4');
INSERT INTO works_at (employee_id, hall_num) VALUES ('051948', '1');
INSERT INTO works_at (employee_id, hall_num) VALUES ('058372', '5');
INSERT INTO works_at (employee_id, hall_num) VALUES ('051188', '2');

SELECT C.age, MAX(T.price)
FROM tickets T, customer C
WHERE C.age > 22
GROUP BY C.age;



SELECT A.name
FROM artist A
INNER JOIN employee E ON  A.check_by=E.employee_id WHERE E.name='Shaq';
