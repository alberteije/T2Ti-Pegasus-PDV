import 'package:flutter/material.dart';

import 'package:fenix/src/infra/locator.dart';
import 'package:fenix/src/model/cadastros/banco_agencia.dart';
import 'package:fenix/src/model/filtro.dart';
import 'package:fenix/src/model/retorno_json_erro.dart';
import 'package:fenix/src/service/cadastros/banco_agencia_service.dart';

class BancoAgenciaViewModel extends ChangeNotifier {
  BancoAgenciaService _bancoAgenciaService = locator<BancoAgenciaService>();
  List<BancoAgencia> listaBancoAgencia;
  RetornoJsonErro objetoJsonErro;

  BancoAgenciaViewModel() {
    consultarLista();
  }

  Future<List<BancoAgencia>> consultarLista({Filtro filtro}) async {
    listaBancoAgencia = await _bancoAgenciaService.consultarLista(filtro: filtro);
    if (listaBancoAgencia == null) {
      objetoJsonErro = _bancoAgenciaService.objetoJsonErro;
    }
    notifyListeners();
    return listaBancoAgencia;
  }

  Future<BancoAgencia> consultarObjeto(int id) async {
    var result = await _bancoAgenciaService.consultarObjeto(id);
    if (result == null) {
      objetoJsonErro = _bancoAgenciaService.objetoJsonErro;
    }
    notifyListeners();
    return result;
  }

  Future<BancoAgencia> inserir(BancoAgencia bancoAgencia) async {
    var result = await _bancoAgenciaService.inserir(bancoAgencia);
    if (result == null) {
      objetoJsonErro = _bancoAgenciaService.objetoJsonErro;
    }
    notifyListeners();
    return result;
  }

  Future<BancoAgencia> alterar(BancoAgencia bancoAgencia) async {
    var result = await _bancoAgenciaService.alterar(bancoAgencia);
    if (result == null) {
      objetoJsonErro = _bancoAgenciaService.objetoJsonErro;
    }
    notifyListeners();
    return result;
  }

  Future<bool> excluir(int id) async {
    var result = await _bancoAgenciaService.excluir(id);
    if (result == false) {
      objetoJsonErro = _bancoAgenciaService.objetoJsonErro;
      notifyListeners();
    } else {
      consultarLista();
    }
    return result;
  }
}