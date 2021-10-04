import 'dart:convert';

/// classe transiente para enviar os dados do filtro para o servidor
class Filtro {
  String campo;
  String valor;
  String dataInicial;
  String dataFinal;

  Filtro({this.campo, this.valor, this.dataInicial, this.dataFinal});

  Filtro.fromJson(Map<String, dynamic> jsonDados) {
    campo = jsonDados['campo'];
    valor = jsonDados['valor'];
    dataInicial = jsonDados['dataInicial'];
    dataFinal = jsonDados['dataFinal'];
  }

  Map<String, dynamic> get toJson {
    Map<String, dynamic> jsonDados = new Map<String, dynamic>();
    jsonDados['campo'] = this.campo;
    jsonDados['valor'] = this.valor;
    jsonDados['dataInicial'] = this.dataInicial;
    jsonDados['dataFinal'] = this.dataFinal;
    return jsonDados;
  }
}

String filtroEncodeJson(Filtro filtro) {
  final jsonDados = filtro.toJson;
  return json.encode(jsonDados);
}