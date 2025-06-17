CREATE TABLE Artists (
    ArtistID INT PRIMARY KEY,
    Name VARCHAR(255) NOT NULL,
    Biography TEXT,
    Nationality VARCHAR(100)
);


CREATE TABLE Categories (
    CategoryID INT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL
);


CREATE TABLE Artworks (
    ArtworkID INT PRIMARY KEY,
    Title VARCHAR(255) NOT NULL,
    ArtistID INT,
    CategoryID INT,
    Year INT,
    Description TEXT,
    ImageURL VARCHAR(255),
    FOREIGN KEY (ArtistID) REFERENCES Artists (ArtistID),
    FOREIGN KEY (CategoryID) REFERENCES Categories (CategoryID)
);


CREATE TABLE Exhibitions (
    ExhibitionID INT PRIMARY KEY,
    Title VARCHAR(255) NOT NULL,
    StartDate DATE,
    EndDate DATE,
    Description TEXT
);


CREATE TABLE ExhibitionArtworks (
    ExhibitionID INT,
    ArtworkID INT,
    PRIMARY KEY (ExhibitionID, ArtworkID),
    FOREIGN KEY (ExhibitionID) REFERENCES Exhibitions (ExhibitionID),
    FOREIGN KEY (ArtworkID) REFERENCES Artworks (ArtworkID)
);




INSERT INTO Artists (ArtistID, Name, Biography, Nationality) VALUES
(1, 'Pablo Picasso', 'Renowned Spanish painter and sculptor.', 'Spanish'),
(2, 'Vincent van Gogh', 'Dutch post-impressionist painter.', 'Dutch'),
(3, 'Leonardo da Vinci', 'Italian polymath of the Renaissance.', 'Italian');


INSERT INTO Categories (CategoryID, Name) VALUES
(1, 'Painting'),
(2, 'Sculpture'),
(3, 'Photography');

INSERT INTO Artworks (ArtworkID, Title, ArtistID, CategoryID, Year, Description, ImageURL) VALUES
(1, 'Starry Night', 2, 1, 1889, 'A famous painting by Vincent van Gogh.', 'starry_night.jpg'),
(2, 'Mona Lisa', 3, 1, 1503, 'The iconic portrait by Leonardo da Vinci.', 'mona_lisa.jpg'),
(3, 'Guernica', 1, 1, 1937, 'Pablo Picasso\s powerful anti-war mural.', 'guernica.jpg');


INSERT INTO Exhibitions (ExhibitionID, Title, StartDate, EndDate, Description) VALUES
(1, 'Modern Art Masterpieces', '2023-01-01', '2023-03-01', 'A collection of modern art masterpieces.'),
(2, 'Renaissance Art', '2023-04-01', '2023-06-01', 'A showcase of Renaissance art treasures.');

INSERT INTO ExhibitionArtworks (ExhibitionID, ArtworkID) VALUES
(1, 1),
(1, 2),
(1, 3),
(2, 2);

--1.
SELECT 
    ar.Name AS ArtistName,
    COUNT(aw.ArtworkID) AS NumberOfArtworks
FROM Artists ar
LEFT JOIN Artworks aw ON ar.ArtistID = aw.ArtistID
GROUP BY ar.ArtistID, ar.Name
ORDER BY NumberOfArtworks DESC;

--2.
SELECT 
    aw.Title,
    ar.Name AS ArtistName,
    ar.Nationality,
    aw.Year
FROM Artworks aw
JOIN Artists ar ON aw.ArtistID = ar.ArtistID
WHERE ar.Nationality IN ('Spanish', 'Dutch')
ORDER BY aw.Year ASC;

--3.
SELECT 
    ar.Name AS ArtistName,
    COUNT(aw.ArtworkID) AS NumberOfPaintings
FROM Artists ar
JOIN Artworks aw ON ar.ArtistID = aw.ArtistID
JOIN Categories c ON aw.CategoryID = c.CategoryID
WHERE c.Name = 'Painting'
GROUP BY ar.ArtistID, ar.Name;


--4
SELECT 
    aw.Title AS ArtworkTitle,
    ar.Name AS ArtistName,
    c.Name AS CategoryName
FROM ExhibitionArtworks ea
JOIN Exhibitions e ON ea.ExhibitionID = e.ExhibitionID
JOIN Artworks aw ON ea.ArtworkID = aw.ArtworkID
JOIN Artists ar ON aw.ArtistID = ar.ArtistID
JOIN Categories c ON aw.CategoryID = c.CategoryID
WHERE e.Title = 'Modern Art Masterpieces';


INSERT INTO Artworks (ArtworkID, Title, ArtistID, CategoryID, Year, Description, ImageURL) VALUES
(4, 'Les Demoiselles Avignon', 1, 1, 1907, 'A revolutionary painting by Picasso.', 'les_demoiselles.jpg'),
(5, 'The Weeping Woman', 1, 1, 1937, 'One of Picasso most famous portraits.', 'weeping_woman.jpg'),
(6, 'The Old Guitarist', 1, 1, 1903, 'A painting from Picasso Blue Period.', 'old_guitarist.jpg');


--5.
SELECT 
    ar.Name AS ArtistName,
    COUNT(aw.ArtworkID) AS NumberOfArtworks
FROM Artists ar
JOIN Artworks aw ON ar.ArtistID = aw.ArtistID
GROUP BY ar.ArtistID, ar.Name
HAVING COUNT(aw.ArtworkID) > 2;

