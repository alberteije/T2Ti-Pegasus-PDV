/*******************************************************************************
Title: T2Ti ERP Fenix                                                                
Description: Model relacionado à tabela [COLABORADOR] 
                                                                                
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
import { Usuario } from '../../entities-export';
import { Pessoa } from '../../entities-export';
import { Cargo } from '../../entities-export';
import { Setor } from '../../entities-export';

@Entity({ name: 'COLABORADOR' })
export class Colaborador { 

	@PrimaryGeneratedColumn()
	id: number;

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


	/**
	* Relations
	*/
    @OneToOne(() => Usuario, usuario => usuario.colaborador, { cascade: true })
    usuario: Usuario;

    @OneToOne(() => Pessoa)
    @JoinColumn({ name: "ID_PESSOA" })
    pessoa: Pessoa;

    @OneToOne(() => Cargo)
    @JoinColumn({ name: "ID_CARGO" })
    cargo: Cargo;

    @OneToOne(() => Setor)
    @JoinColumn({ name: "ID_SETOR" })
    setor: Setor;


	/**
	* Constructor
	*/
	constructor(objetoJson: {}) {
		if (objetoJson != null) {
			this.id = objetoJson['id'];
			this.matricula = objetoJson['matricula'];
			this.dataCadastro = objetoJson['dataCadastro'];
			this.dataAdmissao = objetoJson['dataAdmissao'];
			this.dataDemissao = objetoJson['dataDemissao'];
			this.ctpsNumero = objetoJson['ctpsNumero'];
			this.ctpsSerie = objetoJson['ctpsSerie'];
			this.ctpsDataExpedicao = objetoJson['ctpsDataExpedicao'];
			this.ctpsUf = objetoJson['ctpsUf'];
			this.observacao = objetoJson['observacao'];
			
			if (objetoJson['usuario'] != null) {
				this.usuario = new Usuario(objetoJson['usuario']);
			}

			if (objetoJson['pessoa'] != null) {
				this.pessoa = new Pessoa(objetoJson['pessoa']);
			}

			if (objetoJson['cargo'] != null) {
				this.cargo = new Cargo(objetoJson['cargo']);
			}

			if (objetoJson['setor'] != null) {
				this.setor = new Setor(objetoJson['setor']);
			}

			
		}
	}
}