'use strict';
const { Model} = require('sequelize');
// const Address = sequelize.define("address", {})
module.exports = (sequelize, DataTypes) => {
  class transaction extends Model {
    /**
     * Helper method for defining associations.
     * This method is not a part of Sequelize lifecycle.
     * The `models/index` file will call this method automatically.
     */
    static associate(models) {
      // define association here
      // Address.belongsTo(transaction,{as:"customer"})
      // transaction.belongsTo(Address, {
      //   foreignKey: "address_id",
      //   as: "transaction",
      // })
    }
  }
  transaction.init({
    address_id: DataTypes.INTEGER
  }, {
    sequelize,
    modelName: 'transaction',
  });
  return transaction;
};