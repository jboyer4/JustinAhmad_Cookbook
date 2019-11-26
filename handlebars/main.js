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

// home page that displays recipes
app.get('/', function (req, res, next){
  res.render('search');
});

app.get('/sources', function (req, res, next){
  res.render('sources');
});

app.get('/ingredients', function (req, res, next){
  res.render('ingredients');
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


// post insert
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
    res.render('recipe_main');
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
    res.render('sources');
  })
});

app.get('/insert-ingredient', function(req, res){
  console.log(req.query)
  mysql.pool.query("INSERT INTO Ingredients (recipe_id, name, amount, unit) VALUES ((select id from Recipe where id = ?),?,?, ?)", [parseInt(req.query.recipe_id), req.query.name, req.query.amount, req.query.units], function(err, result){
    if(err){
      res.send(err)
      next(err);
      console.log(err);
      return;
    }
    console.log(result);
    res.render('ingredients');
  })
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
