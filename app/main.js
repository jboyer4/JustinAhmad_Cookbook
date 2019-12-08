/*
    Uses express, dbcon for database connection, body parser to parse form data
    handlebars for HTML templates
*/

var express = require('express');
var mysql = require('./dbcon.js');
var bodyParser = require('body-parser');

var app = express();
var handlebars = require('express-handlebars').create({
        defaultLayout:'main',
        });

app.engine('handlebars', handlebars.engine);
app.use(bodyParser.urlencoded({extended:true}));
app.use(express.static('public'));
app.set('view engine', 'handlebars');
app.set('port', 5816);
app.set('mysql', mysql);



// home page - search
app.get('/',function (req,res,next){
  res.render('search');
});

// displays recipes
app.get('/recipes', function (req, res, next){
  res.render('recipe_main');
});

// displays sources
app.get('/sources', function (req, res, next){
  res.render('sources');
});

// displays ingredients
app.get('/ingredients', function (req, res, next){
  res.render('ingredients');
});

// displays tags
app.get('/tags', function (req, res, next){
  res.render('tags');
});

// display recipe_tag table
app.get('/recipe_tag', function (req, res, next){
  res.render('recipe_tag');
});


// get recipes
app.get('/select-recipes', function (req,res,next) {
  mysql.pool.query("SELECT * FROM Recipes", function(err, result){
    if(err){
      next(err);
      return;
    }
    console.log(result);
    res.send(JSON.stringify(result));
  })
});

// get sources
app.get('/select-sources', function (req,res,next) {
  mysql.pool.query("SELECT * FROM Sources", function(err, result){
    if(err){
      next(err);
      return;
    }
    console.log(result);
    res.send(JSON.stringify(result));
  })
});

// get tags
app.get('/select-tags', function (req,res,next) {
  mysql.pool.query("SELECT * FROM Tags", function(err, result){
    if(err){
      next(err);
      return;
    }
    console.log(result);
    res.send(JSON.stringify(result));
  })
});

// get ingredients
app.get('/select-ingredients', function (req,res,next) {
  mysql.pool.query("SELECT * FROM Ingredients", function(err, result){
    if(err){
      next(err);
      return;
    }
    console.log(result);
    res.send(JSON.stringify(result));
  })
});

// get recipe_tag
app.get('/select-recipe_tags', function (req,res,next) {
  mysql.pool.query("SELECT * FROM Recipe_Tags", function(err, result){
    if(err){
      next(err);
      return;
    }
    console.log(result);
    res.send(JSON.stringify(result));
  })
});


// inserts
app.get('/insert-recipe', function(req, res){
  console.log(req.query)
  mysql.pool.query("INSERT INTO Recipes (name, serving_size, cook_time, instructions) VALUES (?,?,?,?)", [req.query.name, req.query.serving_size, req.query.cook_time, req.query.instructions], function(err, result){
    if(err){
      res.send(err)
      next(err);
      console.log(err);
      return;
    }
    console.log(result);
    res.redirect('/');
  })
});

app.get('/insert-source', function(req, res){
  console.log(req.query)
  mysql.pool.query("INSERT INTO Sources (name, author, year_published) VALUES (?,?,?)", [req.query.name, req.query.author, req.query.year_published], function(err, result){
    if(err){
      res.send(err)
      next(err);
      console.log(err);
      return;
    }
    console.log(result);
    res.redirect('/sources');
  })
});

app.get('/insert-ingredient', function(req, res){
  console.log(req.query)
  mysql.pool.query("INSERT INTO Ingredients (recipe_id, name, amount, units) VALUES ((select id from Recipes where id = ?),?,?, ?)", [parseInt(req.query.recipe_id), req.query.name, req.query.amount, req.query.units], function(err, result){
    if(err){
      res.send(err)
      next(err);
      console.log(err);
      return;
    }
    console.log(result);
    res.redirect('/ingredients');
  })
});

app.get('/insert-tag', function(req, res){
  console.log(req.query)
  mysql.pool.query("INSERT INTO Tags (name, catagory) VALUES (?,?)", [req.query.name, req.query.catagory], function(err, result){
    if(err){
      res.send(err)
      next(err);
      console.log(err);
      return;
    }
    console.log(result);
    res.redirect('/tags');
  })
});


app.get('/insert-recipe_tag', function(req, res){
  console.log(req.query)
  mysql.pool.query("INSERT INTO Recipe_Tags (Recipe_id, Tag_id) VALUES (?,?)", [req.query.recipe_id, req.query.tag_id], function(err, result){
    if(err){
      res.send(err)
      next(err);
      console.log(err);
      return;
    }
    console.log(result);
    res.redirect('/recipe_tag');
  })
});


// delete queries
app.get('/delete-recipe', function(req,res) {
  mysql.pool.query("DELETE FROM Recipes WHERE id = ?", req.query.id, function(err, result){
    if(err){
      res.send(err)
      next(err);
      console.log(err);
      return;
    }
    console.log(result);
  })
  res.send("Recipe deleted!")
});

app.get('/delete-source', function(req,res) {
  mysql.pool.query("DELETE FROM Sources WHERE id = ?", req.query.id, function(err, result){
    if(err){
      res.send(err)
      next(err);
      console.log(err);
      return;
    }
    console.log(result);
  })
  res.send("Source deleted!")
});


// admin stuff for pages that don't exit or errors
app.use(function(req,res){
  res.status(404);
  res.render('404');
});

app.use(function(err, req, res, next){
  console.error(err.stack);
  res.status(500);
  res.render('500');
});

app.listen(app.get('port'), function(){
  console.log('Express started on http://localhost:' + app.get('port') + '; press Ctrl-C to terminate.');
});
