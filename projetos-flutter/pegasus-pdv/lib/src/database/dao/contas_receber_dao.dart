/*
Title: T2Ti ERP Pegasus                                                                
Description: DAO relacionado à tabela [CONTAS_RECEBER] 
                                                                                
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

part 'contas_receber_dao.g.dart';

@UseDao(tables: [
          ContasRecebers,
          Clientes,
		])
class ContasReceberDao extends DatabaseAccessor<AppDatabase> with _$ContasReceberDaoMixin {
  final AppDatabase db;

  List<ContasReceber> listaContasReceber; // será usada para popular a grid na janela do contasReceber
  List<ContasReceberMontado> listaContasReceberMontado; // será usada para popular a grid na janela do contas a receber, pois leva o cliente

  ContasReceberDao(this.db) : super(db);

  Future<List<ContasReceber>> consultarLista() async {
    listaContasReceber = await select(contasRecebers).get();
    return listaContasReceber;
  }

  Future<List<ContasReceber>> consultarListaFiltro(String campo, String valor) async {
    listaContasReceber = await (customSelect("SELECT * FROM CONTAS_RECEBER WHERE " + campo + " like '%" + valor + "%'", 
                                readsFrom: { contasRecebers }).map((row) {
                                  return ContasReceber.fromData(row.data, db);  
                                }).get());
    return listaContasReceber;
  }

  Future<List<ContasReceber>> consultarRecebimentosDeUmaVenda(int idPdvVendaCabecalho, String status) async {
    listaContasReceber = await (customSelect("SELECT * FROM CONTAS_RECEBER WHERE ID_PDV_VENDA_CABECALHO = " 
                                + idPdvVendaCabecalho.toString() + " AND STATUS_RECEBIMENTO =  '" + status + "'", 
                                readsFrom: { contasRecebers }).map((row) {
                                  return ContasReceber.fromData(row.data, db);  
                                }).get());
    return listaContasReceber;
  }
  Future<List<ContasReceberMontado>> consultarListaMontado({int mes, int ano, String status}) async {
    final consulta = select(contasRecebers)
      .join([
        leftOuterJoin(clientes, clientes.id.equalsExp(contasRecebers.idCliente)),
      ]);
    
    if (mes != null && ano != null) {
      consulta.where(contasRecebers.dataVencimento.month.equals(mes));
      consulta.where(contasRecebers.dataVencimento.year.equals(ano));
    }

    if (status != null) {
      switch (status) {
        case 'Receber':
          consulta.where(contasRecebers.statusRecebimento.equals('A'));
          break;
        case 'Recebido':
          consulta.where(contasRecebers.statusRecebimento.equals('R'));          
          break;
        default:
      }
    }

    listaContasReceberMontado = await consulta.map((row) {
        final contasReceber = row.readTableOrNull(contasRecebers);
        final cliente = row.readTableOrNull(clientes);

        return ContasReceberMontado(
          contasReceber: contasReceber,
          cliente: cliente,
        );
      }).get();
    return listaContasReceberMontado;
  }

  Future<double> consultarReceitas({String periodo}) async {
    var diasPeriodo;
    if (periodo.contains('Semana')) {
      diasPeriodo = '7';
    } else if (periodo.contains('Mês')) {
      diasPeriodo = '30';
    } else if (periodo.contains('Ano')) {
      diasPeriodo = '360';
    }
    final sql = "select SUM(VALOR_RECEBIDO) AS TOTAL from CONTAS_RECEBER "
                "where "
                "STATUS_RECEBIMENTO='R' "
                "and " 
                "( "
                "date(DATA_RECEBIMENTO, 'unixepoch') "
                "between "
                "date('now','-" + diasPeriodo + " day') AND date('now') "
                ")";
    final resultado = await customSelect(sql).getSingleOrNull();
    return resultado.data["TOTAL"] ?? 0;
  }

  Future<double> consultarRecebimentosVencidos() async {
    final sql = "select SUM(VALOR_RECEBIDO) AS TOTAL from CONTAS_RECEBER "
                "where "
                "STATUS_RECEBIMENTO='A' "
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

    final sql = "select SUM(VALOR_A_RECEBER) AS TOTAL from CONTAS_RECEBER "
                "where "
                "STATUS_RECEBIMENTO='A' "
                "and " 
                "( "
                "date(DATA_VENCIMENTO, 'unixepoch') "
                "between "
                "date('now') AND date('now','+"+ diasPeriodo + " day') "
                ")";
    final resultado = await customSelect(sql).getSingleOrNull();
    return resultado.data["TOTAL"] ?? 0;
  }

  Stream<List<ContasReceber>> observarLista() => select(contasRecebers).watch();

  Future<ContasReceber> consultarObjeto(int pId) {
    return (select(contasRecebers)..where((t) => t.id.equals(pId))).getSingleOrNull();
  } 

  Future<int> inserir(Insertable<ContasReceber> pObjeto) {
    return transaction(() async {
      final idInserido = await into(contasRecebers).insert(pObjeto);
      return idInserido;
    });    
  } 

  Future<bool> inserirParcelas(List<ContasReceber> listaParcelas) {
    var retorno = 0;
    if (listaParcelas != null) {
      return transaction(() async {
        for (var objeto in listaParcelas) {
          retorno = await into(contasRecebers).insert(objeto);  
        }
        return Future.value(retorno > 0);
      });    
    } else {
      return Future.value(false);
    }
  } 

  Future<bool> alterar(Insertable<ContasReceber> pObjeto) {
    return transaction(() async {
      return update(contasRecebers).replace(pObjeto);
    });    
  } 

  Future<int> excluir(Insertable<ContasReceber> pObjeto) {
    return transaction(() async {
      return delete(contasRecebers).delete(pObjeto);
    });    
  }

  Future<int> excluirReceitasDeUmaVenda(int idPdvVendaCabecalho) async {
    return await (delete(contasRecebers)..where((t) => t.idPdvVendaCabecalho.equals(idPdvVendaCabecalho))).go();
  }

	static List<String> campos = <String>[
		'ID', 
		'DATA_LANCAMENTO', 
		'DATA_VENCIMENTO', 
		'DATA_PAGAMENTO', 
		'VALOR_A_RECEBER', 
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
		'Data de Recebimento', 
		'Valor a Receber', 
		'Taxa Juros', 
		'Taxa Multa', 
		'Taxa Desconto', 
		'Valor Juros', 
		'Valor Multa', 
		'Valor Desconto', 
		'Valor Recebido', 
		'Número do Documento', 
		'Histórico', 
		'Status Recebimento', 
	];

  
}