-- Clear tables to rebuild them --
SET FOREIGN_KEY_CHECKS = 0;

DROP TABLE IF EXISTS `Ingredients`;
DROP TABLE IF EXISTS `Recipe_Ingredients`;
DROP TABLE IF EXISTS `Recipes`;
DROP TABLE IF EXISTS `Sources`;
DROP TABLE IF EXISTS `Tags`;
DROP TABLE IF EXISTS `Recipe_Tags`;

SET FOREIGN_KEY_CHECKS = 1;


-- Build Tables -- 
-- Ingredients --
CREATE TABLE IF NOT EXISTS `Ingredients` (
	`id` int(11) NOT NULL AUTO_INCREMENT,
	`name` varchar(225) NOT NULL,
	PRIMARY KEY (`id`)
	) 
	ENGINE=InnoDB;

-- Recipe_Ingredients --
CREATE TABLE IF NOT EXISTS `Recipe_Ingredients` (
	`id` int(11) NOT NULL AUTO_INCREMENT,
	`recipe_id` int(11) NOT NULL,
	`ingredient_id` int(11) NOT NULL,
	`amount` varchar(225),
	PRIMARY KEY (`id`)
	)
	ENGINE=InnoDB;

-- Tags --	
CREATE TABLE IF NOT EXISTS `Tags` (
	`id` int(11) NOT NULL AUTO_INCREMENT,
	`name` varchar(225) NOT NULL,
	PRIMARY KEY (`id`)
	)
	ENGINE=InnoDB;

-- Recipe_Tags --
CREATE TABLE IF NOT EXISTS `Recipe_Tags` (
	`recipe_id` int(11) NOT NULL,
	`tag_id` int(11) NOT NULL,
	PRIMARY KEY (`recipe_id`, `tag_id`)
	)
	ENGINE = InnoDB;

-- Sources --
CREATE TABLE IF NOT EXISTS `Sources` (
	`id` int(11) NOT NULL AUTO_INCREMENT,
	`name` varchar(225) NOT NULL,
	`year_published` int(11) DEFAULT NULL,
	`author` varchar(225) DEFAULT NULL,
	`url` varchar(225) DEFAULT NULL,
	PRIMARY KEY (`id`)
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
	PRIMARY KEY (`id`)
	)
	ENGINE=InnoDB;

