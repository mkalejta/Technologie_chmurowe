const redis = require('redis');
const { promisify } = require('util');

const redisClient = redis.createClient({
    host: process.env.REDIS_HOST,
    port: process.env.REDIS_PORT,
});

const setAsync = promisify(redisClient.set).bind(redisClient);
const getAsync = promisify(redisClient.get).bind(redisClient);

const addMessage = async (key, message) => {
    await setAsync(key, message);
};

const getMessage = async (key) => {
    return await getAsync(key);
};

module.exports = {
    addMessage,
    getMessage,
};