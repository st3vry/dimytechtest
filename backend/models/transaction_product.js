'use strict';
const {
  Model
} = require('sequelize');
// const Transaction = sequelize.define("transaction", {})
// const Product = sequelize.define("product", {})
module.exports = (sequelize, DataTypes) => {
  class transaction_product extends Model {
    /**
     * Helper method for defining associations.
     * This method is not a part of Sequelize lifecycle.
     * The `models/index` file will call this method automatically.
     */
    static associate(models) {
      // define association here
      // transaction_product.belongsTo(Product, {
      //   foreignKey: "product_id",
      //   as: "product",
      // });
      // transaction_product.belongsTo(Transaction, {
      //   foreignKey: "transaction_id",
      //   as: "transaction",
      // });
      
    }
  }
  transaction_product.init({
    transaction_id: DataTypes.INTEGER,
    product_id: DataTypes.INTEGER
  }, {
    sequelize,
    modelName: 'transaction_product',
  });
  return transaction_product;
};