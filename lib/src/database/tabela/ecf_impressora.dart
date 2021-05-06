/*
Title: T2Ti ERP Pegasus                                                                
Description: Table Moor relacionada à tabela [ECF_IMPRESSORA] 
                                                                                
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

@DataClassName("EcfImpressora")
class EcfImpressoras extends Table {
  String get tableName => 'ECF_IMPRESSORA';

  IntColumn get id => integer().named('ID').autoIncrement()();
  IntColumn get numero => integer().named('NUMERO').nullable()();
  TextColumn get codigo => text().named('CODIGO').withLength(min: 0, max: 10).nullable()();
  TextColumn get serie => text().named('SERIE').withLength(min: 0, max: 30).nullable()();
  TextColumn get identificacao => text().named('IDENTIFICACAO').withLength(min: 0, max: 250).nullable()();
  TextColumn get mc => text().named('MC').withLength(min: 0, max: 2).nullable()();
  TextColumn get md => text().named('MD').withLength(min: 0, max: 2).nullable()();
  TextColumn get vr => text().named('VR').withLength(min: 0, max: 2).nullable()();
  TextColumn get tipo => text().named('TIPO').withLength(min: 0, max: 7).nullable()();
  TextColumn get marca => text().named('MARCA').withLength(min: 0, max: 30).nullable()();
  TextColumn get modelo => text().named('MODELO').withLength(min: 0, max: 30).nullable()();
  TextColumn get modeloAcbr => text().named('MODELO_ACBR').withLength(min: 0, max: 30).nullable()();
  TextColumn get modeloDocumentoFiscal => text().named('MODELO_DOCUMENTO_FISCAL').withLength(min: 0, max: 2).nullable()();
  TextColumn get versao => text().named('VERSAO').withLength(min: 0, max: 30).nullable()();
  TextColumn get le => text().named('LE').withLength(min: 0, max: 1).nullable()();
  TextColumn get lef => text().named('LEF').withLength(min: 0, max: 1).nullable()();
  TextColumn get mfd => text().named('MFD').withLength(min: 0, max: 1).nullable()();
  TextColumn get lacreNaMfd => text().named('LACRE_NA_MFD').withLength(min: 0, max: 1).nullable()();
  TextColumn get docto => text().named('DOCTO').withLength(min: 0, max: 60).nullable()();
  DateTimeColumn get dataInstalacaoSb => dateTime().named('DATA_INSTALACAO_SB').nullable()();
  TextColumn get horaInstalacaoSb => text().named('HORA_INSTALACAO_SB').withLength(min: 0, max: 8).nullable()();
}