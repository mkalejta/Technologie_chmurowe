const { Pool } = require('pg');
require('dotenv').config();

const pool = new Pool({
    user: process.env.DB_USER,
    host: process.env.DB_HOST,
    database: process.env.DB_NAME,
    password: process.env.DB_PASSWORD,
    port: process.env.DB_PORT,
});

const addUser = async (username, email) => {
    const query = 'INSERT INTO users (username, email) VALUES ($1, $2) RETURNING *';
    const values = [username, email];
    const res = await pool.query(query, values);
    return res.rows[0];
};

const getUserById = async (id) => {
    const query = 'SELECT * FROM users WHERE id = $1';
    const values = [id];
    const res = await pool.query(query, values);
    return res.rows[0];
};

const getAllUsers = async () => {
    const query = 'SELECT * FROM users';
    const res = await pool.query(query);
    return res.rows;
};

module.exports = {
    addUser,
    getUserById,
    getAllUsers,
};