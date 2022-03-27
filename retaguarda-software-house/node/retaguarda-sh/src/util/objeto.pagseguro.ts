/**
   * classe transiente que armazena o objeto enviado pelo pagseguro
   */

export class ObjetoPagSeguro {

    codigoTransacao: string;
    statusTransacao: string;
    codigoStatusTransacao: string;
    emailCliente: string;
    metodoPagamento: string;
    codigoTipoPagamento: string;
    codigoProduto: string;
    descricaoProduto: string;
    valorUnitario: number;
	
	/**
	* Constructor
	*/
	constructor(objetoJson: {}) {
		if (objetoJson != null) {
			this.codigoTransacao = objetoJson['codigoTransacao'];
			this.statusTransacao = objetoJson['statusTransacao'];
			this.codigoStatusTransacao = objetoJson['codigoStatusTransacao'];
			this.emailCliente = objetoJson['emailCliente'];
			this.metodoPagamento = objetoJson['metodoPagamento'];
			this.codigoTipoPagamento = objetoJson['codigoTipoPagamento'];
			this.codigoProduto = objetoJson['codigoProduto'];
			this.descricaoProduto = objetoJson['descricaoProduto'];
			this.valorUnitario = objetoJson['valorUnitario'];			
		}
	}
    
}