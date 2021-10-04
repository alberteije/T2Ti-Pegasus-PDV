/*
Title: T2Ti ERP Fenix                                                                
Description: Model relacionado à tabela [FIN_LANCAMENTO_RECEBER] 
                                                                                
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

class FinLancamentoReceber {
	int id;
	int idFinDocumentoOrigem;
	int idFinNaturezaFinanceira;
	int idCliente;
	int quantidadeParcela;
	double valorTotal;
	double valorAReceber;
	DateTime dataLancamento;
	String numeroDocumento;
	DateTime primeiroVencimento;
	double taxaComissao;
	double valorComissao;
	int intervaloEntreParcelas;
	String diaFixo;
	FinDocumentoOrigem finDocumentoOrigem;
	FinNaturezaFinanceira finNaturezaFinanceira;
	Cliente cliente;
	List<FinParcelaReceber> listaFinParcelaReceber = [];

	FinLancamentoReceber({
			this.id,
			this.idFinDocumentoOrigem,
			this.idFinNaturezaFinanceira,
			this.idCliente,
			this.quantidadeParcela,
			this.valorTotal,
			this.valorAReceber,
			this.dataLancamento,
			this.numeroDocumento,
			this.primeiroVencimento,
			this.taxaComissao,
			this.valorComissao,
			this.intervaloEntreParcelas,
			this.diaFixo,
			this.finDocumentoOrigem,
			this.finNaturezaFinanceira,
			this.cliente,
			this.listaFinParcelaReceber,
		});

	static List<String> campos = <String>[
		'ID', 
		'QUANTIDADE_PARCELA', 
		'VALOR_TOTAL', 
		'VALOR_A_RECEBER', 
		'DATA_LANCAMENTO', 
		'NUMERO_DOCUMENTO', 
		'PRIMEIRO_VENCIMENTO', 
		'TAXA_COMISSAO', 
		'VALOR_COMISSAO', 
		'INTERVALO_ENTRE_PARCELAS', 
		'DIA_FIXO', 
	];
	
	static List<String> colunas = <String>[
		'Id', 
		'Quantidade de Parcelas', 
		'Valor Total', 
		'Valor a Receber', 
		'Data de Lançamento', 
		'Número do Documento', 
		'Data do Primeiro Vencimento', 
		'Taxa de Comissão', 
		'Valor Comissão', 
		'Intervalo Entre Parcelas', 
		'Dia Fixo', 
	];

	FinLancamentoReceber.fromJson(Map<String, dynamic> jsonDados) {
		id = jsonDados['id'];
		idFinDocumentoOrigem = jsonDados['idFinDocumentoOrigem'];
		idFinNaturezaFinanceira = jsonDados['idFinNaturezaFinanceira'];
		idCliente = jsonDados['idCliente'];
		quantidadeParcela = jsonDados['quantidadeParcela'];
		valorTotal = jsonDados['valorTotal'] != null ? jsonDados['valorTotal'].toDouble() : null;
		valorAReceber = jsonDados['valorAReceber'] != null ? jsonDados['valorAReceber'].toDouble() : null;
		dataLancamento = jsonDados['dataLancamento'] != null ? DateTime.tryParse(jsonDados['dataLancamento']) : null;
		numeroDocumento = jsonDados['numeroDocumento'];
		primeiroVencimento = jsonDados['primeiroVencimento'] != null ? DateTime.tryParse(jsonDados['primeiroVencimento']) : null;
		taxaComissao = jsonDados['taxaComissao'] != null ? jsonDados['taxaComissao'].toDouble() : null;
		valorComissao = jsonDados['valorComissao'] != null ? jsonDados['valorComissao'].toDouble() : null;
		intervaloEntreParcelas = jsonDados['intervaloEntreParcelas'];
		diaFixo = jsonDados['diaFixo'];
		finDocumentoOrigem = jsonDados['finDocumentoOrigem'] == null ? null : new FinDocumentoOrigem.fromJson(jsonDados['finDocumentoOrigem']);
		finNaturezaFinanceira = jsonDados['finNaturezaFinanceira'] == null ? null : new FinNaturezaFinanceira.fromJson(jsonDados['finNaturezaFinanceira']);
		cliente = jsonDados['cliente'] == null ? null : new Cliente.fromJson(jsonDados['cliente']);
		listaFinParcelaReceber = (jsonDados['listaFinParcelaReceber'] as Iterable)?.map((m) => FinParcelaReceber.fromJson(m))?.toList() ?? [];
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonDados = new Map<String, dynamic>();

		jsonDados['id'] = this.id ?? 0;
		jsonDados['idFinDocumentoOrigem'] = this.idFinDocumentoOrigem ?? 0;
		jsonDados['idFinNaturezaFinanceira'] = this.idFinNaturezaFinanceira ?? 0;
		jsonDados['idCliente'] = this.idCliente ?? 0;
		jsonDados['quantidadeParcela'] = this.quantidadeParcela ?? 0;
		jsonDados['valorTotal'] = this.valorTotal;
		jsonDados['valorAReceber'] = this.valorAReceber;
		jsonDados['dataLancamento'] = this.dataLancamento != null ? DateFormat('yyyy-MM-ddT00:00:00').format(this.dataLancamento) : null;
		jsonDados['numeroDocumento'] = this.numeroDocumento;
		jsonDados['primeiroVencimento'] = this.primeiroVencimento != null ? DateFormat('yyyy-MM-ddT00:00:00').format(this.primeiroVencimento) : null;
		jsonDados['taxaComissao'] = this.taxaComissao;
		jsonDados['valorComissao'] = this.valorComissao;
		jsonDados['intervaloEntreParcelas'] = this.intervaloEntreParcelas ?? 0;
		jsonDados['diaFixo'] = this.diaFixo;
		jsonDados['finDocumentoOrigem'] = this.finDocumentoOrigem == null ? null : this.finDocumentoOrigem.toJson;
		jsonDados['finNaturezaFinanceira'] = this.finNaturezaFinanceira == null ? null : this.finNaturezaFinanceira.toJson;
		jsonDados['cliente'] = this.cliente == null ? null : this.cliente.toJson;
		

		var listaFinParcelaReceberLocal = [];
		for (FinParcelaReceber objeto in this.listaFinParcelaReceber ?? []) {
			listaFinParcelaReceberLocal.add(objeto.toJson);
		}
		jsonDados['listaFinParcelaReceber'] = listaFinParcelaReceberLocal;
	
		return jsonDados;
	}
	

	String objetoEncodeJson(FinLancamentoReceber objeto) {
	  final jsonDados = objeto.toJson;
	  return json.encode(jsonDados);
	}
	
}