'use strict';
const {
  Model
} = require('sequelize');
// const Transaction = sequelize.define("transaction", {})
// const PaymentMethod = sequelize.define("payment_method", {})
module.exports = (sequelize, DataTypes) => {
  class transaction_payment_method extends Model {
    /**
     * Helper method for defining associations.
     * This method is not a part of Sequelize lifecycle.
     * The `models/index` file will call this method automatically.
     */
    static associate(models) {
      // define association here
      // transaction_payment_method.belongsTo(PaymentMethod, {
      //   foreignKey: "payment_method_id",
      //   as: "payment_method",
      // });
      // transaction_product.belongsTo(Transaction, {
      //   foreignKey: "transaction_id",
      //   as: "transaction",
      // });
    }
  }
  transaction_payment_method.init({
    transaction_id: DataTypes.INTEGER,
    payment_method_id: DataTypes.INTEGER
  }, {
    sequelize,
    modelName: 'transaction_payment_method',
  });
  return transaction_payment_method;
};