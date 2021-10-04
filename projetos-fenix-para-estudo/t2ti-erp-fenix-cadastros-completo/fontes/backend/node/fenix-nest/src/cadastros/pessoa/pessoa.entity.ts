/*******************************************************************************
Title: T2Ti ERP Fenix                                                                
Description: Model relacionado à tabela [PESSOA] 
                                                                                
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
import { Entity, Column, PrimaryGeneratedColumn, OneToMany, OneToOne } from 'typeorm';
import { PessoaContato } from '../../entities-export';
import { PessoaEndereco } from '../../entities-export';
import { PessoaFisica } from '../../entities-export';
import { PessoaJuridica } from '../../entities-export';
import { PessoaTelefone } from '../../entities-export';

@Entity({ name: 'PESSOA' })
export class Pessoa { 

	@PrimaryGeneratedColumn()
	id: number;

	@Column({ name: 'NOME' })
	nome: string;

	@Column({ name: 'TIPO' })
	tipo: string;

	@Column({ name: 'SITE' })
	site: string;

	@Column({ name: 'EMAIL' })
	email: string;

	@Column({ name: 'CLIENTE' })
	cliente: string;

	@Column({ name: 'FORNECEDOR' })
	fornecedor: string;

	@Column({ name: 'TRANSPORTADORA' })
	transportadora: string;

	@Column({ name: 'COLABORADOR' })
	colaborador: string;

	@Column({ name: 'CONTADOR' })
	contador: string;


	/**
	* Relations
	*/
    @OneToOne(() => PessoaFisica, pessoaFisica => pessoaFisica.pessoa, { cascade: true })
    pessoaFisica: PessoaFisica;

    @OneToOne(() => PessoaJuridica, pessoaJuridica => pessoaJuridica.pessoa, { cascade: true })
    pessoaJuridica: PessoaJuridica;

    @OneToMany(() => PessoaContato, pessoaContato => pessoaContato.pessoa, { cascade: true })
    listaPessoaContato: PessoaContato[];

    @OneToMany(() => PessoaEndereco, pessoaEndereco => pessoaEndereco.pessoa, { cascade: true })
    listaPessoaEndereco: PessoaEndereco[];

    @OneToMany(() => PessoaTelefone, pessoaTelefone => pessoaTelefone.pessoa, { cascade: true })
    listaPessoaTelefone: PessoaTelefone[];


	/**
	* Constructor
	*/
	constructor(objetoJson: {}) {
		if (objetoJson != null) {
			this.id = objetoJson['id'];
			this.nome = objetoJson['nome'];
			this.tipo = objetoJson['tipo'];
			this.site = objetoJson['site'];
			this.email = objetoJson['email'];
			this.cliente = objetoJson['cliente'];
			this.fornecedor = objetoJson['fornecedor'];
			this.transportadora = objetoJson['transportadora'];
			this.colaborador = objetoJson['colaborador'];
			this.contador = objetoJson['contador'];
			
			if (objetoJson['pessoaFisica'] != null) {
				this.pessoaFisica = new PessoaFisica(objetoJson['pessoaFisica']);
			}

			if (objetoJson['pessoaJuridica'] != null) {
				this.pessoaJuridica = new PessoaJuridica(objetoJson['pessoaJuridica']);
			}

			
			this.listaPessoaContato = [];
			let listaPessoaContatoJson = objetoJson['listaPessoaContato'];
			if (listaPessoaContatoJson != null) {
				for (let i = 0; i < listaPessoaContatoJson.length; i++) {
					let objeto = new PessoaContato(listaPessoaContatoJson[i]);
					this.listaPessoaContato.push(objeto);
				}
			}

			this.listaPessoaEndereco = [];
			let listaPessoaEnderecoJson = objetoJson['listaPessoaEndereco'];
			if (listaPessoaEnderecoJson != null) {
				for (let i = 0; i < listaPessoaEnderecoJson.length; i++) {
					let objeto = new PessoaEndereco(listaPessoaEnderecoJson[i]);
					this.listaPessoaEndereco.push(objeto);
				}
			}

			this.listaPessoaTelefone = [];
			let listaPessoaTelefoneJson = objetoJson['listaPessoaTelefone'];
			if (listaPessoaTelefoneJson != null) {
				for (let i = 0; i < listaPessoaTelefoneJson.length; i++) {
					let objeto = new PessoaTelefone(listaPessoaTelefoneJson[i]);
					this.listaPessoaTelefone.push(objeto);
				}
			}

		}
	}
}