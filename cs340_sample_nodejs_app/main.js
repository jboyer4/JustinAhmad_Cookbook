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
//app.use('/static', express.static('public'));
app.set('view engine', 'handlebars');
app.set('port', 33123);
app.set('mysql', mysql);

// app.use('/people_certs', require('./people_certs.js'));
// app.use('/people', require('./people.js'));
// app.use('/planets', require('./planets.js'));
// app.use('/', express.static('public'));

// home page that displays recipes
app.get('/', function (req, res, next){
  res.render('recipe_main');
});

// get recipes
app.get('/select-recipes', function (req,res,next) {
  mysql.pool.query("SELECT * FROM Recipe", function(err, result){
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
  mysql.pool.query("SELECT * FROM Source", function(err, result){
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
  mysql.pool.query("SELECT * FROM Tag", function(err, result){
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
  mysql.pool.query("SELECT * FROM Ingredient", function(err, result){
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
  console.log(req.body)
  mysql.pool.query("INSERT INTO recipe (name, serving_size, cook_time, instructions) VALUES (?,?,?,?)", req.body.name, req.body.serving_size, req.body.cook_time, req.body.instructions, function(err, result){
    if(err){
      next(err);
      return;
    }
    console.log(result);
    res.render('recipe_main');
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
