/*
Title: T2Ti ERP Pegasus                                                                
Description: DAO relacionado à tabela [PRODUTO_SUBGRUPO] 
                                                                                
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

part 'produto_subgrupo_dao.g.dart';

@UseDao(tables: [
          ProdutoSubgrupos,
          ProdutoGrupos,
		])
class ProdutoSubgrupoDao extends DatabaseAccessor<AppDatabase> with _$ProdutoSubgrupoDaoMixin {
  final AppDatabase db;

  ProdutoSubgrupoDao(this.db) : super(db);

  List<ProdutoSubgrupo>? listaProdutoSubgrupo; 
  List<ProdutoSubgrupoMontado>? listaProdutoSubgrupoMontado; 
  
  Future<List<ProdutoSubgrupo>?> consultarLista() async {
    listaProdutoSubgrupo = await select(produtoSubgrupos).get();
    return listaProdutoSubgrupo;
  }  

  Future<List<ProdutoSubgrupo>?> consultarListaFiltro(String campo, String valor) async {
    listaProdutoSubgrupo = await (customSelect("SELECT * FROM PRODUTO_SUBGRUPO WHERE " + campo + " like '%" + valor + "%'", 
                                readsFrom: { produtoSubgrupos }).map((row) {
                                  return ProdutoSubgrupo.fromData(row.data, db);  
                                }).get());
    return listaProdutoSubgrupo;
  }
    
  Future<ProdutoSubgrupo?> consultarObjetoFiltro(String campo, String valor) async {
    return (customSelect("SELECT * FROM PRODUTO_SUBGRUPO WHERE " + campo + " = '" + valor + "'", 
                                readsFrom: { produtoSubgrupos }).map((row) {
                                  return ProdutoSubgrupo.fromData(row.data, db);  
                                }).getSingleOrNull());
  }  
  
  Future<List<ProdutoSubgrupoMontado>?> consultarListaMontado({String? campo, dynamic valor}) async {
    final consulta = select(produtoSubgrupos)
      .join([
        leftOuterJoin(produtoGrupos, produtoGrupos.id.equalsExp(produtoSubgrupos.idProdutoGrupo)),
      ]);

    if (campo != null && campo != '') {      
      final coluna = produtoSubgrupos.$columns.where(((coluna) => coluna.$name == campo)).first;
      if (coluna is TextColumn) {
        consulta.where((coluna as TextColumn).like('%'  + valor + '%'));
      } else if (coluna is IntColumn) {
        consulta.where(coluna.equals(int.tryParse(valor)));
      } else if (coluna is RealColumn) {
        consulta.where(coluna.equals(double.tryParse(valor)));
      }
    }

    listaProdutoSubgrupoMontado = await consulta.map((row) {
        final produtoSubgrupo = row.readTableOrNull(produtoSubgrupos);
        final produtoGrupo = row.readTableOrNull(produtoGrupos);

        return ProdutoSubgrupoMontado(
          produtoSubgrupo: produtoSubgrupo,
          produtoGrupo: produtoGrupo,
        );
      }).get();      
    return listaProdutoSubgrupoMontado;
  }

  Stream<List<ProdutoSubgrupo>> observarLista() => select(produtoSubgrupos).watch();

  Future<ProdutoSubgrupo?> consultarObjeto(int pId) {
    return (select(produtoSubgrupos)..where((t) => t.id.equals(pId))).getSingleOrNull();
  } 

  Future<int> inserir(Insertable<ProdutoSubgrupo> pObjeto) {
    return transaction(() async {
      final idInserido = await into(produtoSubgrupos).insert(pObjeto);
      return idInserido;
    });    
  } 

  Future<bool> alterar(Insertable<ProdutoSubgrupo> pObjeto) {
    return transaction(() async {
      return update(produtoSubgrupos).replace(pObjeto);
    });    
  } 

  Future<int> excluir(Insertable<ProdutoSubgrupo> pObjeto) {
    return transaction(() async {
      return delete(produtoSubgrupos).delete(pObjeto);
    });    
  }

  
  
  static List<String> campos = <String>[
    'ID', 
    'NOME', 
    'DESCRICAO', 
  ];

  static List<String> colunas = <String>[
    'Id', 
    'Nome', 
    'Descrição', 
  ];  
}