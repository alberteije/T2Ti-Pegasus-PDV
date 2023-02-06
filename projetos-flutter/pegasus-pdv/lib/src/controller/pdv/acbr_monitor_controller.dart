// ignore_for_file: prefer_interpolation_to_compose_strings

/*
Title: T2Ti ERP 3.0
Description: Controller utilizado para se comunicar diretamente com o ACBrMonitor na máquina local 
                                                                                
The MIT License                                                                 
                                                                                
Copyright: Copyright (C) 2022 T2Ti.COM                                          
                                                                                
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
import 'dart:async';
import 'dart:io';
import 'package:drift/drift.dart';
import 'package:pegasus_pdv/src/controller/controller.dart';
import 'package:pegasus_pdv/src/infra/infra.dart';
import 'package:ini/ini.dart';

class ACBrMonitorController {

  static final _caminhoComCnpj = "C:\\ACBrMonitor\\" + Sessao.empresa!.cnpj! + "\\";
  // static final _caminhoEnviados = _caminhoComCnpj + "Arqs\\SAT\\Enviados\\";
  // static final _caminhoCancelamentos = _caminhoComCnpj + "Arqs\\SAT\\Cancelamentos\\";
  static final _caminhoVendas = _caminhoComCnpj + "Arqs\\SAT\\Vendas\\";
  static final _caminhoExtratoPdf = _caminhoComCnpj + "Arqs\\SAT\\PDF\\extrato-sat.pdf";
  static final _caminhoExtratoCancelado = _caminhoComCnpj + "Arqs\\SAT\\PDF\\extrato-sat-cancelado.pdf";

	static Future<Uint8List> emitirCfe() async {
		// salva o arquivo INI em disco
		final caminhoArquivoIniCfe = _caminhoComCnpj + "ini\\sat\\sat.ini";
    final arquivoIni = File(caminhoArquivoIniCfe);
    arquivoIni.writeAsStringSync(Sessao.ultimoIniCfeEnviado);

		// inicializar sat
		await inicializarSat();

		// chama o método para criar e enviar o cupom
		await criarEnviarCfe(caminhoArquivoIniCfe);

		// pega o caminho do XML criado
		final caminhoArquivoXml = await pegarRetornoSaida("ARQUIVO-XML");

		// chama o método para gerar o PDF
		await gerarPdfCupom(caminhoArquivoXml);

    // carrega o arquivo PDF    
    final retorno = File(_caminhoExtratoPdf).readAsBytesSync();

    // atualizar os dados do sat com base no XML de retorno
    await SatController.atualizarDadosCfe(caminhoArquivoXml: caminhoArquivoXml); 

		// desinicializar sat
		await desinicializarSat();

		return retorno;
  }

	static Future<Uint8List> cancelarCfe(String chaveAcesso) async {
		// inicializar sat
		await inicializarSat();

		// chama o método para criar e enviar o cupom
		await cancelarCupom(chaveAcesso);

		// pega o caminho do XML criado
		final caminhoArquivoXml = await pegarRetornoSaida("CANCELAMENTO");

		// chama o método para gerar o PDF
		await gerarPdfCancelamento(chaveAcesso, caminhoArquivoXml);

    // carrega o arquivo PDF    
    final retorno = File(_caminhoExtratoCancelado).readAsBytesSync();

		// desinicializar sat
		await desinicializarSat();

		return retorno;
  }

  static Future<void> inicializarSat() async {
		await apagarArquivoSaida();
		await gerarArquivoEntrada("SAT.Inicializar"); 
		await aguardarArquivoSaida();
  }

  static Future<void> desinicializarSat() async {
		await apagarArquivoSaida();
		await gerarArquivoEntrada("SAT.Desinicializar"); 
		await aguardarArquivoSaida();
  }

  static Future<void> criarEnviarCfe(String caminhoArquivoIniCfe) async {
		await apagarArquivoSaida();
		await gerarArquivoEntrada("SAT.CriarEnviarCFe(" + caminhoArquivoIniCfe + ")"); 
		await aguardarArquivoSaida();
  }

  static Future<void> cancelarCupom(String chaveAcesso) async {
		await apagarArquivoSaida();
		await gerarArquivoEntrada("SAT.CancelarCFe(" + _caminhoVendas + chaveAcesso + ".xml)");
		await aguardarArquivoSaida();		
  }

	static Future<void> gerarPdfCupom(String caminhoArquivoXml) async {
		await apagarArquivoSaida();
		await gerarArquivoEntrada('SAT.GerarPDFExtratoVenda("' + caminhoArquivoXml + '", "' + _caminhoExtratoPdf + '")'); 
		await aguardarArquivoSaida();
	}

	static Future<void> gerarPdfCancelamento(String chaveAcesso, String caminhoArquivoXml) async {
		await apagarArquivoSaida();
		await gerarArquivoEntrada('SAT.GerarPDFExtratoCancelamento(' + _caminhoVendas + chaveAcesso + '.xml, ' + caminhoArquivoXml + ', ' + _caminhoExtratoCancelado + ')'); 
		await aguardarArquivoSaida();
	}

	static Future<void> gerarArquivoEntrada(String comando) async {
		final nomeArquivo = _caminhoComCnpj + "ent.txt";
    final arquivo = File(nomeArquivo);
    arquivo.writeAsStringSync(comando);
	}

	static Future<String> pegarRetornoSaida(String operacao) async {
		var retorno = "";

		final nomeArquivo = _caminhoComCnpj + "sai.txt";

    // File arquivoSaida = File(nomeArquivo);
    final arquivoCompleto = File(nomeArquivo).readAsLinesSync();
    if (arquivoCompleto[0] == "OK: ") { // remove a primeira linha do arquivo
      arquivoCompleto.removeAt(0);
    }
    final configIni = Config.fromStrings(arquivoCompleto);

    var codigoRetorno = configIni.get("ENVIO", "CodigoDeRetorno") ?? "";
    var retornoString = configIni.get("ENVIO", "RetornoStr") ?? "";

		var caminhoArquivoXml = "";

    if (operacao == "ARQUIVO-XML") {
        caminhoArquivoXml = configIni.get("ENVIO", "Arquivo") ?? "";
        return caminhoArquivoXml.trim();
    } else if (operacao == "CANCELAMENTO") {
        caminhoArquivoXml = configIni.get("CANCELAMENTO", "Arquivo") ?? "";
        return caminhoArquivoXml.trim();
    }
        
    const listaRetorno = ["", "6000" , "7000"]; // se o status não for um dos que estiverem nessa lista, vamos retornar um erro.
    if (!listaRetorno.contains(codigoRetorno)) { 
        return "[ERRO] - [" + codigoRetorno + "] " + retornoString;
    }

		return retorno;
	}

	static Future<void> apagarArquivoSaida() async {
		final nomeArquivo = _caminhoComCnpj + "sai.txt";
    final arquivo = File(nomeArquivo);
    if (arquivo.existsSync()) {
      arquivo.deleteSync();
    }
	}

	static Future<bool> aguardarArquivoSaida() async {
		final nomeArquivo = _caminhoComCnpj + "sai.txt";
    final arquivo = File(nomeArquivo);
    var tempoEspera = 0;
    while (!arquivo.existsSync()) { 
      await Future.delayed(const Duration(seconds: 1));
			tempoEspera++;
			if (tempoEspera > 30) {
				return false;
			}
    }
    return true;
	}

}