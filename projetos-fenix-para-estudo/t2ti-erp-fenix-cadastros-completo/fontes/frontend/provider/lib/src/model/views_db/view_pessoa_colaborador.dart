/*
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
import 'dart:convert';

import 'package:intl/intl.dart';

class ViewPessoaColaborador {
	int id;
	String nome;
	String tipo;
	String email;
	String site;
	String cpfCnpj;
	String rgIe;
	String matricula;
	DateTime dataCadastro;
	DateTime dataAdmissao;
	DateTime dataDemissao;
	String ctpsNumero;
	String ctpsSerie;
	DateTime ctpsDataExpedicao;
	String ctpsUf;
	String observacao;
	String logradouro;
	String numero;
	String complemento;
	String bairro;
	String cidade;
	String cep;
	int municipioIbge;
	String uf;
	int idPessoa;
	int idCargo;
	int idSetor;

	ViewPessoaColaborador({
			this.id,
			this.nome,
			this.tipo,
			this.email,
			this.site,
			this.cpfCnpj,
			this.rgIe,
			this.matricula,
			this.dataCadastro,
			this.dataAdmissao,
			this.dataDemissao,
			this.ctpsNumero,
			this.ctpsSerie,
			this.ctpsDataExpedicao,
			this.ctpsUf,
			this.observacao,
			this.logradouro,
			this.numero,
			this.complemento,
			this.bairro,
			this.cidade,
			this.cep,
			this.municipioIbge,
			this.uf,
			this.idPessoa,
			this.idCargo,
			this.idSetor,
		});

	static List<String> campos = <String>[
		'ID', 
		'NOME', 
		'TIPO', 
		'EMAIL', 
		'SITE', 
		'CPF_CNPJ', 
		'RG_IE', 
		'MATRICULA', 
		'DATA_CADASTRO', 
		'DATA_ADMISSAO', 
		'DATA_DEMISSAO', 
		'CTPS_NUMERO', 
		'CTPS_SERIE', 
		'CTPS_DATA_EXPEDICAO', 
		'CTPS_UF', 
		'OBSERVACAO', 
		'LOGRADOURO', 
		'NUMERO', 
		'COMPLEMENTO', 
		'BAIRRO', 
		'CIDADE', 
		'CEP', 
		'MUNICIPIO_IBGE', 
		'UF', 
	];
	
	static List<String> colunas = <String>[
		'Id', 
		'Nome', 
		'Tipo', 
		'Email', 
		'Site', 
		'Cpf Cnpj', 
		'Rg Ie', 
		'Matricula', 
		'Data Cadastro', 
		'Data Admissao', 
		'Data Demissao', 
		'Ctps Numero', 
		'Ctps Serie', 
		'Ctps Data Expedicao', 
		'Ctps Uf', 
		'Observacao', 
		'Logradouro', 
		'Numero', 
		'Complemento', 
		'Bairro', 
		'Cidade', 
		'Cep', 
		'Municipio Ibge', 
		'Uf', 
	];

	ViewPessoaColaborador.fromJson(Map<String, dynamic> jsonDados) {
		id = jsonDados['id'];
		nome = jsonDados['nome'];
		tipo = jsonDados['tipo'];
		email = jsonDados['email'];
		site = jsonDados['site'];
		cpfCnpj = jsonDados['cpfCnpj'];
		rgIe = jsonDados['rgIe'];
		matricula = jsonDados['matricula'];
		dataCadastro = jsonDados['dataCadastro'] != null ? DateTime.tryParse(jsonDados['dataCadastro']) : null;
		dataAdmissao = jsonDados['dataAdmissao'] != null ? DateTime.tryParse(jsonDados['dataAdmissao']) : null;
		dataDemissao = jsonDados['dataDemissao'] != null ? DateTime.tryParse(jsonDados['dataDemissao']) : null;
		ctpsNumero = jsonDados['ctpsNumero'];
		ctpsSerie = jsonDados['ctpsSerie'];
		ctpsDataExpedicao = jsonDados['ctpsDataExpedicao'] != null ? DateTime.tryParse(jsonDados['ctpsDataExpedicao']) : null;
		ctpsUf = jsonDados['ctpsUf'];
		observacao = jsonDados['observacao'];
		logradouro = jsonDados['logradouro'];
		numero = jsonDados['numero'];
		complemento = jsonDados['complemento'];
		bairro = jsonDados['bairro'];
		cidade = jsonDados['cidade'];
		cep = jsonDados['cep'];
		municipioIbge = jsonDados['municipioIbge'];
		uf = jsonDados['uf'];
		idPessoa = jsonDados['idPessoa'];
		idCargo = jsonDados['idCargo'];
		idSetor = jsonDados['idSetor'];
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonDados = new Map<String, dynamic>();

		jsonDados['id'] = this.id ?? 0;
		jsonDados['nome'] = this.nome;
		jsonDados['tipo'] = this.tipo;
		jsonDados['email'] = this.email;
		jsonDados['site'] = this.site;
		jsonDados['cpfCnpj'] = this.cpfCnpj;
		jsonDados['rgIe'] = this.rgIe;
		jsonDados['matricula'] = this.matricula;
		jsonDados['dataCadastro'] = this.dataCadastro != null ? DateFormat('yyyy-MM-ddT00:00:00').format(this.dataCadastro) : null;
		jsonDados['dataAdmissao'] = this.dataAdmissao != null ? DateFormat('yyyy-MM-ddT00:00:00').format(this.dataAdmissao) : null;
		jsonDados['dataDemissao'] = this.dataDemissao != null ? DateFormat('yyyy-MM-ddT00:00:00').format(this.dataDemissao) : null;
		jsonDados['ctpsNumero'] = this.ctpsNumero;
		jsonDados['ctpsSerie'] = this.ctpsSerie;
		jsonDados['ctpsDataExpedicao'] = this.ctpsDataExpedicao != null ? DateFormat('yyyy-MM-ddT00:00:00').format(this.ctpsDataExpedicao) : null;
		jsonDados['ctpsUf'] = this.ctpsUf;
		jsonDados['observacao'] = this.observacao;
		jsonDados['logradouro'] = this.logradouro;
		jsonDados['numero'] = this.numero;
		jsonDados['complemento'] = this.complemento;
		jsonDados['bairro'] = this.bairro;
		jsonDados['cidade'] = this.cidade;
		jsonDados['cep'] = this.cep;
		jsonDados['municipioIbge'] = this.municipioIbge ?? 0;
		jsonDados['uf'] = this.uf;
		jsonDados['idPessoa'] = this.idPessoa ?? 0;
		jsonDados['idCargo'] = this.idCargo ?? 0;
		jsonDados['idSetor'] = this.idSetor ?? 0;
	
		return jsonDados;
	}
	

	String objetoEncodeJson(ViewPessoaColaborador objeto) {
	  final jsonDados = objeto.toJson;
	  return json.encode(jsonDados);
	}
	
}