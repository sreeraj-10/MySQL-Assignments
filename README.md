Project Overview
The Library Management System is designed to keep track of all essential information related to a library. This system will store and manage details about books, branches, employees, customers, and the status of issued and returned books. The system is implemented with a relational database, making it easier to query and retrieve information efficiently.

Purpose
The primary goal of this system is to help libraries manage their resources effectively by tracking:

Book availability, status, and costs.
Employee details, positions, and salaries.
Information about customers, including their registration and issued books.
Records of issued and returned books.
Database Setup
Database Name:
The database is named library and includes six key tables:

Branch
Employee
Books
Customer
IssueStatus
ReturnStatus
1. Branch Table
This table stores information about library branches.

Attributes:
Branch_no (Primary Key): Unique identifier for each branch.
Manager_Id: Manager of the branch.
Branch_address: Address of the library branch.
Contact_no: Contact number of the branch.# MySQL-Assignments
Library Management System
