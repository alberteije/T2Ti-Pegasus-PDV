import 'package:cpf_cnpj_validator/cnpj_validator.dart';
import 'package:cpf_cnpj_validator/cpf_validator.dart';

/// valida os campos do formulário
class ValidaCampoFormulario {
  /// factory - teremos apenas uma instância de ValidaCampoFormulario - singleton
  factory ValidaCampoFormulario() {
    _this ??= ValidaCampoFormulario._();
    return _this;
  }
  static ValidaCampoFormulario _this;
  ValidaCampoFormulario._() : super();

  /// valida campo obrigatório
  static String validarObrigatorio(String value) {
    if (value.isEmpty) return 'Obrigatório informar esse campo.';
    return null;
  }

  /// validar o campo como obrigatório e verificar se os caracteres são alfanumericos
  static String validarObrigatorioAlfanumerico(String value) {
    var campoObrigario = validarObrigatorio(value);
    if (campoObrigario == null) {
      final RegExp nameExp = RegExp(r'^[A-Za-z0-9. ]+$');
      if (!nameExp.hasMatch(value))
        return 'Por favor, informe apenas caracteres alfanuméricos.';
    } else {
      return campoObrigario;
    }
    return null;
  }

  /// validar o campo como obrigatório e verificar se os caracteres são numericos
  static String validarObrigatorioNumerico(String value) {
    var campoObrigario = validarObrigatorio(value);
    if (campoObrigario == null) {
      final RegExp nameExp = RegExp(r'^[0-9]+$');
      if (!nameExp.hasMatch(value))
        return 'Por favor, informe apenas caracteres numéricos.';
    } else {
      return campoObrigario;
    }
    return null;
  }

  /// validar se o conteúdo do campo é um CNPJ válido
  static String validarCNPJ(String value) {
    var cnpjValido = CNPJValidator.isValid(value);
    if (cnpjValido) {
      return null;
    } else {
      return 'Por favor, informe um CNPJ válido.';
    }
  }

  /// validar se o conteúdo do campo é um CPF válido
  static String validarCPF(String value) {
    var cpfValido = CPFValidator.isValid(value);
    if (cpfValido) {
      return null;
    } else {
      return 'Por favor, informe um CPF válido.';
    }
  }

}
