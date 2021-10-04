import 'dart:convert';

class Banco {
  int id;
  String codigo;
  String nome;
  String url;

  Banco({this.id, this.codigo, this.nome, this.url});

  Banco.fromJson(Map<String, dynamic> jsonDados) {
    id = jsonDados['id'];
    codigo = jsonDados['codigo'];
    nome = jsonDados['nome'];
    url = jsonDados['url'];
  }

  Map<String, dynamic> get toJson {
    Map<String, dynamic> jsonDados = new Map<String, dynamic>();
    jsonDados['id'] = this.id ?? 0;
    jsonDados['codigo'] = this.codigo;
    jsonDados['nome'] = this.nome;
    jsonDados['url'] = this.url;
    return jsonDados;
  }
}

String bancoEncodeJson(Banco banco) {
  final jsonDados = banco.toJson;
  return json.encode(jsonDados);
}