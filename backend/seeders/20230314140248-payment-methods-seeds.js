'use strict';

/** @type {import('sequelize-cli').Migration} */
module.exports = {
  async up (queryInterface, Sequelize) {
    /**
     * Add seed commands here.
     *
     * Example:
     * await queryInterface.bulkInsert('People', [{
     *   name: 'John Doe',
     *   isBetaMember: false
     * }], {});
    */
    let payment_methods = [
      {
        name: "GoPay",
        is_active:true
      },
      {
        name: "Ovo",
        is_active:true
      }
     ]
     await queryInterface.bulkInsert('payment_methods', payment_methods, {});
  },

  async down (queryInterface, Sequelize) {
    /**
     * Add commands to revert seed here.
     *
     * Example:
     * await queryInterface.bulkDelete('People', null, {});
     */
    await queryInterface.bulkDelete('payment_methods', null, {});
  }
};
