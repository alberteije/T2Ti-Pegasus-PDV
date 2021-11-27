/*
Title: T2Ti ERP Pegasus                                                                
Description: DAO relacionado à tabela [EMPRESA_CNAE] 
                                                                                
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

part 'empresa_cnae_dao.g.dart';

@UseDao(tables: [
          EmpresaCnaes,
		])
class EmpresaCnaeDao extends DatabaseAccessor<AppDatabase> with _$EmpresaCnaeDaoMixin {
  final AppDatabase db;

  EmpresaCnaeDao(this.db) : super(db);

  List<EmpresaCnae> listaEmpresaCnae = []; 
  
  Future<List<EmpresaCnae>> consultarLista() async {
    listaEmpresaCnae = await select(empresaCnaes).get();
    return listaEmpresaCnae;
  }  

  Future<List<EmpresaCnae>?> consultarListaFiltro(String campo, String valor) async {
    listaEmpresaCnae = await (customSelect("SELECT * FROM EMPRESA_CNAE WHERE " + campo + " like '%" + valor + "%'", 
                                readsFrom: { empresaCnaes }).map((row) {
                                  return EmpresaCnae.fromData(row.data, db);  
                                }).get());
    return listaEmpresaCnae;
  }
    
  Future<EmpresaCnae?> consultarObjetoFiltro(String campo, String valor) async {
    return (customSelect("SELECT * FROM EMPRESA_CNAE WHERE " + campo + " = '" + valor + "'", 
                                readsFrom: { empresaCnaes }).map((row) {
                                  return EmpresaCnae.fromData(row.data, db);  
                                }).getSingleOrNull());
  }  
  
  Stream<List<EmpresaCnae>> observarLista() => select(empresaCnaes).watch();

  Future<EmpresaCnae?> consultarObjeto(int pId) {
    return (select(empresaCnaes)..where((t) => t.id.equals(pId))).getSingleOrNull();
  } 

  Future<int> inserir(Insertable<EmpresaCnae> pObjeto) {
    return transaction(() async {
      final idInserido = await into(empresaCnaes).insert(pObjeto);
      return idInserido;
    });    
  } 

  Future<bool> alterar(Insertable<EmpresaCnae> pObjeto) {
    return transaction(() async {
      return update(empresaCnaes).replace(pObjeto);
    });    
  } 

  Future<int> excluir(Insertable<EmpresaCnae> pObjeto) {
    return transaction(() async {
      return delete(empresaCnaes).delete(pObjeto);
    });    
  }

  Future<void> inserirTodos(List<EmpresaCnae> listaCnae) async {
    return transaction(() async {
      for (var objeto in listaCnae) {
        await into(empresaCnaes).insert(objeto);  
      }
    });
  }

  Future<int> excluirTodos() {
    return transaction(() async {
      return (delete(empresaCnaes)..where((t) => t.id.isNotNull())).go();      
    });    
  }  
  
  static List<String> campos = <String>[
    'ID', 
    'CODIGO', 
    'PRINCIPAL', 
  ];

  static List<String> colunas = <String>[
    'Id', 
    'Codigo', 
    'Principal', 
  ];  
}