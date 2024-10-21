# MySQL-Assignments
The Library Management System is designed to keep track of all essential information related to a library. This system will store and manage details about books, branches, employees, customers, and the status of issued and returned books. The system is implemented with a relational database, making it easier to query and retrieve information efficiently.

## Project Objectives

- Book availability, status, and costs.
- Employee details, positions, and salaries.
- Information about customers, including their registration and issued books.
- Records of issued and returned books.

## Database Setup

#### Database Name:
The database is named library and includes six key tables:
- Branch
- Employee
- Books
- Customer
- IssueStatus
- ReturnStatus

#### 1. Branch Table
This table stores information about library branches.

##### Attributes:
- Branch_no (Primary Key): Unique identifier for each branch.
- Manager_Id: Manager of the branch.
- Branch_address: Address of the library branch.
- Contact_no: Contact number of the branch.

- ![Screenshot 2024-10-21 104134](https://github.com/user-attachments/assets/b9ad5cf2-b725-4471-876b-0300a57a1e81)


#### 2. Employee Table
This table stores information about library employees.

##### Attributes:
- Emp_Id (Primary Key): Unique identifier for each employee.
- Emp_name: Name of the employee.
- Position: Position of the employee (e.g., Manager, Staff).
- Salary: Employee's salary.
- Branch_no (Foreign Key): Refers to Branch_no in the Branch table.

- ![Screenshot 2024-10-21 104200](https://github.com/user-attachments/assets/1d716935-db56-4420-8fd7-726d7849d81b)



#### 3. Books Table
This table stores information about books available in the library.

##### Attributes:
- ISBN (Primary Key): Unique identifier for each book.
- Book_title: Title of the book.
- Category: Book category (e.g., Fiction, Technology, History).
- Rental_Price: Price to rent the book.
- Status: Availability of the book (Yes if available, No if not available).
- Author: Author of the book.
- Publisher: Publisher of the book.

- ![Screenshot 2024-10-21 104222](https://github.com/user-attachments/assets/ac392f62-15e2-4eda-811b-899ee7315b8b)


#### 4. Customer Table
This table stores information about library customers.

##### Attributes:
- Customer_Id (Primary Key): Unique identifier for each customer.
- Customer_name: Name of the customer.
- Customer_address: Address of the customer.
- Reg_date: Registration date of the customer.

- ![Screenshot 2024-10-21 104327](https://github.com/user-attachments/assets/3e9c8df3-54ac-4dc3-92cf-012e40e22873)


#### 5. IssueStatus Table
This table stores information about the books issued to customers.

##### Attributes:
- Issue_Id (Primary Key): Unique identifier for each issue.
- Issued_cust (Foreign Key): Refers to Customer_Id in the Customer table.
- Issued_book_name: Name of the issued book.
- Issue_date: Date when the book was issued.
- Isbn_book (Foreign Key): Refers to ISBN in the Books table.

- ![Screenshot 2024-10-21 104347](https://github.com/user-attachments/assets/23d6b50a-9561-4f29-96c0-867b139b9d73)


#### 6. ReturnStatus Table
This table stores information about books returned by customers.

##### Attributes:
- Return_Id (Primary Key): Unique identifier for each return.
- Return_cust (Foreign Key): Refers to Customer_Id in the Customer table.
- Return_book_name: Name of the returned book.
- Return_date: Date when the book was returned.
- Isbn_book2 (Foreign Key): Refers to ISBN in the Books table.

- ![Screenshot 2024-10-21 104401](https://github.com/user-attachments/assets/5d6af70e-9c03-4920-a1a3-5191135da11b)


## Queries and Results
##### 1. Retrieve the book title, category, and rental price of all available books.
```
SELECT Book_title, Category, Rental_Price 
FROM Books 
WHERE Status = 'Yes';
```
###### Result:
![1](https://github.com/user-attachments/assets/93677c6a-18df-4d5a-a3b3-fdd367b1e42d)

##### 2. List the employee names and their respective salaries in descending order of salary.
```
SELECT Emp_name, Salary 
FROM Employee 
ORDER BY Salary DESC;

```
###### Result:
![2](https://github.com/user-attachments/assets/77862fa8-c417-43dd-bb80-7d6b176bce5c)

##### 3. Retrieve the book titles and the corresponding customers who have issued those books.
```
SELECT Books.Book_title, Customer.Customer_name 
FROM IssueStatus
JOIN Books ON IssueStatus.Isbn_book = Books.ISBN
JOIN Customer ON IssueStatus.Issued_cust = Customer.Customer_Id;

```
###### Result:
![3](https://github.com/user-attachments/assets/b15a18ed-0307-4303-8e84-26c90f368698)

##### 4. Display the total count of books in each category.
```
SELECT Category, COUNT(*) AS TotalBooks 
FROM Books 
GROUP BY Category;

```
###### Result:
![4](https://github.com/user-attachments/assets/b9d09904-986f-4333-821b-3a932197e02b)

##### 5. Retrieve the employee names and their positions for the employees whose salaries are above Rs. 50,000.
sql
```
SELECT Emp_name, Position 
FROM Employee 
WHERE Salary > 50000;

```
###### Result:
![5](https://github.com/user-attachments/assets/ea36468b-fcdd-4f35-9634-68420248027c)

##### 6. List the customer names who registered before 2022-01-01 and have not issued any books yet.
```
SELECT Customer_name 
FROM Customer 
WHERE Reg_date < '2022-01-01'
AND Customer_Id NOT IN (SELECT Issued_cust FROM IssueStatus);
```
###### Result:
![6](https://github.com/user-attachments/assets/0a1eca8a-d179-4d51-8b1a-bfc8cdcfd2f5)

##### 7. Display the branch numbers and the total count of employees in each branch.
```
SELECT Branch_no, COUNT(*) AS TotalEmployees 
FROM Employee 
GROUP BY Branch_no;
```
###### Result: 
![7](https://github.com/user-attachments/assets/b21119f4-8848-49cc-85a1-ba200bcdc27e)

##### 8. Display the names of customers who have issued books in the month of June 2023.
sql
```
SELECT Customer.Customer_name 
FROM IssueStatus
JOIN Customer ON IssueStatus.Issued_cust = Customer.Customer_Id
WHERE Issue_date BETWEEN '2023-06-01' AND '2023-06-30';

```
###### Result: 
![8](https://github.com/user-attachments/assets/4f6b8cf5-bf7c-48fd-8110-1af93f52c6b9)

##### 9. Retrieve book_title from Books table containing the word "history."
```
SELECT Book_title 
FROM Books 
WHERE Book_title LIKE '%history%';
```
###### Result:
![9](https://github.com/user-attachments/assets/2871b54d-faf3-47b6-bbb0-8e83d4c8de25)

##### 10. Retrieve the branch numbers along with the count of employees for branches having more than 5 employees.
```
SELECT Branch_no, COUNT(*) AS TotalEmployees 
FROM Employee 
GROUP BY Branch_no
HAVING COUNT(*) > 5;
```
###### Result: 
![10](https://github.com/user-attachments/assets/04e35d3c-ef21-466f-83ae-7adda629f29a)


##### 11. Retrieve the names of employees who manage branches and their respective branch addresses.
```
SELECT Employee.Emp_name, Branch.Branch_address 
FROM Employee
JOIN Branch ON Employee.Emp_Id = Branch.Manager_Id;
```
###### Result: 
![11](https://github.com/user-attachments/assets/f9e2f9ac-3866-4739-b6bd-d626f24966e9)

##### 12. Display the names of customers who have issued books with a rental price higher than Rs. 25.
```
SELECT Customer.Customer_name 
FROM IssueStatus
JOIN Books ON IssueStatus.Isbn_book = Books.ISBN
JOIN Customer ON IssueStatus.Issued_cust = Customer.Customer_Id
WHERE Books.Rental_Price > 25;
```
###### Result: 
![12](https://github.com/user-attachments/assets/6bb9dcb9-3c78-4c82-9bab-310b2a82c36c)

## Installation

1. Create the database by running the provided SQL CREATE DATABASE command.
2. Execute the CREATE TABLE statements to set up the schema.
3. Insert sample data into the tables.
4. Run the provided queries to retrieve the required information.

## Conclusion
This Library Management System allows efficient management of a library's resources, with a focus on tracking book availability, customer issues, employee management, and book returns.
