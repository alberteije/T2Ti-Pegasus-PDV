class PessoaContato implements Comparable<PessoaContato> {
  PessoaContato();

  String 
        _id,
        _idPessoa,
        _nome,
        _email,
        _observacao;

  String get id => _id;
  set id(String value){
    if (value == null) value = "";
    _id = value;
  }

  String get idPessoa => _idPessoa;
  set idPessoa(String value){
    if (value == null) value = "";
    _idPessoa = value;
  }

  String get nome => _nome;
  set nome(String value){
    if (value == null) value = "";
    _nome = value;
  }

  String get email => _email;
  set email(String value){
    if (value == null) value = "";
    _email = value;
  }

  String get observacao => _observacao;
  set observacao(String value){
    if (value == null) value = "";
    _observacao = value;
  }

  PessoaContato.fromMap(Map m) {
    id = m["id"];
    idPessoa = m["idPessoa"];
    nome = m["nome"];
    email = m["email"];
    observacao = m["observacao"];
  }

  Map<String, dynamic> get toMap {
    return {
      "id": _id,
      "idPessoa": _idPessoa,
      "nome": _nome,
      "email": _email,
      "observacao": _observacao, 
    };
  }
  
  @override
  int compareTo(PessoaContato other) => _nome.toLowerCase().compareTo(other._nome.toLowerCase());  
}