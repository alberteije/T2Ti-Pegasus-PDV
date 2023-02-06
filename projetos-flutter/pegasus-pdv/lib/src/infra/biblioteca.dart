// ignore_for_file: prefer_interpolation_to_compose_strings

/*
Title: T2Ti ERP 3.0                                                                
Description: Classe que armazena alguns métodos úteis para as classes da aplicação.
                                                                                
The MIT License                                                                 
                                                                                
Copyright: Copyright (C) 2021 T2Ti.COM                                          
                                                                                
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
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:intl/intl.dart';

import 'constantes.dart';

class Biblioteca {
  /// singleton
  factory Biblioteca() {
    _this ??= Biblioteca._();
    return _this!;
  }
  static Biblioteca? _this;
  Biblioteca._() : super();


  /// remove a máscara de uma string
  /// útil para campos do tipo: CPF, CNPJ, CEP, etc
  static String? removerMascara(dynamic value) {
    if (value != null) {
      return value.replaceAll(RegExp(r'[^\w\s]+'), '');
    } else {
      return null;
    }
  }

  /// calcula valor de juros
  static double calcularJuros(double? valor, double? taxaJuros, DateTime? dataVencimento) {
    if (dataVencimento == null) {
      return 0;
    }
    valor ??= 0;
    taxaJuros ??= 0;
    double valorJuros = (valor * (taxaJuros / 30) / 100) * (DateTime.now().difference(dataVencimento).inDays);
    valorJuros = num.parse(valorJuros.toStringAsFixed(Constantes.decimaisValor)) as double;
    return valorJuros;
  }

  /// calcula valor de multa
  static double calcularMulta(double? valor, double? taxaMulta) {
    valor ??= 0;
    taxaMulta ??= 0;
    double valorMulta = (valor * (taxaMulta / 100));
    valorMulta = num.parse(valorMulta.toStringAsFixed(Constantes.decimaisValor)) as double;
    return valorMulta;
  }

  /// calcula valor de desconto
  static double calcularDesconto(double? valor, double? taxaDesconto) {
    valor ??= 0;
    taxaDesconto ??= 0;
    double valorDesconto = (valor * (taxaDesconto / 100));
    valorDesconto = num.parse(valorDesconto.toStringAsFixed(Constantes.decimaisValor)) as double;
    return valorDesconto;
  }

  /// calcula valor da comissão
  static double calcularComissao(double? valor, double? taxaComissao) {
    valor ??= 0;
    taxaComissao ??= 0;
    double valorComissao = (valor * (taxaComissao / 100));
    valorComissao = num.parse(valorComissao.toStringAsFixed(Constantes.decimaisValor)) as double;
    return valorComissao;
  }

  /// calcula a multiplicacao entre dois números e retorna o valor com as devidas casas decimais
  static double multiplicarMonetario(double? valor1, double? valor2) {
    valor1 ??= 0;
    valor2 ??= 0;

    double resultado = num.parse((valor1 * valor2).toStringAsFixed(Constantes.decimaisValor)) as double;
    return resultado;
  }

  /// calcula a divisão entre dois números e retorna o valor com as devidas casas decimais
  static double dividirMonetario(dynamic valor1, dynamic valor2) {
    valor1 ??= 0;
    valor2 ??= 0;

    double resultado = num.parse((valor1 / valor2).toStringAsFixed(Constantes.decimaisValor)) as double;
    return resultado;
  }

  /// pega um período anterior com a máscara MM/AAAA
  static String periodoAnterior(String mesAno) {
    int? mes = int.tryParse(mesAno.substring(0, 2));
    int? ano = int.tryParse(mesAno.substring(3, 7));

    if (mes == 1) {
      mes = 12;
      ano = ano! - 1;
      return mes.toString() + '/' + ano.toString();
    } else {
      mes = mes! - 1;
      return mes.toString().padLeft(2, '0') + '/' + ano.toString();
    }
  }

  static String formatarCampoLookup(String conteudoCampo, {required bool formatoTimeStamp}) {
    var retorno = conteudoCampo;
    if (retorno == 'null') {
      retorno = '';
    }

    // tenta parssar o campo para inteiro
    int? inteiro = int.tryParse(conteudoCampo);

    // se estivermos trabalhando com o Moor, a data será colocada num formato timestamp
    if (formatoTimeStamp && inteiro != null) {
      retorno = formatarData(DateTime.fromMillisecondsSinceEpoch(inteiro));
    } else {
      // se for inteiro, não faz nada, o valor é o mesmo que veio
      // se inteiro é nulo, temos que verificar se é data ou double
      if (inteiro == null) {
          // trata o double
          double? valor = double.tryParse(conteudoCampo);
          if (valor != null) {
            retorno = Constantes.formatoDecimalValor.format(valor);
          } else {
            // tratando tipos data
            DateTime? data = DateTime.tryParse(conteudoCampo);
            if (data != null) {
              retorno = DateFormat('dd/MM/yyyy').format(data);
            }
          }      
      }
    }
    return retorno;
  }

  static String formatarHora(DateTime hora) {
    var formatter = DateFormat('Hms');
    String horaFormatada = formatter.format(hora);
    return horaFormatada;
  }

  static String formatarData(DateTime? data) {
    if (data == null) {
      return '';
    } else {
      var formatter = DateFormat('dd/MM/yyyy');
      String dataFormatada = formatter.format(data);
      return dataFormatada;
    }
  }

  static String formatarDataHora(DateTime? data) {
    if (data == null) {
      return '';
    } else {    
      var formatter = DateFormat('dd/MM/yyyy HH:mm:ss');
      String dataHoraFormatada = formatter.format(data);
      return dataHoraFormatada;
    }
  }

  static String formatarDataAAAAMM(DateTime? data) {
    if (data == null) {
      return '';
    } else {    
      var formatter = DateFormat('yyyyMM');
      String dataHoraFormatada = formatter.format(data);
      return dataHoraFormatada;
    }
  }

  static String formatarDataAAMM(DateTime? data) {
    if (data == null) {
      return '';
    } else {    
      var formatter = DateFormat('yyMM');
      String dataHoraFormatada = formatter.format(data);
      return dataHoraFormatada;
    }
  }

  static String formatarMes(DateTime data) {
    var formatter = DateFormat('MM');
    String mesFormatado = formatter.format(data);
    return mesFormatado;
  }

  static String formatarMesAno(DateTime data) {
    var formatter = DateFormat('MM/yyyy');
    String mesFormatado = formatter.format(data);
    return mesFormatado;
  }
  static String formatarValorDecimal(double? valor) {
    return Constantes.formatoDecimalValor.format(valor ?? 0);
  }

  static DateTime converteDataInicioParaFiltro(DateTime data) {
    return DateTime(data.year, data.month, data.day, 0, 0, 0, 0, 0); // zera o tempo
  }

  static DateTime converteDataFimParaFiltro(DateTime data) {
    return DateTime(data.year, data.month, data.day, 23, 59, 59, 0, 0); // adiciona o tempo
  }

  static DateTime? removerTempoDaData(DateTime? data) {
    if (data != null) {
      return DateTime(data.year, data.month, data.day, 0, 0, 0, 0, 0); // zera o tempo
    } else {
      return data;
    }
  }

  static DateTime? tratarDataJson(dynamic data) {
    if (data != null) {
      if (data is int) {
        return DateTime.fromMicrosecondsSinceEpoch(data * 1000);
      } else {
        return DateTime.tryParse(data.toString().substring(0, 10));
      }
    } else {
      return null;
    }
  }

  /// define o que é a tela pequena e se o dispositivo utilizado tem a tela pequena
  static bool? isTelaPequena(BuildContext context) {
	  return bootStrapValueBasedOnSize(
      sizes: {
        "xl": false,
        "lg": false,
        "md": false,
        "sm": false,
        "": true,
      },
      context: context,  
    );  
  }

  /// define se a plataforma é desktop
  static bool isDesktop() {
    if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
      return true;
    } else {
      return false;
    }
  }

  /// define se a plataforma é mobile
  static bool isMobile() {
    if (Platform.isAndroid || Platform.isIOS) {
      return true;
    } else {
      return false;
    }
  }

  /// define a distância entre as colunas caso haja uma quebra de linha
	static EdgeInsets? distanciaEntreColunasQuebraLinha(BuildContext context) { 
    return bootStrapValueBasedOnSize(
      sizes: {
        "xl": EdgeInsets.zero,
        "lg": EdgeInsets.zero,
        "md": EdgeInsets.zero,
        "sm": EdgeInsets.zero,
        "": const EdgeInsets.only(top: 5.0, bottom: 10.0),
      },
      context: context,
    );
  }

  static Future<bool> hasNetwork() async {
    try {
      final result = await InternetAddress.lookup('t2ti.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      return false;
    }
  }

///
/// Retorna o(s) numDig Dígitos de Controle Módulo 11 do
/// dado, limitando o Valor de Multiplicação em limiteMultiplicacao,
/// multiplicando a soma por 10, se indicado:
///
///    Números Comuns:   numDig:   limiteMultiplicacao:   x10:
///      CPF                2         12      true
///      CNPJ               2          9      true
///      PIS,C/C,Age        1          9      true
///      RG SSP-SP          1          9      false
/// 
/// [valor] String dado contendo o número (sem o DV)
/// [quantidadeDigitos] Número de dígitos a calcular
/// [limiteMultiplicacao] Limite de multiplicação 
/// [x10] Se true multiplica soma por 10
///
/// Baseado em: https://www.cjdinfo.com.br/solucao-javascript-calculo-digito-modulo-11

  static String calcularModulo11(String valor, int quantidadeDigitos, int limiteMultiplicacao, bool x10){  
    dynamic mult = 0;
    dynamic soma = 0;
    dynamic dig = 0;
      
    if(!x10) quantidadeDigitos = 1;
    for(var n = 1; n <= quantidadeDigitos; n++){
      soma = 0;
      mult = 2;
      for(var i = valor.length - 1; i>=0; i--){
        soma += (mult * int.tryParse(valor[i]));
        if(++mult > limiteMultiplicacao) mult = 2;
      }
      if(x10){
        dig = ((soma * 10) % 11) % 10;
      } else {
        dig = soma % 11;
        if(dig == 10) dig = "X";
      }
      valor = valor + dig.toString();
    }
    return valor.substring(valor.length-quantidadeDigitos, valor.length);
  }

  static String cifrar(String valor) {
    if (Constantes.linguagemServidor == "c") {
      return "\"" + Constantes.encrypter.encrypt(valor, iv: Constantes.iv).base64 + "\"";
    } else {
      return Constantes.encrypter.encrypt(valor, iv: Constantes.iv).base64;
    }
  }

  static String decifrar(String valor) {
    if (valor.substring(0, 1) == "\"") {
      valor = valor.substring(1, valor.length - 1);  
    }
    return Constantes.encrypter.decrypt64(valor, iv: Constantes.iv);
  }

  static int retornarCodigoIbgeUf(String? uf) {
    int codigoUf = 0;
    switch (uf) {
      case 'AC' :
        codigoUf = 12;
        break;
      case 'AL' :
        codigoUf = 27;
        break;
      case 'AP' :
        codigoUf = 16;
        break;
      case 'AM' :
        codigoUf = 13;
        break;
      case 'BA' :
        codigoUf = 29;
        break;
      case 'CE' :
        codigoUf = 23;
        break;
      case 'DF' :
        codigoUf = 53;
        break;
      case 'ES' :
        codigoUf = 32;
        break;
      case 'GO' :
        codigoUf = 52;
        break;
      case 'MA' :
        codigoUf = 21;
        break;
      case 'MT' :
        codigoUf = 51;
        break;
      case 'MS' :
        codigoUf = 50;
        break;
      case 'MG' :
        codigoUf = 31;
        break;
      case 'PA' :
        codigoUf = 15;
        break;
      case 'PB' :
        codigoUf = 25;
        break;
      case 'PR' :
        codigoUf = 41;
        break;
      case 'PE' :
        codigoUf = 26;
        break;
      case 'PI' :
        codigoUf = 22;
        break;
      case 'RJ' :
        codigoUf = 33;
        break;
      case 'RN' :
        codigoUf = 24;
        break;
      case 'RS' :
        codigoUf = 43;
        break;
      case 'RO' :
        codigoUf = 11;
        break;
      case 'RR' :
        codigoUf = 14;
        break;
      case 'SC' :
        codigoUf = 42;
        break;
      case 'SP' :
        codigoUf = 35;
        break;
      case 'SE' :
        codigoUf = 28;
        break;
      case 'TO' :       
        codigoUf = 17;
        break;
      default:
    }
    return codigoUf;
  }


}