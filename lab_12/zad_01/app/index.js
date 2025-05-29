const express = require('express');
const app = express();

const PORT = 3000;

app.get('/', (req, res) => {
    res.send('Hello World!');
});

app.post('/submit', (req, res) => {
    res.send('Form submitted successfully!');
});

app.put('/update', (req, res) => {
    res.send('Resource updated successfully!');
});

app.delete('/delete', (req, res) => {
    res.send('Resource deleted successfully!');
});

app.get('/about', (req, res) => {
    res.send('About Page');
});

app.get('/health', (req, res) => {
  res.status(200).send('OK');
});

app.listen(PORT, () => {
    console.log(`Server is running on http://localhost:${PORT}`);
});