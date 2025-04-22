db = db.getSiblingDB('my-db');

db.users.insertOne({
    name: "user",
    last_name: "kowalski"
});
