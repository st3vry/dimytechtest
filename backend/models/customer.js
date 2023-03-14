'use strict';
const {
  Model
} = require('sequelize');

module.exports = (sequelize, DataTypes) => {
  class customer extends Model {
    /**
     * Helper method for defining associations.
     * This method is not a part of Sequelize lifecycle.
     * The `models/index` file will call this method automatically.
     */
    static associate(models) {
      // customer.hasMany(Address, {as:'address'})
    }
  }
  customer.init({
    name: DataTypes.STRING
  }, {
    sequelize,
    modelName: 'customer',
  });
  return customer;
};