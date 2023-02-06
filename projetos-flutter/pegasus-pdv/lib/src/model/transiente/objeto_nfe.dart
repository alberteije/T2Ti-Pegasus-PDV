/*
Title: T2Ti ERP 3.0                                                                
Description: Classe transiente para armazenar o objeto de inutilização da NFC-e
                                                                                
The MIT License                                                                 
                                                                                
Copyright: Copyright (C) 2021 T2Ti.COM                                          
                                                                                
Permission is hereby granted, free of charge, to any person                     
obtaining a copy of this software and associated documentation                  
files (the "Software"), to deal in the Software without                         
restriction, including without limitation the rights to use,                    
copy, modify, merge, publish, distribute, sublicense, and/or sell               
copies of the Software, and to permit persons to whom the                       
Software is furnished to do so, subject to the following                        
conditions:                                                                     
                                                                                
The above copyright notice and this permission notice shall be                  
included in all copies or substantial portions of the Software.                 
                                                                                
THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,                 
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES                 
OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND                        
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT                     
HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,                    
WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING                    
FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR                   
OTHER DEALINGS IN THE SOFTWARE.                                                 
                                                                                
       The author may be contacted at:                                          
           t2ti.com@gmail.com                                                   
                                                                                
@author Albert Eije (alberteije@gmail.com)                    
@version 1.0.0
*******************************************************************************/
import 'dart:convert';

class ObjetoNfe {
  String? cnpj;
  String? justificativa;
  String? ano;
  String? modelo;
  String? serie;
  String? numeroInicial;
  String? numeroFinal;
  String? chaveAcesso;

  ObjetoNfe(
    {
      this.cnpj, 
      this.justificativa, 
      this.ano, 
      this.modelo, 
      this.serie,
      this.numeroInicial,
      this.numeroFinal,
      this.chaveAcesso,
    }
  );

  ObjetoNfe.fromJson(Map<String, dynamic> jsonDados) {
    cnpj = jsonDados['cnpj'];
    justificativa = jsonDados['justificativa'];
    ano = jsonDados['ano'];
    modelo = jsonDados['modelo'];
    serie = jsonDados['serie'];
    numeroInicial = jsonDados['numeroInicial'];
    numeroFinal = jsonDados['numeroFinal'];
    chaveAcesso = jsonDados['chaveAcesso'];
  }

  Map<String, dynamic> get toJson {
    Map<String, dynamic> jsonDados = <String, dynamic>{};
    jsonDados['cnpj'] = cnpj;
    jsonDados['justificativa'] = justificativa;
    jsonDados['ano'] = ano;
    jsonDados['modelo'] = modelo;
    jsonDados['serie'] = serie;
    jsonDados['numeroInicial'] = numeroInicial;
    jsonDados['numeroFinal'] = numeroFinal;
    jsonDados['chaveAcesso'] = chaveAcesso;
    return jsonDados;
  }

	String objetoEncodeJson() {
	  final jsonDados = toJson;
	  return json.encode(jsonDados);
	}  
}