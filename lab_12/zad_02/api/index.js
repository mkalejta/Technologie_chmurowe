const express = require('express');
const mongoose = require('mongoose');
const app = express();

const mongoUri = process.env.MONGO_URI || 'mongodb://localhost:27017/testdb';

mongoose.connect(mongoUri, { useNewUrlParser: true, useUnifiedTopology: true })
  .then(() => console.log('Connected to MongoDB'))
  .catch(err => console.error('MongoDB connection error:', err));

app.get('/', (req, res) => {
  res.send('Hello from API!');
});

app.listen(3000, () => {
  console.log('API server listening on port 3000');
});