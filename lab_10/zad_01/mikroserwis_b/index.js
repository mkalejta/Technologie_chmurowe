const express = require('express');
const app = express();

app.get('/hello', (req, res) => {
  res.json({ msg: 'Hello from mikroserwis_b!' });
});

app.listen(3000, () => console.log('mikroserwis_b listening on 3000'));