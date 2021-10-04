/*******************************************************************************
Title: T2Ti ERP Fenix                                                                
Description: Model relacionado à tabela [USUARIO] 
                                                                                
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
import { Colaborador } from '../../entities-export';
import { Papel } from '../../entities-export';

@Entity({ name: 'USUARIO' })
export class Usuario { 

	@PrimaryGeneratedColumn()
	id: number;

	@Column({ name: 'LOGIN' })
	login: string;

	@Column({ name: 'SENHA' })
	senha: string;

	@Column({ name: 'ADMINISTRADOR' })
	administrador: string;

	@Column({ name: 'DATA_CADASTRO' })
	dataCadastro: Date;


	/**
	* Relations
	*/
    @OneToOne(() => Colaborador, colaborador => colaborador.usuario)
    @JoinColumn({ name: "ID_COLABORADOR" })
    colaborador: Colaborador;

    @OneToOne(() => Papel)
    @JoinColumn({ name: "ID_PAPEL" })
    papel: Papel;


	/**
	* Constructor
	*/
	constructor(objetoJson: {}) {
		if (objetoJson != null) {
			this.id = objetoJson['id'];
			this.login = objetoJson['login'];
			this.senha = objetoJson['senha'];
			this.administrador = objetoJson['administrador'];
			this.dataCadastro = objetoJson['dataCadastro'];
			
			if (objetoJson['papel'] != null) {
				this.papel = new Papel(objetoJson['papel']);
			}

			
		}
	}
}