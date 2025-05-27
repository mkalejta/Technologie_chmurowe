const express = require('express');
const mysql = require('mysql2');
const app = express();

const db = mysql.createConnection({
  host: process.env.DB_HOST || 'mysql',
  user: process.env.DB_USER || 'root',
  password: process.env.DB_PASS || 'example',
  database: process.env.DB_NAME || 'testdb'
});

app.get('/data', (req, res) => {
  db.query('SELECT NOW() as now', (err, results) => {
    if (err) return res.status(500).json({ error: err.message });
    res.json({ db_time: results[0].now });
  });
});

app.listen(3000, () => console.log('mikroserwis_b listening on 3000'));