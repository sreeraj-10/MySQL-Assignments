CREATE DATABASE Library;
USE Library;

# BRANCH TABLE
CREATE TABLE Branch(
    Branch_no INT PRIMARY KEY,
    Manager_Id INT,
    Branch_address VARCHAR(100),
    Contact_no VARCHAR(20)
);
DESC Branch;

INSERT INTO Branch VALUES(1, 201, 'Connaught Place, New Delhi', '011-23456789');
INSERT INTO Branch VALUES(2, 202, 'MG Road, Bengaluru', '080-26543210');
INSERT INTO Branch VALUES(3, 203, 'Marine Drive, Mumbai', '022-12345678');
INSERT INTO Branch VALUES(4, 204, 'Anna Nagar, Chennai', '044-98765432');
INSERT INTO Branch VALUES(5, 205, 'Salt Lake, Kolkata', '033-54321678');

SELECT * FROM Branch;

# Employee Table
CREATE TABLE Employee (
    Emp_Id INT PRIMARY KEY,
    Emp_name VARCHAR(100),
    Position VARCHAR(100),
    Salary DECIMAL(10, 2),
    Branch_no INT,
    FOREIGN KEY (Branch_no) REFERENCES Branch(Branch_no)
);

INSERT INTO Employee VALUES(201, 'Ravi Sharma', 'Manager', 85000, 1);
INSERT INTO Employee VALUES(202, 'Amit Desai', 'Manager', 90000, 2);
INSERT INTO Employee VALUES(203, 'Rohit Singh', 'Staff', 45000, 1);
INSERT INTO Employee VALUES(204, 'Pooja Nair', 'Staff', 50000, 3);
INSERT INTO Employee VALUES(205, 'Arun Gupta', 'Manager', 78000, 1);
INSERT INTO Employee VALUES(206, 'Sonia Verma', 'Staff', 47000, 4);
INSERT INTO Employee VALUES(207, 'Kiran Joshi', 'Manager', 92000, 1);
INSERT INTO Employee VALUES(208, 'Rahul Sen', 'Staff', 48000, 5);
INSERT INTO Employee VALUES(209, 'Varghese Joseph ', 'Staff', 50000, 1);
INSERT INTO Employee VALUES(210, 'Matthew Cicil', 'Staff', 45000, 1);

SELECT * FROM Employee;

# Books Table
CREATE TABLE Books (
    ISBN VARCHAR(20) PRIMARY KEY,
    Book_title VARCHAR(100),
    Category VARCHAR(50),
    Rental_Price DECIMAL(10, 2),
    Status ENUM('Yes', 'No'),
    Author VARCHAR(100),
    Publisher VARCHAR(100)
);

INSERT INTO Books VALUES('978-81-291-0892-5', 'The Mahabharata', 'Mythology', 70, 'Yes', 'C. Rajagopalachari', 'Bharatiya Vidya Bhavan');
INSERT INTO Books VALUES('978-93-84039-06-0', 'India After Gandhi', 'History', 80, 'No', 'Ramachandra Guha', 'HarperCollins India');
INSERT INTO Books VALUES('978-81-7223-580-2', 'Wings of Fire', 'Biography', 65, 'Yes', 'A.P.J. Abdul Kalam', 'Universities Press');
INSERT INTO Books VALUES('978-93-5029-455-3', 'Indian Polity', 'Politics', 75, 'No', 'M. Laxmikanth', 'McGraw Hill Education');
INSERT INTO Books VALUES('978-93-5287-161-2', 'The God of Small Things', 'Fiction', 50, 'Yes', 'Arundhati Roy', 'Penguin India');

SELECT * FROM Books;

# Customer Table
CREATE TABLE Customer (
    Customer_Id INT PRIMARY KEY,
    Customer_name VARCHAR(100),
    Customer_address VARCHAR(255),
    Reg_date DATE
);

INSERT INTO Customer VALUES(301, 'Anjali Raj', 'Sector 15, Noida', '2021-09-25');
INSERT INTO Customer VALUES(302, 'Vikram Singh', 'Koramangala, Bengaluru', '2022-01-10');
INSERT INTO Customer VALUES(303, 'Priya Nair', 'Andheri West, Mumbai', '2022-11-18');
INSERT INTO Customer VALUES(304, 'Suresh Kumar', 'T Nagar, Chennai', '2021-12-05');
INSERT INTO Customer VALUES(305, 'Ritika S', 'Salt Lake, Kolkata', '2023-04-10');
DROP TABLE Customer;
SELECT * FROM Customer;

