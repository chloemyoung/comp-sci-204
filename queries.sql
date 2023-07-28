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

SELECT bk.BookTitle
FROM Book bk
INNER JOIN Borrower b
    ON bk.BookID = b.BookID
WHERE b.BorrowDate BETWEEN '2015-01-01' AND '2017-12-31'
GROUP BY bk.BookTitle
ORDER BY COUNT(bk.BookTitle) DESC
LIMIT 1;

SELECT bk.Genre
FROM Book bk
INNER JOIN Borrower b
    ON bk.BookID = b.BookID
INNER JOIN Client c
    ON c.ClientID = b.ClientID
WHERE c.ClientDOB BETWEEN 1970 AND 1980
GROUP BY bk.Genre
ORDER BY COUNT(bk.Genre) DESC;

SELECT c.Occupation
FROM Client c 
INNER JOIN Borrower b 
    ON c.ClientID = b.ClientID
INNER JOIN Book bk
    ON b.BookID = bk.BookID
WHERE b.BorrowDate BETWEEN '2016-01-1' AND '2016-12-31'
GROUP BY c.Occupation
ORDER BY COUNT(c.Occupation) DESC
LIMIT 5;

SELECT 
    c.Occupation,
    AVG(bo.BorrowCount) AS AverageBorrows
FROM Client c
INNER JOIN (
    SELECT ClientID, COUNT(*) BorrowCount
    FROM Borrower
    GROUP BY ClientID 
) bo 
    ON bo.ClientID = c.ClientID 
GROUP BY c.Occupation;

CREATE OR REPLACE VIEW DisplayTitlesView AS 
SELECT BookTitle 
FROM Book bk 
INNER JOIN Borrower b
    ON b.BookID = bk.BookID 
GROUP BY bk.BookTitle
HAVING COUNT(bk.BookTitle) >= (
    SELECT COUNT(*) / 5
    FROM Client
);

SELECT * FROM DisplayTitlesView;


SELECT MONTHNAME(BorrowDate) AS TopMonth
FROM Borrower
WHERE BorrowDate BETWEEN '2017-01-01' AND '2017-12-31'
GROUP BY 
    MONTHNAME(BorrowDate), 
    MONTH(BorrowDate)
ORDER BY 
    COUNT(*) DESC,
    MONTH(BorrowDate) DESC
LIMIT 1;


SELECT 
    year(curdate()) - ClientDOB AS Age,
    AVG(bo.BorrowCount) AS AverageBorrows
FROM Client c
INNER JOIN (
    SELECT ClientID, COUNT(*) BorrowCount
    FROM Borrower
    GROUP BY ClientID 
) bo 
    ON bo.ClientID = c.ClientID 
GROUP BY year(curdate()) - ClientDOB
ORDER BY year(curdate()) - ClientDOB;


SET @MaxAge := (
    SELECT MAX(year(curdate()) - ClientDOB)
    FROM Client
);

SET @MinAge := (
    SELECT MIN(year(curdate()) - ClientDOB)
    FROM Client
);

SELECT c.*, year(curdate()) - ClientDOB AS Age
FROM Client c 
WHERE year(curdate()) - ClientDOB = @MinAge 
UNION 
SELECT c.*, year(curdate()) - ClientDOB AS Age
FROM Client c
WHERE year(curdate()) - ClientDOB = @MaxAge
;

SELECT AuthorFirstName, AuthorLastName
FROM Author a
INNER JOIN (
    SELECT COUNT(DISTINCT Genre) as GenreCount, AuthorID
    FROM Book
    GROUP BY Genre, AuthorID
) b ON b.AuthorID = a.AuthorID
WHERE b.GenreCount > 1;

beep