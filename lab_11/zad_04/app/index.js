const express = require('express');
const app = express();

app.get('/', (req, res) => {
  res.send('Hello from my-app!');
});

app.listen(8080, () => {
  console.log('my-app listening on port 8080');
});