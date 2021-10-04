/*
Title: T2Ti ERP Fenix                                                                
Description: Model relacionado à tabela [FIN_CONFIGURACAO_BOLETO] 
                                                                                
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

import 'package:fenix/src/model/model.dart';

class FinConfiguracaoBoleto {
	int id;
	int idBancoContaCaixa;
	String instrucao01;
	String instrucao02;
	String caminhoArquivoRemessa;
	String caminhoArquivoRetorno;
	String caminhoArquivoLogotipo;
	String caminhoArquivoPdf;
	String mensagem;
	String localPagamento;
	String layoutRemessa;
	String aceite;
	String especie;
	String carteira;
	String codigoConvenio;
	String codigoCedente;
	double taxaMulta;
	double taxaJuro;
	int diasProtesto;
	String nossoNumeroAnterior;
	BancoContaCaixa bancoContaCaixa;

	FinConfiguracaoBoleto({
			this.id,
			this.idBancoContaCaixa,
			this.instrucao01,
			this.instrucao02,
			this.caminhoArquivoRemessa,
			this.caminhoArquivoRetorno,
			this.caminhoArquivoLogotipo,
			this.caminhoArquivoPdf,
			this.mensagem,
			this.localPagamento,
			this.layoutRemessa,
			this.aceite,
			this.especie,
			this.carteira,
			this.codigoConvenio,
			this.codigoCedente,
			this.taxaMulta,
			this.taxaJuro,
			this.diasProtesto,
			this.nossoNumeroAnterior,
			this.bancoContaCaixa,
		});

	static List<String> campos = <String>[
		'ID', 
		'INSTRUCAO01', 
		'INSTRUCAO02', 
		'CAMINHO_ARQUIVO_REMESSA', 
		'CAMINHO_ARQUIVO_RETORNO', 
		'CAMINHO_ARQUIVO_LOGOTIPO', 
		'CAMINHO_ARQUIVO_PDF', 
		'MENSAGEM', 
		'LOCAL_PAGAMENTO', 
		'LAYOUT_REMESSA', 
		'ACEITE', 
		'ESPECIE', 
		'CARTEIRA', 
		'CODIGO_CONVENIO', 
		'CODIGO_CEDENTE', 
		'TAXA_MULTA', 
		'TAXA_JURO', 
		'DIAS_PROTESTO', 
		'NOSSO_NUMERO_ANTERIOR', 
	];
	
	static List<String> colunas = <String>[
		'Id', 
		'Instrução 01', 
		'Instrução 02', 
		'Caminho Arquivo Remessa', 
		'Caminho Arquivo Retorno', 
		'Caminho Arquivo Logotipo', 
		'Caminho Arquivo PDF', 
		'Mensagem', 
		'Local Pagamento', 
		'Layout Remessa', 
		'Aceite', 
		'Espécie', 
		'Carteira', 
		'Código Convênio', 
		'Código Cedente', 
		'Taxa Multa', 
		'Taxa Juros', 
		'Dias Protesto', 
		'Nosso Número Anterior', 
	];

	FinConfiguracaoBoleto.fromJson(Map<String, dynamic> jsonDados) {
		id = jsonDados['id'];
		idBancoContaCaixa = jsonDados['idBancoContaCaixa'];
		instrucao01 = jsonDados['instrucao01'];
		instrucao02 = jsonDados['instrucao02'];
		caminhoArquivoRemessa = jsonDados['caminhoArquivoRemessa'];
		caminhoArquivoRetorno = jsonDados['caminhoArquivoRetorno'];
		caminhoArquivoLogotipo = jsonDados['caminhoArquivoLogotipo'];
		caminhoArquivoPdf = jsonDados['caminhoArquivoPdf'];
		mensagem = jsonDados['mensagem'];
		localPagamento = jsonDados['localPagamento'];
		layoutRemessa = getLayoutRemessa(jsonDados['layoutRemessa']);
		aceite = getAceite(jsonDados['aceite']);
		especie = getEspecie(jsonDados['especie']);
		carteira = jsonDados['carteira'];
		codigoConvenio = jsonDados['codigoConvenio'];
		codigoCedente = jsonDados['codigoCedente'];
		taxaMulta = jsonDados['taxaMulta'] != null ? jsonDados['taxaMulta'].toDouble() : null;
		taxaJuro = jsonDados['taxaJuro'] != null ? jsonDados['taxaJuro'].toDouble() : null;
		diasProtesto = jsonDados['diasProtesto'];
		nossoNumeroAnterior = jsonDados['nossoNumeroAnterior'];
		bancoContaCaixa = jsonDados['bancoContaCaixa'] == null ? null : new BancoContaCaixa.fromJson(jsonDados['bancoContaCaixa']);
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonDados = new Map<String, dynamic>();

		jsonDados['id'] = this.id ?? 0;
		jsonDados['idBancoContaCaixa'] = this.idBancoContaCaixa ?? 0;
		jsonDados['instrucao01'] = this.instrucao01;
		jsonDados['instrucao02'] = this.instrucao02;
		jsonDados['caminhoArquivoRemessa'] = this.caminhoArquivoRemessa;
		jsonDados['caminhoArquivoRetorno'] = this.caminhoArquivoRetorno;
		jsonDados['caminhoArquivoLogotipo'] = this.caminhoArquivoLogotipo;
		jsonDados['caminhoArquivoPdf'] = this.caminhoArquivoPdf;
		jsonDados['mensagem'] = this.mensagem;
		jsonDados['localPagamento'] = this.localPagamento;
		jsonDados['layoutRemessa'] = setLayoutRemessa(this.layoutRemessa);
		jsonDados['aceite'] = setAceite(this.aceite);
		jsonDados['especie'] = setEspecie(this.especie);
		jsonDados['carteira'] = this.carteira;
		jsonDados['codigoConvenio'] = this.codigoConvenio;
		jsonDados['codigoCedente'] = this.codigoCedente;
		jsonDados['taxaMulta'] = this.taxaMulta;
		jsonDados['taxaJuro'] = this.taxaJuro;
		jsonDados['diasProtesto'] = this.diasProtesto ?? 0;
		jsonDados['nossoNumeroAnterior'] = this.nossoNumeroAnterior;
		jsonDados['bancoContaCaixa'] = this.bancoContaCaixa == null ? null : this.bancoContaCaixa.toJson;
	
		return jsonDados;
	}
	
    getLayoutRemessa(String layoutRemessa) {
    	switch (layoutRemessa) {
    		case '0':
    			return 'CNAB 240';
    			break;
    		case '1':
    			return 'CNAB 400';
    			break;
    		default:
    			return null;
    		}
    	}

    setLayoutRemessa(String layoutRemessa) {
    	switch (layoutRemessa) {
    		case 'CNAB 240':
    			return '0';
    			break;
    		case 'CNAB 400':
    			return '1';
    			break;
    		default:
    			return null;
    		}
    	}

    getAceite(String aceite) {
    	switch (aceite) {
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

    setAceite(String aceite) {
    	switch (aceite) {
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

    getEspecie(String especie) {
    	switch (especie) {
    		case '0':
    			return 'DM-Duplicata Mercantil';
    			break;
    		case '1':
    			return 'DS-Duplicata de Serviços';
    			break;
    		case '2':
    			return 'RC-Recibo';
    			break;
    		case '3':
    			return 'NP-Nota Promissória';
    			break;
    		default:
    			return null;
    		}
    	}

    setEspecie(String especie) {
    	switch (especie) {
    		case 'DM-Duplicata Mercantil':
    			return '0';
    			break;
    		case 'DS-Duplicata de Serviços':
    			return '1';
    			break;
    		case 'RC-Recibo':
    			return '2';
    			break;
    		case 'NP-Nota Promissória':
    			return '3';
    			break;
    		default:
    			return null;
    		}
    	}


	String objetoEncodeJson(FinConfiguracaoBoleto objeto) {
	  final jsonDados = objeto.toJson;
	  return json.encode(jsonDados);
	}
	
}