-- Use the current selected database in pgAdmin (no need for USE)

-- Creating a table called EmployeeSalaries
CREATE TABLE EmployeeSalaries (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(50),
    dept VARCHAR(50),
    salary INT,
    joining_year INT
);

-- Inserting sample data
INSERT INTO EmployeeSalaries VALUES
(1, 'Alice', 'HR', 45000, 2020),
(2, 'Bob', 'Engineering', 70000, 2021),
(3, 'Charlie', 'Engineering', 60000, 2020),
(4, 'David', 'Marketing', 50000, 2022),
(5, 'Eve', 'HR', 48000, 2021),
(6, 'Frank', 'Engineering', 72000, 2022);

-- Window Function – Rank Employees by Salary per Department
SELECT emp_name, dept, salary,
       RANK() OVER (PARTITION BY dept ORDER BY salary DESC) AS dept_rank
FROM EmployeeSalaries;

-- Subquery – Employees Earning More Than Their Department’s Average
SELECT emp_name, salary, dept
FROM EmployeeSalaries e
WHERE salary > (
    SELECT AVG(salary)
    FROM EmployeeSalaries
    WHERE dept = e.dept
);

-- CTE – Top 3 Earners Across All Departments
WITH RankedSalaries AS (
    SELECT emp_name, dept, salary,
           DENSE_RANK() OVER (ORDER BY salary DESC) AS sal_rank
    FROM EmployeeSalaries
)
SELECT * FROM RankedSalaries
WHERE sal_rank <= 3;
