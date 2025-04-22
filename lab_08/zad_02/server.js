const express = require('express');
const { createClient } = require('redis');

const app = express();
const port = 3000;

// Middleware to parse JSON
app.use(express.json());

// Create a Redis client
const client = createClient({
    url: 'redis://redis:6379'
});

client.on('error', (err) => console.error('Redis Client Error', err));

client.connect().then(() => {
    console.log('Connected to Redis');
}).catch((err) => {
    console.error('Failed to connect to Redis:', err);
    process.exit(1);
});

// Route to add a message
app.post('/messages', async (req, res) => {
    const { id, message } = req.body;

    if (!id || !message) {
        return res.status(400).json({ error: 'ID and message are required' });
    }

    if (!client.isOpen) {
        return res.status(500).json({ error: 'Redis client is not connected' });
    }

    try {
        await client.set(id, message); // Użycie Promise
        res.status(201).json({ message: 'Message saved successfully' });
    } catch (err) {
        res.status(500).json({ error: 'Failed to save message' });
    }
});

// Route to get a message by ID
app.get('/messages/:id', async (req, res) => {
    const { id } = req.params;

    if (!client.isOpen) {
        return res.status(500).json({ error: 'Redis client is not connected' });
    }

    try {
        const message = await client.get(id); // Użycie Promise
        if (!message) {
            return res.status(404).json({ error: 'Message not found' });
        }
        res.json({ id, message });
    } catch (err) {
        res.status(500).json({ error: 'Failed to retrieve message' });
    }
});

// Start the server
app.listen(port, () => {
    console.log(`Server is running on http://localhost:${port}`);
});