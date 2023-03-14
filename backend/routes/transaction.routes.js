module.exports = app => {
    const tutorials = require("../controllers/transaction.controller.js");
    var router = require("express").Router();
    router.post("/", tutorials.create);
    app.use('/api/transactions', router);
};