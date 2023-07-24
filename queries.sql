SELECT * from Client;


SELECT 
    ClientFirstName, 
    ClientLastName,
    year(curdate()) - ClientDOB AS Age,
    Occupation
FROM Client;


SELECT 
    c.ClientFirstName,
    c.ClientLastName
FROM Client c
INNER JOIN Borrower b
    ON c.ClientID = b.ClientID
WHERE b.BorrowDate BETWEEN '2018-03-01' AND '2018-03-31';


SELECT
    a.AuthorFirstName,
    a.AuthorLastName
FROM Author a
INNER JOIN Book bk
    ON a.AuthorID = bk.AuthorID
INNER JOIN Borrower b 
    ON bk.BookID = b.BookID
WHERE b.BorrowDate BETWEEN '2017-01-01' AND '2017-12-31'
GROUP BY 
    a.AuthorFirstName, 
    a.AuthorLastName
ORDER BY COUNT(a.AuthorID) DESC
LIMIT 5;


SELECT a.AuthorNationality
FROM Author a 
INNER JOIN Book bk
    ON a.AuthorID = bk.AuthorID
INNER JOIN Borrower b
    ON bk.BookID = b.BookID
WHERE b.BorrowDate BETWEEN '2015-01-01' AND '2017-12-31'
GROUP BY  a.AuthorNationality
ORDER BY COUNT(a.AuthorID) ASC
LIMIT 5;
