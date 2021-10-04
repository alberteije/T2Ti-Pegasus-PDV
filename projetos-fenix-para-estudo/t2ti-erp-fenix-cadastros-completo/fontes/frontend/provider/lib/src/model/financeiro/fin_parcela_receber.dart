/*
Title: T2Ti ERP Fenix                                                                
Description: Model relacionado à tabela [FIN_PARCELA_RECEBER] 
                                                                                
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

class FinParcelaReceber {
	int id;
	int idFinLancamentoReceber;
	int idFinStatusParcela;
	int idFinTipoRecebimento;
	int idBancoContaCaixa;
	int idFinChequeRecebido;
	int numeroParcela;
	DateTime dataEmissao;
	DateTime dataVencimento;
	DateTime descontoAte;
	double valor;
	double taxaJuro;
	double taxaMulta;
	double taxaDesconto;
	double valorJuro;
	double valorMulta;
	double valorDesconto;
	String emitiuBoleto;
	String boletoNossoNumero;
	double valorRecebido;
	String historico;
	FinStatusParcela finStatusParcela;
	FinTipoRecebimento finTipoRecebimento;
	BancoContaCaixa bancoContaCaixa;
	FinChequeRecebido finChequeRecebido;

	FinParcelaReceber({
			this.id,
			this.idFinLancamentoReceber,
			this.idFinStatusParcela,
			this.idFinTipoRecebimento,
			this.idBancoContaCaixa,
			this.idFinChequeRecebido,
			this.numeroParcela,
			this.dataEmissao,
			this.dataVencimento,
			this.descontoAte,
			this.valor,
			this.taxaJuro,
			this.taxaMulta,
			this.taxaDesconto,
			this.valorJuro,
			this.valorMulta,
			this.valorDesconto,
			this.emitiuBoleto,
			this.boletoNossoNumero,
			this.valorRecebido,
			this.historico,
			this.finStatusParcela,
			this.finTipoRecebimento,
			this.bancoContaCaixa,
			this.finChequeRecebido,
		});

	static List<String> campos = <String>[
		'ID', 
		'NUMERO_PARCELA', 
		'DATA_EMISSAO', 
		'DATA_VENCIMENTO', 
		'DESCONTO_ATE', 
		'VALOR', 
		'TAXA_JURO', 
		'TAXA_MULTA', 
		'TAXA_DESCONTO', 
		'VALOR_JURO', 
		'VALOR_MULTA', 
		'VALOR_DESCONTO', 
		'EMITIU_BOLETO', 
		'BOLETO_NOSSO_NUMERO', 
		'VALOR_RECEBIDO', 
		'HISTORICO', 
	];
	
	static List<String> colunas = <String>[
		'Id', 
		'Número da Parcela', 
		'Data de Emissão', 
		'Data de Vencimento', 
		'Valor', 
		'Taxa Juros', 
		'Taxa Multa', 
		'Taxa Desconto', 
		'Valor Juros', 
		'Valor Multa', 
		'Valor Desconto', 
		'Emitiu Boleto', 
		'Boleto Nosso Número', 
		'Valor Recebido', 
		'Histórico', 
	];

	FinParcelaReceber.fromJson(Map<String, dynamic> jsonDados) {
		id = jsonDados['id'];
		idFinLancamentoReceber = jsonDados['idFinLancamentoReceber'];
		idFinStatusParcela = jsonDados['idFinStatusParcela'];
		idFinTipoRecebimento = jsonDados['idFinTipoRecebimento'];
		idBancoContaCaixa = jsonDados['idBancoContaCaixa'];
		idFinChequeRecebido = jsonDados['idFinChequeRecebido'];
		numeroParcela = jsonDados['numeroParcela'];
		dataEmissao = jsonDados['dataEmissao'] != null ? DateTime.tryParse(jsonDados['dataEmissao']) : null;
		dataVencimento = jsonDados['dataVencimento'] != null ? DateTime.tryParse(jsonDados['dataVencimento']) : null;
		descontoAte = jsonDados['descontoAte'] != null ? DateTime.tryParse(jsonDados['descontoAte']) : null;
		valor = jsonDados['valor'] != null ? jsonDados['valor'].toDouble() : null;
		taxaJuro = jsonDados['taxaJuro'] != null ? jsonDados['taxaJuro'].toDouble() : null;
		taxaMulta = jsonDados['taxaMulta'] != null ? jsonDados['taxaMulta'].toDouble() : null;
		taxaDesconto = jsonDados['taxaDesconto'] != null ? jsonDados['taxaDesconto'].toDouble() : null;
		valorJuro = jsonDados['valorJuro'] != null ? jsonDados['valorJuro'].toDouble() : null;
		valorMulta = jsonDados['valorMulta'] != null ? jsonDados['valorMulta'].toDouble() : null;
		valorDesconto = jsonDados['valorDesconto'] != null ? jsonDados['valorDesconto'].toDouble() : null;
		emitiuBoleto = getEmitiuBoleto(jsonDados['emitiuBoleto']);
		boletoNossoNumero = jsonDados['boletoNossoNumero'];
		valorRecebido = jsonDados['valorRecebido'] != null ? jsonDados['valorRecebido'].toDouble() : null;
		historico = jsonDados['historico'];
		finStatusParcela = jsonDados['finStatusParcela'] == null ? null : new FinStatusParcela.fromJson(jsonDados['finStatusParcela']);
		finTipoRecebimento = jsonDados['finTipoRecebimento'] == null ? null : new FinTipoRecebimento.fromJson(jsonDados['finTipoRecebimento']);
		bancoContaCaixa = jsonDados['bancoContaCaixa'] == null ? null : new BancoContaCaixa.fromJson(jsonDados['bancoContaCaixa']);
		finChequeRecebido = jsonDados['finChequeRecebido'] == null ? null : new FinChequeRecebido.fromJson(jsonDados['finChequeRecebido']);
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonDados = new Map<String, dynamic>();

		jsonDados['id'] = this.id ?? 0;
		jsonDados['idFinLancamentoReceber'] = this.idFinLancamentoReceber ?? 0;
		jsonDados['idFinStatusParcela'] = this.idFinStatusParcela ?? 0;
		jsonDados['idFinTipoRecebimento'] = this.idFinTipoRecebimento ?? 0;
		jsonDados['idBancoContaCaixa'] = this.idBancoContaCaixa ?? 0;
		jsonDados['idFinChequeRecebido'] = this.idFinChequeRecebido ?? 0;
		jsonDados['numeroParcela'] = this.numeroParcela ?? 0;
		jsonDados['dataEmissao'] = this.dataEmissao != null ? DateFormat('yyyy-MM-ddT00:00:00').format(this.dataEmissao) : null;
		jsonDados['dataVencimento'] = this.dataVencimento != null ? DateFormat('yyyy-MM-ddT00:00:00').format(this.dataVencimento) : null;
		jsonDados['descontoAte'] = this.descontoAte != null ? DateFormat('yyyy-MM-ddT00:00:00').format(this.descontoAte) : null;
		jsonDados['valor'] = this.valor;
		jsonDados['taxaJuro'] = this.taxaJuro;
		jsonDados['taxaMulta'] = this.taxaMulta;
		jsonDados['taxaDesconto'] = this.taxaDesconto;
		jsonDados['valorJuro'] = this.valorJuro;
		jsonDados['valorMulta'] = this.valorMulta;
		jsonDados['valorDesconto'] = this.valorDesconto;
		jsonDados['emitiuBoleto'] = setEmitiuBoleto(this.emitiuBoleto);
		jsonDados['boletoNossoNumero'] = this.boletoNossoNumero;
		jsonDados['valorRecebido'] = this.valorRecebido;
		jsonDados['historico'] = this.historico;
		jsonDados['finStatusParcela'] = this.finStatusParcela == null ? null : this.finStatusParcela.toJson;
		jsonDados['finTipoRecebimento'] = this.finTipoRecebimento == null ? null : this.finTipoRecebimento.toJson;
		jsonDados['bancoContaCaixa'] = this.bancoContaCaixa == null ? null : this.bancoContaCaixa.toJson;
		jsonDados['finChequeRecebido'] = this.finChequeRecebido == null ? null : this.finChequeRecebido.toJson;
	
		return jsonDados;
	}
	
    getEmitiuBoleto(String emitiuBoleto) {
    	switch (emitiuBoleto) {
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

    setEmitiuBoleto(String emitiuBoleto) {
    	switch (emitiuBoleto) {
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


	String objetoEncodeJson(FinParcelaReceber objeto) {
	  final jsonDados = objeto.toJson;
	  return json.encode(jsonDados);
	}
	
}