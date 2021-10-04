/*******************************************************************************
Title: T2Ti ERP Fenix                                                                
Description: Model relacionado à tabela [PESSOA_ENDERECO] 
                                                                                
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
import { Entity, Column, PrimaryGeneratedColumn, ManyToOne, JoinColumn } from 'typeorm';
import { Pessoa } from '../../entities-export';

@Entity({ name: 'PESSOA_ENDERECO' })
export class PessoaEndereco { 

	@PrimaryGeneratedColumn()
	id: number;

	@Column({ name: 'LOGRADOURO' })
	logradouro: string;

	@Column({ name: 'NUMERO' })
	numero: string;

	@Column({ name: 'BAIRRO' })
	bairro: string;

	@Column({ name: 'MUNICIPIO_IBGE' })
	municipioIbge: number;

	@Column({ name: 'UF' })
	uf: string;

	@Column({ name: 'CEP' })
	cep: string;

	@Column({ name: 'CIDADE' })
	cidade: string;

	@Column({ name: 'COMPLEMENTO' })
	complemento: string;

	@Column({ name: 'PRINCIPAL' })
	principal: string;

	@Column({ name: 'ENTREGA' })
	entrega: string;

	@Column({ name: 'COBRANCA' })
	cobranca: string;

	@Column({ name: 'CORRESPONDENCIA' })
	correspondencia: string;


	/**
	* Relations
	*/
    @ManyToOne(() => Pessoa, pessoa => pessoa.listaPessoaEndereco)
    @JoinColumn({ name: "ID_PESSOA" })
    pessoa: Pessoa;


	/**
	* Constructor
	*/
	constructor(objetoJson: {}) {
		if (objetoJson != null) {
			this.id = objetoJson['id'];
			this.logradouro = objetoJson['logradouro'];
			this.numero = objetoJson['numero'];
			this.bairro = objetoJson['bairro'];
			this.municipioIbge = objetoJson['municipioIbge'];
			this.uf = objetoJson['uf'];
			this.cep = objetoJson['cep'];
			this.cidade = objetoJson['cidade'];
			this.complemento = objetoJson['complemento'];
			this.principal = objetoJson['principal'];
			this.entrega = objetoJson['entrega'];
			this.cobranca = objetoJson['cobranca'];
			this.correspondencia = objetoJson['correspondencia'];
			
			
		}
	}
}