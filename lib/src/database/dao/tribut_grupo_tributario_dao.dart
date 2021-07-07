/*
Title: T2Ti ERP Pegasus                                                                
Description: DAO relacionado à tabela [TRIBUT_GRUPO_TRIBUTARIO] 
                                                                                
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

part 'tribut_grupo_tributario_dao.g.dart';

@UseDao(tables: [
          TributGrupoTributarios,
		])
class TributGrupoTributarioDao extends DatabaseAccessor<AppDatabase> with _$TributGrupoTributarioDaoMixin {
  final AppDatabase db;

  TributGrupoTributarioDao(this.db) : super(db);

  List<TributGrupoTributario> listaTributGrupoTributario; // será usada para popular a grid na janela do grupo tributario
  
  Future<List<TributGrupoTributario>> consultarLista() async {
    listaTributGrupoTributario = await select(tributGrupoTributarios).get();
    aplicarDomains();
    return listaTributGrupoTributario;
  }
  Future<List<TributGrupoTributario>> consultarListaFiltro(String campo, String valor) async {
    listaTributGrupoTributario = await (customSelect("SELECT * FROM TRIBUT_GRUPO_TRIBUTARIO WHERE " + campo + " like '%" + valor + "%'", 
                                readsFrom: { tributGrupoTributarios }).map((row) {
                                  return TributGrupoTributario.fromData(row.data, db);  
                                }).get());
    aplicarDomains();
    return listaTributGrupoTributario;
  }

  Stream<List<TributGrupoTributario>> observarLista() => select(tributGrupoTributarios).watch();

  Future<TributGrupoTributario> consultarObjeto(int pId) {
    return (select(tributGrupoTributarios)..where((t) => t.id.equals(pId))).getSingleOrNull();
  } 

  Future<int> inserir(Insertable<TributGrupoTributario> pObjeto) {
    return transaction(() async {
      final grupoTributario = removerDomains(pObjeto);
      final idInserido = await into(tributGrupoTributarios).insert(grupoTributario);
      return idInserido;
    });    
  } 

  Future<bool> alterar(Insertable<TributGrupoTributario> pObjeto) {
    return transaction(() async {
      final grupoTributario = removerDomains(pObjeto);
      return update(tributGrupoTributarios).replace(grupoTributario);
    });    
  } 

  Future<int> excluir(Insertable<TributGrupoTributario> pObjeto) {
    return transaction(() async {
      return delete(tributGrupoTributarios).delete(pObjeto);
    });    
  }

  TributGrupoTributario removerDomains(TributGrupoTributario grupoTributario) {
    if (grupoTributario.origemMercadoria != null) {
      grupoTributario = grupoTributario.copyWith(
        origemMercadoria: grupoTributario.origemMercadoria.substring(0,1)
      );
    }
    return grupoTributario;
  }
  
  void aplicarDomains() {
    for (var i = 0; i < listaTributGrupoTributario.length; i++) {
      switch (listaTributGrupoTributario[i].origemMercadoria) {
        case '0' :
          listaTributGrupoTributario[i] = listaTributGrupoTributario[i].copyWith(origemMercadoria: '0-Nacional - Exceto as indicadas nos códigos 3, 4, 5 e 8',);
          break;
        case '1' :
          listaTributGrupoTributario[i] = listaTributGrupoTributario[i].copyWith(origemMercadoria: '1-Estrangeira – Importação direta, exceto a indicada no código 6',);
          break;
        case '2' :
          listaTributGrupoTributario[i] = listaTributGrupoTributario[i].copyWith(origemMercadoria: '2-Estrangeira – Adquirida no mercado interno, exceto a indicada no código 7',);
          break;
        case '3' :
          listaTributGrupoTributario[i] = listaTributGrupoTributario[i].copyWith(origemMercadoria: '3-Nacional - Conteúdo de Importação > 40% e <= 70%',);
          break;
        case '4' :
          listaTributGrupoTributario[i] = listaTributGrupoTributario[i].copyWith(origemMercadoria: '4-Nacional - Produção conforme processos produtivos - Decreto/Lei',);
          break;
        case '5' :
          listaTributGrupoTributario[i] = listaTributGrupoTributario[i].copyWith(origemMercadoria: '5-Nacional - Conteúdo de Importação <= 40%',);
          break;
        case '6' :
          listaTributGrupoTributario[i] = listaTributGrupoTributario[i].copyWith(origemMercadoria: '6-Estrangeira – Importação direta - Resolução CAMEX e gás natural',);
          break;
        case '7' :
          listaTributGrupoTributario[i] = listaTributGrupoTributario[i].copyWith(origemMercadoria: '7-Estrangeira – Adquirida no mercado interno - Resolução CAMEX e gás natural',);
          break;
        case '8' :
          listaTributGrupoTributario[i] = listaTributGrupoTributario[i].copyWith(origemMercadoria: '8-Nacional - Conteúdo de Importação > 70%',);
          break;
        default:
      }      
    }
  } 
 
	static List<String> campos = <String>[
		'ID', 
		'DESCRICAO', 
		'ORIGEM_MERCADORIA', 
		'OBSERVACAO', 
	];
	
	static List<String> colunas = <String>[
		'Id', 
		'Descrição', 
		'Origem da Mercadoria', 
		'Observação', 
	];

 
}