const express = require('express');
const axios = require('axios');
const app = express();

app.get('/api', async (req, res) => {
  try {
    const response = await axios.get('http://mikroserwis-b-service:3000/data');
    res.json({ from_b: response.data });
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

app.listen(3000, () => console.log('mikroserwis_a listening on 3000'));