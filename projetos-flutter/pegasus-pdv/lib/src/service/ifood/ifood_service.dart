/*
Title: T2Ti ERP 3.0
Description: Service utilizado para consumir os webservices relacionados ao iFood
                                                                                
The MIT License                                                                 
                                                                                
Copyright: Copyright (C) 2022 T2Ti.COM                                          
                                                                                
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
import 'dart:io';
import 'package:http/http.dart' show Client;

import 'package:pegasus_pdv/src/service/service_base.dart';
import 'package:pegasus_pdv/src/model/model.dart';

class IfoodService extends ServiceBase {
  var clienteHTTP = Client();

  Future<RootModel?> consultarPedido() async {
    // TODO: implemente a rotina que vai buscar o pedido ou a lista de pedidos do iFood
    // try {
    //   final response = await clienteHTTP.get(
    //     Uri.tryParse('$endpoint/ifood')!,
    //     headers: ServiceBase.cabecalhoRequisicao,
    //   );

    //   if (response.statusCode == 200 || response.statusCode == 201) {
    //     if (response.headers["content-type"]!.contains("html")) {
    //       tratarRetornoErro(response.body, response.headers);
    //       return null;
    //     } else {
    //       var empresaJson = json.decode(Biblioteca.decifrar(response.body));
    //       return EmpresaModel.fromJson(empresaJson);
    //     }
    //   } else {
    //     tratarRetornoErro(response.body, response.headers);
    //     return null;
    //   }
    // } on Exception catch (e) {
    //   tratarRetornoErro(null, null, exception: e);
    //   return null;
    // }
    final arquivoJsonTeste = File('c:\\t2ti\\json\\ifood_delivery_imediato.txt').readAsLinesSync();
    final stringJson = arquivoJsonTeste.toString().substring(1, arquivoJsonTeste.toString().length - 1);
    final ifoodJson = json.decode(stringJson);
    return RootModel.fromJson(ifoodJson);
  }


}