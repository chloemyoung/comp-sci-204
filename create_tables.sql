USE library;
CREATE TABLE Author (
    AuthorID INT AUTO_INCREMENT PRIMARY KEY,
    AuthorFirstName VARCHAR(50),
    AuthorLastName VARCHAR(50),
    AuthorNationality VARCHAR(50)
);

CREATE TABLE Client (
    ClientID INT AUTO_INCREMENT PRIMARY KEY,
    ClientFirstName VARCHAR(50),
    ClientLastName VARCHAR(50),
    ClientDOB YEAR,
    Occupation VARCHAR(50)
);

CREATE TABLE Book (
    BookID INT AUTO_INCREMENT PRIMARY KEY,
    BookTitle VARCHAR(100),
    AuthorID INT,
    Genre VARCHAR(100),
    FOREIGN KEY (AuthorID) REFERENCES Author(AuthorID)
);

CREATE TABLE Borrower (
    BorrowID INT AUTO_INCREMENT PRIMARY KEY,
    ClientID INT,
    BookID INT,
    BorrowDate DATE,
    FOREIGN KEY (ClientID) REFERENCES Client(ClientID),
    FOREIGN KEY (BookID) REFERENCES Book(BookID)
);              