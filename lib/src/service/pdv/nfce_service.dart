/*
Title: T2Ti ERP 3.0
Description: Service utilizado para consumir os métodos da NFC-e no servidor
                                                                                
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
import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pegasus_pdv/src/infra/infra.dart';

import 'package:pegasus_pdv/src/service/service_base.dart';
import 'package:pegasus_pdv/src/view/shared/page/pdf_page.dart';

/// classe responsável por requisições ao servidor REST
class NfceService extends ServiceBase {
  Socket _socket;

  // TODO: Assista aos seguintes vídeos para melhor compreensão:
  // http://t2ti.com/erp3/videos/flutter-pdv.php#44
  // http://t2ti.com/erp3/videos/flutter-pdv.php#45

  void dispose() {
    _socket.destroy();
  }

  Future<Socket> conectar() async {
    //TODO: obrigar o cadastro dos dados do servidor: endereço e porta
    final enderecoServidor = InternetAddress('127.0.0.1');
    final portaServidor = 3434;
    return Socket.connect(enderecoServidor, portaServidor);
  }

}