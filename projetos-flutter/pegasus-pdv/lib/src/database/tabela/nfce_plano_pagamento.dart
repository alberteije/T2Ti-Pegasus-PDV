/*
Title: T2Ti ERP Pegasus                                                                
Description: Table Moor relacionada à tabela [NFCE_PLANO_PAGAMENTO] 
Por enquanto utilizamos apenas o PagSeguro com meio de pagamento
                                                                                
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
import 'package:moor/moor.dart';

@DataClassName("NfcePlanoPagamento")
class NfcePlanoPagamentos extends Table {
  String get tableName => 'NFCE_PLANO_PAGAMENTO';

  IntColumn get id => integer().named('ID').autoIncrement()();
  DateTimeColumn get dataSolicitacao => dateTime().named('DATA_SOLICITACAO').nullable()();
  DateTimeColumn get dataPagamento => dateTime().named('DATA_PAGAMENTO').nullable()();
  TextColumn get tipoPlano => text().named('TIPO_PLANO').withLength(min: 0, max: 1).nullable()(); //M-MENSAL - S-SEMESTRAL - A-ANUAL
  RealColumn get valor => real().named('VALOR').nullable()();
  /*  statusPagamento
  1 	Aguardando pagamento: o comprador iniciou a transação, mas até o momento o PagSeguro não recebeu nenhuma informação sobre o pagamento.
  2 	Em análise: o comprador optou por pagar com um cartão de crédito e o PagSeguro está analisando o risco da transação.
  3 	Paga: a transação foi paga pelo comprador e o PagSeguro já recebeu uma confirmação da instituição financeira responsável pelo processamento.
  4 	Disponível: a transação foi paga e chegou ao final de seu prazo de liberação sem ter sido retornada e sem que haja nenhuma disputa aberta.
  5 	Em disputa: o comprador, dentro do prazo de liberação da transação, abriu uma disputa.
  6 	Devolvida: o valor da transação foi devolvido para o comprador.
  7 	Cancelada: a transação foi cancelada sem ter sido finalizada.
  8 	Debitado: o valor da transação foi devolvido para o comprador.
  9 	Retenção temporária: o comprador contestou o pagamento junto à operadora do cartão de crédito ou abriu uma demanda judicial ou administrativa (Procon). 
  */
  TextColumn get statusPagamento => text().named('STATUS_PAGAMENTO').withLength(min: 0, max: 1).nullable()();
  TextColumn get codigoTransacao => text().named('CODIGO_TRANSACAO').withLength(min: 0, max: 100).nullable()();
  /*  metodoPagamento
  1 	Cartão de crédito: o comprador escolheu pagar a transação com cartão de crédito.
  2 	Boleto: o comprador optou por pagar com um boleto bancário.
  3 	Débito online (TEF): o comprador optou por pagar a transação com débito online de algum dos bancos conveniados.
  4 	Saldo PagSeguro: o comprador optou por pagar a transação utilizando o saldo de sua conta PagSeguro.
  5 	Oi Paggo *: o comprador escolheu pagar sua transação através de seu celular Oi.
  7 	Depósito em conta: o comprador optou por fazer um depósito na conta corrente do PagSeguro. Ele precisará ir até uma agência bancária, fazer o depósito, guardar o comprovante e retornar ao PagSeguro para informar os dados do pagamento. A transação será confirmada somente após a finalização deste processo, que pode levar de 2 a 13 dias úteis. 
  */
  TextColumn get metodoPagamento => text().named('METODO_PAGAMENTO').withLength(min: 0, max: 1).nullable()();
  /*  codigoTipoPagamento
  101 	Cartão de crédito Visa.
  102 	Cartão de crédito MasterCard.
  103 	Cartão de crédito American Express.
  104 	Cartão de crédito Diners.
  105 	Cartão de crédito Hipercard.
  106 	Cartão de crédito Aura.
  107 	Cartão de crédito Elo.
  108 	Cartão de crédito PLENOCard. *
  109 	Cartão de crédito PersonalCard.
  110 	Cartão de crédito JCB.
  111 	Cartão de crédito Discover.
  112 	Cartão de crédito BrasilCard.
  113 	Cartão de crédito FORTBRASIL.
  114 	Cartão de crédito CARDBAN. *
  115 	Cartão de crédito VALECARD.
  116 	Cartão de crédito Cabal.
  117 	Cartão de crédito Mais!.
  118 	Cartão de crédito Avista.
  119 	Cartão de crédito GRANDCARD.
  120 	Cartão de crédito Sorocred.
  201 	Boleto Bradesco. *
  202 	Boleto Santander.
  301 	Débito online Bradesco.
  302 	Débito online Itaú.
  303 	Débito online Unibanco. *
  304 	Débito online Banco do Brasil.
  305 	Débito online Banco Real. *
  306 	Débito online Banrisul.
  307 	Débito online HSBC.
  401 	Saldo PagSeguro.
  501 	Oi Paggo. *
  701 	Depósito em conta - Banco do Brasil
  702 	Depósito em conta - HSBC
  */
  TextColumn get codigoTipoPagamento => text().named('CODIGO_TIPO_PAGAMENTO').withLength(min: 0, max: 3).nullable()();
  DateTimeColumn get dataPlanoExpira => dateTime().named('DATA_PLANO_EXPIRA').nullable()();
  TextColumn get hashRegistro => text().named('HASH_REGISTRO').withLength(min: 0, max: 32).nullable()();
}