--6.
SELECT a.Title
FROM Artworks a
JOIN ExhibitionArtworks ea1 ON a.ArtworkID = ea1.ArtworkID
JOIN Exhibitions e1 ON ea1.ExhibitionID = e1.ExhibitionID
JOIN ExhibitionArtworks ea2 ON a.ArtworkID = ea2.ArtworkID
JOIN Exhibitions e2 ON ea2.ExhibitionID = e2.ExhibitionID
WHERE e1.Title = 'Modern Art Masterpieces'
  AND e2.Title = 'Renaissance Art';


--7.
SELECT 
    c.Name AS CategoryName,
    COUNT(a.ArtworkID) AS TotalArtworks
FROM Categories c
LEFT JOIN Artworks a ON c.CategoryID = a.CategoryID
GROUP BY c.CategoryID, c.Name;

--8.
SELECT 
    ar.Name AS ArtistName,
    COUNT(aw.ArtworkID) AS NumberOfArtworks
FROM Artists ar
JOIN Artworks aw ON ar.ArtistID = aw.ArtistID
GROUP BY ar.ArtistID, ar.Name
HAVING COUNT(aw.ArtworkID) > 3;


--9.
SELECT 
    aw.Title AS ArtworkTitle,
    ar.Name AS ArtistName,
    ar.Nationality
FROM Artworks aw
JOIN Artists ar ON aw.ArtistID = ar.ArtistID
WHERE ar.Nationality = 'Spanish';


--10.
SELECT e.Title
FROM Exhibitions e
JOIN ExhibitionArtworks ea1 ON e.ExhibitionID = ea1.ExhibitionID
JOIN Artworks a1 ON ea1.ArtworkID = a1.ArtworkID
JOIN Artists ar1 ON a1.ArtistID = ar1.ArtistID
WHERE ar1.Name = 'Vincent van Gogh'

INTERSECT

SELECT e.Title
FROM Exhibitions e
JOIN ExhibitionArtworks ea2 ON e.ExhibitionID = ea2.ExhibitionID
JOIN Artworks a2 ON ea2.ArtworkID = a2.ArtworkID
JOIN Artists ar2 ON a2.ArtistID = ar2.ArtistID
WHERE ar2.Name = 'Leonardo da Vinci';




--11.
SELECT 
    aw.Title AS ArtworkTitle
FROM Artworks aw
LEFT JOIN ExhibitionArtworks ea ON aw.ArtworkID = ea.ArtworkID
WHERE ea.ExhibitionID IS NULL;


-- Add a sculpture for Pablo Picasso
INSERT INTO Artworks (ArtworkID, Title, ArtistID, CategoryID, Year, Description, ImageURL)
VALUES (10, 'Picasso Sculpture 1', 1, 2, 1940, 'A sculpture by Picasso.', 'picasso_sculpture1.jpg');

-- Add a photograph for Pablo Picasso
INSERT INTO Artworks (ArtworkID, Title, ArtistID, CategoryID, Year, Description, ImageURL)
VALUES (11, 'Picasso Photo 1', 1, 3, 1945, 'A photograph by Picasso.', 'picasso_photo1.jpg');



--12.
SELECT ar.Name
FROM Artists ar
JOIN Artworks aw ON ar.ArtistID = aw.ArtistID
JOIN Categories c ON aw.CategoryID = c.CategoryID
GROUP BY ar.ArtistID, ar.Name
HAVING COUNT(DISTINCT c.CategoryID) = (SELECT COUNT(*) FROM Categories);


--13.
SELECT 
    c.Name AS CategoryName,
    COUNT(a.ArtworkID) AS TotalArtworks
FROM Categories c
LEFT JOIN Artworks a ON c.CategoryID = a.CategoryID
GROUP BY c.CategoryID, c.Name;

--14.
SELECT 
    ar.Name AS ArtistName,
    COUNT(aw.ArtworkID) AS NumberOfArtworks
FROM Artists ar
JOIN Artworks aw ON ar.ArtistID = aw.ArtistID
GROUP BY ar.ArtistID, ar.Name
HAVING COUNT(aw.ArtworkID) > 2;


--15.
SELECT 
    c.Name AS CategoryName,
    AVG(a.Year) AS AverageYear
FROM Categories c
JOIN Artworks a ON c.CategoryID = a.CategoryID
GROUP BY c.CategoryID, c.Name
HAVING COUNT(a.ArtworkID) > 1;

--16.
SELECT a.Title AS ArtworkTitle
FROM Artworks a
JOIN ExhibitionArtworks ea ON a.ArtworkID = ea.ArtworkID
JOIN Exhibitions e ON ea.ExhibitionID = e.ExhibitionID
WHERE e.Title = 'Modern Art Masterpieces';

--17.
SELECT c.Name AS CategoryName
FROM Categories c
JOIN Artworks a ON c.CategoryID = a.CategoryID
GROUP BY c.CategoryID, c.Name
HAVING AVG(a.Year) > (SELECT AVG(Year) FROM Artworks);

--18.
SELECT a.Title AS ArtworkTitle
FROM Artworks a
LEFT JOIN ExhibitionArtworks ea ON a.ArtworkID = ea.ArtworkID
WHERE ea.ExhibitionID IS NULL;


--19.
SELECT DISTINCT ar.Name AS ArtistName
FROM Artists ar
JOIN Artworks a ON ar.ArtistID = a.ArtistID
WHERE a.CategoryID = (
    SELECT CategoryID
    FROM Artworks
    WHERE Title = 'Mona Lisa'
);

--20.
SELECT ar.Name AS ArtistName, COUNT(a.ArtworkID) AS NumberOfArtworks
FROM Artists ar
LEFT JOIN Artworks a ON ar.ArtistID = a.ArtistID
GROUP BY ar.ArtistID, ar.Name;

