/*
Title: T2Ti ERP Pegasus                                                                
Description: DAO relacionado à tabela [CONTAS_PAGAR] 
                                                                                
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

part 'contas_pagar_dao.g.dart';

@UseDao(tables: [
          ContasPagars,
          Fornecedors,
		])
class ContasPagarDao extends DatabaseAccessor<AppDatabase> with _$ContasPagarDaoMixin {
  final AppDatabase db;

  List<ContasPagar> listaContasPagar; // será usada para popular a grid na janela do contasPagar
  List<ContasPagarMontado> listaContasPagarMontado; // será usada para popular a grid na janela do contas a pagar, pois leva o fornecedor

  ContasPagarDao(this.db) : super(db);

  Future<List<ContasPagar>> consultarLista() async {
    listaContasPagar = await select(contasPagars).get();
    return listaContasPagar;
  }

  Future<List<ContasPagar>> consultarListaFiltro(String campo, String valor) async {
    listaContasPagar = await (customSelect("SELECT * FROM CONTAS_PAGAR WHERE " + campo + " like '%" + valor + "%'", 
                                readsFrom: { contasPagars }).map((row) {
                                  return ContasPagar.fromData(row.data, db);  
                                }).get());
    return listaContasPagar;
  }

  Future<List<ContasPagarMontado>> consultarListaMontado({int mes, int ano, String status}) async {
    final consulta = select(contasPagars)
      .join([
        leftOuterJoin(fornecedors, fornecedors.id.equalsExp(contasPagars.idFornecedor)),
      ]);
    
    if (mes != null && ano != null) {
      consulta.where(contasPagars.dataVencimento.month.equals(mes));
      consulta.where(contasPagars.dataVencimento.year.equals(ano));
    }

    if (status != null) {
      switch (status) {
        case 'Pagar':
          consulta.where(contasPagars.statusPagamento.equals('A'));
          break;
        case 'Pago':
          consulta.where(contasPagars.statusPagamento.equals('P'));          
          break;
        default:
      }
    }

    listaContasPagarMontado = await consulta.map((row) {
        final contasPagar = row.readTableOrNull(contasPagars);
        final fornecedor = row.readTableOrNull(fornecedors);

        return ContasPagarMontado(
          contasPagar: contasPagar,
          fornecedor: fornecedor,
        );
      }).get();
    return listaContasPagarMontado;
  }

  Future<double> consultarDespesas({String periodo}) async {
    var diasPeriodo;
    if (periodo.contains('Semana')) {
      diasPeriodo = '7';
    } else if (periodo.contains('Mês')) {
      diasPeriodo = '30';
    } else if (periodo.contains('Ano')) {
      diasPeriodo = '360';
    }

    final sql = "select SUM(VALOR_PAGO) AS TOTAL from CONTAS_PAGAR "
                "where "
                "STATUS_PAGAMENTO='P' "
                "and " 
                "( "
                "date(DATA_PAGAMENTO, 'unixepoch') "
                "between "
                "date('now','-"+ diasPeriodo + " day') AND date('now') "
                ")";
    final resultado = await customSelect(sql).getSingleOrNull();
    return resultado.data["TOTAL"] ?? 0;
  }

  Future<double> consultarPagamentosVencidos() async {
    final sql = "select SUM(VALOR_PAGO) AS TOTAL from CONTAS_PAGAR "
                "where "
                "STATUS_PAGAMENTO='A' "
                "and " 
                "( "
                "date(DATA_VENCIMENTO, 'unixepoch') "
                "< "
                "date('now') "
                ")";
    final resultado = await customSelect(sql).getSingleOrNull();
    return resultado.data["TOTAL"] ?? 0;
  }

  Future<double> consultarFluxo({String periodo}) async {
    var diasPeriodo;
    if (periodo.contains('Semana')) {
      diasPeriodo = '7';
    } else if (periodo.contains('Mês')) {
      diasPeriodo = '30';
    } else if (periodo.contains('Ano')) {
      diasPeriodo = '360';
    }

    final sql = "select SUM(VALOR_A_PAGAR) AS TOTAL from CONTAS_PAGAR "
                "where "
                "STATUS_PAGAMENTO='A' "
                "and " 
                "( "
                "date(DATA_VENCIMENTO, 'unixepoch') "
                "between "
                "date('now') AND date('now','+"+ diasPeriodo + " day') "
                ")";
    final resultado = await customSelect(sql).getSingleOrNull();
    return resultado.data["TOTAL"] ?? 0;
  }

  Stream<List<ContasPagar>> observarLista() => select(contasPagars).watch();

  Future<ContasPagar> consultarObjeto(int pId) {
    return (select(contasPagars)..where((t) => t.id.equals(pId))).getSingleOrNull();
  } 

  Future<int> inserir(Insertable<ContasPagar> pObjeto) {
    return transaction(() async {
      final idInserido = await into(contasPagars).insert(pObjeto);
      return idInserido;
    });    
  } 

  Future<bool> inserirParcelas(List<ContasPagar> listaParcelas) {
    var retorno = 0;
    if (listaParcelas != null) {
      return transaction(() async {
        for (var objeto in listaParcelas) {
          retorno = await into(contasPagars).insert(objeto);  
        }
        return Future.value(retorno > 0);
      });    
    } else {
      return Future.value(false);
    }
  } 

  Future<bool> alterar(Insertable<ContasPagar> pObjeto) {
    return transaction(() async {
      return update(contasPagars).replace(pObjeto);
    });    
  } 

  Future<int> excluir(Insertable<ContasPagar> pObjeto) {
    return transaction(() async {
      return delete(contasPagars).delete(pObjeto);
    });    
  }

  Future<int> excluirContasDePedidoVinculado(int idPedidoCompra) {
    return transaction(() async {
      return (delete(contasPagars)..where((t) => t.idCompraPedidoCabecalho.equals(idPedidoCompra))).go();
    });    
  }

	static List<String> campos = <String>[
		'ID', 
		'DATA_LANCAMENTO', 
		'DATA_VENCIMENTO', 
		'DATA_PAGAMENTO', 
		'VALOR_A_PAGAR', 
		'TAXA_JURO', 
		'TAXA_MULTA', 
		'TAXA_DESCONTO', 
		'VALOR_JURO', 
		'VALOR_MULTA', 
		'VALOR_DESCONTO', 
		'VALOR_PAGO', 
		'NUMERO_DOCUMENTO', 
		'HISTORICO', 
		'STATUS_PAGAMENTO', 
	];
	
	static List<String> colunas = <String>[
		'Id', 
		'Data de Lançamento', 
		'Data de Vencimento', 
		'Data de Pagamento', 
		'Valor a Pagar', 
		'Taxa Juros', 
		'Taxa Multa', 
		'Taxa Desconto', 
		'Valor Juros', 
		'Valor Multa', 
		'Valor Desconto', 
		'Valor Pago', 
		'Número do Documento', 
		'Histórico', 
		'Status Pagamento', 
	];

  
}