const express = require('express');

const PORT = 3000;
const app = express();

const myVariable = process.env.MY_VARIABLE || "default_value";

app.listen(PORT, () => {
    console.log(`App listens on port: ${PORT}`);
    console.log(`Environment Variable MY_VARIABLE: ${myVariable}`);
});