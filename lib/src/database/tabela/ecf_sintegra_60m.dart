/*
Title: T2Ti ERP Pegasus                                                                
Description: Table Moor relacionada à tabela [ECF_SINTEGRA_60M] 
                                                                                
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

@DataClassName("EcfSintegra60M")
class EcfSintegra60Ms extends Table {
  String get tableName => 'ECF_SINTEGRA_60M';

  IntColumn get id => integer().named('ID').autoIncrement()();
  DateTimeColumn get dataEmissao => dateTime().named('DATA_EMISSAO').nullable()();
  TextColumn get numeroSerieEcf => text().named('NUMERO_SERIE_ECF').withLength(min: 0, max: 20).nullable()();
  IntColumn get numeroEquipamento => integer().named('NUMERO_EQUIPAMENTO').nullable()();
  TextColumn get modeloDocumentoFiscal => text().named('MODELO_DOCUMENTO_FISCAL').withLength(min: 0, max: 2).nullable()();
  IntColumn get cooInicial => integer().named('COO_INICIAL').nullable()();
  IntColumn get cooFinal => integer().named('COO_FINAL').nullable()();
  IntColumn get crz => integer().named('CRZ').nullable()();
  IntColumn get cro => integer().named('CRO').nullable()();
  RealColumn get valorVendaBruta => real().named('VALOR_VENDA_BRUTA').nullable()();
  RealColumn get valorGrandeTotal => real().named('VALOR_GRANDE_TOTAL').nullable()();
}