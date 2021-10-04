class Pessoa implements Comparable<Pessoa> {
  Pessoa();

  String 
        _id,
        _nome,
        _tipo,
        _site,
        _email,
        _cliente,
        _fornecedor,
        _transportadora,
        _colaborador,
        _contador;

  String get id => _id;
  set id(String value){
    if (value == null) value = "";
    _id = value;
  }

  String get nome => _nome;
  set nome(String value){
    if (value == null) value = "";
    _nome = value;
  }

  String get tipo => _tipo;
  set tipo(String value){
    if (value == null) value = "";
    _tipo = value;
  }

  String get site => _site;
  set site(String value){
    if (value == null) value = "";
    _site = value;
  }

  String get email => _email;
  set email(String value){
    if (value == null) value = "";
    _email = value;
  }

  String get cliente => _cliente;
  set cliente(String value){
    if (value == null) value = "";
    _cliente = value;
  }

  String get fornecedor => _fornecedor;
  set fornecedor(String value){
    if (value == null) value = "";
    _fornecedor = value;
  }

  String get transportadora => _transportadora;
  set transportadora(String value){
    if (value == null) value = "";
    _transportadora = value;
  }

  String get colaborador => _colaborador;
  set colaborador(String value){
    if (value == null) value = "";
    _colaborador = value;
  }

  String get contador => _contador;
  set contador(String value){
    if (value == null) value = "";
    _contador = value;
  }

  Pessoa.fromMap(Map m) {
    id = m["id"];
    nome = m["nome"];
    tipo = m["tipo"];
    site = m["site"];
    email = m["email"];
    cliente = m["cliente"];
    fornecedor = m["fornecedor"];
    transportadora = m["transportadora"];
    colaborador = m["colaborador"];
    contador = m["contador"];
  }

  Map<String, dynamic> get toMap {
    return {
      "id": _id,
      "nome": _nome,
      "tipo": _tipo,
      "site": _site,
      "email": _email,
      "cliente": _cliente,
      "fornecedor": _fornecedor,
      "transportadora": _transportadora,
      "colaborador": _colaborador,
      "contador": _contador,
    };
  }
  
  @override
  int compareTo(Pessoa other) => _nome.toLowerCase().compareTo(other._nome.toLowerCase());  
}

