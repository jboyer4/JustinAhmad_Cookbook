-- Clear tables to rebuild them --
SET FOREIGN_KEY_CHECKS = 0;

DROP TABLE IF EXISTS `Sources`;
DROP TABLE IF EXISTS `Recipes`;
DROP TABLE IF EXISTS `Ingredients`;
DROP TABLE IF EXISTS `Tags`;
DROP TABLE IF EXISTS `Recipe_Tags`;

SET FOREIGN_KEY_CHECKS = 1;


-- Build Tables -- 

-- Sources --
CREATE TABLE IF NOT EXISTS `Sources` (
	`id` int(11) NOT NULL AUTO_INCREMENT,
	`name` varchar(225) NOT NULL,
	`year_published` int(11) DEFAULT NULL,
	`author` varchar(225) DEFAULT NULL,
	`url` varchar(225) DEFAULT NULL,
	PRIMARY KEY (`id`),
	UNIQUE (`name`)
	)
	ENGINE = InnoDB;
		
-- Recipes --
CREATE TABLE IF NOT EXISTS `Recipes` (
	`id` int(11) NOT NULL AUTO_INCREMENT,
	`name` varchar(225) NOT NULL,
	`serving_size` int(11) DEFAULT NULL,
	`cook_time` int(11) DEFAULT NULL,
	`source_id` int(11) DEFAULT NULL,
	`instructions` longtext,
	PRIMARY KEY (`id`),
	UNIQUE (`name`),
	FOREIGN KEY (`source_id`) REFERENCES Sources(`id`)
	)
	ENGINE=InnoDB;
	
-- Ingredients --
CREATE TABLE IF NOT EXISTS `Ingredients` (
	`id` int(11) NOT NULL AUTO_INCREMENT,
	`recipe_id` int NOT NULL,
	`name` varchar(225) NOT NULL,
	`amount` int,
	`units` varchar(225),
	PRIMARY KEY (`id`),
	FOREIGN KEY (`recipe_id`) REFERENCES Recipes(id)
	) 
	ENGINE=InnoDB;

-- Tags --	
CREATE TABLE IF NOT EXISTS `Tags` (
	`id` int(11) NOT NULL AUTO_INCREMENT,
	`name` varchar(225) NOT NULL,
	`catagory` varchar(225) DEFAULT NULL,
	PRIMARY KEY (`id`)
	)
	ENGINE=InnoDB;

-- Recipe_Tags --
CREATE TABLE IF NOT EXISTS `Recipe_Tags` (
	`recipe_id` int(11) NOT NULL,
	`tag_id` int(11) NOT NULL,
	PRIMARY KEY (`recipe_id`, `tag_id`),
	FOREIGN KEY (`recipe_id`) REFERENCES Recipes(id),
	FOREIGN KEY (`tag_id`) REFERENCES Tags(id) 
	)
	ENGINE = InnoDB;

-- Insert Sample data --
-- 2 sample sources
INSERT INTO Sources (name, year_published, author) VALUES ("Cookbook Extravaganza", 2002, "Rachel Ray");
INSERT INTO Sources (name, year_published, author) VALUES ("Ahmad's Great Dishes", 2019, "Ahmad El-Bobou");

-- 3 sample recipes
INSERT INTO Recipes (name, source_id, cook_time, serving_size, instructions) VALUES
('Crispy Chicken Tenders', (select id from Sources WHERE author = 'Ahmad El-Bobou'),
25, 6, "First take the chicken. Then Coat it in flour. Dip it in batter. Coat it again. Lastly, fry until brown");

INSERT INTO Recipes (name, source_id, cook_time, serving_size, instructions) VALUES
('Spaghetti', (select id from Sources WHERE author = 'Rachel Ray'),
20, 4, "Boil noodles until soft. Cook the ground beef and add the sauce. Mix noodles with sauce and meat.");

INSERT INTO Recipes (name, cook_time, serving_size, instructions) VALUES
('Fruit Loops',
2, 1, "Pour the cereal into a bowl. Add milk to desired milkiness");

-- add ingredients: [chicken tenders(200), oil(1000), flour(500), batter(500)], [noodles(500), ground beef(250), spaghetti sauce(100)],
-- [fruit loops(50), milk(50)]
INSERT into Ingredients (name, amount, recipe_id) VALUES
("chicken tenders", 200, (SELECT id FROM Recipes where name = "Crispy Chicken Tenders"));

INSERT into Ingredients (name, amount, recipe_id) VALUES
("oil", 1000, (SELECT id FROM Recipes where name = "Crispy Chicken Tenders"));

INSERT into Ingredients (name, amount, recipe_id) VALUES
("flour", 500, (SELECT id FROM Recipes where name = "Crispy Chicken Tenders"));

INSERT into Ingredients (name, amount, recipe_id) VALUES
("batter", 500, (SELECT id FROM Recipes where name = "Crispy Chicken Tenders"));

INSERT into Ingredients (name, amount, recipe_id) VALUES
("noodles", 500, (SELECT id FROM Recipes where name = "Spaghetti"));

INSERT into Ingredients (name, amount, recipe_id) VALUES
("ground beef", 250, (SELECT id FROM Recipes where name = "Spaghetti"));

INSERT into Ingredients (name, amount, recipe_id) VALUES
("tomato sauce", 50, (SELECT id FROM Recipes where name = "Spaghetti"));

INSERT into Ingredients (name, amount, recipe_id) VALUES
("Fruit Loops Cereal", 50, (SELECT id FROM Recipes where name = "Fruit Loops"));

INSERT into Ingredients (name, amount, recipe_id) VALUES
("Milk", 50, (SELECT id FROM Recipes where name = "Fruit Loops"));

-- add types - breakfast, italian, american, dinner, fried

INSERT into Tags (name, catagory) VALUES ("breakfast", "meal");
INSERT into Tags (name, catagory) VALUES ("Italian", "region");
INSERT into Tags (name, catagory) VALUES ("American", "region");
INSERT into Tags (name, catagory) VALUES ("dinner", "meal");
INSERT into Tags (name) VALUES ("fried");

-- add type relationships
INSERT into Recipe_Tags (recipe_id, tag_id) VALUES
((select id from Recipes where name = "Fruit Loops"),
(select id from Tags where name = 'breakfast'));

INSERT into Recipe_Tags (recipe_id, tag_id) VALUES
((select id from Recipes where name = "Fruit Loops"),
(select id from Tags where name = 'American'));

INSERT into Recipe_Tags (recipe_id, tag_id) VALUES
((select id from Recipes where name = "Crispy Chicken Tenders"),
(select id from Tags where name = 'American'));

INSERT into Recipe_Tags (recipe_id, tag_id) VALUES
((select id from Recipes where name = "Crispy Chicken Tenders"),
(select id from Tags where name = 'fried'));

INSERT into Recipe_Tags (recipe_id, tag_id) VALUES
((select id from Recipes where name = "Crispy Chicken Tenders"),
(select id from Tags where name = 'dinner'));

INSERT into Recipe_Tags (recipe_id, tag_id) VALUES
((select id from Recipes where name = "Spaghetti"),
(select id from Tags where name = 'Italian'));
