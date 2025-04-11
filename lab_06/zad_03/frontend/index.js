const express = require('express');
const axios = require('axios');

const app = express();
const PORT = 8080;
const BACKEND_URL = 'http://backend3:3000/data';

app.get('/', async (req, res) => {
  try {
    const response = await axios.get(BACKEND_URL);
    const rows = response.data;

    const html = `
      <html>
        <head><title>Dane z backendu</title></head>
        <body>
          <h1>Dane z backendu:</h1>
          <ul>
            ${rows.map(row => `<li>${row.id}: ${row.name}</li>`).join('')}
          </ul>
        </body>
      </html>
    `;

    res.send(html);
  } catch (error) {
    res.status(500).send(`<p>Błąd połączenia z backendem: ${error.message}</p>`);
  }
});

app.listen(PORT, () => {
  console.log(`Frontend serwer działa na http://localhost:${PORT}`);
});
