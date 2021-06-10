/*
Title: T2Ti ERP Pegasus                                                                
Description: Table Moor relacionada à tabela [NFE_DECLARACAO_IMPORTACAO] 
                                                                                
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

@DataClassName("NfeDeclaracaoImportacao")
class NfeDeclaracaoImportacaos extends Table {
  String get tableName => 'NFE_DECLARACAO_IMPORTACAO';

  IntColumn get id => integer().named('ID').autoIncrement()();
  IntColumn get idNfeDetalhe => integer().named('ID_NFE_DETALHE').nullable().customConstraint('NULLABLE REFERENCES NFE_DETALHE(ID)')();
  TextColumn get numeroDocumento => text().named('NUMERO_DOCUMENTO').withLength(min: 0, max: 12).nullable()();
  DateTimeColumn get dataRegistro => dateTime().named('DATA_REGISTRO').nullable()();
  TextColumn get localDesembaraco => text().named('LOCAL_DESEMBARACO').withLength(min: 0, max: 60).nullable()();
  TextColumn get ufDesembaraco => text().named('UF_DESEMBARACO').withLength(min: 0, max: 2).nullable()();
  DateTimeColumn get dataDesembaraco => dateTime().named('DATA_DESEMBARACO').nullable()();
  TextColumn get viaTransporte => text().named('VIA_TRANSPORTE').withLength(min: 0, max: 1).nullable()();
  RealColumn get valorAfrmm => real().named('VALOR_AFRMM').nullable()();
  TextColumn get formaIntermediacao => text().named('FORMA_INTERMEDIACAO').withLength(min: 0, max: 1).nullable()();
  TextColumn get cnpj => text().named('CNPJ').withLength(min: 0, max: 14).nullable()();
  TextColumn get ufTerceiro => text().named('UF_TERCEIRO').withLength(min: 0, max: 2).nullable()();
  TextColumn get codigoExportador => text().named('CODIGO_EXPORTADOR').withLength(min: 0, max: 60).nullable()();
}