import 'dart:convert';

class PessoaContato {
  int id;
  int idPessoa;
  String nome;
  String email;
  String observacao;

  PessoaContato(
      {this.id, this.idPessoa, this.nome, this.email, this.observacao});

  static List<String> campos = <String>['ID', 'NOME', 'EMAIL', 'OBSERVACAO'];

  static List<String> colunas = <String>['Id', 'Nome', 'Email', 'Observacao'];

  PessoaContato.fromJson(Map<String, dynamic> jsonDados) {
    id = jsonDados['id'];
    idPessoa = jsonDados['idPessoa'];
    nome = jsonDados['nome'];
    email = jsonDados['email'];
    observacao = jsonDados['observacao'];
  }

  Map<String, dynamic> get toJson {
    Map<String, dynamic> jsonDados = new Map<String, dynamic>();
    jsonDados['id'] = this.id ?? 0;
    jsonDados['idPessoa'] = this.idPessoa ?? 0;
    jsonDados['nome'] = this.nome;
    jsonDados['email'] = this.email;
    jsonDados['observacao'] = this.observacao;
    return jsonDados;
  }
}

String objetoEncodeJson(PessoaContato objeto) {
  final jsonDados = objeto.toJson;
  return json.encode(jsonDados);
}
