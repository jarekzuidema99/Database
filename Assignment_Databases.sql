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
DROP TABLE IF EXISTS check_on;

CREATE TABLE tickets (
    ticket_id INTEGER,
    price REAL,
    event_date DATE,
    event_time TIME,
    PRIMARY KEY(ticket_id)
);


CREATE TABLE buys (
    ticket_id INTEGER,
    customer_id INTEGER,
    PRIMARY KEY(customer_id, ticket_id),
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id)
    ON DELETE CASCADE,
    FOREIGN KEY (ticket_id) REFERENCES tickets(ticket_id)
    ON DELETE CASCADE
);

CREATE TABLE customer (
    customer_id INTEGER,
    name TEXT NOT NULL,
    age INTEGER,
    check_by INTEGER,
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
    PRIMARY KEY(employee_id),
    FOREIGN KEY (employee_id) REFERENCES employee(employee_id)
);

CREATE TABLE sound_technician (
    employee_id INTEGER,
    PRIMARY KEY(employee_id),
    FOREIGN KEY (employee_id) REFERENCES employee(employee_id)
);

CREATE TABLE check_on (
check_id INTEGER,
main INTEGER,
inspector INTEGER,
PRIMARY KEY (check_id),
FOREIGN KEY (main) REFERENCES employee(employee_id),
FOREIGN KEY (inspector) REFERENCES employee(employee_id)
);

CREATE TABLE artist (
    artist_id INTEGER,
    name TEXT,
    check_by INTEGER,
    PRIMARY KEY(artist_id),
    FOREIGN KEY (check_by) REFERENCES employee(employee_id)
    ON DELETE RESTRICT
);

CREATE TABLE plays_at (
    event_date DATE NOT NULL,
    event_time TIME NOT NULL,
    artist_id INTEGER,
    hall_num INTEGER,
    PRIMARY KEY(artist_id, hall_num),
    FOREIGN KEY (artist_id) REFERENCES artist(artist_id)
    ON DELETE CASCADE,
    FOREIGN KEY (hall_num) REFERENCES music_hall(hall_num)
    ON DELETE CASCADE,
    FOREIGN KEY (event_date) REFERENCES tickets(event_date)
    ON DELETE CASCADE,
    FOREIGN KEY (event_time) REFERENCES tickets(event_time)
    ON DELETE CASCADE
);

CREATE TABLE sound_check (
    employee_id INTEGER,
    hall_num INTEGER,
    check_date DATE,
    check_time TIME,
    PRIMARY KEY(employee_id, hall_num),
    FOREIGN KEY (employee_id) REFERENCES employee(employee_id),
    FOREIGN KEY (hall_num) REFERENCES music_hall(hall_num)
);

CREATE TABLE music_hall (
    hall_num INTEGER,
    PRIMARY KEY(hall_num)
);

CREATE TABLE works_at (
    employee_id INTEGER,
    hall_num INTEGER,
    PRIMARY KEY (employee_id, hall_num),
    FOREIGN KEY (employee_id) REFERENCES employee(employee_id),
    FOREIGN KEY (hall_num) REFERENCES music_hall(hall_num)
);

INSERT INTO tickets(ticket_id, price, event_time, event_date) VALUES ('00203988747', '69.99','19:00', '20-03-2026');
INSERT INTO tickets(ticket_id, price, event_time, event_date) VALUES ('00034928398', '149.99','20:15', '13-07-2025');
INSERT INTO tickets(ticket_id, price, event_time, event_date) VALUES ('00035724895', '44.99', '18:30', '23-04-2025');
INSERT INTO tickets(ticket_id, price, event_time, event_date) VALUES ('00189384920', '34.99','17:55', '29-09-2025');
INSERT INTO tickets(ticket_id, price, event_time, event_date) VALUES ('00638295857', '64.99', '21:30', '27-05-2025');

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
INSERT INTO employee(employee_id, name, age) VALUES ('056666', 'Miguel', '38');
INSERT INTO employee(employee_id, name, age) VALUES ('053434', 'Bartje', '59');
INSERT INTO employee(employee_id, name, age) VALUES ('051948', 'Dontavius', '34');
INSERT INTO employee(employee_id, name, age) VALUES ('058372', 'Fleur', '20');
INSERT INTO employee(employee_id, name, age) VALUES ('051188', 'Pjotr', '41');

INSERT INTO security(employee_id) VALUES ('053829');
INSERT INTO security(employee_id) VALUES ('057349');
INSERT INTO security(employee_id) VALUES ('058129');
INSERT INTO security(employee_id) VALUES ('056666');
INSERT INTO security(employee_id) VALUES ('053434');

INSERT INTO sound_technician(employee_id) VALUES ('052727');
INSERT INTO sound_technician(employee_id) VALUES ('058948');
INSERT INTO sound_technician(employee_id) VALUES ('051948');
INSERT INTO sound_technician(employee_id) VALUES ('058372');
INSERT INTO sound_technician(employee_id) VALUES ('051188');

INSERT INTO check_on(check_id, main, inspector) VALUES ("1", '052727', '058948');
INSERT INTO check_on(check_id, main, inspector) VALUES ("2", '052727', '051948');
INSERT INTO check_on(check_id, main, inspector) VALUES ("3", '058372', '051188');
INSERT INTO check_on(check_id, main, inspector) VALUES ("4", '051948', '051188');
INSERT INTO check_on(check_id, main, inspector) VALUES ("5", '058371', '051948');

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

--GROUP BY ... HAVING (Finds amount of employees per hall with more than 1 employee)
SELECT hall_num, COUNT(employee_id)
FROM works_at
GROUP BY hall_num
HAVING COUNT(employee_id) > 1;

--UNION (Finds name of customers and artists who are checked by Henk)
SELECT C.name
FROM customer C
WHERE C.check_by IN(SELECT E.employee_id FROM employee E WHERE E.name='Henk')

UNION

SELECT A.name
FROM artist A
WHERE A.check_by IN(SELECT E.employee_id FROM employee E WHERE E.name='Henk');

--INNER JOIN (Find the names of customers and employees who are both age 38)
SELECT C.age, C.name AS customer, E.name AS employee
FROM customer C
INNER JOIN employee E ON  C.age=E.age;

--AGGREGATION (Find the highest price that has been payed for a ticket)
SELECT MAX(T.price)
FROM tickets T;

--STRING MATCHING (Find all customer names that start with M and end with Y and have at least 3 characters)
SELECT C.name
FROM customer C
WHERE C.name LIKE 'M_%Y';

--NESTED QUERY (Find the name of all artists that play in hall 2)
SELECT A.name
FROM artist A
WHERE A.artist_id IN (SELECT P.artist_id FROM plays_at P WHERE P.hall_num=2);
