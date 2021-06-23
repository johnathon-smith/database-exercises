USE albums_db;

SELECT * FROM albums;
#There are 31 rows in the albums table

SELECT DISTINCT artist FROM albums;
#There are 23 distinct artists in the albums table

DESCRIBE albums;
#The primary key for the albums table is 'id'

SELECT max(release_date), min(release_date) FROM albums;
#The oldest release date is 1967 and the most recent release date is 2011

#Find the names of all the albums by Pink Floyd
SELECT * FROM albums WHERE artist = 'Pink Floyd';
#The Pink Floyd albums are 'The Dark Side of the Moon' and 'The Wall'

#Find the year Sgt. Pepper's Lonely Hearts Club Band was released
SELECT release_date FROM albums WHERE name = 'Sgt. Pepper\'s Lonely Hearts Club Band';
#Sgt. Pepper's Lonely Hearts Club Band was released in 1967

#Find the genre for Nevermind
SELECT genre FROM albums WHERE name = 'Nevermind';
#The genre for Nevermind is listed as Grunge, Alternative Rock

#Which albums were relased in the 1990's?
SELECT name FROM albums WHERE release_date BETWEEN 1990 AND 1999;
/*
The albums released in the 1990's are:

The Bodyguard
Jagged Little Pill
Come On Over
Falling into You
Let's Talk About Love
Dangerous
The Immaculate Collection
Titanic: Music from the Motion Picture
Metallica
Nevermind
Supernatural
*/

#Which albums had less than 20 million sales?
SELECT name FROM albums WHERE sales < 20;
/*
The following albums had less than 20 million sales:

Grease: The Original Soundtrack from the Motion Picture
Bad
Sgt. Pepper's Lonely Hearts Club Band
Dirty Dancing
Let's Talk About Love
Dangerous
The Immaculate Collection
Abbey Road
Born in the U.S.A.
Brothers in Arms
Titanic: Music from the Motion Picture
Nevermind
The Wall
*/

#Find all the albums with a genre of 'Rock'. Why do these results not include albums with genres of 'Hard Rock' or 'Progressive Rock'?
SELECT name FROM albums WHERE genre = 'Rock';
/*
The following albums have genre of 'Rock':

Sgt. Pepper's Lonely Hearts Club B
1
Abbey Road
Born in the U.S.A.
Supernatural

The albums with genres 'Hard Rock' or 'Progressive Rock' are not included in these results because SQL is searching for an exact match to 'Rock' for the genre.
*/