/// utilize o código abaixo para acessar o banco de dados sem utilizar o Sequelize

const mysql = require('mysql');

var connection = mysql.createPool({
    host: 'localhost',
    user: 'root',
    password: 'root',
    database: 'fenix'
});

module.exports = connection;