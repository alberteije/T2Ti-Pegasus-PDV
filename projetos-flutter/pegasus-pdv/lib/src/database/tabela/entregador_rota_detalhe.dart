/*
Title: T2Ti ERP Pegasus                                                                
Description: Table Moor relacionada à tabela [ENTREGADOR_ROTA_DETALHE] 
                                                                                
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
import 'package:drift/drift.dart';
import 'package:pegasus_pdv/src/database/database.dart';

@DataClassName("EntregadorRotaDetalhe")
@UseRowClass(EntregadorRotaDetalhe)
class EntregadorRotaDetalhes extends Table {
  @override
  String get tableName => 'ENTREGADOR_ROTA_DETALHE';

  IntColumn get id => integer().named('ID').nullable()();
  IntColumn get idEntregadorRota => integer().named('ID_ENTREGADOR_ROTA').nullable().customConstraint('NULLABLE REFERENCES ENTREGADOR_ROTA(ID)')();
  IntColumn get idDelivery => integer().named('ID_DELIVERY').nullable().customConstraint('NULLABLE REFERENCES DELIVERY(ID)')();
  IntColumn get posicaoNaFila => integer().named('POSICAO_NA_FILA').nullable()();
  IntColumn get latitude => integer().named('LATITUDE').nullable()();
  IntColumn get longitude => integer().named('LONGITUDE').nullable()();

  @override
  Set<Column> get primaryKey => {id};  
}
