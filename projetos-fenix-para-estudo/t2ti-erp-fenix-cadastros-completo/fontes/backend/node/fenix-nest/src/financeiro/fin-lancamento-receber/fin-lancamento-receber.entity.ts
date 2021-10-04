/*******************************************************************************
Title: T2Ti ERP Fenix                                                                
Description: Model relacionado à tabela [FIN_LANCAMENTO_RECEBER] 
                                                                                
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
import { Entity, Column, PrimaryGeneratedColumn, OneToMany, OneToOne, JoinColumn } from 'typeorm';
import { FinParcelaReceber } from '../../entities-export';
import { FinDocumentoOrigem } from '../../entities-export';
import { FinNaturezaFinanceira } from '../../entities-export';
import { Cliente } from '../../entities-export';

@Entity({ name: 'FIN_LANCAMENTO_RECEBER' })
export class FinLancamentoReceber { 

	@PrimaryGeneratedColumn()
	id: number;

	@Column({ name: 'QUANTIDADE_PARCELA' })
	quantidadeParcela: number;

	@Column({ name: 'VALOR_TOTAL' })
	valorTotal: number;

	@Column({ name: 'VALOR_A_RECEBER' })
	valorAReceber: number;

	@Column({ name: 'DATA_LANCAMENTO' })
	dataLancamento: Date;

	@Column({ name: 'NUMERO_DOCUMENTO' })
	numeroDocumento: string;

	@Column({ name: 'PRIMEIRO_VENCIMENTO' })
	primeiroVencimento: Date;

	@Column({ name: 'TAXA_COMISSAO' })
	taxaComissao: number;

	@Column({ name: 'VALOR_COMISSAO' })
	valorComissao: number;

	@Column({ name: 'INTERVALO_ENTRE_PARCELAS' })
	intervaloEntreParcelas: number;

	@Column({ name: 'DIA_FIXO' })
	diaFixo: string;


	/**
	* Relations
	*/
    @OneToOne(() => FinDocumentoOrigem)
    @JoinColumn({ name: "ID_FIN_DOCUMENTO_ORIGEM" })
    finDocumentoOrigem: FinDocumentoOrigem;

    @OneToOne(() => FinNaturezaFinanceira)
    @JoinColumn({ name: "ID_FIN_NATUREZA_FINANCEIRA" })
    finNaturezaFinanceira: FinNaturezaFinanceira;

    @OneToOne(() => Cliente)
    @JoinColumn({ name: "ID_CLIENTE" })
    cliente: Cliente;

    @OneToMany(() => FinParcelaReceber, finParcelaReceber => finParcelaReceber.finLancamentoReceber, { cascade: true })
    listaFinParcelaReceber: FinParcelaReceber[];


	/**
	* Constructor
	*/
	constructor(objetoJson: {}) {
		if (objetoJson != null) {
			this.id = objetoJson['id'];
			this.quantidadeParcela = objetoJson['quantidadeParcela'];
			this.valorTotal = objetoJson['valorTotal'];
			this.valorAReceber = objetoJson['valorAReceber'];
			this.dataLancamento = objetoJson['dataLancamento'];
			this.numeroDocumento = objetoJson['numeroDocumento'];
			this.primeiroVencimento = objetoJson['primeiroVencimento'];
			this.taxaComissao = objetoJson['taxaComissao'];
			this.valorComissao = objetoJson['valorComissao'];
			this.intervaloEntreParcelas = objetoJson['intervaloEntreParcelas'];
			this.diaFixo = objetoJson['diaFixo'];
			
			if (objetoJson['finDocumentoOrigem'] != null) {
				this.finDocumentoOrigem = new FinDocumentoOrigem(objetoJson['finDocumentoOrigem']);
			}

			if (objetoJson['finNaturezaFinanceira'] != null) {
				this.finNaturezaFinanceira = new FinNaturezaFinanceira(objetoJson['finNaturezaFinanceira']);
			}

			if (objetoJson['cliente'] != null) {
				this.cliente = new Cliente(objetoJson['cliente']);
			}

			
			this.listaFinParcelaReceber = [];
			let listaFinParcelaReceberJson = objetoJson['listaFinParcelaReceber'];
			if (listaFinParcelaReceberJson != null) {
				for (let i = 0; i < listaFinParcelaReceberJson.length; i++) {
					let objeto = new FinParcelaReceber(listaFinParcelaReceberJson[i]);
					this.listaFinParcelaReceber.push(objeto);
				}
			}

		}
	}
}