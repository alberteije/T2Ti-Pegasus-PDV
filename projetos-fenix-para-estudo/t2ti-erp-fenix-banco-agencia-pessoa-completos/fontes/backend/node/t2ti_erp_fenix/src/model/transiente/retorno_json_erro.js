/// classe transiente que armazena o objeto do erro que será retornado para o cliente
class RetornoJsonErro {
    constructor(parametros) {
        this.status = parametros.codigo;
        this.message = parametros.mensagem;
        switch (this.status) {
            case 400:
                this.error = "Bad Request";
                break;
            case 404:
                this.error = "Not Found";
                break;
            case 500:
                this.error = "Internal Server Error";
                break;
            default:
                this.error = "Erro não mapeado";
                break;
        }
        if (parametros.erro != null) {
            this.message = this.message + " - Exceção: " + parametros.erro.message;
            this.trace = parametros.erro.stack;
        }
    }
}

module.exports = RetornoJsonErro;