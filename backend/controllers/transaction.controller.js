const db = require("../models");
const Transaction = db.transaction;
const TransactionProduct = db.transaction_product;
const TransactionPayment = db.transaction_payment_method;
const Op = db.Sequelize.Op;
exports.create = (req, res) => {
    // if (!req.body.title) {
    //     res.status(400).send({
    //       message: "Content can not be empty!"
    //     });
    //     return;
    // }
    const transaction = {
        address_id: req.body.address_id,
    };

    console.log('1',req.body.products)
    const products = JSON.parse(req.body.products);
    console.log(2,products)
    console.log(3,req.body.payment_methods)
    const payment_methods= JSON.parse(req.body.payment_methods);
    console.log(4,payment_methods)
    Transaction.create(transaction)
        .then(data => {
            products.forEach(product => {
                TransactionProduct.create({
                    transaction_id:data.id,
                    product_id:product.id
                })
            });
            payment_methods.forEach(payment_method => {
                TransactionPayment.create({
                    transaction_id:data.id,
                    payment_method_id:payment_method.id
                })
            })
            res.send(data);
        })
        .catch(err => {
            res.status(500).send({
                message: err.message || "Some error occurred."
        });
    });
};