/*
Title: T2Ti ERP Pegasus                                                                
Description: Table Moor relacionada à tabela [PDV_MOVIMENTO] 
                                                                                
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

@DataClassName("PdvMovimento")
class PdvMovimentos extends Table {
  String get tableName => 'PDV_MOVIMENTO';

  IntColumn get id => integer().named('ID').autoIncrement()();
  IntColumn get idEcfImpressora => integer().named('ID_ECF_IMPRESSORA').nullable().customConstraint('NULLABLE REFERENCES ECF_IMPRESSORA(ID)')();
  IntColumn get idPdvOperador => integer().named('ID_PDV_OPERADOR').nullable().customConstraint('NULLABLE REFERENCES PDV_OPERADOR(ID)')();
  IntColumn get idPdvCaixa => integer().named('ID_PDV_CAIXA').nullable().customConstraint('NULLABLE REFERENCES PDV_CAIXA(ID)')();
  IntColumn get idGerenteSupervisor => integer().named('ID_GERENTE_SUPERVISOR').nullable().customConstraint('NULLABLE REFERENCES GERENTE_SUPERVISOR(ID)')();
  DateTimeColumn get dataAbertura => dateTime().named('DATA_ABERTURA').nullable()();
  TextColumn get horaAbertura => text().named('HORA_ABERTURA').withLength(min: 0, max: 8).nullable()();
  DateTimeColumn get dataFechamento => dateTime().named('DATA_FECHAMENTO').nullable()();
  TextColumn get horaFechamento => text().named('HORA_FECHAMENTO').withLength(min: 0, max: 8).nullable()();
  RealColumn get totalSuprimento => real().named('TOTAL_SUPRIMENTO').nullable()();
  RealColumn get totalSangria => real().named('TOTAL_SANGRIA').nullable()();
  RealColumn get totalNaoFiscal => real().named('TOTAL_NAO_FISCAL').nullable()();
  RealColumn get totalVenda => real().named('TOTAL_VENDA').nullable()();
  RealColumn get totalDesconto => real().named('TOTAL_DESCONTO').nullable()();
  RealColumn get totalAcrescimo => real().named('TOTAL_ACRESCIMO').nullable()();
  RealColumn get totalFinal => real().named('TOTAL_FINAL').nullable()();
  RealColumn get totalRecebido => real().named('TOTAL_RECEBIDO').nullable()();
  RealColumn get totalTroco => real().named('TOTAL_TROCO').nullable()();
  RealColumn get totalCancelado => real().named('TOTAL_CANCELADO').nullable()();
  TextColumn get statusMovimento => text().named('STATUS_MOVIMENTO').withLength(min: 0, max: 1).nullable()();
}