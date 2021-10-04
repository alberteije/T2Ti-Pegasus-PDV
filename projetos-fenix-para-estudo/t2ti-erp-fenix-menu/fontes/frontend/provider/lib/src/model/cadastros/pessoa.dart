import 'dart:convert';

import 'pessoa_endereco.dart';
import 'pessoa_telefone.dart';
import 'pessoa_contato.dart';
import 'pessoa_fisica.dart';
import 'pessoa_juridica.dart';

class Pessoa {
  int id;
  String nome;
  String tipo;
  String site;
  String email;
  String cliente;
  String fornecedor;
  String transportadora;
  String colaborador;
  String contador;
  PessoaFisica pessoaFisica;
  PessoaJuridica pessoaJuridica;
  List<PessoaContato> listaPessoaContato = [];
  List<PessoaEndereco> listaPessoaEndereco = [];
  List<PessoaTelefone> listaPessoaTelefone = [];

  Pessoa(
      {this.id,
      this.nome,
      this.tipo = 'Física', // valor padrão para preenchimento no DropdownButton
      this.site,
      this.email,
      this.cliente,
      this.fornecedor,
      this.transportadora,
      this.colaborador,
      this.contador,
      this.pessoaFisica,
      this.pessoaJuridica,
      this.listaPessoaContato,
      this.listaPessoaEndereco,
      this.listaPessoaTelefone});

  static List<String> campos = <String>[
    'ID',
    'NOME',
    'TIPO',
    'SITE',
    'EMAIL',
    'CLIENTE',
    'FORNECEDOR',
    'TRANSPORTADORA',
    'COLABORADOR',
    'CONTADOR'
  ];

  static List<String> colunas = <String>[
    'Id',
    'Nome',
    'Tipo',
    'Site',
    'Email',
    'Cliente',
    'Fornecedor',
    'Transportadora',
    'Colaborador',
    'Contador'
  ];

  Pessoa.fromJson(Map<String, dynamic> jsonDados) {
    id = jsonDados['id'];
    nome = jsonDados['nome'];
    tipo = jsonDados['tipo'] == 'F' ? 'Física' : 'Jurídica'; // DropdownButton //Domains
    site = jsonDados['site'];
    email = jsonDados['email'];
    cliente = jsonDados['cliente'] == 'S' ? 'Sim' : 'Não'; // DropdownButton
    fornecedor = jsonDados['fornecedor'] == 'S' ? 'Sim' : 'Não'; // DropdownButton
    transportadora = jsonDados['transportadora'] == 'S' ? 'Sim' : 'Não'; // DropdownButton
    colaborador = jsonDados['colaborador'] == 'S' ? 'Sim' : 'Não'; // DropdownButton
    contador = jsonDados['contador'] == 'S' ? 'Sim' : 'Não'; // DropdownButton
    pessoaFisica = jsonDados['pessoaFisica'] == null ? null : new PessoaFisica.fromJson(jsonDados['pessoaFisica']);
    pessoaJuridica = jsonDados['pessoaJuridica'] == null ? null : new PessoaJuridica.fromJson(jsonDados['pessoaJuridica']);
    listaPessoaContato = (jsonDados['listaPessoaContato'] as Iterable)?.map((m) => PessoaContato.fromJson(m))?.toList() ?? [];
    listaPessoaEndereco = (jsonDados['listaPessoaEndereco'] as Iterable)?.map((m) => PessoaEndereco.fromJson(m))?.toList() ?? [];
    listaPessoaTelefone = (jsonDados['listaPessoaTelefone'] as Iterable)?.map((m) => PessoaTelefone.fromJson(m))?.toList() ?? [];
  }

  Map<String, dynamic> get toJson {
    Map<String, dynamic> jsonDados = new Map<String, dynamic>();
    jsonDados['id'] = this.id ?? 0;
    jsonDados['nome'] = this.nome;
    jsonDados['tipo'] = this.tipo == 'Física' ? 'F' : 'J'; // DropdownButton
    jsonDados['site'] = this.site;
    jsonDados['email'] = this.email;
    jsonDados['cliente'] = this.cliente == 'Sim' ? 'S' : 'N'; // DropdownButton
    jsonDados['fornecedor'] = this.fornecedor == 'Sim' ? 'S' : 'N'; // DropdownButton
    jsonDados['transportadora'] = this.transportadora == 'Sim' ? 'S' : 'N'; // DropdownButton
    jsonDados['colaborador'] = this.colaborador == 'Sim' ? 'S' : 'N'; // DropdownButton
    jsonDados['contador'] = this.contador == 'Sim' ? 'S' : 'N'; // DropdownButton
    jsonDados['pessoaFisica'] = this.pessoaFisica == null ? null : this.pessoaFisica.toJson;
    jsonDados['pessoaJuridica'] = this.pessoaJuridica == null ? null : this.pessoaJuridica.toJson;

    // contatos
    var listaPessoaContatoLocal = [];
    for (PessoaContato contato in this.listaPessoaContato ?? []) {
      listaPessoaContatoLocal.add(contato.toJson);
    }
    jsonDados['listaPessoaContato'] = listaPessoaContatoLocal;

    // enderecos
    var listaPessoaEnderecoLocal = [];
    for (PessoaEndereco endereco in this.listaPessoaEndereco ?? []) {
      listaPessoaEnderecoLocal.add(endereco.toJson);
    }
    jsonDados['listaPessoaEndereco'] = listaPessoaEnderecoLocal;

    // telefones
    var listaPessoaTelefoneLocal = [];
    for (PessoaTelefone telefone in this.listaPessoaTelefone ?? []) {
      listaPessoaTelefoneLocal.add(telefone.toJson);
    }
    jsonDados['listaPessoaTelefone'] = listaPessoaTelefoneLocal;

    return jsonDados;
  }
}

String objetoEncodeJson(Pessoa objeto) {
  final jsonDados = objeto.toJson;
  return json.encode(jsonDados);
}
