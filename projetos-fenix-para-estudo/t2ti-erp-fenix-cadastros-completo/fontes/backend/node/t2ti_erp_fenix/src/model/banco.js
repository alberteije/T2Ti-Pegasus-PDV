const Sequelize = require('sequelize');
const sequelize = require('../config/db_config.js');

const Model = Sequelize.Model;
class Banco extends Model { }
Banco.init({
    id: {
        primaryKey: true,
        autoIncrement: true,
        type: Sequelize.INTEGER,
        field: 'ID'
    },
    codigo: {
        type: Sequelize.STRING,
        field: 'CODIGO'
    },
    nome: {
        type: Sequelize.STRING,
        field: 'NOME'
    },
    url: {
        type: Sequelize.STRING,
        field: 'URL'
    }
}, {
    sequelize,
    modelName: 'banco'
});

module.exports = Banco;