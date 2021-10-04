const Sequelize = require('sequelize');
const sequelizeConfig = require('../config/sequelize_config.js');

const sequelize = new Sequelize(sequelizeConfig);

sequelize
  .authenticate()
  .then(() => {
    console.log('Conexão estabelecida com sucesso usando o Sequelize.');
  })
  .catch(err => {
    console.error('Problemas ao estabelecer a conexão usando o Sequelize:', err);
  });

module.exports = sequelize;

/*
/// utilize o código abaixo para acessar o banco de dados sem utilizar o Sequelize

const mysql = require('mysql');

var connection = mysql.createPool({
    host: 'localhost',
    user: 'root',
    password: 'root',
    database: 'fenix'
});
*/