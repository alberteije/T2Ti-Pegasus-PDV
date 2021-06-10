/*
Title: T2Ti ERP Pegasus                                                                
Description: Table Moor relacionada à tabela [PDV_VENDA_CABECALHO] 
                                                                                
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

@DataClassName("PdvVendaCabecalho")
class PdvVendaCabecalhos extends Table {
  String get tableName => 'PDV_VENDA_CABECALHO';

  IntColumn get id => integer().named('ID').autoIncrement()();
  IntColumn get idCliente => integer().named('ID_CLIENTE').nullable().customConstraint('NULLABLE REFERENCES CLIENTE(ID)')();
  IntColumn get idColaborador => integer().named('ID_COLABORADOR').nullable().customConstraint('NULLABLE REFERENCES COLABORADOR(ID)')();
  IntColumn get idPdvMovimento => integer().named('ID_PDV_MOVIMENTO').nullable().customConstraint('NULLABLE REFERENCES PDV_MOVIMENTO(ID)')();
  IntColumn get idEcfDav => integer().named('ID_ECF_DAV').nullable().customConstraint('NULLABLE REFERENCES ECF_DAV(ID)')();
  IntColumn get idEcfPreVendaCabecalho => integer().named('ID_ECF_PRE_VENDA_CABECALHO').nullable().customConstraint('NULLABLE REFERENCES ECF_PRE_VENDA_CABECALHO(ID)')();
  TextColumn get serieEcf => text().named('SERIE_ECF').withLength(min: 0, max: 20).nullable()();
  IntColumn get cfop => integer().named('CFOP').nullable()();
  IntColumn get coo => integer().named('COO').nullable()();
  IntColumn get ccf => integer().named('CCF').nullable()();
  DateTimeColumn get dataVenda => dateTime().named('DATA_VENDA').nullable()();
  TextColumn get horaVenda => text().named('HORA_VENDA').withLength(min: 0, max: 8).nullable()();
  RealColumn get valorVenda => real().named('VALOR_VENDA').nullable()();
  RealColumn get taxaDesconto => real().named('TAXA_DESCONTO').nullable()();
  RealColumn get valorDesconto => real().named('VALOR_DESCONTO').nullable()();
  RealColumn get taxaAcrescimo => real().named('TAXA_ACRESCIMO').nullable()();
  RealColumn get valorAcrescimo => real().named('VALOR_ACRESCIMO').nullable()();
  RealColumn get valorFinal => real().named('VALOR_FINAL').nullable()();
  RealColumn get valorRecebido => real().named('VALOR_RECEBIDO').nullable()();
  RealColumn get valorTroco => real().named('VALOR_TROCO').nullable()();
  RealColumn get valorCancelado => real().named('VALOR_CANCELADO').nullable()();
  RealColumn get valorTotalProdutos => real().named('VALOR_TOTAL_PRODUTOS').nullable()();
  RealColumn get valorTotalDocumento => real().named('VALOR_TOTAL_DOCUMENTO').nullable()();
  RealColumn get valorBaseIcms => real().named('VALOR_BASE_ICMS').nullable()();
  RealColumn get valorIcms => real().named('VALOR_ICMS').nullable()();
  RealColumn get valorIcmsOutras => real().named('VALOR_ICMS_OUTRAS').nullable()();
  RealColumn get valorIssqn => real().named('VALOR_ISSQN').nullable()();
  RealColumn get valorPis => real().named('VALOR_PIS').nullable()();
  RealColumn get valorCofins => real().named('VALOR_COFINS').nullable()();
  RealColumn get valorAcrescimoItens => real().named('VALOR_ACRESCIMO_ITENS').nullable()();
  RealColumn get valorDescontoItens => real().named('VALOR_DESCONTO_ITENS').nullable()();
  TextColumn get statusVenda => text().named('STATUS_VENDA').withLength(min: 0, max: 1).nullable()();
  TextColumn get nomeCliente => text().named('NOME_CLIENTE').withLength(min: 0, max: 100).nullable()();
  TextColumn get cpfCnpjCliente => text().named('CPF_CNPJ_CLIENTE').withLength(min: 0, max: 14).nullable()();
  TextColumn get cupomCancelado => text().named('CUPOM_CANCELADO').withLength(min: 0, max: 1).nullable()();
  TextColumn get hashRegistro => text().named('HASH_REGISTRO').withLength(min: 0, max: 32).nullable()();
  TextColumn get tipoOperacao => text().named('TIPO_OPERACAO').withLength(min: 0, max: 3).nullable()(); //NFC = NFC-e | SAT = SAT | MFE = MFE | REC = RECIBO
}