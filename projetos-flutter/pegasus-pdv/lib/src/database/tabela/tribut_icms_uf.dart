/*
Title: T2Ti ERP Pegasus                                                                
Description: Table Moor relacionada à tabela [TRIBUT_ICMS_UF] 
                                                                                
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

@DataClassName("TributIcmsUf")
class TributIcmsUfs extends Table {
  String get tableName => 'TRIBUT_ICMS_UF';

  IntColumn get id => integer().named('ID').autoIncrement()();
  IntColumn get idTributConfiguraOfGt => integer().named('ID_TRIBUT_CONFIGURA_OF_GT').nullable().customConstraint('NULLABLE REFERENCES TRIBUT_CONFIGURA_OF_GT(ID)')();
  TextColumn get ufDestino => text().named('UF_DESTINO').withLength(min: 0, max: 2).nullable()();
  IntColumn get cfop => integer().named('CFOP').nullable()();
  TextColumn get csosn => text().named('CSOSN').withLength(min: 0, max: 3).nullable()();
  TextColumn get cst => text().named('CST').withLength(min: 0, max: 2).nullable()();
  TextColumn get modalidadeBc => text().named('MODALIDADE_BC').withLength(min: 0, max: 1).nullable()();
  RealColumn get aliquota => real().named('ALIQUOTA').nullable()();
  RealColumn get valorPauta => real().named('VALOR_PAUTA').nullable()();
  RealColumn get valorPrecoMaximo => real().named('VALOR_PRECO_MAXIMO').nullable()();
  RealColumn get mva => real().named('MVA').nullable()();
  RealColumn get porcentoBc => real().named('PORCENTO_BC').nullable()();
  TextColumn get modalidadeBcSt => text().named('MODALIDADE_BC_ST').withLength(min: 0, max: 1).nullable()();
  RealColumn get aliquotaInternaSt => real().named('ALIQUOTA_INTERNA_ST').nullable()();
  RealColumn get aliquotaInterestadualSt => real().named('ALIQUOTA_INTERESTADUAL_ST').nullable()();
  RealColumn get porcentoBcSt => real().named('PORCENTO_BC_ST').nullable()();
  RealColumn get aliquotaIcmsSt => real().named('ALIQUOTA_ICMS_ST').nullable()();
  RealColumn get valorPautaSt => real().named('VALOR_PAUTA_ST').nullable()();
  RealColumn get valorPrecoMaximoSt => real().named('VALOR_PRECO_MAXIMO_ST').nullable()();
}