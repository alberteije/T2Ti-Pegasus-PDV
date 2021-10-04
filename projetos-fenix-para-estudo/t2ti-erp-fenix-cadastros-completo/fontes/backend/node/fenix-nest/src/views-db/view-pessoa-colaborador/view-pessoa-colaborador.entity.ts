/*******************************************************************************
Title: T2Ti ERP Fenix                                                                
Description: Model relacionado à tabela [VIEW_PESSOA_COLABORADOR] 
                                                                                
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
import { Entity, Column, PrimaryGeneratedColumn } from 'typeorm';

@Entity({ name: 'VIEW_PESSOA_COLABORADOR' })
export class ViewPessoaColaborador { 

	@PrimaryGeneratedColumn()
	id: number;

	@Column({ name: 'NOME' })
	nome: string;

	@Column({ name: 'TIPO' })
	tipo: string;

	@Column({ name: 'EMAIL' })
	email: string;

	@Column({ name: 'SITE' })
	site: string;

	@Column({ name: 'CPF_CNPJ' })
	cpfCnpj: string;

	@Column({ name: 'RG_IE' })
	rgIe: string;

	@Column({ name: 'MATRICULA' })
	matricula: string;

	@Column({ name: 'DATA_CADASTRO' })
	dataCadastro: Date;

	@Column({ name: 'DATA_ADMISSAO' })
	dataAdmissao: Date;

	@Column({ name: 'DATA_DEMISSAO' })
	dataDemissao: Date;

	@Column({ name: 'CTPS_NUMERO' })
	ctpsNumero: string;

	@Column({ name: 'CTPS_SERIE' })
	ctpsSerie: string;

	@Column({ name: 'CTPS_DATA_EXPEDICAO' })
	ctpsDataExpedicao: Date;

	@Column({ name: 'CTPS_UF' })
	ctpsUf: string;

	@Column({ name: 'OBSERVACAO' })
	observacao: string;

	@Column({ name: 'LOGRADOURO' })
	logradouro: string;

	@Column({ name: 'NUMERO' })
	numero: string;

	@Column({ name: 'COMPLEMENTO' })
	complemento: string;

	@Column({ name: 'BAIRRO' })
	bairro: string;

	@Column({ name: 'CIDADE' })
	cidade: string;

	@Column({ name: 'CEP' })
	cep: string;

	@Column({ name: 'MUNICIPIO_IBGE' })
	municipioIbge: number;

	@Column({ name: 'UF' })
	uf: string;

	@Column({ name: 'ID_PESSOA' })
	idPessoa: number;

	@Column({ name: 'ID_CARGO' })
	idCargo: number;

	@Column({ name: 'ID_SETOR' })
	idSetor: number;


	/**
	* Relations
	*/

	/**
	* Constructor
	*/
	constructor(objetoJson: {}) {
		if (objetoJson != null) {
			this.id = objetoJson['id'];
			this.nome = objetoJson['nome'];
			this.tipo = objetoJson['tipo'];
			this.email = objetoJson['email'];
			this.site = objetoJson['site'];
			this.cpfCnpj = objetoJson['cpfCnpj'];
			this.rgIe = objetoJson['rgIe'];
			this.matricula = objetoJson['matricula'];
			this.dataCadastro = objetoJson['dataCadastro'];
			this.dataAdmissao = objetoJson['dataAdmissao'];
			this.dataDemissao = objetoJson['dataDemissao'];
			this.ctpsNumero = objetoJson['ctpsNumero'];
			this.ctpsSerie = objetoJson['ctpsSerie'];
			this.ctpsDataExpedicao = objetoJson['ctpsDataExpedicao'];
			this.ctpsUf = objetoJson['ctpsUf'];
			this.observacao = objetoJson['observacao'];
			this.logradouro = objetoJson['logradouro'];
			this.numero = objetoJson['numero'];
			this.complemento = objetoJson['complemento'];
			this.bairro = objetoJson['bairro'];
			this.cidade = objetoJson['cidade'];
			this.cep = objetoJson['cep'];
			this.municipioIbge = objetoJson['municipioIbge'];
			this.uf = objetoJson['uf'];
			this.idPessoa = objetoJson['idPessoa'];
			this.idCargo = objetoJson['idCargo'];
			this.idSetor = objetoJson['idSetor'];
			
			
		}
	}
}