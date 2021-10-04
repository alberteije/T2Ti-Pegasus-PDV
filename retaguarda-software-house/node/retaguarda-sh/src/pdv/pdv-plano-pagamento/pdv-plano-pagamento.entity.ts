/*******************************************************************************
Title: T2Ti ERP 3.0                                                                
Description: Model relacionado à tabela [PDV_PLANO_PAGAMENTO] 
                                                                                
The MIT License                                                                 
                                                                                
Copyright: Copyright (C) 2021 T2Ti.COM                                          
                                                                                
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
import { Empresa } from '../../entities-export';
import { PdvTipoPlano } from '../../entities-export';

@Entity({ name: 'PDV_PLANO_PAGAMENTO' })
export class PdvPlanoPagamento { 

	@PrimaryGeneratedColumn()
	id: number;

	@Column({ name: 'DATA_SOLICITACAO' })
	dataSolicitacao: Date;

	@Column({ name: 'DATA_PAGAMENTO' })
	dataPagamento: Date;

	@Column({ name: 'PLANO' })
	plano: string;

	@Column({ name: 'VALOR' })
	valor: number;

	@Column({ name: 'STATUS_PAGAMENTO' })
	statusPagamento: string;

	@Column({ name: 'CODIGO_TRANSACAO' })
	codigoTransacao: string;

	@Column({ name: 'METODO_PAGAMENTO' })
	metodoPagamento: string;

	@Column({ name: 'CODIGO_TIPO_PAGAMENTO' })
	codigoTipoPagamento: string;

	@Column({ name: 'DATA_PLANO_EXPIRA' })
	dataPlanoExpira: Date;

	@Column({ name: 'EMAIL_PAGAMENTO' })
	emailPagamento: string;


	/**
	* Relations
	*/
    @OneToOne(() => Empresa)
    @JoinColumn({ name: "ID_EMPRESA" })
    empresa: Empresa;

    @OneToOne(() => PdvTipoPlano)
    @JoinColumn({ name: "ID_PDV_TIPO_PLANO" })
    pdvTipoPlano: PdvTipoPlano;

	/**
	* Constructor
	*/
	constructor(objetoJson: {}) {
		if (objetoJson != null) {
			this.id = objetoJson['id'] == 0 ? undefined : objetoJson['id'];
			this.dataSolicitacao = objetoJson['dataSolicitacao'];
			this.dataPagamento = objetoJson['dataPagamento'];
			this.plano = objetoJson['plano'];
			this.valor = objetoJson['valor'];
			this.statusPagamento = objetoJson['statusPagamento'];
			this.codigoTransacao = objetoJson['codigoTransacao'] != null ? objetoJson['codigoTransacao'] : objetoJson['CODIGO_TRANSACAO'];
			this.metodoPagamento = objetoJson['metodoPagamento'];
			this.codigoTipoPagamento = objetoJson['codigoTipoPagamento'];
			this.dataPlanoExpira = objetoJson['dataPlanoExpira'];
			this.emailPagamento = objetoJson['emailPagamento'];
			
			if (objetoJson['empresa'] != null) {
				this.empresa = new Empresa(objetoJson['empresa']);
			}	

			if (objetoJson['pdvTipoPlano'] != null) {
				this.pdvTipoPlano = new PdvTipoPlano(objetoJson['pdvTipoPlano']);
			}	
			
		}
	}
}