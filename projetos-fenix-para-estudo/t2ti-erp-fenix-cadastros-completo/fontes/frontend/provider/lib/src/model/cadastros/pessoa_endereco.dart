/*
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
import 'dart:convert';

import 'package:fenix/src/infra/biblioteca.dart';

class PessoaEndereco {
	int id;
	int idPessoa;
	String logradouro;
	String numero;
	String bairro;
	int municipioIbge;
	String uf;
	String cep;
	String cidade;
	String complemento;
	String principal;
	String entrega;
	String cobranca;
	String correspondencia;

	PessoaEndereco({
			this.id,
			this.idPessoa,
			this.logradouro,
			this.numero,
			this.bairro,
			this.municipioIbge,
			this.uf,
			this.cep,
			this.cidade,
			this.complemento,
			this.principal,
			this.entrega,
			this.cobranca,
			this.correspondencia,
		});

	static List<String> campos = <String>[
		'ID', 
		'LOGRADOURO', 
		'NUMERO', 
		'BAIRRO', 
		'MUNICIPIO_IBGE', 
		'UF', 
		'CEP', 
		'CIDADE', 
		'COMPLEMENTO', 
		'PRINCIPAL', 
		'ENTREGA', 
		'COBRANCA', 
		'CORRESPONDENCIA', 
	];
	
	static List<String> colunas = <String>[
		'Id', 
		'Logradouro', 
		'Número', 
		'Bairro', 
		'Município IBGE', 
		'UF', 
		'CEP', 
		'Cidade', 
		'Complemento', 
		'É Endereço Principal', 
		'É Endereço de Entrega', 
		'É Endereço de Cobrança', 
		'É Endereço de Correspondência', 
	];

	PessoaEndereco.fromJson(Map<String, dynamic> jsonDados) {
		id = jsonDados['id'];
		idPessoa = jsonDados['idPessoa'];
		logradouro = jsonDados['logradouro'];
		numero = jsonDados['numero'];
		bairro = jsonDados['bairro'];
		municipioIbge = jsonDados['municipioIbge'];
		uf = jsonDados['uf'];
		cep = jsonDados['cep'];
		cidade = jsonDados['cidade'];
		complemento = jsonDados['complemento'];
		principal = getPrincipal(jsonDados['principal']);
		entrega = getEntrega(jsonDados['entrega']);
		cobranca = getCobranca(jsonDados['cobranca']);
		correspondencia = getCorrespondencia(jsonDados['correspondencia']);
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonDados = new Map<String, dynamic>();

		jsonDados['id'] = this.id ?? 0;
		jsonDados['idPessoa'] = this.idPessoa ?? 0;
		jsonDados['logradouro'] = this.logradouro;
		jsonDados['numero'] = this.numero;
		jsonDados['bairro'] = this.bairro;
		jsonDados['municipioIbge'] = this.municipioIbge ?? 0;
		jsonDados['uf'] = this.uf;
		jsonDados['cep'] = Biblioteca.removerMascara(this.cep);
		jsonDados['cidade'] = this.cidade;
		jsonDados['complemento'] = this.complemento;
		jsonDados['principal'] = setPrincipal(this.principal);
		jsonDados['entrega'] = setEntrega(this.entrega);
		jsonDados['cobranca'] = setCobranca(this.cobranca);
		jsonDados['correspondencia'] = setCorrespondencia(this.correspondencia);
	
		return jsonDados;
	}
	
    getPrincipal(String principal) {
    	switch (principal) {
    		case 'S':
    			return 'Sim';
    			break;
    		case 'N':
    			return 'Não';
    			break;
    		default:
    			return null;
    		}
    	}

    setPrincipal(String principal) {
    	switch (principal) {
    		case 'Sim':
    			return 'S';
    			break;
    		case 'Não':
    			return 'N';
    			break;
    		default:
    			return null;
    		}
    	}

    getEntrega(String entrega) {
    	switch (entrega) {
    		case 'S':
    			return 'Sim';
    			break;
    		case 'N':
    			return 'Não';
    			break;
    		default:
    			return null;
    		}
    	}

    setEntrega(String entrega) {
    	switch (entrega) {
    		case 'Sim':
    			return 'S';
    			break;
    		case 'Não':
    			return 'N';
    			break;
    		default:
    			return null;
    		}
    	}

    getCobranca(String cobranca) {
    	switch (cobranca) {
    		case 'S':
    			return 'Sim';
    			break;
    		case 'N':
    			return 'Não';
    			break;
    		default:
    			return null;
    		}
    	}

    setCobranca(String cobranca) {
    	switch (cobranca) {
    		case 'Sim':
    			return 'S';
    			break;
    		case 'Não':
    			return 'N';
    			break;
    		default:
    			return null;
    		}
    	}

    getCorrespondencia(String correspondencia) {
    	switch (correspondencia) {
    		case 'S':
    			return 'Sim';
    			break;
    		case 'N':
    			return 'Não';
    			break;
    		default:
    			return null;
    		}
    	}

    setCorrespondencia(String correspondencia) {
    	switch (correspondencia) {
    		case 'Sim':
    			return 'S';
    			break;
    		case 'Não':
    			return 'N';
    			break;
    		default:
    			return null;
    		}
    	}


	String objetoEncodeJson(PessoaEndereco objeto) {
	  final jsonDados = objeto.toJson;
	  return json.encode(jsonDados);
	}
	
}