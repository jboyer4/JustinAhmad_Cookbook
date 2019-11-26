var mysql = require('mysql');
var pool = mysql.createPool({
  connectionLimit : 10,
  host            : 'classmysql.engr.oregonstate.edu',
  user            : 'cs340_boyerju',
  password        : '5816',
  database        : 'cs340_boyerju'
});
module.exports.pool = pool;
