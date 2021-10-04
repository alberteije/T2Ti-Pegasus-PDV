import 'dart:convert';

class PessoaTelefone {
  int id;
  int idPessoa;
  String tipo;
  String numero;

  PessoaTelefone(
      {this.id, this.idPessoa, this.tipo, this.numero});

  static List<String> campos = <String>['ID', 'TIPO', 'NUMERO'];

  static List<String> colunas = <String>['Id', 'tipo', 'numero'];

  PessoaTelefone.fromJson(Map<String, dynamic> jsonDados) {
    id = jsonDados['id'];
    idPessoa = jsonDados['idPessoa'];
    tipo = getTipo(jsonDados['tipo']); // DropdownButton
    numero = jsonDados['numero'];
  }

  Map<String, dynamic> get toJson {
    Map<String, dynamic> jsonDados = new Map<String, dynamic>();
    jsonDados['id'] = this.id ?? 0;
    jsonDados['idPessoa'] = this.idPessoa ?? 0;
    jsonDados['tipo'] = setTipo(this.tipo); // DropdownButton
    jsonDados['numero'] = this.numero;
    return jsonDados;
  }

  getTipo(String tipo) {
    switch (tipo) {
      case '0':
        return 'Residencial';
        break;
      case '1':
        return 'Comercial';
        break;
      case '2':
        return 'Celular';
        break;
      case '3':
        return 'Outro';
        break;
      default:
        return null;
    }
  }

  setTipo(String tipo) {
    switch (tipo) {
      case 'Residencial':
        return '0';
        break;
      case 'Comercial':
        return '1';
        break;
      case 'Celular':
        return '2';
        break;
      case 'Outro':
        return '3';
        break;
      default:
        return null;
    }
  } 

}

String objetoEncodeJson(PessoaTelefone objeto) {
  final jsonDados = objeto.toJson;
  return json.encode(jsonDados);
}