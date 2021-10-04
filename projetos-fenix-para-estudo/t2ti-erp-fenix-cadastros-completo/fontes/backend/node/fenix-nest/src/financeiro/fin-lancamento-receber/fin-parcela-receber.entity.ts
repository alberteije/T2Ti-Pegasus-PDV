/*******************************************************************************
Title: T2Ti ERP Fenix                                                                
Description: Model relacionado à tabela [FIN_PARCELA_RECEBER] 
                                                                                
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
import { FinLancamentoReceber } from '../../entities-export';
import { FinStatusParcela } from '../../entities-export';
import { FinTipoRecebimento } from '../../entities-export';
import { BancoContaCaixa } from '../../entities-export';
import { FinChequeRecebido } from '../../entities-export';

@Entity({ name: 'FIN_PARCELA_RECEBER' })
export class FinParcelaReceber { 

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

	@Column({ name: 'EMITIU_BOLETO' })
	emitiuBoleto: string;

	@Column({ name: 'BOLETO_NOSSO_NUMERO' })
	boletoNossoNumero: string;

	@Column({ name: 'VALOR_RECEBIDO' })
	valorRecebido: number;

	@Column({ name: 'HISTORICO' })
	historico: string;


	/**
	* Relations
	*/
    @OneToOne(() => FinStatusParcela)
    @JoinColumn({ name: "ID_FIN_STATUS_PARCELA" })
    finStatusParcela: FinStatusParcela;

    @OneToOne(() => FinTipoRecebimento)
    @JoinColumn({ name: "ID_FIN_TIPO_RECEBIMENTO" })
    finTipoRecebimento: FinTipoRecebimento;

    @OneToOne(() => BancoContaCaixa)
    @JoinColumn({ name: "ID_BANCO_CONTA_CAIXA" })
    bancoContaCaixa: BancoContaCaixa;

    @OneToOne(() => FinChequeRecebido)
    @JoinColumn({ name: "ID_FIN_CHEQUE_RECEBIDO" })
    finChequeRecebido: FinChequeRecebido;

    @ManyToOne(() => FinLancamentoReceber, finLancamentoReceber => finLancamentoReceber.listaFinParcelaReceber)
    @JoinColumn({ name: "ID_FIN_LANCAMENTO_RECEBER" })
    finLancamentoReceber: FinLancamentoReceber;


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
			this.emitiuBoleto = objetoJson['emitiuBoleto'];
			this.boletoNossoNumero = objetoJson['boletoNossoNumero'];
			this.valorRecebido = objetoJson['valorRecebido'];
			this.historico = objetoJson['historico'];
			
			if (objetoJson['finStatusParcela'] != null) {
				this.finStatusParcela = new FinStatusParcela(objetoJson['finStatusParcela']);
			}

			if (objetoJson['finTipoRecebimento'] != null) {
				this.finTipoRecebimento = new FinTipoRecebimento(objetoJson['finTipoRecebimento']);
			}

			if (objetoJson['bancoContaCaixa'] != null) {
				this.bancoContaCaixa = new BancoContaCaixa(objetoJson['bancoContaCaixa']);
			}

			if (objetoJson['finChequeRecebido'] != null) {
				this.finChequeRecebido = new FinChequeRecebido(objetoJson['finChequeRecebido']);
			}

			
		}
	}
}