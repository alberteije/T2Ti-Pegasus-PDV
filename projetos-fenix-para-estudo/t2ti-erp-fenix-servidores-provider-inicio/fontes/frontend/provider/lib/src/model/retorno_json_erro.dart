/// classe transiente para armazenar o retorno de erros que vem do servidor
class RetornoJsonErro {
  String status;
  String error;
  String message;
  String trace;

  RetornoJsonErro({this.status, this.error, this.message});

  RetornoJsonErro.fromJson(Map<String, dynamic> jsonDados) {
    status = jsonDados['status'];
    error = jsonDados['error'];
    message = jsonDados['message'];
    trace = jsonDados['trace'];
  }

  Map<String, dynamic> get toJson {
    Map<String, dynamic> jsonDados = new Map<String, dynamic>();
    jsonDados['status'] = this.status;
    jsonDados['error'] = this.error;
    jsonDados['message'] = this.message;
    jsonDados['trace'] = this.trace;
    return jsonDados;
  }
}