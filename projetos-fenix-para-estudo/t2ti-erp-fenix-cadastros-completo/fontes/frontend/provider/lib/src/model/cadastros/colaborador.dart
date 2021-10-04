/*
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
import 'dart:convert';

import 'package:intl/intl.dart';
import 'package:fenix/src/model/model.dart';

class Colaborador {
	int id;
	int idPessoa;
	int idCargo;
	int idSetor;
	String matricula;
	DateTime dataCadastro;
	DateTime dataAdmissao;
	DateTime dataDemissao;
	String ctpsNumero;
	String ctpsSerie;
	DateTime ctpsDataExpedicao;
	String ctpsUf;
	String observacao;
	Usuario usuario;
	Pessoa pessoa;
	Cargo cargo;
	Setor setor;

	Colaborador({
			this.id,
			this.idPessoa,
			this.idCargo,
			this.idSetor,
			this.matricula,
			this.dataCadastro,
			this.dataAdmissao,
			this.dataDemissao,
			this.ctpsNumero,
			this.ctpsSerie,
			this.ctpsDataExpedicao,
			this.ctpsUf,
			this.observacao,
			this.usuario,
			this.pessoa,
			this.cargo,
			this.setor,
		});

	static List<String> campos = <String>[
		'ID', 
		'MATRICULA', 
		'DATA_CADASTRO', 
		'DATA_ADMISSAO', 
		'DATA_DEMISSAO', 
		'CTPS_NUMERO', 
		'CTPS_SERIE', 
		'CTPS_DATA_EXPEDICAO', 
		'CTPS_UF', 
		'OBSERVACAO', 
	];
	
	static List<String> colunas = <String>[
		'Id', 
		'Matrícula', 
		'Data de Cadastro', 
		'Data de Admissão', 
		'Data de Demissão', 
		'Número CTPS', 
		'Série CTPS', 
		'Data de Expedição', 
		'UF CTPS', 
		'Observação', 
	];

	Colaborador.fromJson(Map<String, dynamic> jsonDados) {
		id = jsonDados['id'];
		idPessoa = jsonDados['idPessoa'];
		idCargo = jsonDados['idCargo'];
		idSetor = jsonDados['idSetor'];
		matricula = jsonDados['matricula'];
		dataCadastro = jsonDados['dataCadastro'] != null ? DateTime.tryParse(jsonDados['dataCadastro']) : null;
		dataAdmissao = jsonDados['dataAdmissao'] != null ? DateTime.tryParse(jsonDados['dataAdmissao']) : null;
		dataDemissao = jsonDados['dataDemissao'] != null ? DateTime.tryParse(jsonDados['dataDemissao']) : null;
		ctpsNumero = jsonDados['ctpsNumero'];
		ctpsSerie = jsonDados['ctpsSerie'];
		ctpsDataExpedicao = jsonDados['ctpsDataExpedicao'] != null ? DateTime.tryParse(jsonDados['ctpsDataExpedicao']) : null;
		ctpsUf = jsonDados['ctpsUf'] == '' ? null : jsonDados['ctpsUf'];
		observacao = jsonDados['observacao'];
		usuario = jsonDados['usuario'] == null ? null : new Usuario.fromJson(jsonDados['usuario']);
		pessoa = jsonDados['pessoa'] == null ? null : new Pessoa.fromJson(jsonDados['pessoa']);
		cargo = jsonDados['cargo'] == null ? null : new Cargo.fromJson(jsonDados['cargo']);
		setor = jsonDados['setor'] == null ? null : new Setor.fromJson(jsonDados['setor']);
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonDados = new Map<String, dynamic>();

		jsonDados['id'] = this.id ?? 0;
		jsonDados['idPessoa'] = this.idPessoa ?? 0;
		jsonDados['idCargo'] = this.idCargo ?? 0;
		jsonDados['idSetor'] = this.idSetor ?? 0;
		jsonDados['matricula'] = this.matricula;
		jsonDados['dataCadastro'] = this.dataCadastro != null ? DateFormat('yyyy-MM-ddT00:00:00').format(this.dataCadastro) : null;
		jsonDados['dataAdmissao'] = this.dataAdmissao != null ? DateFormat('yyyy-MM-ddT00:00:00').format(this.dataAdmissao) : null;
		jsonDados['dataDemissao'] = this.dataDemissao != null ? DateFormat('yyyy-MM-ddT00:00:00').format(this.dataDemissao) : null;
		jsonDados['ctpsNumero'] = this.ctpsNumero;
		jsonDados['ctpsSerie'] = this.ctpsSerie;
		jsonDados['ctpsDataExpedicao'] = this.ctpsDataExpedicao != null ? DateFormat('yyyy-MM-ddT00:00:00').format(this.ctpsDataExpedicao) : null;
		jsonDados['ctpsUf'] = this.ctpsUf;
		jsonDados['observacao'] = this.observacao;
		jsonDados['usuario'] = this.usuario == null ? null : this.usuario.toJson;
		jsonDados['pessoa'] = this.pessoa == null ? null : this.pessoa.toJson;
		jsonDados['cargo'] = this.cargo == null ? null : this.cargo.toJson;
		jsonDados['setor'] = this.setor == null ? null : this.setor.toJson;
	
		return jsonDados;
	}
	

	String objetoEncodeJson(Colaborador objeto) {
	  final jsonDados = objeto.toJson;
	  return json.encode(jsonDados);
	}
	
}