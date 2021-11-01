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
  @override
  String get tableName => 'PDV_MOVIMENTO';

  IntColumn? get id => integer().named('ID').autoIncrement()();
  IntColumn? get idEcfImpressora => integer().named('ID_ECF_IMPRESSORA').nullable().customConstraint('NULLABLE REFERENCES ECF_IMPRESSORA(ID)')() as Column<int>?;
  IntColumn? get idPdvOperador => integer().named('ID_PDV_OPERADOR').nullable().customConstraint('NULLABLE REFERENCES PDV_OPERADOR(ID)')() as Column<int>?;
  IntColumn? get idPdvCaixa => integer().named('ID_PDV_CAIXA').nullable().customConstraint('NULLABLE REFERENCES PDV_CAIXA(ID)')() as Column<int>?;
  IntColumn? get idGerenteSupervisor => integer().named('ID_GERENTE_SUPERVISOR').nullable().customConstraint('NULLABLE REFERENCES GERENTE_SUPERVISOR(ID)')() as Column<int>?;
  DateTimeColumn? get dataAbertura => dateTime().named('DATA_ABERTURA').nullable()() as Column<DateTime>?;
  TextColumn? get horaAbertura => text().named('HORA_ABERTURA').withLength(min: 0, max: 8).nullable()() as Column<String>?;
  DateTimeColumn? get dataFechamento => dateTime().named('DATA_FECHAMENTO').nullable()() as Column<DateTime>?;
  TextColumn? get horaFechamento => text().named('HORA_FECHAMENTO').withLength(min: 0, max: 8).nullable()() as Column<String>?;
  RealColumn? get totalSuprimento => real().named('TOTAL_SUPRIMENTO').nullable()() as Column<double>?;
  RealColumn? get totalSangria => real().named('TOTAL_SANGRIA').nullable()() as Column<double>?;
  RealColumn? get totalNaoFiscal => real().named('TOTAL_NAO_FISCAL').nullable()() as Column<double>?;
  RealColumn? get totalVenda => real().named('TOTAL_VENDA').nullable()() as Column<double>?;
  RealColumn? get totalDesconto => real().named('TOTAL_DESCONTO').nullable()() as Column<double>?;
  RealColumn? get totalAcrescimo => real().named('TOTAL_ACRESCIMO').nullable()() as Column<double>?;
  RealColumn? get totalFinal => real().named('TOTAL_FINAL').nullable()() as Column<double>?;
  RealColumn? get totalRecebido => real().named('TOTAL_RECEBIDO').nullable()() as Column<double>?;
  RealColumn? get totalTroco => real().named('TOTAL_TROCO').nullable()() as Column<double>?;
  RealColumn? get totalCancelado => real().named('TOTAL_CANCELADO').nullable()() as Column<double>?;
  TextColumn? get statusMovimento => text().named('STATUS_MOVIMENTO').withLength(min: 0, max: 1).nullable()() as Column<String>?;
}