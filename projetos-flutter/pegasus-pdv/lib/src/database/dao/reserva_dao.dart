/*
Title: T2Ti ERP Pegasus                                                                
Description: DAO relacionado à tabela [RESERVA] 
                                                                                
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
import 'package:pegasus_pdv/src/infra/biblioteca.dart';

part 'reserva_dao.g.dart';

@UseDao(tables: [
          Reservas,
          ReservaMesas,
          Mesas,
          Clientes,
		])
class ReservaDao extends DatabaseAccessor<AppDatabase> with _$ReservaDaoMixin {
  final AppDatabase db;

  ReservaDao(this.db) : super(db);

  List<Reserva>? listaReserva; 
  List<ReservaMontado>? listaReservaMontado;
  List<ReservaMesaMontado>? listaReservaMesaMontado;
  
  Future<List<Reserva>?> consultarLista() async {
    listaReserva = await select(reservas).get();
    aplicarDomains();
    return listaReserva;
  }  

  Future<List<Reserva>?> consultarListaFiltro(String campo, String valor) async {
    listaReserva = await (customSelect("SELECT * FROM RESERVA WHERE " + campo + " like '%" + valor + "%'", 
                                readsFrom: { reservas }).map((row) {
                                  return Reserva.fromData(row.data, db);  
                                }).get());
    aplicarDomains();
    return listaReserva;
  }
    
  Future<Reserva?> consultarObjetoFiltro(String campo, String valor) async {
    return (customSelect("SELECT * FROM RESERVA WHERE " + campo + " = '" + valor + "'", 
                                readsFrom: { reservas }).map((row) {
                                  return Reserva.fromData(row.data, db);  
                                }).getSingleOrNull());
  }  
  
  Stream<List<Reserva>> observarLista() => select(reservas).watch();

  Future<Reserva?> consultarObjeto(int pId) {
    return (select(reservas)..where((t) => t.id.equals(pId))).getSingleOrNull();
  } 

  Future<List<Mesa>> consultarListaReservaDia(DateTime diaReserva) async {
    final consulta = select(reservas)
      .join([
        leftOuterJoin(reservaMesas, reservaMesas.idReserva.equalsExp(reservas.id)),
      ]);
    
    consulta.where(reservas.dataReserva.equals(diaReserva));
    consulta.where(reservas.situacao.equals('A'));
    
    listaReservaMesaMontado = await consulta.map((row) {
      final reserva = row.readTableOrNull(reservas);
      final reservaMesa = row.readTableOrNull(reservaMesas);

      return ReservaMesaMontado(
        reserva: reserva,
        reservaMesa: reservaMesa,
      );
    }).get(); 

    // vamos modificar a lista de mesas abaixo, marcando as mesas que já foram reservadas
    List<Mesa> listaMesa = await db.mesaDao.consultarLista(); 
    if (listaReservaMesaMontado != null) {
      for (var reserva in listaReservaMesaMontado!) {
        for (var i = 0; i < listaMesa.length; i++) {
          if (listaMesa[i].id == reserva.reservaMesa!.idMesa) {
            listaMesa[i] = listaMesa[i].copyWith(disponivel: 'N');
          }
        }
      }
    }
    return listaMesa;
  }  

  Future<List<Mesa>> consultarMesasParaComanda() async {
    final consulta = select(reservas)
      .join([
        leftOuterJoin(reservaMesas, reservaMesas.idReserva.equalsExp(reservas.id)),
      ]);
    
    consulta.where(reservas.dataReserva.equals(Biblioteca.removerTempoDaData(DateTime.now())!));
    consulta.where(reservas.situacao.equals('A'));
    
    listaReservaMesaMontado = await consulta.map((row) {
      final reserva = row.readTableOrNull(reservas);
      final reservaMesa = row.readTableOrNull(reservaMesas);

      return ReservaMesaMontado(
        reserva: reserva,
        reservaMesa: reservaMesa,
      );
    }).get(); 

    // vamos modificar a lista de mesas abaixo, marcando as mesas que estão reservadas
    List<Mesa> listaMesa = await db.mesaDao.consultarLista(); 
    if (listaReservaMesaMontado != null) {
      for (var reserva in listaReservaMesaMontado!) {
        for (var i = 0; i < listaMesa.length; i++) {
          if (listaMesa[i].id == reserva.reservaMesa!.idMesa) {
            listaMesa[i] = listaMesa[i].copyWith(disponivel: 'R');
          }
        }
      }
    }
    return listaMesa;
  }  

  Future<List<ReservaMontado>?> consultarListaMontado({String? campo, dynamic valor, required DateTime dataInicio, required DateTime dataFim, required String situacao}) async {
    final consulta = select(reservas)
      .join([
        leftOuterJoin(clientes, clientes.id.equalsExp(reservas.idCliente)),
      ]);

    consulta.where(reservas.dataReserva.isBetweenValues(dataInicio, dataFim));

    switch (situacao) {
      case 'Ativa':
        consulta.where(reservas.situacao.equals('A'));
        break;
      case 'Cancelada':
        consulta.where(reservas.situacao.equals('C'));          
        break;
      case 'Utilizada':
        consulta.where(reservas.situacao.equals('U'));          
        break;
      default:
    }    

    if (campo != null && campo != '') {      
      final coluna = reservas.$columns.where(((coluna) => coluna.$name == campo)).first;
      if (coluna is TextColumn) {
        consulta.where((coluna as TextColumn).like('%'  + valor + '%'));
      } else if (coluna is IntColumn) {
        consulta.where(coluna.equals(int.tryParse(valor)));
      } else if (coluna is RealColumn) {
        consulta.where(coluna.equals(double.tryParse(valor)));
      }
    }

    listaReservaMontado = await consulta.map((row) {
      final reserva = row.readTableOrNull(reservas);
      final cliente = row.readTableOrNull(clientes);

      return ReservaMontado(
        reserva: reserva,
        cliente: cliente,
        listaMesa: [],
      );
    }).get();      
    aplicarDomains();

    // pega as mesas
    for (var reservaMontado in listaReservaMontado!) {
      // primeiro pega os registros da RESERVA_MESA
      final listaReservaMesa = 
      await customSelect("SELECT * FROM RESERVA_MESA WHERE ID_RESERVA = '" + reservaMontado.reserva!.id.toString() + "'", 
        readsFrom: { reservaMesas }).map((row) {
          return ReservaMesa.fromData(row.data, db);  
        }
      ).get();

      // para cada reserva_mesa, pega o registro da mesa
      Mesa? _mesaDaReserva;
      for (var reservaMesa in listaReservaMesa) {
        _mesaDaReserva = await (customSelect("SELECT * FROM MESA WHERE ID = '" + reservaMesa.idMesa.toString() + "'", 
          readsFrom: { mesas }).map((row) {
            return Mesa.fromData(row.data, db);  
          }
        ).getSingleOrNull());
        if (_mesaDaReserva != null) {
          reservaMontado.listaMesa!.add(_mesaDaReserva);
        }
      }
    }

    return listaReservaMontado;
  }

  Future<int> inserir(Insertable<Reserva> pObjeto, List<Mesa> listaMesa) {
    return transaction(() async {
      final reserva = removerDomains(pObjeto as Reserva);
      final idInserido = await into(reservas).insert(reserva);
      await inserirMesas(idInserido, listaMesa);
      return idInserido;
    });    
  } 

  Future<bool> alterar(Insertable<Reserva> pObjeto, List<Mesa> listaMesa) {
    return transaction(() async {
      final reserva = removerDomains(pObjeto as Reserva);
      await excluirMesas(pObjeto.id!);
      await inserirMesas(pObjeto.id!, listaMesa);
      return update(reservas).replace(reserva);
    });    
  } 

  Future<int> excluir(Insertable<Reserva> pObjeto) {
    return transaction(() async {
      await excluirMesas((pObjeto as Reserva).id!);
      return delete(reservas).delete(pObjeto);
    });    
  }

  Future<void> inserirMesas(int idReserva, List<Mesa> listaMesa) async {
    for (var mesa in listaMesa) {
      ReservaMesa reservaMesa = ReservaMesa(id: null, idReserva: idReserva, idMesa: mesa.id);
      await into(reservaMesas).insert(reservaMesa);  
    }
  }
  
  Future<void> excluirMesas(int idReserva) async {
    await (delete(reservaMesas)..where((t) => t.idReserva.equals(idReserva))).go();
  }

  Reserva removerDomains(Reserva reserva) {
    if (reserva.situacao != null) {
      reserva = 
      reserva.copyWith(
        situacao: reserva.situacao!.substring(0,1)
      );
    }
    return reserva;
  }

  void aplicarDomains() {
    if (listaReserva != null) {
      for (var i = 0; i < listaReserva!.length; i++) {
        switch (listaReserva![i].situacao) {
          case 'A' :
            listaReserva![i] = listaReserva![i].copyWith(
              situacao: 'Ativa',);
            break;
          case 'C' :
            listaReserva![i] = listaReserva![i].copyWith(
              situacao: 'Cancelada',);
            break;
          case 'U' :
            listaReserva![i] = listaReserva![i].copyWith(
              situacao: 'Utilizada',);
            break;
          default:
        }       
      }
    }

    if (listaReservaMontado != null) {
      for (var i = 0; i < listaReservaMontado!.length; i++) {
        switch (listaReservaMontado![i].reserva!.situacao) {
          case 'A' :
            listaReservaMontado![i].reserva = listaReservaMontado![i].reserva!.copyWith(
              situacao: 'Ativa',);
            break;
          case 'C' :
            listaReservaMontado![i].reserva = listaReservaMontado![i].reserva!.copyWith(
              situacao: 'Cancelada',);
            break;
          case 'U' :
            listaReservaMontado![i].reserva = listaReservaMontado![i].reserva!.copyWith(
              situacao: 'Utilizada',);
            break;
          default:
        }       
      }
    }
  }

  static List<String> campos = <String>[
    'ID', 
    'DATA_RESERVA', 
    'HORA_RESERVA', 
    'QUANTIDADE_PESSOAS', 
    'NOME_CONTATO', 
    'TELEFONE_CONTATO', 
    'SITUACAO', 
  ];

  static List<String> colunas = <String>[
    'Id', 
    'Data Reserva', 
    'Hora Reserva', 
    'Quantidade de Pessoas', 
    'Contato', 
    'Telefone', 
    'Situação', 
  ];  
}