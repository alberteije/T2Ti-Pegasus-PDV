/*******************************************************************************
Title: T2Ti ERP Fenix                                                                
Description: Model relacionado à tabela [FIN_CHEQUE_RECEBIDO] 
                                                                                
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
import { Entity, Column, PrimaryGeneratedColumn, OneToOne, JoinColumn } from 'typeorm';
import { Pessoa } from '../../entities-export';

@Entity({ name: 'FIN_CHEQUE_RECEBIDO' })
export class FinChequeRecebido { 

	@PrimaryGeneratedColumn()
	id: number;

	@Column({ name: 'CPF' })
	cpf: string;

	@Column({ name: 'CNPJ' })
	cnpj: string;

	@Column({ name: 'NOME' })
	nome: string;

	@Column({ name: 'CODIGO_BANCO' })
	codigoBanco: string;

	@Column({ name: 'CODIGO_AGENCIA' })
	codigoAgencia: string;

	@Column({ name: 'CONTA' })
	conta: string;

	@Column({ name: 'NUMERO' })
	numero: number;

	@Column({ name: 'DATA_EMISSAO' })
	dataEmissao: Date;

	@Column({ name: 'BOM_PARA' })
	bomPara: Date;

	@Column({ name: 'DATA_COMPENSACAO' })
	dataCompensacao: Date;

	@Column({ name: 'VALOR' })
	valor: number;

	@Column({ name: 'CUSTODIA_DATA' })
	custodiaData: Date;

	@Column({ name: 'CUSTODIA_TARIFA' })
	custodiaTarifa: number;

	@Column({ name: 'CUSTODIA_COMISSAO' })
	custodiaComissao: number;

	@Column({ name: 'DESCONTO_DATA' })
	descontoData: Date;

	@Column({ name: 'DESCONTO_TARIFA' })
	descontoTarifa: number;

	@Column({ name: 'DESCONTO_COMISSAO' })
	descontoComissao: number;

	@Column({ name: 'VALOR_RECEBIDO' })
	valorRecebido: number;


	/**
	* Relations
	*/
    @OneToOne(() => Pessoa)
    @JoinColumn({ name: "ID_PESSOA" })
    pessoa: Pessoa;


	/**
	* Constructor
	*/
	constructor(objetoJson: {}) {
		if (objetoJson != null) {
			this.id = objetoJson['id'];
			this.cpf = objetoJson['cpf'];
			this.cnpj = objetoJson['cnpj'];
			this.nome = objetoJson['nome'];
			this.codigoBanco = objetoJson['codigoBanco'];
			this.codigoAgencia = objetoJson['codigoAgencia'];
			this.conta = objetoJson['conta'];
			this.numero = objetoJson['numero'];
			this.dataEmissao = objetoJson['dataEmissao'];
			this.bomPara = objetoJson['bomPara'];
			this.dataCompensacao = objetoJson['dataCompensacao'];
			this.valor = objetoJson['valor'];
			this.custodiaData = objetoJson['custodiaData'];
			this.custodiaTarifa = objetoJson['custodiaTarifa'];
			this.custodiaComissao = objetoJson['custodiaComissao'];
			this.descontoData = objetoJson['descontoData'];
			this.descontoTarifa = objetoJson['descontoTarifa'];
			this.descontoComissao = objetoJson['descontoComissao'];
			this.valorRecebido = objetoJson['valorRecebido'];
			
			if (objetoJson['pessoa'] != null) {
				this.pessoa = new Pessoa(objetoJson['pessoa']);
			}

			
		}
	}
}