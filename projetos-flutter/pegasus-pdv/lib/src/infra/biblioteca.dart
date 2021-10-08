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
    return _this;
  }
  static Biblioteca _this;
  Biblioteca._() : super();


  /// remove a máscara de uma string
  /// útil para campos do tipo: CPF, CNPJ, CEP, etc
  static String removerMascara(dynamic value) {
    if (value != null) {
      return value.replaceAll(RegExp(r'[^\w\s]+'), '');
    } else {
      return null;
    }
  }

  /// calcula valor de juros
  static double calcularJuros(double valor, double taxaJuros, DateTime dataVencimento) {
    if (dataVencimento == null) {
      return 0;
    }
    if (valor == null) {
      valor = 0;
    }
    if (taxaJuros == null) {
      taxaJuros = 0;
    }
    double valorJuros = (valor * (taxaJuros / 30) / 100) * (DateTime.now().difference(dataVencimento).inDays);
    valorJuros = num.parse(valorJuros.toStringAsFixed(Constantes.decimaisValor));
    return valorJuros;
  }

  /// calcula valor de multa
  static double calcularMulta(double valor, double taxaMulta) {
    if (valor == null) {
      valor = 0;
    }
    if (taxaMulta == null) {
      taxaMulta = 0;
    }
    double valorMulta = (valor * (taxaMulta / 100));
    valorMulta = num.parse(valorMulta.toStringAsFixed(Constantes.decimaisValor));
    return valorMulta;
  }

  /// calcula valor de desconto
  static double calcularDesconto(double valor, double taxaDesconto) {
    if (valor == null) {
      valor = 0;
    }
    if (taxaDesconto == null) {
      taxaDesconto = 0;
    }
    double valorDesconto = (valor * (taxaDesconto / 100));
    valorDesconto = num.parse(valorDesconto.toStringAsFixed(Constantes.decimaisValor));
    return valorDesconto;
  }

  /// calcula valor da comissão
  static double calcularComissao(double valor, double taxaComissao) {
    if (valor == null) {
      valor = 0;
    }
    if (taxaComissao == null) {
      taxaComissao = 0;
    }
    double valorComissao = (valor * (taxaComissao / 100));
    valorComissao = num.parse(valorComissao.toStringAsFixed(Constantes.decimaisValor));
    return valorComissao;
  }

  /// calcula a multiplicacao entre dois números e retorna o valor com as devidas casas decimais
  static double multiplicarMonetario(double valor1, double valor2) {
    if (valor1 == null) {
      valor1 = 0;
    }
    if (valor2 == null) {
      valor2 = 0;
    }

    double resultado = num.parse((valor1 * valor2).toStringAsFixed(Constantes.decimaisValor));
    return resultado;
  }

  /// calcula a divisão entre dois números e retorna o valor com as devidas casas decimais
  static double dividirMonetario(dynamic valor1, dynamic valor2) {
    if (valor1 == null) {
      valor1 = 0;
    }
    if (valor2 == null) {
      valor2 = 0;
    }

    double resultado = num.parse((valor1 / valor2).toStringAsFixed(Constantes.decimaisValor));
    return resultado;
  }

  /// pega um período anterior com a máscara MM/AAAA
  static String periodoAnterior(String mesAno) {
    int mes = int.tryParse(mesAno.substring(0, 2));
    int ano = int.tryParse(mesAno.substring(3, 7));

    if (mes == 1) {
      mes = 12;
      ano = ano - 1;
      return mes.toString() + '/' + ano.toString();
    } else {
      mes = mes - 1;
      return mes.toString().padLeft(2, '0') + '/' + ano.toString();
    }
  }

  static String formatarCampoLookup(String conteudoCampo, {bool formatoTimeStamp}) {
    var retorno = conteudoCampo;
    if (retorno == 'null') {
      retorno = '';
    }

    // tenta parssar o campo para inteiro
    int inteiro = int.tryParse(conteudoCampo);

    // se estivermos trabalhando com o Moor, a data será colocada num formato timestamp
    if (formatoTimeStamp && inteiro != null) {
      retorno = formatarData(DateTime.fromMillisecondsSinceEpoch(inteiro));
    } else {
      // se for inteiro, não faz nada, o valor é o mesmo que veio
      // se inteiro é nulo, temos que verificar se é data ou double
      if (inteiro == null) {
          // trata o double
          double valor = double.tryParse(conteudoCampo);
          if (valor != null) {
            retorno = Constantes.formatoDecimalValor.format(valor);
          } else {
            // tratando tipos data
            DateTime data = DateTime.tryParse(conteudoCampo);
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

  static String formatarData(DateTime data) {
    if (data == null) {
      return '';
    } else {
      var formatter = DateFormat('dd/MM/yyyy');
      String dataFormatada = formatter.format(data);
      return dataFormatada;
    }
  }

  static String formatarDataHora(DateTime data) {
    if (data == null) {
      return '';
    } else {    
      var formatter = DateFormat('dd/MM/yyyy HH:mm:ss');
      String dataHoraFormatada = formatter.format(data);
      return dataHoraFormatada;
    }
  }

  static String formatarDataAAAAMM(DateTime data) {
    if (data == null) {
      return '';
    } else {    
      var formatter = DateFormat('yyyyMM');
      String dataHoraFormatada = formatter.format(data);
      return dataHoraFormatada;
    }
  }

  static String formatarMes(DateTime data) {
    var formatter = DateFormat('MM');
    String mesFormatado = formatter.format(data);
    return mesFormatado;
  }

  static String formatarValorDecimal(double valor) {
    return Constantes.formatoDecimalValor.format(valor ?? 0);
  }

  /// define o que é a tela pequena e se o dispositivo utilizado tem a tela pequena
  static bool isTelaPequena(BuildContext context) {
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
	static EdgeInsets distanciaEntreColunasQuebraLinha(BuildContext context) { 
    return bootStrapValueBasedOnSize(
      sizes: {
        "xl": EdgeInsets.zero,
        "lg": EdgeInsets.zero,
        "md": EdgeInsets.zero,
        "sm": EdgeInsets.zero,
        "": EdgeInsets.only(top: 5.0, bottom: 10.0),
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

  static int retornarCodigoIbgeUf(String uf) {
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