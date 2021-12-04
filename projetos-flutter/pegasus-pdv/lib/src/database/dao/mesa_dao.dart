/*
Title: T2Ti ERP Pegasus                                                                
Description: DAO relacionado à tabela [MESA] 
                                                                                
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
import 'dart:async';

import 'package:moor/moor.dart';

import 'package:pegasus_pdv/src/database/database.dart';
import 'package:pegasus_pdv/src/database/database_classes.dart';

part 'mesa_dao.g.dart';

@UseDao(tables: [
          Mesas,
		])
class MesaDao extends DatabaseAccessor<AppDatabase> with _$MesaDaoMixin {
  final AppDatabase db;

  MesaDao(this.db) : super(db);

  List<Mesa> listaMesa = []; 
  
  Future<List<Mesa>> consultarLista() async {
    listaMesa = await select(mesas).get();
    return listaMesa;
  }  

  Future<List<Mesa>?> consultarListaFiltro(String campo, String valor) async {
    listaMesa = await (customSelect("SELECT * FROM MESA WHERE " + campo + " like '%" + valor + "%'", 
                                readsFrom: { mesas }).map((row) {
                                  return Mesa.fromData(row.data, db);  
                                }).get());
    return listaMesa;
  }
    
  Future<Mesa?> consultarObjetoFiltro(String campo, String valor) async {
    return (customSelect("SELECT * FROM MESA WHERE " + campo + " = '" + valor + "'", 
                                readsFrom: { mesas }).map((row) {
                                  return Mesa.fromData(row.data, db);  
                                }).getSingleOrNull());
  }  
  
  Stream<List<Mesa>> observarLista() => select(mesas).watch();

  Future<Mesa?> consultarObjeto(int pId) {
    return (select(mesas)..where((t) => t.id.equals(pId))).getSingleOrNull();
  } 

  Future<int> inserir(Insertable<Mesa> pObjeto) {
    return transaction(() async {
      final idInserido = await into(mesas).insert(pObjeto);
      return idInserido;
    });    
  } 

  Future<bool> alterar(Insertable<Mesa> pObjeto) {
    return transaction(() async {
      return update(mesas).replace(pObjeto);
    });    
  } 

  Future<int> excluir(Insertable<Mesa> pObjeto) {
    return transaction(() async {
      return delete(mesas).delete(pObjeto);
    });    
  }

  Future<void> inserirMesas(int quantidadeMesas, int quantidadeCadeirasAdultos, int quantidadeCadeirasCriancas) async {
    return transaction(() async {
      for (var i = 0; i < quantidadeMesas; i++) {
        Mesa objeto = Mesa(id: null, numero: (i+1).toString(), quantidadeCadeiras: quantidadeCadeirasAdultos, disponivel: 'S');
        await into(mesas).insert(objeto);  
      }
    });
  }

  Future<int> excluirTodos() {
    return transaction(() async {
      return (delete(mesas)..where((t) => t.id.isNotNull())).go();      
    });    
  }  

  static List<String> campos = <String>[
    'ID', 
    'NUMERO', 
    'QUANTIDADE_CADEIRAS', 
    'QUANTIDADE_CADEIRAS_CRIANCA', 
    'DISPONIVEL', 
    'OBSERVACAO', 
  ];

  static List<String> colunas = <String>[
    'Id', 
    'Número', 
    'Quantidade de Cadeiras', 
    'Quantidade de Cadeiras para Crianças', 
    'Disponível', 
    'Observação', 
  ];  
}