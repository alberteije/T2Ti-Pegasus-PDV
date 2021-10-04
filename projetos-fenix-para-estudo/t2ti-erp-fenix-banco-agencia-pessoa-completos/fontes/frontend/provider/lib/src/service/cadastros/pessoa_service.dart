import 'dart:convert';
import 'package:http/http.dart' show Client;

import 'package:fenix/src/service/service_base.dart';
import 'package:fenix/src/model/filtro.dart';
import 'package:fenix/src/model/cadastros/pessoa.dart';

/// classe responsável por requisições ao servidor REST
class PessoaService extends ServiceBase {
  var cliente = Client();

  Future<List<Pessoa>> consultarLista({Filtro filtro}) async {
    var listaPessoa = List<Pessoa>();

    tratarFiltro(filtro, '/pessoa/');
    final response = await cliente.get(url);

    if (response.statusCode == 200) {
      var parsed = json.decode(response.body) as List<dynamic>;
      for (var pessoa in parsed) {
        listaPessoa.add(Pessoa.fromJson(pessoa));
      }
      return listaPessoa;
    } else {
      tratarRetorno(json.decode(response.body));
      return null;
    }
  }

  Future<Pessoa> consultarObjeto(int id) async {
    final response = await cliente.get('$endpoint/pessoa/$id');

    if (response.statusCode == 200) {
      var pessoaJson = json.decode(response.body);
      return Pessoa.fromJson(pessoaJson);
    } else {
      tratarRetorno(json.decode(response.body));
      return null;
    }
  }

  Future<Pessoa> inserir(Pessoa pessoa) async {
    final response = await cliente.post(
      '$endpoint/pessoa',
      headers: {"content-type": "application/json"},
      body: objetoEncodeJson(pessoa),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      var pessoaJson = json.decode(response.body);
      return Pessoa.fromJson(pessoaJson);
    } else {
      tratarRetorno(json.decode(response.body));
      return null;
    }
  }

  Future<Pessoa> alterar(Pessoa pessoa) async {
    var id = pessoa.id;
    final response = await cliente.put(
      '$endpoint/pessoa/$id',
      headers: {"content-type": "application/json"},
      body: objetoEncodeJson(pessoa),
    );

    if (response.statusCode == 200) {
      var pessoaJson = json.decode(response.body);
      return Pessoa.fromJson(pessoaJson);
    } else {
      tratarRetorno(json.decode(response.body));
      return null;
    }
  }

  Future<bool> excluir(int id) async {
    final response = await cliente.delete(
      '$endpoint/pessoa/$id',
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