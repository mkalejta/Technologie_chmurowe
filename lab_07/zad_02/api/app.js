const express = require('express');
const mongoose = require('mongoose');

const app = express();
const PORT = 3003;

// Konfiguracja połączenia z MongoDB
mongoose.connect('mongodb://db:27017/my-db')
  .then(() => console.log('Połączono z MongoDB'))
  .catch((err) => console.log('Błąd połączenia z MongoDB: ', err));

// Model dla kolekcji users
const User = mongoose.model('User', new mongoose.Schema({
  name: String,
  last_name: String
}));

// Endpoint GET /users
app.get('/users', async (req, res) => {
  try {
    const users = await User.find();
    res.json(users);
  } catch (err) {
    res.status(500).send('Błąd pobierania użytkowników');
  }
});

// Uruchomienie serwera
app.listen(PORT, () => {
  console.log(`Serwer działa na porcie ${PORT}`);
});
