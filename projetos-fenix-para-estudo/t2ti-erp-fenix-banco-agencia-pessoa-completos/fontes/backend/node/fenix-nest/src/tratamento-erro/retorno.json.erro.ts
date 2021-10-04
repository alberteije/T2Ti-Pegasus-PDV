/**
   * classe transiente que armazena o objeto do erro que será retornado para o cliente
   */

export class RetornoJsonErro {

    status: string;
    message: string;
    error: string;
    trace: string;

    constructor(parametros: any) {
        this.status = parametros.codigo;
        this.message = parametros.mensagem;
        switch (parametros.codigo) {
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
            this.message = this.message + " - Exceção: " + parametros.erro.message.error + " - " + parametros.erro.message.message;
            this.trace = parametros.erro.stack;
        }
    }
}