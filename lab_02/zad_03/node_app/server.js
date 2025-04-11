const express = require('express');
const mongoose = require('mongoose');

const app = express();
const PORT = process.env.PORT || 8080;
const MONGO_URI = "mongodb://mongo_db:27017/test";

mongoose.connect(MONGO_URI, { useNewUrlParser: true, useUnifiedTopology: true })
  .then(() => console.log('Connected to MongoDB'))
  .catch(err => console.error(err));

const ItemSchema = new mongoose.Schema({ name: String });
const Item = mongoose.model('Item', ItemSchema);

app.get('/', async (req, res) => {
  const items = await Item.find();
  res.json(items);
});

app.listen(PORT, () => {
  console.log();
});
