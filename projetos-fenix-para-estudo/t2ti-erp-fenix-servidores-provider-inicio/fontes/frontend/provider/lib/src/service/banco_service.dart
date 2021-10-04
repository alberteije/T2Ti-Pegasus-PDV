import 'dart:convert';

import 'package:fenix/src/model/filtro.dart';
import 'package:fenix/src/service/service_base.dart';
import 'package:http/http.dart' show Client;
import 'package:fenix/src/model/banco.dart';

/// classe responsável por requisições ao servidor REST
class BancoService extends ServiceBase {
  var cliente = Client();

  Future<List<Banco>> consultarLista({Filtro filtro}) async {
    var listaBanco = List<Banco>();

    // faz o tratamento do filtro
    tratarFiltro(filtro, '/banco');

    // faz o tratamento do retorno
    final response = await cliente.get(url);

    if (response.statusCode == 200) {
      // faz o parse para lista
      var parsed = json.decode(response.body) as List<dynamic>;
      // loop para converter cada item para o Objeto
      for (var banco in parsed) {
        listaBanco.add(Banco.fromJson(banco));
      }
      return listaBanco;
    } else {
      tratarRetorno(json.decode(response.body));
      return null;
    }
  }

  Future<Banco> consultarObjeto(int id) async {
    // pega o objeto no servidor pelo Id
    final response = await cliente.get('$endpoint/banco/$id');

    if (response.statusCode == 200) {
      // converte o response de JSON para objeto
      var bancoJson = json.decode(response.body);

      // retorno o objeto convertido
      return Banco.fromJson(bancoJson);
    } else {
      tratarRetorno(json.decode(response.body));
      return null;
    }
  }

  Future<Banco> inserir(Banco banco) async {
    final response = await cliente.post(
      '$endpoint/banco',
      headers: {"content-type": "application/json"},
      body: bancoEncodeJson(banco),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      var bancoJson = json.decode(response.body);
      return Banco.fromJson(bancoJson);
    } else {
      tratarRetorno(json.decode(response.body));
      return null;
    }
  }

  Future<Banco> alterar(Banco banco) async {
    final response = await cliente.put(
      '$endpoint/banco',
      headers: {"content-type": "application/json"},
      body: bancoEncodeJson(banco),
    );

    if (response.statusCode == 200) {
      var bancoJson = json.decode(response.body);
      return Banco.fromJson(bancoJson);
    } else {
      tratarRetorno(json.decode(response.body));
      return null;
    }
  }

  Future<bool> excluir(int id) async {
    final response = await cliente.delete(
      '$endpoint/banco/$id',
      headers: {"content-type": "application/json"},
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      tratarRetorno(json.decode(response.body));
      return false;
    }
  }
}