# Issue_Status Table
CREATE TABLE Issue_Status(
    Issue_Id INT PRIMARY KEY,
    Issued_cust INT,
    Issued_book_name VARCHAR(255),
    Issue_date DATE,
    Isbn_book VARCHAR(20),
    FOREIGN KEY (Issued_cust) REFERENCES Customer(Customer_Id),
    FOREIGN KEY (Isbn_book) REFERENCES Books(ISBN)
);

INSERT INTO Issue_Status VALUES (1, 301, 'The Mahabharata', '2023-06-12', '978-81-291-0892-5');
INSERT INTO Issue_Status VALUES (2, 302, 'India After Gandhi', '2023-05-23', '978-93-84039-06-0');
INSERT INTO Issue_Status VALUES (3, 303, 'Indian Polity', '2023-06-15', '978-93-5029-455-3');

SELECT * FROM Issue_Status;

# Return_Status Table
CREATE TABLE Return_Status (
    Return_Id INT PRIMARY KEY,
    Return_cust INT,
    Return_book_name VARCHAR(255),
    Return_date DATE,
    Isbn_book2 VARCHAR(20),
    FOREIGN KEY (Return_cust) REFERENCES Customer(Customer_Id),
    FOREIGN KEY (Isbn_book2) REFERENCES Books(ISBN)
);

INSERT INTO Return_Status VALUES (1, 301, 'The Mahabharata', '2023-06-20', '978-81-291-0892-5');
INSERT INTO Return_Status VALUES (2, 302, 'India After Gandhi', '2023-06-10', '978-93-84039-06-0');

SELECT * FROM Return_Status;

#1. Retrieve the book title, category, and rental price of all available books.
SELECT Book_title, Category, Rental_Price FROM Books WHERE Status = 'Yes';

#2. List the employee names and their respective salaries in descending order of salary.
SELECT Emp_name, Salary FROM Employee ORDER BY Salary DESC;

#3. Retrieve the book titles and the corresponding customers who have issued those books.
SELECT B.Book_title, C.Customer_name
FROM Issue_Status I
JOIN Books B ON I.Isbn_book = B.ISBN
JOIN Customer C ON I.Issued_cust = C.Customer_Id;

# 4. Display the total count of books in each category. 
SELECT Category, COUNT(*) AS TotalBooks FROM Books GROUP BY Category;

#5. Retrieve the employee names and their positions for the employees whose salaries are above Rs.50,000. 
SELECT Emp_name, Position,Salary FROM Employee WHERE Salary > 50000;

#6. List the customer names who registered before 2022-01-01 and have not issued any books yet. 
SELECT Customer_Id,C.Customer_name FROM Customer C
LEFT JOIN Issue_Status I ON C.Customer_Id = I.Issued_cust
WHERE C.Reg_date < '2022-01-01' AND I.Issue_Id IS NULL;

#7. Display the branch numbers and the total count of employees in each branch. 
SELECT Branch_no, COUNT(*) AS EmployeeCount FROM Employee GROUP BY Branch_no;

#8. Display the names of customers who have issued books in the month of June 2023. 
SELECT C.Customer_name
FROM Issue_Status I
JOIN Customer C ON I.Issued_cust = C.Customer_Id
WHERE I.Issue_date BETWEEN '2023-06-01' AND '2023-06-30';

#9. Retrieve book_title from book table containing history.
SELECT Book_title FROM Books WHERE Category LIKE '%History%';

#10.Retrieve the branch numbers along with the count of employees for branches having more than 5 employees 
SELECT Branch_no, COUNT(*) AS EmployeeCount FROM Employee GROUP BY Branch_no HAVING COUNT(*) > 5;

#11. Retrieve the names of employees who manage branches and their respective branch addresses. 
SELECT E.Emp_name, B.Branch_address
FROM Employee E
JOIN Branch B ON E.Emp_Id = B.Manager_Id;

#12. Display the names of customers who have issued books with a rental price higher than Rs. 25.
SELECT C.Customer_name
FROM Issue_Status I
JOIN Books B ON I.Isbn_book = B.ISBN
JOIN Customer C ON I.Issued_cust = C.Customer_Id
WHERE B.Rental_Price > 25;