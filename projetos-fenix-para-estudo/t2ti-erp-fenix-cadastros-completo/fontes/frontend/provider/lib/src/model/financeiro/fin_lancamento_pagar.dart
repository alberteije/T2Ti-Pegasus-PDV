/*
Title: T2Ti ERP Fenix                                                                
Description: Model relacionado à tabela [FIN_LANCAMENTO_PAGAR] 
                                                                                
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

class FinLancamentoPagar {
	int id;
	int idFinDocumentoOrigem;
	int idFinNaturezaFinanceira;
	int idFornecedor;
	int quantidadeParcela;
	double valorTotal;
	double valorAPagar;
	DateTime dataLancamento;
	String numeroDocumento;
	String imagemDocumento;
	DateTime primeiroVencimento;
	int intervaloEntreParcelas;
	String diaFixo;
	FinDocumentoOrigem finDocumentoOrigem;
	FinNaturezaFinanceira finNaturezaFinanceira;
	Fornecedor fornecedor;
	List<FinParcelaPagar> listaFinParcelaPagar = [];

	FinLancamentoPagar({
			this.id,
			this.idFinDocumentoOrigem,
			this.idFinNaturezaFinanceira,
			this.idFornecedor,
			this.quantidadeParcela,
			this.valorTotal,
			this.valorAPagar,
			this.dataLancamento,
			this.numeroDocumento,
			this.imagemDocumento,
			this.primeiroVencimento,
			this.intervaloEntreParcelas,
			this.diaFixo,
			this.finDocumentoOrigem,
			this.finNaturezaFinanceira,
			this.fornecedor,
			this.listaFinParcelaPagar,
		});

	static List<String> campos = <String>[
		'ID', 
		'QUANTIDADE_PARCELA', 
		'VALOR_TOTAL', 
		'VALOR_A_PAGAR', 
		'DATA_LANCAMENTO', 
		'NUMERO_DOCUMENTO', 
		'IMAGEM_DOCUMENTO', 
		'PRIMEIRO_VENCIMENTO', 
		'INTERVALO_ENTRE_PARCELAS', 
		'DIA_FIXO', 
	];
	
	static List<String> colunas = <String>[
		'Id', 
		'Quantidade de Parcelas', 
		'Valor Total', 
		'Valor a Pagar', 
		'Data de Lançamento', 
		'Número do Documento', 
		'Imagem Documento', 
		'Data do Primeiro Vencimento', 
		'Intervalo Entre Parcelas', 
		'Dia Fixo', 
	];

	FinLancamentoPagar.fromJson(Map<String, dynamic> jsonDados) {
		id = jsonDados['id'];
		idFinDocumentoOrigem = jsonDados['idFinDocumentoOrigem'];
		idFinNaturezaFinanceira = jsonDados['idFinNaturezaFinanceira'];
		idFornecedor = jsonDados['idFornecedor'];
		quantidadeParcela = jsonDados['quantidadeParcela'];
		valorTotal = jsonDados['valorTotal'] != null ? jsonDados['valorTotal'].toDouble() : null;
		valorAPagar = jsonDados['valorAPagar'] != null ? jsonDados['valorAPagar'].toDouble() : null;
		dataLancamento = jsonDados['dataLancamento'] != null ? DateTime.tryParse(jsonDados['dataLancamento']) : null;
		numeroDocumento = jsonDados['numeroDocumento'];
		imagemDocumento = jsonDados['imagemDocumento'];
		primeiroVencimento = jsonDados['primeiroVencimento'] != null ? DateTime.tryParse(jsonDados['primeiroVencimento']) : null;
		intervaloEntreParcelas = jsonDados['intervaloEntreParcelas'];
		diaFixo = jsonDados['diaFixo'];
		finDocumentoOrigem = jsonDados['finDocumentoOrigem'] == null ? null : new FinDocumentoOrigem.fromJson(jsonDados['finDocumentoOrigem']);
		finNaturezaFinanceira = jsonDados['finNaturezaFinanceira'] == null ? null : new FinNaturezaFinanceira.fromJson(jsonDados['finNaturezaFinanceira']);
		fornecedor = jsonDados['fornecedor'] == null ? null : new Fornecedor.fromJson(jsonDados['fornecedor']);
		listaFinParcelaPagar = (jsonDados['listaFinParcelaPagar'] as Iterable)?.map((m) => FinParcelaPagar.fromJson(m))?.toList() ?? [];
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonDados = new Map<String, dynamic>();

		jsonDados['id'] = this.id ?? 0;
		jsonDados['idFinDocumentoOrigem'] = this.idFinDocumentoOrigem ?? 0;
		jsonDados['idFinNaturezaFinanceira'] = this.idFinNaturezaFinanceira ?? 0;
		jsonDados['idFornecedor'] = this.idFornecedor ?? 0;
		jsonDados['quantidadeParcela'] = this.quantidadeParcela ?? 0;
		jsonDados['valorTotal'] = this.valorTotal;
		jsonDados['valorAPagar'] = this.valorAPagar;
		jsonDados['dataLancamento'] = this.dataLancamento != null ? DateFormat('yyyy-MM-ddT00:00:00').format(this.dataLancamento) : null;
		jsonDados['numeroDocumento'] = this.numeroDocumento;
		jsonDados['imagemDocumento'] = this.imagemDocumento;
		jsonDados['primeiroVencimento'] = this.primeiroVencimento != null ? DateFormat('yyyy-MM-ddT00:00:00').format(this.primeiroVencimento) : null;
		jsonDados['intervaloEntreParcelas'] = this.intervaloEntreParcelas ?? 0;
		jsonDados['diaFixo'] = this.diaFixo;
		jsonDados['finDocumentoOrigem'] = this.finDocumentoOrigem == null ? null : this.finDocumentoOrigem.toJson;
		jsonDados['finNaturezaFinanceira'] = this.finNaturezaFinanceira == null ? null : this.finNaturezaFinanceira.toJson;
		jsonDados['fornecedor'] = this.fornecedor == null ? null : this.fornecedor.toJson;
		

		var listaFinParcelaPagarLocal = [];
		for (FinParcelaPagar objeto in this.listaFinParcelaPagar ?? []) {
			listaFinParcelaPagarLocal.add(objeto.toJson);
		}
		jsonDados['listaFinParcelaPagar'] = listaFinParcelaPagarLocal;
	
		return jsonDados;
	}
	

	String objetoEncodeJson(FinLancamentoPagar objeto) {
	  final jsonDados = objeto.toJson;
	  return json.encode(jsonDados);
	}
	
}