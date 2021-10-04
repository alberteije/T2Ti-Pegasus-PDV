import 'dart:convert';

class PessoaEndereco {
  int id;
  int idPessoa;
  String logradouro;
  String numero;
  String bairro;
  int municipioIbge;
  String uf;
  String cep;
  String cidade;
  String complemento;
  String principal;
  String entrega;
  String cobranca;
  String correspondencia;

  PessoaEndereco(
      {this.id,
      this.idPessoa,
      this.logradouro,
      this.numero,
      this.bairro,
      this.municipioIbge,
      this.uf,
      this.cep,
      this.cidade,
      this.complemento,
      this.principal,
      this.entrega,
      this.cobranca,
      this.correspondencia});

  static List<String> campos = <String>[
    'ID',
    'LOGRADOURO',
    'NUMERO',
    'BAIRRO',
    'MUNICIPIO_IBGE',
    'UF',
    'CEP',
    'CIDADE',
    'COMPLEMENTO',
    'PRINCIPAL',
    'ENTREGA',
    'COBRANCA',
    'CORRESPONDENCIA',
  ];

  static List<String> colunas = <String>[
    'Id',
    'Logradouro',
    'Numero',
    'Bairro',
    'Municipio Ibge',
    'Uf',
    'Cep',
    'Cidade',
    'Complemento',
    'Principal',
    'Entrega',
    'Cobranca',
    'Correspondencia',
  ];

  PessoaEndereco.fromJson(Map<String, dynamic> jsonDados) {
    id = jsonDados['id'];
    idPessoa = jsonDados['idPessoa'];
    logradouro = jsonDados['logradouro'];
    numero = jsonDados['numero'];
    bairro = jsonDados['bairro'];
    municipioIbge = jsonDados['municipioIbge'];
    uf = jsonDados['uf'];
    cep = jsonDados['cep'];
    cidade = jsonDados['cidade'];
    complemento = jsonDados['complemento'];
    principal = jsonDados['principal'] == 'S' ? 'Sim' : 'Não'; // DropdownButton
    entrega = jsonDados['entrega'] == 'S' ? 'Sim' : 'Não'; // DropdownButton
    cobranca = jsonDados['cobranca'] == 'S' ? 'Sim' : 'Não'; // DropdownButton
    correspondencia =
        jsonDados['correspondencia'] == 'S' ? 'Sim' : 'Não'; // DropdownButton
  }

  Map<String, dynamic> get toJson {
    Map<String, dynamic> jsonDados = new Map<String, dynamic>();
    jsonDados['id'] = this.id ?? 0;
    jsonDados['idPessoa'] = this.idPessoa ?? 0;
    jsonDados['logradouro'] = this.logradouro;
    jsonDados['numero'] = this.numero;
    jsonDados['bairro'] = this.bairro;
    jsonDados['municipioIbge'] = this.municipioIbge ?? 0;
    jsonDados['uf'] = this.uf;
    jsonDados['cep'] = this.cep;
    jsonDados['cidade'] = this.cidade;
    jsonDados['complemento'] = this.complemento;
    jsonDados['principal'] = this.principal == 'Sim' ? 'S' : 'N'; // DropdownButton
    jsonDados['entrega'] = this.entrega == 'Sim' ? 'S' : 'N'; // DropdownButton
    jsonDados['cobranca'] = this.cobranca == 'Sim' ? 'S' : 'N'; // DropdownButton
    jsonDados['correspondencia'] = this.correspondencia == 'Sim' ? 'S' : 'N'; // DropdownButton    
    return jsonDados;
  }
}

String objetoEncodeJson(PessoaEndereco objeto) {
  final jsonDados = objeto.toJson;
  return json.encode(jsonDados);
}
