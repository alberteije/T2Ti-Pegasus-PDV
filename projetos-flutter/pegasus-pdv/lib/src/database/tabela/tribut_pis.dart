/*
Title: T2Ti ERP Pegasus                                                                
Description: Table Moor relacionada à tabela [TRIBUT_PIS] 
                                                                                
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

@DataClassName("TributPis")
class TributPiss extends Table {
  String get tableName => 'TRIBUT_PIS';

  IntColumn get id => integer().named('ID').autoIncrement()();
  IntColumn get idTributConfiguraOfGt => integer().named('ID_TRIBUT_CONFIGURA_OF_GT').nullable().customConstraint('NULLABLE REFERENCES TRIBUT_CONFIGURA_OF_GT(ID)')();
  TextColumn get cstPis => text().named('CST_PIS').withLength(min: 0, max: 2).nullable()();
  TextColumn get efdTabela435 => text().named('EFD_TABELA_435').withLength(min: 0, max: 2).nullable()();
  TextColumn get modalidadeBaseCalculo => text().named('MODALIDADE_BASE_CALCULO').withLength(min: 0, max: 1).nullable()();
  RealColumn get porcentoBaseCalculo => real().named('PORCENTO_BASE_CALCULO').nullable()();
  RealColumn get aliquotaPorcento => real().named('ALIQUOTA_PORCENTO').nullable()();
  RealColumn get aliquotaUnidade => real().named('ALIQUOTA_UNIDADE').nullable()();
  RealColumn get valorPrecoMaximo => real().named('VALOR_PRECO_MAXIMO').nullable()();
  RealColumn get valorPautaFiscal => real().named('VALOR_PAUTA_FISCAL').nullable()();
}