<!---# SQLCodingChallenge
#my answers for the queries are:
#in SQLCodingChallenge.sql
###Coding Challenge SQL
Virtual Art Gallery Shema DDL and DML
-- Create the Artists table
CREATE TABLE Artists (
 ArtistID INT PRIMARY KEY,
 Name VARCHAR(255) NOT NULL,
 Biography TEXT,
 Nationality VARCHAR(100));
-- Create the Categories table
CREATE TABLE Categories (
 CategoryID INT PRIMARY KEY,
 Name VARCHAR(100) NOT NULL);
-- Create the Artworks table
CREATE TABLE Artworks (
 ArtworkID INT PRIMARY KEY,
 Title VARCHAR(255) NOT NULL,
 ArtistID INT,
 CategoryID INT,
 Year INT,
 Description TEXT,
 ImageURL VARCHAR(255),
 FOREIGN KEY (ArtistID) REFERENCES Artists (ArtistID),
 FOREIGN KEY (CategoryID) REFERENCES Categories (CategoryID));
-- Create the Exhibitions table
CREATE TABLE Exhibitions (
 ExhibitionID INT PRIMARY KEY,
 Title VARCHAR(255) NOT NULL,
 StartDate DATE,
 EndDate DATE,
 Description TEXT);
-- Create a table to associate artworks with exhibitions
CREATE TABLE ExhibitionArtworks (
 ExhibitionID INT,
 ArtworkID INT,
 PRIMARY KEY (ExhibitionID, ArtworkID),
 FOREIGN KEY (ExhibitionID) REFERENCES Exhibitions (ExhibitionID),
 FOREIGN KEY (ArtworkID) REFERENCES Artworks (ArtworkID));
© Hexaware Technologies Limited. All rights www.hexaware.com
DML(Insert sample data to tables)
-- Insert sample data into the Artists table
INSERT INTO Artists (ArtistID, Name, Biography, Nationality) VALUES
 (1, 'Pablo Picasso', 'Renowned Spanish painter and sculptor.', 'Spanish'),
 (2, 'Vincent van Gogh', 'Dutch post-impressionist painter.', 'Dutch'),
 (3, 'Leonardo da Vinci', 'Italian polymath of the Renaissance.', 'Italian');
-- Insert sample data into the Categories table
INSERT INTO Categories (CategoryID, Name) VALUES
 (1, 'Painting'),
 (2, 'Sculpture'),
 (3, 'Photography');
-- Insert sample data into the Artworks table
INSERT INTO Artworks (ArtworkID, Title, ArtistID, CategoryID, Year, Description, ImageURL) VALUES
 (1, 'Starry Night', 2, 1, 1889, 'A famous painting by Vincent van Gogh.', 'starry_night.jpg'),
 (2, 'Mona Lisa', 3, 1, 1503, 'The iconic portrait by Leonardo da Vinci.', 'mona_lisa.jpg'),
 (3, 'Guernica', 1, 1, 1937, 'Pablo Picasso\'s powerful anti-war mural.', 'guernica.jpg');
-- Insert sample data into the Exhibitions table
INSERT INTO Exhibitions (ExhibitionID, Title, StartDate, EndDate, Description) VALUES
 (1, 'Modern Art Masterpieces', '2023-01-01', '2023-03-01', 'A collection of modern art masterpieces.'),
 (2, 'Renaissance Art', '2023-04-01', '2023-06-01', 'A showcase of Renaissance art treasures.');
-- Insert artworks into exhibitions
INSERT INTO ExhibitionArtworks (ExhibitionID, ArtworkID) VALUES
 (1, 1),
 (1, 2),
 (1, 3),
 (2, 2);
Solve the below queries:
1. Retrieve the names of all artists along with the number of artworks they have in the gallery, and
list them in descending order of the number of artworks.
2. List the titles of artworks created by artists from 'Spanish' and 'Dutch' nationalities, and order
them by the year in ascending order.
3. Find the names of all artists who have artworks in the 'Painting' category, and the number of
artworks they have in this category.
4. List the names of artworks from the 'Modern Art Masterpieces' exhibition, along with their
artists and categories.
5. Find the artists who have more than two artworks in the gallery.
6. Find the titles of artworks that were exhibited in both 'Modern Art Masterpieces' and
'Renaissance Art' exhibitions
© Hexaware Technologies Limited. All rights www.hexaware.com
7. Find the total number of artworks in each category
8. List artists who have more than 3 artworks in the gallery.
9. Find the artworks created by artists from a specific nationality (e.g., Spanish).
10. List exhibitions that feature artwork by both Vincent van Gogh and Leonardo da Vinci.
11. Find all the artworks that have not been included in any exhibition.
12. List artists who have created artworks in all available categories.
13. List the total number of artworks in each category.
14. Find the artists who have more than 2 artworks in the gallery.
15. List the categories with the average year of artworks they contain, only for categories with more
than 1 artwork.
16. Find the artworks that were exhibited in the 'Modern Art Masterpieces' exhibition.
17. Find the categories where the average year of artworks is greater than the average year of all
artworks.
18. List the artworks that were not exhibited in any exhibition.
19. Show artists who have artworks in the same category as "Mona Lisa."
20. List the names of artists and the number of artworks they have in the gallery###--->
