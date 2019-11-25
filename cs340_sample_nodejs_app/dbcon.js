var mysql = require('mysql');
var pool = mysql.createPool({
  connectionLimit : 10,
  host            : 'classmysql.engr.oregonstate.edu',
  user            : 'cs340_elboboua',
  password        : '3135',
  database        : 'cs340_elboboua'
});
module.exports.pool = pool;
