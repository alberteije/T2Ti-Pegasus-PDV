/*
Title: T2Ti ERP Pegasus                                                                
Description: Table Moor relacionada à tabela [ECF_R06] 
                                                                                
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

@DataClassName("EcfR06")
class EcfR06s extends Table {
  @override
  String get tableName => 'ECF_R06';

  IntColumn? get id => integer().named('ID').autoIncrement()();
  IntColumn? get idPdvOperador => integer().named('ID_PDV_OPERADOR').nullable().customConstraint('NULLABLE REFERENCES PDV_OPERADOR(ID)')() as Column<int>?;
  IntColumn? get idEcfImpressora => integer().named('ID_ECF_IMPRESSORA').nullable().customConstraint('NULLABLE REFERENCES ECF_IMPRESSORA(ID)')() as Column<int>?;
  IntColumn? get idEcfCaixa => integer().named('ID_ECF_CAIXA').nullable().customConstraint('NULLABLE REFERENCES ECF_CAIXA(ID)')() as Column<int>?;
  TextColumn? get serieEcf => text().named('SERIE_ECF').withLength(min: 0, max: 20).nullable()() as Column<String>?;
  IntColumn? get coo => integer().named('COO').nullable()() as Column<int>?;
  IntColumn? get gnf => integer().named('GNF').nullable()() as Column<int>?;
  IntColumn? get grg => integer().named('GRG').nullable()() as Column<int>?;
  IntColumn? get cdc => integer().named('CDC').nullable()() as Column<int>?;
  TextColumn? get denominacao => text().named('DENOMINACAO').withLength(min: 0, max: 2).nullable()() as Column<String>?;
  DateTimeColumn? get dataEmissao => dateTime().named('DATA_EMISSAO').nullable()() as Column<DateTime>?;
  TextColumn? get horaEmissao => text().named('HORA_EMISSAO').withLength(min: 0, max: 8).nullable()() as Column<String>?;
  TextColumn? get hashRegistro => text().named('HASH_REGISTRO').withLength(min: 0, max: 32).nullable()() as Column<String>?;
}