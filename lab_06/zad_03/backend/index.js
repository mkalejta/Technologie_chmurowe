const express = require('express');
const mysql = require('mysql2/promise');

const app = express();
const port = 3000;

const dbConfig = {
  host: 'database3',
  user: 'user',
  password: 'password',
  database: 'appdb',
};

app.get('/data', async (req, res) => {
  try {
    const connection = await mysql.createConnection(dbConfig);
    const [rows] = await connection.execute('SELECT * FROM test');
    await connection.end();
    res.json(rows);
  } catch (err) {
    res.status(500).send('Database error: ' + err.message);
  }
});

app.listen(port, () => {
  console.log(`Backend running at http://localhost:${port}`);
});
