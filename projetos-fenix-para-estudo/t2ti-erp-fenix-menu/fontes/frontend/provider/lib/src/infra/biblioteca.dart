/// Classe que armazena alguns métodos úteis para as classes da aplicação.

class Biblioteca {
  /// singleton
  factory Biblioteca() {
    _this ??= Biblioteca._();
    return _this;
  }
  static Biblioteca _this;
  Biblioteca._() : super();

  /// remove a máscara de uma string
  /// útil para campos do tipo: CPF, CNPJ, CEP, etc
  static String removerMascara(String value) {
    return value.replaceAll(new RegExp(r'[^\w\s]+'), '');
  }
}
