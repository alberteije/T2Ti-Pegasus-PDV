/*
Title: T2Ti ERP Pegasus                                                                
Description: DAO relacionado à tabela [COZINHA] 
                                                                                
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

import 'package:pegasus_pdv/src/database/database.dart';
import 'package:pegasus_pdv/src/database/database_classes.dart';

part 'cozinha_dao.g.dart';

@UseDao(tables: [
          Cozinhas,
          ComandaPedidos,
		])
class CozinhaDao extends DatabaseAccessor<AppDatabase> with _$CozinhaDaoMixin {
  final AppDatabase db;

  CozinhaDao(this.db) : super(db);

  List<Cozinha>? listaCozinha; 
  
  Future<List<Cozinha>?> consultarLista() async {
    listaCozinha = await select(cozinhas).get();
    return listaCozinha;
  }  

  Future<List<Cozinha>?> consultarListaFiltro(String campo, String valor) async {
    listaCozinha = await (customSelect("SELECT * FROM COZINHA WHERE " + campo + " like '%" + valor + "%'", 
                                readsFrom: { cozinhas }).map((row) {
                                  return Cozinha.fromData(row.data, db);  
                                }).get());
    return listaCozinha;
  }
    
  Future<Cozinha?> consultarObjetoFiltro(String campo, String valor) async {
    return (customSelect("SELECT * FROM COZINHA WHERE " + campo + " = '" + valor + "'", 
                                readsFrom: { cozinhas }).map((row) {
                                  return Cozinha.fromData(row.data, db);  
                                }).getSingleOrNull());
  }  
  
  Stream<List<Cozinha>> observarLista() => select(cozinhas).watch();

  Future<Cozinha?> consultarObjeto(int pId) {
    return (select(cozinhas)..where((t) => t.id.equals(pId))).getSingleOrNull();
  } 

  Future<int> inserir(Insertable<Cozinha> pObjeto) {
    return transaction(() async {
      final idInserido = await into(cozinhas).insert(pObjeto);
      return idInserido;
    });    
  } 

  Future<bool> alterar(Insertable<Cozinha> pObjeto) {
    return transaction(() async {
      return update(cozinhas).replace(pObjeto);
    });    
  } 

  Future<int> excluir(Insertable<Cozinha> pObjeto) {
    return transaction(() async {
      return delete(cozinhas).delete(pObjeto);
    });    
  }

  static List<String> campos = <String>[
    'ID', 
    'NOME', 
    'IMPRESSORA_NOME', 
    'IMPRESSORA_ENDERECO', 
  ];

  static List<String> colunas = <String>[
    'Id', 
    'Nome', 
    'Nome Impressora', 
    'Endereço Impressora', 
  ];  
}