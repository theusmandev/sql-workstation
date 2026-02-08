CREATE TABLE library_books (
    book_id INT PRIMARY KEY,
    title VARCHAR(255),
    author VARCHAR(255),
    genre VARCHAR(100),
    publication_year INT,
    total_copies INT
);


CREATE TABLE borrowing_records (
    record_id INT PRIMARY KEY,
    book_id INT,
    borrower_name VARCHAR(255),
    borrow_date DATE,
    return_date DATE,
    CONSTRAINT FK_borrowing_books
        FOREIGN KEY (book_id) REFERENCES library_books(book_id)
);


INSERT INTO library_books (book_id, title, author, genre, publication_year, total_copies)
VALUES
(1, 'The Great Gatsby', 'F. Scott', 'Fiction', 1925, 3),
(2, 'To Kill a Mockingbird', 'Harper Lee', 'Fiction', 1960, 3),
(3, '1984', 'George Orwell', 'Dystopian', 1949, 1),
(4, 'Pride and Prejudice', 'Jane Austen', 'Romance', 1813, 2),
(5, 'The Catcher in the Rye', 'J.D. Salinger', 'Fiction', 1951, 1),
(6, 'Brave New World', 'Aldous Huxley', 'Dystopian', 1932, 4);




INSERT INTO borrowing_records (record_id, book_id, borrower_name, borrow_date, return_date)
VALUES
(1, 1, 'Alice Smith',  '2024-01-15', NULL),
(2, 1, 'Bob Johnson',  '2024-01-20', NULL),
(3, 2, 'Carol White',  '2024-01-10', '2024-01-25'),
(4, 3, 'David Brown',  '2024-02-01', NULL),
(5, 4, 'Emma Wilson',  '2024-01-05', NULL),
(6, 5, 'Frank Davis',  '2024-01-18', '2024-02-10'),
(7, 1, 'Grace Miller', '2024-02-05', NULL),
(8, 6, 'Henry Taylor', '2024-01-12', NULL),
(9, 2, 'Ivan Clark',   '2024-02-12', NULL),
(10,2, 'Jane Adams',   '2024-02-15', NULL);



select * from library_books
select * from borrowing_records







WITH CurrentBorrowers AS (
    -- Step 1 & 2: Filter active borrows and count per book
    SELECT 
    book_id, 
    COUNT(*) AS current_borrowers
    FROM borrowing_records
    WHERE return_date IS NULL
    GROUP BY book_id
)

-- Step 3 & 4: Join with main table and compare
SELECT 
    lb.book_id, 
    lb.title, 
    lb.author, 
    lb.genre, 
    lb.publication_year, 
    cb.current_borrowers
FROM library_books lb
JOIN CurrentBorrowers cb ON lb.book_id = cb.book_id
WHERE lb.total_copies = cb.current_borrowers
ORDER BY cb.current_borrowers DESC, lb.title ASC;





