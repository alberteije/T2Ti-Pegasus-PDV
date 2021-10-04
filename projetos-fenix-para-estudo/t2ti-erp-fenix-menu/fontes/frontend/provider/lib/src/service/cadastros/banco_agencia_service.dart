import 'dart:convert';
import 'package:http/http.dart' show Client;

import 'package:fenix/src/service/service_base.dart';
import 'package:fenix/src/model/filtro.dart';
import 'package:fenix/src/model/cadastros/banco_agencia.dart';

/// classe responsável por requisições ao servidor REST
class BancoAgenciaService extends ServiceBase {
  var cliente = Client();

  Future<List<BancoAgencia>> consultarLista({Filtro filtro}) async {
    var listaBancoAgencia = List<BancoAgencia>();

    tratarFiltro(filtro, '/banco-agencia/');
    final response = await cliente.get(url);

    if (response.statusCode == 200) {
      var parsed = json.decode(response.body) as List<dynamic>;
      for (var bancoAgencia in parsed) {
        listaBancoAgencia.add(BancoAgencia.fromJson(bancoAgencia));
      }
      return listaBancoAgencia;
    } else {
      tratarRetorno(json.decode(response.body));
      return null;
    }
  }

  Future<BancoAgencia> consultarObjeto(int id) async {
    final response = await cliente.get('$endpoint/banco-agencia/$id');

    if (response.statusCode == 200) {
      var bancoAgenciaJson = json.decode(response.body);
      return BancoAgencia.fromJson(bancoAgenciaJson);
    } else {
      tratarRetorno(json.decode(response.body));
      return null;
    }
  }

  Future<BancoAgencia> inserir(BancoAgencia bancoAgencia) async {
    final response = await cliente.post(
      '$endpoint/banco-agencia',
      headers: {"content-type": "application/json"},
      body: objetoEncodeJson(bancoAgencia),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      var bancoAgenciaJson = json.decode(response.body);
      return BancoAgencia.fromJson(bancoAgenciaJson);
    } else {
      tratarRetorno(json.decode(response.body));
      return null;
    }
  }

  Future<BancoAgencia> alterar(BancoAgencia bancoAgencia) async {
    var id = bancoAgencia.id;
    final response = await cliente.put(
      '$endpoint/banco-agencia/$id',
      headers: {"content-type": "application/json"},
      body: objetoEncodeJson(bancoAgencia),
    );

    if (response.statusCode == 200) {
      var bancoAgenciaJson = json.decode(response.body);
      return BancoAgencia.fromJson(bancoAgenciaJson);
    } else {
      tratarRetorno(json.decode(response.body));
      return null;
    }
  }

  Future<bool> excluir(int id) async {
    final response = await cliente.delete(
      '$endpoint/banco-agencia/$id',
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