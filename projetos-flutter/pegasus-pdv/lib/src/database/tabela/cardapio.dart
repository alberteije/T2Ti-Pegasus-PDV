/*
Title: T2Ti ERP Pegasus                                                                
Description: Table Moor relacionada à tabela [CARDAPIO] 
                                                                                
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

@DataClassName("Cardapio")
@UseRowClass(Cardapio)
class Cardapios extends Table {
  @override
  String get tableName => 'CARDAPIO';

  IntColumn get id => integer().named('ID').nullable()();
  IntColumn get idProduto => integer().named('ID_PRODUTO').nullable().customConstraint('NULLABLE REFERENCES PRODUTO(ID)')();
  TextColumn get modoPreparo => text().named('MODO_PREPARO').withLength(min: 0, max: 250).nullable()();
  TextColumn get infoAlergico => text().named('INFO_ALERGICO').withLength(min: 0, max: 250).nullable()();
  TextColumn get ingredientes => text().named('INGREDIENTES').withLength(min: 0, max: 250).nullable()();

  @override
  Set<Column> get primaryKey => {id};  
}

class RespostasSelecionadas {
  int idPergunta;
  String pergunta;
  String resposta;

  RespostasSelecionadas({required this.idPergunta, required this.pergunta, required this.resposta});
}