/*******************************************************************************
Title: T2Ti ERP Fenix                                                                
Description: Model relacionado à tabela [FIN_FECHAMENTO_CAIXA_BANCO] 
                                                                                
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
import { BancoContaCaixa } from '../../entities-export';

@Entity({ name: 'FIN_FECHAMENTO_CAIXA_BANCO' })
export class FinFechamentoCaixaBanco { 

	@PrimaryGeneratedColumn()
	id: number;

	@Column({ name: 'DATA_FECHAMENTO' })
	dataFechamento: Date;

	@Column({ name: 'MES_ANO' })
	mesAno: string;

	@Column({ name: 'MES' })
	mes: string;

	@Column({ name: 'ANO' })
	ano: string;

	@Column({ name: 'SALDO_ANTERIOR' })
	saldoAnterior: number;

	@Column({ name: 'RECEBIMENTOS' })
	recebimentos: number;

	@Column({ name: 'PAGAMENTOS' })
	pagamentos: number;

	@Column({ name: 'SALDO_CONTA' })
	saldoConta: number;

	@Column({ name: 'CHEQUE_NAO_COMPENSADO' })
	chequeNaoCompensado: number;

	@Column({ name: 'SALDO_DISPONIVEL' })
	saldoDisponivel: number;


	/**
	* Relations
	*/
    @OneToOne(() => BancoContaCaixa)
    @JoinColumn({ name: "ID_BANCO_CONTA_CAIXA" })
    bancoContaCaixa: BancoContaCaixa;


	/**
	* Constructor
	*/
	constructor(objetoJson: {}) {
		if (objetoJson != null) {
			this.id = objetoJson['id'];
			this.dataFechamento = objetoJson['dataFechamento'];
			this.mesAno = objetoJson['mesAno'];
			this.mes = objetoJson['mes'];
			this.ano = objetoJson['ano'];
			this.saldoAnterior = objetoJson['saldoAnterior'];
			this.recebimentos = objetoJson['recebimentos'];
			this.pagamentos = objetoJson['pagamentos'];
			this.saldoConta = objetoJson['saldoConta'];
			this.chequeNaoCompensado = objetoJson['chequeNaoCompensado'];
			this.saldoDisponivel = objetoJson['saldoDisponivel'];
			
			if (objetoJson['bancoContaCaixa'] != null) {
				this.bancoContaCaixa = new BancoContaCaixa(objetoJson['bancoContaCaixa']);
			}

			
		}
	}
}