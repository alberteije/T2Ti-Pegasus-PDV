/*
Title: T2Ti ERP Fenix                                                                
Description: Model relacionado à tabela [PESSOA_FISICA] 
                                                                                
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
import 'dart:convert';

import 'package:intl/intl.dart';
import 'package:fenix/src/infra/biblioteca.dart';
import 'package:fenix/src/model/model.dart';

class PessoaFisica {
	int id;
	int idPessoa;
	int idNivelFormacao;
	int idEstadoCivil;
	String cpf;
	String rg;
	String orgaoRg;
	DateTime dataEmissaoRg;
	DateTime dataNascimento;
	String sexo;
	String raca;
	String nacionalidade;
	String naturalidade;
	String nomePai;
	String nomeMae;
	NivelFormacao nivelFormacao;
	EstadoCivil estadoCivil;

	PessoaFisica({
			this.id,
			this.idPessoa,
			this.idNivelFormacao,
			this.idEstadoCivil,
			this.cpf,
			this.rg,
			this.orgaoRg,
			this.dataEmissaoRg,
			this.dataNascimento,
			this.sexo,
			this.raca,
			this.nacionalidade,
			this.naturalidade,
			this.nomePai,
			this.nomeMae,
			this.nivelFormacao,
			this.estadoCivil,
		});

	static List<String> campos = <String>[
		'ID', 
		'CPF', 
		'RG', 
		'ORGAO_RG', 
		'DATA_EMISSAO_RG', 
		'DATA_NASCIMENTO', 
		'SEXO', 
		'RACA', 
		'NACIONALIDADE', 
		'NATURALIDADE', 
		'NOME_PAI', 
		'NOME_MAE', 
	];
	
	static List<String> colunas = <String>[
		'Id', 
		'CPF', 
		'RG', 
		'Órgão RG', 
		'Data Emissão', 
		'Data Nascimento', 
		'Sexo', 
		'Raça', 
		'Nacionalidade', 
		'Naturalidade', 
		'Nome Pai', 
		'Nome Mãe', 
	];

	PessoaFisica.fromJson(Map<String, dynamic> jsonDados) {
		id = jsonDados['id'];
		idPessoa = jsonDados['idPessoa'];
		idNivelFormacao = jsonDados['idNivelFormacao'];
		idEstadoCivil = jsonDados['idEstadoCivil'];
		cpf = jsonDados['cpf'];
		rg = jsonDados['rg'];
		orgaoRg = jsonDados['orgaoRg'];
		dataEmissaoRg = jsonDados['dataEmissaoRg'] != null ? DateTime.tryParse(jsonDados['dataEmissaoRg']) : null;
		dataNascimento = jsonDados['dataNascimento'] != null ? DateTime.tryParse(jsonDados['dataNascimento']) : null;
		sexo = getSexo(jsonDados['sexo']);
		raca = getRaca(jsonDados['raca']);
		nacionalidade = jsonDados['nacionalidade'];
		naturalidade = jsonDados['naturalidade'];
		nomePai = jsonDados['nomePai'];
		nomeMae = jsonDados['nomeMae'];
		nivelFormacao = jsonDados['nivelFormacao'] == null ? null : new NivelFormacao.fromJson(jsonDados['nivelFormacao']);
		estadoCivil = jsonDados['estadoCivil'] == null ? null : new EstadoCivil.fromJson(jsonDados['estadoCivil']);
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonDados = new Map<String, dynamic>();

		jsonDados['id'] = this.id ?? 0;
		jsonDados['idPessoa'] = this.idPessoa ?? 0;
		jsonDados['idNivelFormacao'] = this.idNivelFormacao ?? 0;
		jsonDados['idEstadoCivil'] = this.idEstadoCivil ?? 0;
		jsonDados['cpf'] = Biblioteca.removerMascara(this.cpf);
		jsonDados['rg'] = this.rg;
		jsonDados['orgaoRg'] = this.orgaoRg;
		jsonDados['dataEmissaoRg'] = this.dataEmissaoRg != null ? DateFormat('yyyy-MM-ddT00:00:00').format(this.dataEmissaoRg) : null;
		jsonDados['dataNascimento'] = this.dataNascimento != null ? DateFormat('yyyy-MM-ddT00:00:00').format(this.dataNascimento) : null;
		jsonDados['sexo'] = setSexo(this.sexo);
		jsonDados['raca'] = setRaca(this.raca);
		jsonDados['nacionalidade'] = this.nacionalidade;
		jsonDados['naturalidade'] = this.naturalidade;
		jsonDados['nomePai'] = this.nomePai;
		jsonDados['nomeMae'] = this.nomeMae;
		jsonDados['nivelFormacao'] = this.nivelFormacao == null ? null : this.nivelFormacao.toJson;
		jsonDados['estadoCivil'] = this.estadoCivil == null ? null : this.estadoCivil.toJson;
	
		return jsonDados;
	}
	
    getSexo(String sexo) {
    	switch (sexo) {
    		case 'M':
    			return 'Masculino';
    			break;
    		case 'F':
    			return 'Feminino';
    			break;
    		default:
    			return null;
    		}
    	}

    setSexo(String sexo) {
    	switch (sexo) {
    		case 'Masculino':
    			return 'M';
    			break;
    		case 'Feminino':
    			return 'F';
    			break;
    		default:
    			return null;
    		}
    	}

    getRaca(String raca) {
    	switch (raca) {
    		case 'B':
    			return 'Branco';
    			break;
    		case 'M':
    			return 'Moreno';
    			break;
    		case 'N':
    			return 'Negro';
    			break;
    		case 'P':
    			return 'Pardo';
    			break;
    		case 'A':
    			return 'Amarelo';
    			break;
    		case 'I':
    			return 'Indígena';
    			break;
    		case 'O':
    			return 'Outro';
    			break;
    		default:
    			return null;
    		}
    	}

    setRaca(String raca) {
    	switch (raca) {
    		case 'Branco':
    			return 'B';
    			break;
    		case 'Moreno':
    			return 'M';
    			break;
    		case 'Negro':
    			return 'N';
    			break;
    		case 'Pardo':
    			return 'P';
    			break;
    		case 'Amarelo':
    			return 'A';
    			break;
    		case 'Indígena':
    			return 'I';
    			break;
    		case 'Outro':
    			return 'O';
    			break;
    		default:
    			return null;
    		}
    	}


	String objetoEncodeJson(PessoaFisica objeto) {
	  final jsonDados = objeto.toJson;
	  return json.encode(jsonDados);
	}
	
}