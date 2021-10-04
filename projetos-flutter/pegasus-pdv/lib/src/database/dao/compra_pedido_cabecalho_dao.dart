/*
Title: T2Ti ERP Pegasus                                                                
Description: DAO relacionado à tabela [COMPRA_PEDIDO_CABECALHO] 
                                                                                
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

part 'compra_pedido_cabecalho_dao.g.dart';

@UseDao(tables: [
          CompraPedidoCabecalhos,
          CompraPedidoDetalhes,
          Fornecedors,
          Colaboradors,
		])
class CompraPedidoCabecalhoDao extends DatabaseAccessor<AppDatabase> with _$CompraPedidoCabecalhoDaoMixin {
  final AppDatabase db;

  List<CompraPedidoCabecalho> listaCompraPedidoCabecalho; // será usada para popular a grid na janela do compraPedidoCabecalho
  List<CompraPedidoCabecalhoMontado> listaCompraPedidoCabecalhoMontado; // será usada para popular a grid na janela do compraPedidoCabecalho, pois leva a unidade

  CompraPedidoCabecalhoDao(this.db) : super(db);

  Future<List<CompraPedidoCabecalho>> consultarLista() async {
    listaCompraPedidoCabecalho = await select(compraPedidoCabecalhos).get();
    return listaCompraPedidoCabecalho;
  }

  Future<List<CompraPedidoCabecalho>> consultarListaFiltro(String campo, String valor) async {
    listaCompraPedidoCabecalho = await (customSelect("SELECT * FROM COMPRA_PEDIDO_CABECALHO WHERE " + campo + " like '%" + valor + "%'", 
                                readsFrom: { compraPedidoCabecalhos }).map((row) {
                                  return CompraPedidoCabecalho.fromData(row.data, db);  
                                }).get());
    return listaCompraPedidoCabecalho;
  }

  Future<List<CompraPedidoCabecalhoMontado>> consultarListaMontado({int mes, int ano}) async {
    final consulta = select(compraPedidoCabecalhos)
      .join([
        leftOuterJoin(fornecedors, fornecedors.id.equalsExp(compraPedidoCabecalhos.idFornecedor)),
      ])
      .join([
        leftOuterJoin(colaboradors, colaboradors.id.equalsExp(compraPedidoCabecalhos.idColaborador)),
      ]);
    
    if (mes != null && ano != null) {
      consulta.where(compraPedidoCabecalhos.dataPedido.month.equals(mes));
      consulta.where(compraPedidoCabecalhos.dataPedido.year.equals(ano));
    }

    listaCompraPedidoCabecalhoMontado = await consulta.map((row) {
        final compraPedidoCabecalho = row.readTableOrNull(compraPedidoCabecalhos);
        final fornecedor = row.readTableOrNull(fornecedors);
        final colaborador = row.readTableOrNull(colaboradors);

        return CompraPedidoCabecalhoMontado(
          compraPedidoCabecalho: compraPedidoCabecalho,
          fornecedor: fornecedor,
          colaborador: colaborador,
        );
      }).get();
    return listaCompraPedidoCabecalhoMontado;
  }

  Stream<List<CompraPedidoCabecalho>> observarLista() => select(compraPedidoCabecalhos).watch();

  Future<CompraPedidoCabecalho> consultarObjeto(int pId) {
    return (select(compraPedidoCabecalhos)..where((t) => t.id.equals(pId))).getSingleOrNull();
  } 

  Future<int> inserir(Insertable<CompraPedidoCabecalho> pObjeto, List<CompraDetalhe> listaCompraDetalhe) {
    return transaction(() async {
      final idInserido = await into(compraPedidoCabecalhos).insert(pObjeto);
      await inserirFilhos(idInserido, listaCompraDetalhe);
      return idInserido;
    });    
  } 

  Future<bool> alterar(Insertable<CompraPedidoCabecalho> pObjeto, List<CompraDetalhe> listaCompraDetalhe, {bool atualizaEstoque}) {
    return transaction(() async {
      await excluirFilhos((pObjeto as CompraPedidoCabecalho).id);
      await inserirFilhos((pObjeto as CompraPedidoCabecalho).id, listaCompraDetalhe);
      if (atualizaEstoque ?? false) {
        await db.produtoDao.incrementarEstoque(listaCompraDetalhe: listaCompraDetalhe);  
      }
      return update(compraPedidoCabecalhos).replace(pObjeto);
    });    
  } 

  Future<bool> atualizarCabecalho(Insertable<CompraPedidoCabecalho> pObjeto) {
    return transaction(() async {
      return update(compraPedidoCabecalhos).replace(pObjeto);
    });    
  } 

  Future<int> excluir(Insertable<CompraPedidoCabecalho> pObjeto, List<CompraDetalhe> listaCompraDetalhe) {
    return transaction(() async {
      if (((pObjeto as CompraPedidoCabecalho).atualizouEstoque ?? '') == 'S') {
        await db.produtoDao.decrementarEstoque(listaCompraDetalhe: listaCompraDetalhe);  
      }
      if (((pObjeto as CompraPedidoCabecalho).geraFinanceiro ?? '') == 'S') {
        await db.contasPagarDao.excluirContasDePedidoVinculado((pObjeto as CompraPedidoCabecalho).id);  
      }
      await excluirFilhos((pObjeto as CompraPedidoCabecalho).id);
      return delete(compraPedidoCabecalhos).delete(pObjeto);
    });    
  }

  Future<void> inserirFilhos(int idMestre, List<CompraDetalhe> listaCompraDetalhe) async {
    if (listaCompraDetalhe != null) {
      for (var objeto in listaCompraDetalhe) {
        objeto.compraPedidoDetalhe = objeto.compraPedidoDetalhe.copyWith(idCompraPedidoCabecalho: idMestre);
        await into(compraPedidoDetalhes).insert(objeto.compraPedidoDetalhe);  
      }
    }
  }
  
  Future<void> excluirFilhos(int idMestre) async {
    await (delete(compraPedidoDetalhes)..where((t) => t.idCompraPedidoCabecalho.equals(idMestre))).go();
  }

	static List<String> campos = <String>[
		'ID', 
		'DATA_PEDIDO', 
		'DATA_PREVISAO_ENTREGA', 
		'DATA_PREVISAO_PAGAMENTO', 
		'LOCAL_ENTREGA', 
		'LOCAL_COBRANCA', 
		'CONTATO', 
		'VALOR_SUBTOTAL', 
		'TAXA_DESCONTO', 
		'VALOR_DESCONTO', 
		'VALOR_TOTAL', 
		'FORMA_PAGAMENTO', 
		'GERA_FINANCEIRO', 
		'QUANTIDADE_PARCELAS', 
		'DIA_PRIMEIRO_VENCIMENTO', 
		'INTERVALO_ENTRE_PARCELAS', 
		'DIA_FIXO_PARCELA', 
		'DATA_RECEBIMENTO_ITENS', 
		'HORA_RECEBIMENTO_ITENS', 
		'ATUALIZOU_ESTOQUE', 
		'NUMERO_DOCUMENTO_ENTRADA', 
	];
	
	static List<String> colunas = <String>[
		'Id', 
		'Data do Pedido', 
		'Data Prevista para Entrega', 
		'Data Previsão Pagamento', 
		'Local de Entrega', 
		'Local de Cobrança', 
		'Nome do Contato', 
		'Valor Subtotal', 
		'Taxa Desconto', 
		'Valor Desconto', 
		'Valor Total', 
		'Forma de Pagamento', 
		'Gera Financeiro', 
		'Quantidade de Parcelas', 
		'Dia Primeiro Vencimento', 
		'Intervalo entre Parcelas', 
		'Dia Fixo da Parcela', 
		'Data Recebimento Itens', 
		'Hora Recebimento Itens', 
		'Atualizou Estoque', 
		'Numero Documento Entrada', 
	];

}