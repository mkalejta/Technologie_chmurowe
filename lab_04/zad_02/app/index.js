const express = require("express");
const port = 3000;
const app = express();

app.get("/", (req, res) => {
    res.send("Node działa");
})

app.listen(port, () => {
    console.log(`Serwer nasłuchuje na ${port}`);
})