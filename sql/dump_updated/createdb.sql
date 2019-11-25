CREATE TABLE `Source` (
 `id` int NOT NULL AUTO_INCREMENT,
 `name` varchar(25) NOT NULL,
 `year_published` INT,
 `author` varchar(25),
 PRIMARY KEY (`id`),
 UNIQUE (`name`)  
);

CREATE TABLE `Recipe` (
 `id` int NOT NULL AUTO_INCREMENT,
 `name` varchar(25) NOT NULL,
 `serving_size` INT,
 `cook_time` INT,
 `source_id` INT,
 `instructions` TEXT,
 PRIMARY KEY (`id`),
 UNIQUE (`name`),
 FOREIGN KEY (`source_id`) REFERENCES Source(id)  
);

CREATE TABLE `Ingredient` (
 `id` int NOT NULL AUTO_INCREMENT,
 `recipe_id` int NOT NULL,
 `name` varchar(25) NOT NULL,
 `amount` int,
 `unit` varchar(25),
 PRIMARY KEY (`id`),
 FOREIGN KEY (`recipe_id`) REFERENCES Recipe(`id`)
);


CREATE TABLE `Tag` (
 `id` int NOT NULL AUTO_INCREMENT,
 `name` varchar(25) NOT NULL,
 PRIMARY KEY (`id`) 
);

-- Recipe_tag
CREATE TABLE `Recipe_tag` (
 `recipe_id` int NOT NULL,
 `tag_id` int NOT NULL,
 FOREIGN KEY (`recipe_id`) REFERENCES Recipe(id),
 FOREIGN KEY (`tag_id`) REFERENCES Tag(id)  
);

-- 2 sample sources
INSERT INTO source (name, year_published, author) VALUES ("Cookbook Extravaganza", 2002, "Rachel Ray");
INSERT INTO source (name, year_published, author) VALUES ("Ahmad's Great Dishes", 2019, "Ahmad El-Bobou");

-- 3 sample recipes
INSERT INTO Recipe (name, source_id, cook_time, serving_size, instructions) VALUES
('Crispy Chicken Tenders', (select id from source WHERE author = 'Ahmad El-Bobou'),
25, 6, "First take the chicken. Then Coat it in flour. Dip it in batter. Coat it again. Lastly, fry until brown");

INSERT INTO Recipe (name, source_id, cook_time, serving_size, instructions) VALUES
('Spaghetti', (select id from source WHERE author = 'Rachel Ray'),
20, 4, "Boil noodles until soft. Cook the ground beef and add the sauce. Mix noodles with sauce and meat.");

INSERT INTO Recipe (name, cook_time, serving_size, instructions) VALUES
('Fruit Loops',
2, 1, "Pour the cereal into a bowl. Add milk to desired milkiness");

-- add ingredients: [chicken tenders(200), oil(1000), flour(500), batter(500)], [noodles(500), ground beef(250), spaghetti sauce(100)],
-- [fruit loops(50), milk(50)]
INSERT into ingredient (name, amount, recipe_id, unit) VALUES
("chicken tenders", 200, (SELECT id FROM Recipe where name = "Crispy Chicken Tenders"));

INSERT into ingredient (name, amount, recipe_id, unit) VALUES
("oil", 1000, (SELECT id FROM Recipe where name = "Crispy Chicken Tenders"), "ml");

INSERT into ingredient (name, amount, recipe_id, unit) VALUES
("flour", 500, (SELECT id FROM Recipe where name = "Crispy Chicken Tenders"), "grams");

INSERT into ingredient (name, amount, recipe_id, unit) VALUES
("batter", 500, (SELECT id FROM Recipe where name = "Crispy Chicken Tenders"), "ml");

INSERT into ingredient (name, amount, recipe_id, unit) VALUES
("noodles", 500, (SELECT id FROM Recipe where name = "Spaghetti"), "grams");

INSERT into ingredient (name, amount, recipe_id, unit) VALUES
("ground beef", 250, (SELECT id FROM Recipe where name = "Spaghetti"), "grams");

INSERT into ingredient (name, amount, recipe_id, unit) VALUES
("tomato sauce", 50, (SELECT id FROM Recipe where name = "Spaghetti"), "ml");

INSERT into ingredient (name, amount, recipe_id, unit) VALUES
("Fruit Loops Cereal", 50, (SELECT id FROM Recipe where name = "Fruit Loops"), "grams");

INSERT into ingredient (name, amount, recipe_id, unit) VALUES
("Milk", 50, (SELECT id FROM Recipe where name = "Fruit Loops"), "ml");


-- add tags - breakfast, italian, american, dinner, fried

INSERT into tag (name) VALUES ("breakfast");
INSERT into tag (name) VALUES ("Italian");
INSERT into tag (name) VALUES ("American");
INSERT into tag (name) VALUES ("dinner");
INSERT into tag (name) VALUES ("fried");


-- add tags relationships
INSERT into Recipe_tag (recipe_id, tag_id) VALUES
((select id from Recipe where name = "Fruit Loops"),
(select id from tag where name = 'breakfast'));

INSERT into Recipe_tag (recipe_id, tag_id) VALUES
((select id from Recipe where name = "Fruit Loops"),
(select id from tag where name = 'American'));


INSERT into Recipe_tag (recipe_id, tag_id) VALUES
((select id from Recipe where name = "Crispy Chicken Tenders"),
(select id from tag where name = 'American'));

INSERT into Recipe_tag (recipe_id, tag_id) VALUES
((select id from Recipe where name = "Crispy Chicken Tenders"),
(select id from tag where name = 'fried'));

INSERT into Recipe_tag (recipe_id, tag_id) VALUES
((select id from Recipe where name = "Crispy Chicken Tenders"),
(select id from tag where name = 'dinner'));


INSERT into Recipe_tag (recipe_id, tag_id) VALUES
((select id from Recipe where name = "Spaghetti"),
(select id from tag where name = 'Italian'));

INSERT into Recipe_tag (recipe_id, tag_id) VALUES
((select id from Recipe where name = "Crispy Chicken Tenders"),
(select id from tag where name = 'dinner'));