/*******************************************************************************
Title: T2Ti ERP 3.0                                                                
Description: Model relacionado à tabela [EMPRESA] 
                                                                                
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
import { Entity, Column, PrimaryGeneratedColumn } from 'typeorm';

@Entity({ name: 'EMPRESA' })
export class Empresa { 

	@PrimaryGeneratedColumn()
	id: number;

	@Column({ name: 'RAZAO_SOCIAL' })
	razaoSocial: string;

	@Column({ name: 'NOME_FANTASIA' })
	nomeFantasia: string;

	@Column({ name: 'CNPJ' })
	cnpj: string;

	@Column({ name: 'INSCRICAO_ESTADUAL' })
	inscricaoEstadual: string;

	@Column({ name: 'INSCRICAO_MUNICIPAL' })
	inscricaoMunicipal: string;

	@Column({ name: 'TIPO_REGIME' })
	tipoRegime: string;

	@Column({ name: 'CRT' })
	crt: string;

	@Column({ name: 'DATA_CONSTITUICAO' })
	dataConstituicao: Date;

	@Column({ name: 'TIPO' })
	tipo: string;

	@Column({ name: 'EMAIL' })
	email: string;

	@Column({ name: 'LOGRADOURO' })
	logradouro: string;

	@Column({ name: 'NUMERO' })
	numero: string;

	@Column({ name: 'COMPLEMENTO' })
	complemento: string;

	@Column({ name: 'CEP' })
	cep: string;

	@Column({ name: 'BAIRRO' })
	bairro: string;

	@Column({ name: 'CIDADE' })
	cidade: string;

	@Column({ name: 'UF' })
	uf: string;

	@Column({ name: 'FONE' })
	fone: string;

	@Column({ name: 'CONTATO' })
	contato: string;

	@Column({ name: 'CODIGO_IBGE_CIDADE' })
	codigoIbgeCidade: number;

	@Column({ name: 'CODIGO_IBGE_UF' })
	codigoIbgeUf: number;

	@Column({ name: 'LOGOTIPO' })
	logotipo: string;

	@Column({ name: 'REGISTRADO' })
	registrado: string;

	@Column({ name: 'NATUREZA_JURIDICA' })
	naturezaJuridica: string;

	@Column({ name: 'SIMEI' })
	simei: string;

	@Column({ name: 'EMAIL_PAGAMENTO' })
	emailPagamento: string;

	@Column({ name: 'DATA_REGISTRO' })
	dataRegistro: Date;	

	@Column({ name: 'HORA_REGISTRO' })
	horaRegistro: string;

	/**
	* Constructor
	*/
	constructor(objetoJson: {}) {
		if (objetoJson != null) {
			this.id = objetoJson['id'] == 0 ? undefined : objetoJson['id'];
			this.razaoSocial = objetoJson['razaoSocial'];
			this.nomeFantasia = objetoJson['nomeFantasia'];
			this.cnpj = objetoJson['cnpj'];
			this.inscricaoEstadual = objetoJson['inscricaoEstadual'];
			this.inscricaoMunicipal = objetoJson['inscricaoMunicipal'];
			this.tipoRegime = objetoJson['tipoRegime'];
			this.crt = objetoJson['crt'];
			this.dataConstituicao = objetoJson['dataConstituicao'];
			this.tipo = objetoJson['tipo'];
			this.email = objetoJson['email'];
			this.logradouro = objetoJson['logradouro'];
			this.numero = objetoJson['numero'];
			this.complemento = objetoJson['complemento'];
			this.cep = objetoJson['cep'];
			this.bairro = objetoJson['bairro'];
			this.cidade = objetoJson['cidade'];
			this.uf = objetoJson['uf'];
			this.fone = objetoJson['fone'];
			this.contato = objetoJson['contato'];
			this.codigoIbgeCidade = objetoJson['codigoIbgeCidade'];
			this.codigoIbgeUf = objetoJson['codigoIbgeUf'];
			this.logotipo = objetoJson['logotipo'];
			this.registrado = objetoJson['registrado'];
			this.naturezaJuridica = objetoJson['naturezaJuridica'];
			this.simei = objetoJson['simei'];
			this.emailPagamento = objetoJson['emailPagamento'];
			this.dataRegistro = objetoJson['dataRegistro'];
			this.horaRegistro = objetoJson['horaRegistro'];
			
		}
	}
}