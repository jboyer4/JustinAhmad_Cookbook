--Values pased in from GET request

INSERT INTO `recipe`(`name`, `serving_size`,`cook_time`, `source_id`, `instructions`) VALUES (name, servingSize,cookTime, sourceId, instructions);
INSERT INTO `source`(`name`, `year_published`, `author`) VALUES (name, yearPublished, author);
INSERT INTO `ingredient`(`recipe_id`, `food`, `amount`) VALUES (recipe, food, amount);
INSERT INTO `recipe_type`(`recipe_id`, `type_id`) VALUES (recipe, type);
INSERT INTO `type`(`name`) VALUES (name)

SELECT `name`, `serving_size`,`cook_time`, `source_id`, `instructions` FROM `recipe` WHERE `name` = name;
SELECT `name`, `serving_size`,`cook_time`, `source_id`, `instructions` FROM `recipe` WHERE `cook_time` > cookTime;
SELECT `name`, `serving_size`,`cook_time`, `source_id`, `instructions` FROM `recipe` WHERE `cook_time` < cookTime;
SELECT `name`, `serving_size`,`cook_time`, `source_id`, `instructions` FROM `recipe` WHERE `source_id` = source;
SELECT `a.name`, `a.serving_size`,`a.cook_time`, `a.source_id`, `a.instructions`, `b.type` FROM `recipe` AS A INNER JOIN `recipe_type` AS B WHERE a.id = b.recipe_id;

SELECT `recipe_id`, `type_id` FROM `recipe` WHERE `recipe_id` = recipe;
SELECT `recipe_id, `source_name`, `source_id`, `year_published` FROM `source` WHERE `source_id` = source;
SELECT `amount`, `food`, FROM `ingredient` WHERE `recipe_id` = recipe;

UPDATE `recipe` SET `name` = name, `serving_size` = servingSize,`cook_time` = cookTime, `source_id` = sourceId, `instructions`= instructions WHERE `id` = id
UPDATE `source` SET `name` = name, `year_published` = yearPublished, `author` = author WHERE `id` = id;
UPDATE `ingredient` SET `recipe_id` = recipeId, `food` = food, `amount` = amount WHERE `id` = id;
UPDATE `recipe_type` SET `recipe_id` = recipeId, `type_id` = typeId WHERE `id` = id;
UPDATE `type` SET `name` = name WHERE `id` = id;

DELETE FROM `recipe` WHERE `id` = id;
DELETE FROM `source` WHERE `id` = id;
DELETE FROM `ingredient` WHERE `id` = id;
DELETE FROM `recipe_type` WHERE `recipe_id` = recipe AND `type_id` = type;
DELETE FROM `type` WHERE `name` = type;
