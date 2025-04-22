const express = require('express');
const router = express.Router();
const redisService = require('../services/redisService');
const postgresService = require('../services/postgresService');

// Endpoint do dodawania wiadomości do Redis
router.post('/messages', async (req, res) => {
    try {
        const { key, message } = req.body;
        if (!key || !message) {
            return res.status(400).json({ error: 'Key and message are required' });
        }
        await redisService.addMessage(key, message);
        res.status(201).json({ message: 'Message saved to Redis' });
    } catch (error) {
        console.error('Error saving message to Redis:', error);
        res.status(500).json({ error: 'Internal Server Error' });
    }
});

// Endpoint do odczytywania wiadomości z Redis
router.get('/messages/:key', async (req, res) => {
    try {
        const { key } = req.params;
        const message = await redisService.getMessage(key);
        if (!message) {
            return res.status(404).json({ error: 'Message not found' });
        }
        res.status(200).json({ key, message });
    } catch (error) {
        console.error('Error retrieving message from Redis:', error);
        res.status(500).json({ error: 'Internal Server Error' });
    }
});

// Endpoint to add a user to PostgreSQL
router.post('/users', async (req, res) => {
    const { username, email } = req.body;
    try {
        await postgresService.addUser(username, email);
        res.status(201).send({ status: 'User added' });
    } catch (error) {
        res.status(500).send({ error: 'Failed to add user' });
    }
});

router.get('/users', async (req, res) => {
    try {
        const users = await postgresService.getAllUsers();
        res.status(200).json(users);
    } catch (error) {
        console.error('Error retrieving users:', error);
        res.status(500).json({ error: 'Failed to retrieve users' });
    }
});

// Endpoint do pobierania użytkownika po ID
router.get('/users/:id', async (req, res) => {
    const { id } = req.params;
    try {
        const user = await postgresService.getUserById(id);
        if (!user) {
            return res.status(404).json({ error: 'User not found' });
        }
        res.status(200).json(user);
    } catch (error) {
        console.error('Error retrieving user by ID:', error);
        res.status(500).json({ error: 'Failed to retrieve user' });
    }
});

module.exports = router;