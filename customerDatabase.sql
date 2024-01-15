

-- Create the customers table
CREATE TABLE IF NOT EXISTS customers (
    id INT AUTO_INCREMENT PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL,
    ic_number VARCHAR(14) NOT NULL UNIQUE,
    date_of_birth DATE NOT NULL,
    customer_address VARCHAR(100) NOT NULL,
    country VARCHAR(50),
    postcode VARCHAR(20),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

DROP PROCEDURE IF EXISTS customers_selection;




DELIMITER $$

CREATE PROCEDURE customers_selection()
BEGIN
	 SELECT * FROM customers;
END$$

DELIMITER ;*/

/* Create an index on the ic_number column*/

CREATE INDEX idx_ic_number ON customers(ic_number);




/* Insert Query*/
INSERT INTO customers (customer_name, ic_number, date_of_birth, customer_address, country, postcode) VALUES
('Alice Brown', '10000000000001', '1990-01-01', '101 Green Lane', 'Malaysia', '50100'),
('Bob Smith', '10000000000002', '1991-02-01', '102 Green Lane', 'Singapore', '50101'),
('Carol White', '10000000000003', '1992-03-01', '103 Green Lane', 'Malaysia', '50102'),
('David Johnson', '10000000000004', '1993-04-01', '104 Green Lane', 'Singapore', '50103'),
('Emma Jones', '10000000000005', '1994-05-01', '105 Green Lane', 'Malaysia', '50104'),
('Frank Miller', '10000000000006', '1995-06-01', '106 Green Lane', 'Singapore', '50105'),
('Grace Lee', '10000000000007', '1996-07-01', '107 Green Lane', 'Malaysia', '50106'),
('Henry Wilson', '10000000000008', '1997-08-01', '108 Green Lane', 'Singapore', '50107'),
('Isla Hall', '10000000000009', '1998-09-01', '109 Green Lane', 'Malaysia', '50108'),
('Jake Taylor', '10000000000010', '1999-10-01', '110 Green Lane', 'Singapore', '50109'),
('Kara Davies', '10000000000011', '2000-11-01', '111 Green Lane', 'Malaysia', '50110'),
('Liam Evans', '10000000000012', '2001-12-01', '112 Green Lane', 'Singapore', '50111'),
('Mia King', '10000000000013', '2002-01-02', '113 Green Lane', 'Malaysia', '50112'),
('Noah Wright', '10000000000014', '2003-02-02', '114 Green Lane', 'Singapore', '50113'),
('Olivia Thomas', '10000000000015', '2004-03-02', '115 Green Lane', 'Malaysia', '50114'),
('Paul Scott', '10000000000016', '2005-04-02', '116 Green Lane', 'Singapore', '50115'),
('Quinn Adams', '10000000000017', '2006-05-02', '117 Green Lane', 'Malaysia', '50116'),
('Ryan Baker', '10000000000018', '2007-06-02', '118 Green Lane', 'Singapore', '50117'),
('Sophia Clarke', '10000000000019', '2008-07-02', '119 Green Lane', 'Malaysia', '50118'),
('Tom Davis', '10000000000020', '2009-08-02', '120 Green Lane', 'Singapore', '50119'),
('Uma Edwards', '10000000000026', '2010-09-02', '121 Green Lane', 'Malaysia', '50120'),
('Victor Gray', '10000000000025', '2011-10-02', '122 Green Lane', 'Singapore', '50121'),
('Adam Quinn', '10000000000034', '2006-05-02', '117 Green Lane', 'Malaysia', '50116'),
('Baker Ryan', '10000000000067', '2007-06-02', '118 Green Lane', 'Singapore', '50117'),
('Clarke Sophia', '10000000000056', '2008-07-02', '119 Green Lane', 'Malaysia', '50118'),
('Davis Tom', '10000000000022', '2009-08-02', '120 Green Lane', 'Singapore', '50119'),
('Edward Uma', '10000000000023', '2010-09-02', '121 Green Lane', 'Malaysia', '50120'),
('Gray Victor', '10000000000024', '2011-10-02', '122 Green Lane', 'Singapore', '50121');