const express = require('express');
const mysql = require('mysql2');
const app = express();
const port = 3000;

const db = mysql.createConnection({
  host: 'db',
  user: 'user',
  password: 'pass',
  database: 'testdb'
});

db.connect(err => {
  if (err) {
    return console.error('DB connection failed:', err.stack);
  }
  console.log('Connected to database.');
});

app.get('/', (req, res) => {
  db.query('SELECT NOW() as now', (err, results) => {
    if (err) return res.send('Error: ' + err.message);
    res.send('Połączono z bazą danych! Czas: ' + results[0].now);
  });
});

app.listen(port, () => {
  console.log(`App listening at http://localhost:${port}`);
});
