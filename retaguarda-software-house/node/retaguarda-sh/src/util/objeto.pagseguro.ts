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
	
}