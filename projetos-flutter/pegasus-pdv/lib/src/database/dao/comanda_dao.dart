/*
Title: T2Ti ERP Pegasus                                                                
Description: DAO relacionado à tabela [COMANDA] 
                                                                                
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

part 'comanda_dao.g.dart';

@UseDao(tables: [
          Comandas,
          ComandaDetalhes,
          ComandaDetalheComplementos,
          ComandaPedidos,
          Deliverys,
          Clientes,
          Colaboradors,
          Mesas,
		])
class ComandaDao extends DatabaseAccessor<AppDatabase> with _$ComandaDaoMixin {
  final AppDatabase db;

  ComandaDao(this.db) : super(db);

  List<Comanda> listaComanda = []; 
  List<ComandaMontado> listaComandaMontado = []; 
  
  Future<List<Comanda>> consultarLista() async {
    listaComanda = await select(comandas).get();
    return listaComanda;
  }  

  Future<List<Comanda>> consultarListaFiltro(String campo, String valor) async {
    listaComanda = await (customSelect("SELECT * FROM COMANDA WHERE " + campo + " like '%" + valor + "%'", 
                                readsFrom: { comandas }).map((row) {
                                  return Comanda.fromData(row.data, db);  
                                }).get());
    return listaComanda;
  }

  Future<List<Comanda>> consultarComandasPorMesa(int idMesa) async {
    listaComanda = await (customSelect("SELECT * FROM COMANDA WHERE ID_MESA = '" + idMesa.toString() + "'", 
                                readsFrom: { comandas }).map((row) {
                                  return Comanda.fromData(row.data, db);  
                                }).get());
    return listaComanda;
  }

  Future<List<ComandaMontado>> consultarListaMontado({required int idMesa, required int codigoCompartilhado, required String situacao}) async {
    listaComandaMontado.clear();

    String sql = "SELECT * FROM COMANDA WHERE ID_MESA = '" + idMesa.toString() + "'";
    if (codigoCompartilhado > 0) {
      sql += " and CODIGO_COMPARTILHADO = '" + codigoCompartilhado.toString() + "'";
    }
    sql += " and SITUACAO = '" + situacao + "'";

    listaComanda = await (customSelect(sql, 
                                readsFrom: { comandas }).map((row) {
                                  return Comanda.fromData(row.data, db);  
                                }).get());

    for (var comanda in listaComanda) {
      ComandaMontado comandaMontado = ComandaMontado(
        comanda: comanda,

        // pega o cliente
        cliente: await (customSelect("SELECT * FROM CLIENTE WHERE ID = '" + comanda.idCliente.toString() + "'", 
                                readsFrom: { clientes }).map((row) {
                                  return Cliente.fromData(row.data, db);  
                                }).getSingleOrNull()),       

        // pega o colaborador
        colaborador: await (customSelect("SELECT * FROM COLABORADOR WHERE ID = '" + comanda.idColaborador.toString() + "'", 
                                readsFrom: { colaboradors }).map((row) {
                                  return Colaborador.fromData(row.data, db);  
                                }).getSingleOrNull()),       

        //pesa a mesa
        mesa: await (customSelect("SELECT * FROM MESA WHERE ID = '" + comanda.idMesa.toString() + "'", 
                                readsFrom: { mesas }).map((row) {
                                  return Mesa.fromData(row.data, db);  
                                }).getSingleOrNull()),       

        // pega os detalhes
        listaComandaDetalheMontado: await db.comandaDetalheDao.consultarListaMontado(comanda.id!),

      );
      listaComandaMontado.add(comandaMontado);
    }

    return listaComandaMontado;
  }

  Future<List<ComandaMontado>?> consultarListaMontadoPeriodo({String? campo, dynamic valor, required DateTime dataInicio, required DateTime dataFim, required String tipo}) async {
    final consulta = select(comandas)
      .join([
        leftOuterJoin(mesas, mesas.id.equalsExp(comandas.idMesa)),
      ])
      .join([
        leftOuterJoin(colaboradors, colaboradors.id.equalsExp(comandas.idColaborador)),
      ])
      .join([
        leftOuterJoin(clientes, clientes.id.equalsExp(comandas.idCliente)),
      ]);

    consulta.where(comandas.dataChegada.isBetweenValues(dataInicio, dataFim));

    switch (tipo) {
      case 'Indoor':
        consulta.where(comandas.tipo.equals('I'));
        break;
      case 'Takeout':
        consulta.where(comandas.tipo.equals('T'));          
        break;
      case 'Delivery':
        consulta.where(comandas.tipo.equals('D'));          
        break;
      default:
    }    

    if (campo != null && campo != '') {      
      final coluna = comandas.$columns.where(((coluna) => coluna.$name == campo)).first;
      if (coluna is TextColumn) {
        consulta.where((coluna as TextColumn).like('%'  + valor + '%'));
      } else if (coluna is IntColumn) {
        consulta.where(coluna.equals(int.tryParse(valor)));
      } else if (coluna is RealColumn) {
        consulta.where(coluna.equals(double.tryParse(valor)));
      }
    }

    listaComandaMontado = await consulta.map((row) {
      final comanda = row.readTableOrNull(comandas);
      final cliente = row.readTableOrNull(clientes);
      final colaborador = row.readTableOrNull(colaboradors);
      final mesa = row.readTableOrNull(mesas);

      return ComandaMontado(
        comanda: comanda,
        cliente: cliente,
        colaborador: colaborador,
        mesa: mesa,
        listaComandaDetalheMontado: [],
      );
    }).get();      

    return listaComandaMontado;
  }

  Future<Comanda?> consultarObjetoFiltro(String campo, String valor) async {
    return (customSelect("SELECT * FROM COMANDA WHERE " + campo + " = '" + valor + "'", 
                                readsFrom: { comandas }).map((row) {
                                  return Comanda.fromData(row.data, db);  
                                }).getSingleOrNull());
  }  
  
  Stream<List<Comanda>> observarLista() => select(comandas).watch();

  Future<Comanda?> consultarObjeto(int pId) {
    return (select(comandas)..where((t) => t.id.equals(pId))).getSingleOrNull();
  } 

  Future<Comanda?> inserir(ComandaMontado pObjeto) {
    return transaction(() async {
      final idInserido = await into(comandas).insert(pObjeto.comanda!);
      await inserirFilhos(pObjeto);
      return consultarObjeto(idInserido);
    });    
  } 

  Future<bool> alterar(ComandaMontado pObjeto) {
    return transaction(() async {
      await excluirFilhos(pObjeto);
      await inserirFilhos(pObjeto);
      return update(comandas).replace(pObjeto.comanda!);
    });    
  } 

  Future<bool> excluir(ComandaMontado pObjeto) {
    return transaction(() async {
      // await excluirFilhos(pObjeto);
      // return delete(comandas).delete(pObjeto.comanda!);
      return update(comandas).replace(pObjeto.comanda!);
    });    
  }

  Future<void> inserirFilhos(ComandaMontado comandaMontado) async {
    for (var comandaDetalheMontado in comandaMontado.listaComandaDetalheMontado ?? []) {
      comandaDetalheMontado.comandaDetalhe = comandaDetalheMontado.comandaDetalhe.copyWith(idComanda: comandaMontado.comanda!.id); 
      final idDetalhe = await into(comandaDetalhes).insert(comandaDetalheMontado.comandaDetalhe);  
      for (var complemento in comandaDetalheMontado.listaComandaDetalheComplemento) {
        complemento = complemento.copyWith(idComandaDetalhe: idDetalhe);
        await into(comandaDetalheComplementos).insert(complemento);  
      }
    }
  }
  
  Future<void> excluirFilhos(ComandaMontado comandaMontado) async {
    for (var comandaDetalheMontado in comandaMontado.listaComandaDetalheMontado!) {
      await (delete(comandaDetalheComplementos)..where((t) => t.idComandaDetalhe.equals(comandaDetalheMontado.comandaDetalhe!.id ?? 0))).go();
    }
    await (delete(comandaDetalhes)..where((t) => t.idComanda.equals(comandaMontado.comanda!.id!))).go();
  }

  static List<String> campos = <String>[
    'ID', 
    'NUMERO', 
    'DATA_CHEGADA', 
    'HORA_CHEGADA', 
    'DATA_SAIDA', 
    'HORA_SAIDA', 
    'TOTAL', 
    'TIPO', 
    'QUANTIDADE_PESSOAS', 
    'VALOR_POR_PESSOA', 
  ];

  static List<String> colunas = <String>[
    'Id', 
    'Número', 
    'Data da Chegada', 
    'Hora da Chegada', 
    'Data da Saída', 
    'Hora da Saída', 
    'Valor Total', 
    'Tipo', 
    'Quantidade de Pessoas', 
    'Valor por Pessoa', 
  ];  
}