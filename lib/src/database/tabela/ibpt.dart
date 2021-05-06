/*
Title: T2Ti ERP Pegasus                                                                
Description: Table Moor relacionada à tabela [IBPT] 
                                                                                
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

@DataClassName("Ibpt")
class Ibpts extends Table {
  String get tableName => 'IBPT';

  IntColumn get id => integer().named('ID').autoIncrement()();
  TextColumn get ncm => text().named('NCM').withLength(min: 0, max: 8).nullable()();
  TextColumn get ex => text().named('EX').withLength(min: 0, max: 2).nullable()();
  TextColumn get tipo => text().named('TIPO').withLength(min: 0, max: 1).nullable()();
  TextColumn get descricao => text().named('DESCRICAO').withLength(min: 0, max: 250).nullable()();
  RealColumn get nacionalFederal => real().named('NACIONAL_FEDERAL').nullable()();
  RealColumn get importadosFederal => real().named('IMPORTADOS_FEDERAL').nullable()();
  RealColumn get estadual => real().named('ESTADUAL').nullable()();
  RealColumn get municipal => real().named('MUNICIPAL').nullable()();
  DateTimeColumn get vigenciaInicio => dateTime().named('VIGENCIA_INICIO').nullable()();
  DateTimeColumn get vigenciaFim => dateTime().named('VIGENCIA_FIM').nullable()();
  TextColumn get chave => text().named('CHAVE').withLength(min: 0, max: 6).nullable()();
  TextColumn get versao => text().named('VERSAO').withLength(min: 0, max: 6).nullable()();
  TextColumn get fonte => text().named('FONTE').withLength(min: 0, max: 34).nullable()();
}