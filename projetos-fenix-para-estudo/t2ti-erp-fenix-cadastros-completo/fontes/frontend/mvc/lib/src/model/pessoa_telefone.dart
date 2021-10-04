class PessoaTelefone implements Comparable<PessoaTelefone> {
  PessoaTelefone();

  String 
        _id,
        _idPessoa,
        _tipo,
        _numero;

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

  String get tipo => _tipo;
  set tipo(String value){
    if (value == null) value = "";
    _tipo = value;
  }

  String get numero => _numero;
  set numero(String value){
    if (value == null) value = "";
    _numero = value;
  }

  PessoaTelefone.fromMap(Map m) {
    id = m["id"];
    idPessoa = m["idPessoa"];
    tipo = m["tipo"];
    numero = m["numero"];
  }

  Map<String, dynamic> get toMap {
    return {
      "id": _id,
      "idPessoa": _idPessoa,
      "tipo": _tipo,
      "numero": _numero,
    };
  }
  
  @override
  int compareTo(PessoaTelefone other) => _numero.toLowerCase().compareTo(other._numero.toLowerCase());  
}