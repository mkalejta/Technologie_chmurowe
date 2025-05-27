const express = require('express');
const { MongoClient } = require('mongodb');
const app = express();

const user = process.env.MONGO_USER || 'mongouser';
const password = process.env.MONGO_PASSWORD || 'secretpass';
const host = process.env.MONGO_HOST || 'mongo';
const dbName = process.env.MONGO_DB || 'testdb';

const uri = `mongodb://${user}:${password}@${host}:27017/${dbName}?authSource=admin`;

app.get('/data', async (req, res) => {
  try {
    const client = new MongoClient(uri);
    await client.connect();
    const db = client.db(dbName);
    const serverStatus = await db.command({ serverStatus: 1 });
    await client.close();
    res.json({ mongoTime: serverStatus.localTime });
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

app.listen(3000, () => console.log('mikroserwis_b listening on 3000'));