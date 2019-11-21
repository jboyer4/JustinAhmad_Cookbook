
-- `Food`

DROP TABLE IF EXISTS `Food`;
CREATE TABLE `Food` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(25) NOT NULL,
  `type` varchar(25) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB;

--`Ingredient`

CREATE TABLE `Ingredient` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `food_id` int(11) NOT NULL,
  `recipe_id` int(11) NOT NULL,
  `amount` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `food_id` (`food_id`),
  KEY `recipe_id` (`recipe_id`),
  CONSTRAINT `ingredient_ibfk_1` FOREIGN KEY (`food_id`) REFERENCES `food` (`id`),
  CONSTRAINT `ingredient_ibfk_2` FOREIGN KEY (`recipe_id`) REFERENCES `recipe` (`id`)
) ENGINE=InnoDB;

-- `Recipe`

DROP TABLE IF EXISTS `Recipe`;
CREATE TABLE `Recipe` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(25) NOT NULL,
  `serving_size` int(11) DEFAULT NULL,
  `cook_time` int(11) DEFAULT NULL,
  `source_id` int(11) DEFAULT NULL,
  `instructions` text,
  PRIMARY KEY (`id`),
  KEY `source_id` (`source_id`),
  CONSTRAINT `recipe_ibfk_1` FOREIGN KEY (`source_id`) REFERENCES `source` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB;


-- `Recipe_type`

DROP TABLE IF EXISTS `Recipe_type`;
CREATE TABLE `Recipe_type` (
  `recipe_id` int(11) NOT NULL,
  `type_id` int(11) NOT NULL,
  KEY `recipe_id` (`recipe_id`),
  KEY `type_id` (`type_id`),
  CONSTRAINT `recipe_type_ibfk_1` FOREIGN KEY (`recipe_id`) REFERENCES `recipe` (`id`),
  CONSTRAINT `recipe_type_ibfk_2` FOREIGN KEY (`type_id`) REFERENCES `type` (`id`)
) ENGINE=InnoDB;

-- `Source`

DROP TABLE IF EXISTS `Source`;
CREATE TABLE `Source` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(25) NOT NULL,
  `year_published` int(11) DEFAULT NULL,
  `author` varchar(25) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB;


-- `Type`

DROP TABLE IF EXISTS `Type`;
CREATE TABLE `Type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(25) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB;

-- Sample Data
INSERT INTO `recipe`(`name`, `serving_size`,`cook_time`, `instructions`) VALUES ("Pumpkin Pie", 6, 55,  Preheat oven to 425 degrees F. Whisk pumpkin, sweetened condensed milk, eggs, spices and salt in medium bowl until smooth. Pour into crust. Bake 15 minutes.
Reduce oven temperature to 350 degrees F and continue baking 35 to 40 minutes or until knife inserted 1 inch from crust comes out clean. Cool. Garnish as desired. Store leftovers covered in refrigerator.);

INSERT INTO `recipe`(`name`, `serving_size`,`cook_time`, `instructions`) VALUES ("Deluxe Corned beef hash", 8, 70,  Melt butter with the olive oil in a large skillet over medium heat, and cook the onion just until it begins to brown, about 8 minutes; stir in the potatoes and carrot, and cook until tender, about 15 minutes, stirring occasionally. Stir in the cubed corned beef, parsley, thyme, salt, and pepper. Let the mixture cook until hash is crisp and browned, stirring often, 10 to 15 more minutes.);

