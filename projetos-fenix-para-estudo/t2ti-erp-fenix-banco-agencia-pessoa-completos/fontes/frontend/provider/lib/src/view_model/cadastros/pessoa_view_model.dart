import 'package:flutter/material.dart';

import 'package:fenix/src/infra/locator.dart';
import 'package:fenix/src/model/cadastros/pessoa.dart';
import 'package:fenix/src/model/filtro.dart';
import 'package:fenix/src/model/retorno_json_erro.dart';
import 'package:fenix/src/service/cadastros/pessoa_service.dart';

class PessoaViewModel extends ChangeNotifier {
  PessoaService _pessoaService = locator<PessoaService>();
  List<Pessoa> listaPessoa;
  RetornoJsonErro objetoJsonErro;

  PessoaViewModel() {
    consultarLista();
  }

  Future<List<Pessoa>> consultarLista({Filtro filtro}) async {
    listaPessoa = await _pessoaService.consultarLista(filtro: filtro);
    if (listaPessoa == null) {
      objetoJsonErro = _pessoaService.objetoJsonErro;
    }
    notifyListeners();
    return listaPessoa;
  }

  Future<Pessoa> consultarObjeto(int id) async {
    var result = await _pessoaService.consultarObjeto(id);
    if (result == null) {
      objetoJsonErro = _pessoaService.objetoJsonErro;
    }
    notifyListeners();
    return result;
  }

  Future<Pessoa> inserir(Pessoa pessoa) async {
    var result = await _pessoaService.inserir(pessoa);
    if (result == null) {
      objetoJsonErro = _pessoaService.objetoJsonErro;
    }
    notifyListeners();
    return result;
  }

  Future<Pessoa> alterar(Pessoa pessoa) async {
    var result = await _pessoaService.alterar(pessoa);
    if (result == null) {
      objetoJsonErro = _pessoaService.objetoJsonErro;
    }
    notifyListeners();
    return result;
  }

  Future<bool> excluir(int id) async {
    var result = await _pessoaService.excluir(id);
    if (result == false) {
      objetoJsonErro = _pessoaService.objetoJsonErro;
      notifyListeners();
    } else {
      consultarLista();
    }
    return result;
  }
}