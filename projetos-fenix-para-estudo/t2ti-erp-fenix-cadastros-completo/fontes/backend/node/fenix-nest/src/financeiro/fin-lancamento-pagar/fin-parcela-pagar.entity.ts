/*******************************************************************************
Title: T2Ti ERP Fenix                                                                
Description: Model relacionado à tabela [FIN_PARCELA_PAGAR] 
                                                                                
The MIT License                                                                 
                                                                                
Copyright: Copyright (C) 2020 T2Ti.COM                                          
                                                                                
Permission is hereby granted, free of charge, to any person                     
obtaining a copy of this software and associated documentation                  
files (the "Software"), to deal in the Software without                         
restriction, including without limitation the rights to use,                    
copy, modify, merge, publish, distribute, sublicense, and/or sell               
copies of the Software, and to permit persons to whom the                       
Software is furnished to do so, subject to the following                        
conditions:                                                                     
                                                                                
The above copyright notice and this permission notice shall be                  
included in all copies or substantial portions of the Software.                 
                                                                                
THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,                 
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES                 
OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND                        
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT                     
HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,                    
WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING                    
FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR                   
OTHER DEALINGS IN THE SOFTWARE.                                                 
                                                                                
       The author may be contacted at:                                          
           t2ti.com@gmail.com                                                   
                                                                                
@author Albert Eije (alberteije@gmail.com)                    
@version 1.0.0
*******************************************************************************/
import { Entity, Column, PrimaryGeneratedColumn, OneToOne, ManyToOne, JoinColumn } from 'typeorm';
import { FinLancamentoPagar } from '../../entities-export';
import { FinStatusParcela } from '../../entities-export';
import { BancoContaCaixa } from '../../entities-export';
import { FinTipoPagamento } from '../../entities-export';
import { FinChequeEmitido } from '../../entities-export';

@Entity({ name: 'FIN_PARCELA_PAGAR' })
export class FinParcelaPagar { 

	@PrimaryGeneratedColumn()
	id: number;

	@Column({ name: 'NUMERO_PARCELA' })
	numeroParcela: number;

	@Column({ name: 'DATA_EMISSAO' })
	dataEmissao: Date;

	@Column({ name: 'DATA_VENCIMENTO' })
	dataVencimento: Date;

	@Column({ name: 'DESCONTO_ATE' })
	descontoAte: Date;

	@Column({ name: 'VALOR' })
	valor: number;

	@Column({ name: 'TAXA_JURO' })
	taxaJuro: number;

	@Column({ name: 'TAXA_MULTA' })
	taxaMulta: number;

	@Column({ name: 'TAXA_DESCONTO' })
	taxaDesconto: number;

	@Column({ name: 'VALOR_JURO' })
	valorJuro: number;

	@Column({ name: 'VALOR_MULTA' })
	valorMulta: number;

	@Column({ name: 'VALOR_DESCONTO' })
	valorDesconto: number;

	@Column({ name: 'VALOR_PAGO' })
	valorPago: number;

	@Column({ name: 'HISTORICO' })
	historico: string;


	/**
	* Relations
	*/
    @OneToOne(() => FinStatusParcela)
    @JoinColumn({ name: "ID_FIN_STATUS_PARCELA" })
    finStatusParcela: FinStatusParcela;

    @OneToOne(() => BancoContaCaixa)
    @JoinColumn({ name: "ID_BANCO_CONTA_CAIXA" })
    bancoContaCaixa: BancoContaCaixa;

    @OneToOne(() => FinTipoPagamento)
    @JoinColumn({ name: "ID_FIN_TIPO_PAGAMENTO" })
    finTipoPagamento: FinTipoPagamento;

    @OneToOne(() => FinChequeEmitido)
    @JoinColumn({ name: "ID_FIN_CHEQUE_EMITIDO" })
    finChequeEmitido: FinChequeEmitido;

    @ManyToOne(() => FinLancamentoPagar, finLancamentoPagar => finLancamentoPagar.listaFinParcelaPagar)
    @JoinColumn({ name: "ID_FIN_LANCAMENTO_PAGAR" })
    finLancamentoPagar: FinLancamentoPagar;


	/**
	* Constructor
	*/
	constructor(objetoJson: {}) {
		if (objetoJson != null) {
			this.id = objetoJson['id'];
			this.numeroParcela = objetoJson['numeroParcela'];
			this.dataEmissao = objetoJson['dataEmissao'];
			this.dataVencimento = objetoJson['dataVencimento'];
			this.descontoAte = objetoJson['descontoAte'];
			this.valor = objetoJson['valor'];
			this.taxaJuro = objetoJson['taxaJuro'];
			this.taxaMulta = objetoJson['taxaMulta'];
			this.taxaDesconto = objetoJson['taxaDesconto'];
			this.valorJuro = objetoJson['valorJuro'];
			this.valorMulta = objetoJson['valorMulta'];
			this.valorDesconto = objetoJson['valorDesconto'];
			this.valorPago = objetoJson['valorPago'];
			this.historico = objetoJson['historico'];
			
			if (objetoJson['finStatusParcela'] != null) {
				this.finStatusParcela = new FinStatusParcela(objetoJson['finStatusParcela']);
			}

			if (objetoJson['bancoContaCaixa'] != null) {
				this.bancoContaCaixa = new BancoContaCaixa(objetoJson['bancoContaCaixa']);
			}

			if (objetoJson['finTipoPagamento'] != null) {
				this.finTipoPagamento = new FinTipoPagamento(objetoJson['finTipoPagamento']);
			}

			if (objetoJson['finChequeEmitido'] != null) {
				this.finChequeEmitido = new FinChequeEmitido(objetoJson['finChequeEmitido']);
			}

			
		}
	}
}