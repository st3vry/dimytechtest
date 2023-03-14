'use strict';
const {Model} = require('sequelize');
module.exports = (sequelize, DataTypes) => {

  // const Customer = sequelize.define("customer", {}) 
  class address extends Model {
    /**
     * Helper method for defining associations.
     * This method is not a part of Sequelize lifecycle.
     * The `models/index` file will call this method automatically.
     */
    static associate(models) {
      // Customer.belongsTo(address,{as:"customer"})
      // address.belongsTo(Customer, {
      //   foreignKey: "customer_id",
      //   as: "address",
      // });
      // define association here
    }
  }
  address.init({
    name: DataTypes.STRING,
    customer_id: DataTypes.INTEGER
  }, {
    sequelize,
    modelName: 'address',
  });
  return address;
};