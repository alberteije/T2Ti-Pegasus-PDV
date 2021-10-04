/*
Title: T2Ti ERP Pegasus                                                                
Description: DAO relacionado à tabela [PRODUTO] 
                                                                                
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

part 'produto_dao.g.dart';

@UseDao(tables: [
          Produtos,
          ProdutoUnidades,
          TributGrupoTributarios,
		])
class ProdutoDao extends DatabaseAccessor<AppDatabase> with _$ProdutoDaoMixin {
  final AppDatabase db;

  List<Produto> listaProduto; // será usada para popular a grid na janela do produto
  List<ProdutoMontado> listaProdutoMontado; // será usada para popular a grid na janela do produto, pois leva a unidade

  ProdutoDao(this.db) : super(db);

  Future<List<Produto>> consultarLista() async {
    listaProduto = await select(produtos).get();
    return listaProduto;
  }

  Future<List<Produto>> consultarListaFiltro(String campo, String valor) async {
    listaProduto = await (customSelect("SELECT * FROM PRODUTO WHERE " + campo + " like '%" + valor + "%'", 
                                readsFrom: { produtos }).map((row) {
                                  return Produto.fromData(row.data, db);  
                                }).get());
    return listaProduto;
  }

  Future<List<Produto>> consultarProdutoSemGrupoTributario() async {
    listaProduto = await (customSelect("SELECT * FROM PRODUTO WHERE id_tribut_grupo_tributario is null", 
                                readsFrom: { produtos }).map((row) {
                                  return Produto.fromData(row.data, db);  
                                }).get());
    return listaProduto;
  }  

  Future<Produto> consultarObjetoFiltro(String campo, String valor) async {
    return (customSelect("SELECT * FROM PRODUTO WHERE " + campo + " = '" + valor + "'", 
                                readsFrom: { produtos }).map((row) {
                                  return Produto.fromData(row.data, db);  
                                }).getSingleOrNull());
  }

  Future<ProdutoMontado> consultarObjetoMontado(int pId) async {
    final consulta = select(produtos)
      .join([
        leftOuterJoin(produtoUnidades, produtoUnidades.id.equalsExp(produtos.idProdutoUnidade)),
      ])
      .join([
        leftOuterJoin(tributGrupoTributarios, tributGrupoTributarios.id.equalsExp(produtos.idTributGrupoTributario)),
      ]);

    consulta.where(produtos.id.equals(pId));

    final retorno = await consulta.map((row) {
        final produtoUnidade = row.readTableOrNull(produtoUnidades);
        final produto = row.readTableOrNull(produtos);
        final tributGrupoTributario = row.readTableOrNull(tributGrupoTributarios);

        return ProdutoMontado(
          produtoUnidade: produtoUnidade, 
          produto: produto,
          tributGrupoTributario: tributGrupoTributario,
        );
      }).getSingleOrNull();
    return retorno;
  }

  Future<List<ProdutoMontado>> consultarListaMontado({String campo, dynamic valor, String status}) async {
    final consulta = select(produtos)
      .join([
        leftOuterJoin(produtoUnidades, produtoUnidades.id.equalsExp(produtos.idProdutoUnidade)),
      ])
      .join([
        leftOuterJoin(tributGrupoTributarios, tributGrupoTributarios.id.equalsExp(produtos.idTributGrupoTributario)),
      ]);

    if (campo != null && campo != '') {      
      final coluna = produtos.$columns.where(((coluna) => coluna.$name == campo)).first;
      if (coluna is GeneratedTextColumn) {
        consulta.where(coluna.like('%'  + valor + '%'));
      } else if (coluna is GeneratedIntColumn) {
        consulta.where(coluna.equals(int.tryParse(valor)));
      } else if (coluna is GeneratedRealColumn) {
        consulta.where(coluna.equals(double.tryParse(valor)));
      }
    }

    if (status != null) {
      switch (status) {
        case 'Crítico':
          consulta.where(produtos.quantidadeEstoque.isSmallerThan(produtos.estoqueMinimo));
          break;
        default:
      }
    }

    listaProdutoMontado = await consulta.map((row) {
        final produtoUnidade = row.readTableOrNull(produtoUnidades);
        final produto = row.readTableOrNull(produtos);
        final tributGrupoTributario = row.readTableOrNull(tributGrupoTributarios);

        return ProdutoMontado(
          produtoUnidade: produtoUnidade, 
          produto: produto,
          tributGrupoTributario: tributGrupoTributario,
        );
      }).get();
    return listaProdutoMontado;
  }

  Future<int> consultarEstoqueCritico() async {
    final resultado = await customSelect("select count(*) as QUANTIDADE from produto where QUANTIDADE_ESTOQUE<ESTOQUE_MINIMO").getSingleOrNull();
    return resultado.data["QUANTIDADE"] ?? 0;
  }

  Future<bool> incrementarEstoque({List<VendaDetalhe> listaVendaDetalhe, List<CompraDetalhe> listaCompraDetalhe}) {
    return transaction(() async {
      if (listaCompraDetalhe != null) {
        for (var objeto in listaCompraDetalhe) {
          Produto produto = await consultarObjeto(objeto.compraPedidoDetalhe.idProduto);
          produto = produto.copyWith(
              quantidadeEstoque: (produto.quantidadeEstoque ?? 0) + objeto.compraPedidoDetalhe.quantidade,
              valorCompra: objeto.compraPedidoDetalhe.valorUnitario,
            );
          update(produtos).replace(produto);
        }
      } else if (listaVendaDetalhe != null) {
        for (var objeto in listaVendaDetalhe) {
          Produto produto = await consultarObjeto(objeto.pdvVendaDetalhe.idProduto);
          produto = produto.copyWith(
              quantidadeEstoque: (produto.quantidadeEstoque ?? 0) + objeto.pdvVendaDetalhe.quantidade,
            );
          update(produtos).replace(produto);
        }
      }
      return true;
    });    
  } 

  Future<bool> decrementarEstoque({List<VendaDetalhe> listaVendaDetalhe, List<CompraDetalhe> listaCompraDetalhe}) {
    return transaction(() async {
      if (listaVendaDetalhe != null) {
        for (var objeto in listaVendaDetalhe) {
          Produto produto = await consultarObjeto(objeto.pdvVendaDetalhe.idProduto);
          produto = produto.copyWith(quantidadeEstoque: (produto.quantidadeEstoque ?? 0) - objeto.pdvVendaDetalhe.quantidade);
          update(produtos).replace(produto);
        }
      } else if (listaCompraDetalhe != null) {
        for (var objeto in listaCompraDetalhe) {
          Produto produto = await consultarObjeto(objeto.compraPedidoDetalhe.idProduto);
          produto = produto.copyWith(quantidadeEstoque: (produto.quantidadeEstoque ?? 0) - objeto.compraPedidoDetalhe.quantidade);
          update(produtos).replace(produto);
        }
      }
      return true;
    });    
  } 

  Future<int> atualizarGrupoTributario(int idGrupoTributario) async {
    return customUpdate("update PRODUTO set ID_TRIBUT_GRUPO_TRIBUTARIO = '" + idGrupoTributario.toString() + "'");
  }

  Stream<List<Produto>> observarLista() => select(produtos).watch();

  Future<Produto> consultarObjeto(int pId) {
    return (select(produtos)..where((t) => t.id.equals(pId))).getSingleOrNull();
  } 

  Future<int> inserir(Insertable<Produto> pObjeto) {
    return transaction(() async {
      final idInserido = await into(produtos).insert(pObjeto);
      return idInserido;
    });    
  } 

  Future<bool> alterar(Insertable<Produto> pObjeto) {
    return transaction(() async {
      return update(produtos).replace(pObjeto);
    });    
  } 

  Future<int> excluir(Insertable<Produto> pObjeto) {
    return transaction(() async {
      return delete(produtos).delete(pObjeto);
    });    
  }

	static List<String> campos = <String>[
		'ID', 
		'GTIN', 
		'CODIGO_INTERNO', 
		'NOME', 
		'DESCRICAO', 
		'VALOR_COMPRA', 
		'VALOR_VENDA', 
		'QUANTIDADE_ESTOQUE', 
		'ESTOQUE_MINIMO', 
		'ESTOQUE_MAXIMO', 
	];
	
	static List<String> colunas = <String>[
		'Id', 
		'Gtin', 
		'Codigo Interno', 
		'Nome', 
		'Descricao', 
		'Valor Compra', 
		'Valor Venda', 
		'Quantidade Estoque', 
		'Estoque Minimo', 
		'Estoque Maximo', 
	];
  
}