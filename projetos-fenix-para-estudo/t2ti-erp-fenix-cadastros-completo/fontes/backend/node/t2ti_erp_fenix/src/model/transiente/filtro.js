/// classe transiente que faz o tratamento do filtro
class Filtro {
    constructor(parametros) {
        this.campo = parametros.campo;
        this.valor = parametros.valor;
        this.dataInicial = parametros.dataInicial;
        this.dataFinal = parametros.dataFinal;

	    // verifica se o valor é diferente de vazio e se for filtra por campo/valor
	    if(this.valor != null) {
	        this.where = this.campo + " like '%" + this.valor + "%'";
	    }
		// se o valor for vazio, filtra pelo período
		else {
	        this.where = this.campo + " between " + this.dataInicial + " and " + this.dataFinal;
	    }
    }
}

module.exports = Filtro;