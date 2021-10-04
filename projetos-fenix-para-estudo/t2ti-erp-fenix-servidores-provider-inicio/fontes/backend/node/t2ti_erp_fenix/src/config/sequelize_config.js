module.exports = {
    username: 'root',
    password: 'root',
    database: 'fenix',
    host: 'localhost',
    dialect: 'mysql',
    define: {
        timestamps: false, // não cria os campos 'createdAt' e 'updatedAt' nas tabelas
        freezeTableName: true, // não espera o nome das tabelas no plural
        charset: 'utf8',
        dialectOptions: {
            collate: 'utf8_general_ci'
        },
    }
}