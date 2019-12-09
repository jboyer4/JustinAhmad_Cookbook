/* Many of the following queries will not work unless 
the dummy data (?) is replaced with real data*/

-- ***Search Select Query --
SELECT name, cook_time FROM Recipes WHERE cook_time = ?

-------------- *** Regular Select Queries*** -------------- 
-- Recipes select --
SELECT * FROM Recipes;

-- Sources select --
SELECT * FROM Sources;

-- Ingredients select --
SELECT * FROM Ingredients;

-- Tags select --
SELECT * FROM Tags;

-- Recipe_Tags select --
SELECT * FROM Recipe_Tags;

-------------- ***Insert Queries*** --------------
-- Recipes insert --
INSERT INTO Recipes (name, serving_size, cook_time, instructions) VALUES (?,?,?,?);

-- Sources insert --
INSERT INTO Sources (name, author, year_published) VALUES (?,?,?)

-- Ingredients insert --
INSERT INTO Ingredients (recipe_id, name, amount, units) VALUES ((select id from Recipes where id = ?),?,?, ?)

-- Tags insert --
INSERT INTO Tags (name, catagory) VALUES (?,?)

-- Recipe_Tags insert --
INSERT INTO Recipe_Tags (Recipe_id, Tag_id) VALUES (?,?)


-------------- ***Delete Queries*** --------------
-- Recipes delete --
DELETE FROM Recipes WHERE id = ?

-- Sources delete --
DELETE FROM Sources WHERE id = ?

-- Recipe_Tags delete --
DELETE FROM Recipe_Tags WHERE (recipe_id = ? AND tag_id = ?)

-------------- ***Update Query*** --------------
-- Recipes update --
UPDATE Recipes SET name = ?, serving_size = ?, instructions = ?, cook_time = ?, source_id = ? WHERE id = ?


