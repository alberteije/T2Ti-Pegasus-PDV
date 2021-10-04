/*
Title: T2Ti ERP 3.0                                                                
Description: Armazena widgets e métodos relacionados ao controle dos 
            atalhos para o PDV
                                                                                
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
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

Map<LogicalKeySet, Intent> getAtalhosCaixa() {
    return <LogicalKeySet, Intent>{
      LogicalKeySet(LogicalKeyboardKey.f2): const AtalhoTelaIntent.fechamentoRapido(),
      LogicalKeySet(LogicalKeyboardKey.f3): const AtalhoTelaIntent.identificarVendedor(),
      LogicalKeySet(LogicalKeyboardKey.f4): const AtalhoTelaIntent.identificarCliente(),
      LogicalKeySet(LogicalKeyboardKey.f5): const AtalhoTelaIntent.acessarOpcoesGerenciais(),
      LogicalKeySet(LogicalKeyboardKey.f6): const AtalhoTelaIntent.importarProduto(),
      LogicalKeySet(LogicalKeyboardKey.f7): const AtalhoTelaIntent.encerrarVenda(),
      LogicalKeySet(LogicalKeyboardKey.f9): const AtalhoTelaIntent.recuperarVenda(),
      LogicalKeySet(LogicalKeyboardKey.f10): const AtalhoTelaIntent.concederDesconto(),
      LogicalKeySet(LogicalKeyboardKey.f11): const AtalhoTelaIntent.cancelar(),
      LogicalKeySet(LogicalKeyboardKey.f12): const AtalhoTelaIntent.confirmar(),
      LogicalKeySet(LogicalKeyboardKey.escape): const AtalhoTelaIntent.escape(),
    };
}

class AtalhoTelaIntent extends Intent {
  const AtalhoTelaIntent({@required this.type});

  const AtalhoTelaIntent.fechamentoRapido() : type = AtalhoTelaType.fechamentoRapido;

  const AtalhoTelaIntent.identificarVendedor() : type = AtalhoTelaType.identificarVendedor;

  const AtalhoTelaIntent.identificarCliente() : type = AtalhoTelaType.identificarCliente;

  const AtalhoTelaIntent.acessarOpcoesGerenciais() : type = AtalhoTelaType.acessarOpcoesGerenciais;

  const AtalhoTelaIntent.recuperarVenda() : type = AtalhoTelaType.recuperarVenda;

  const AtalhoTelaIntent.concederDesconto() : type = AtalhoTelaType.concederDesconto;

  const AtalhoTelaIntent.cancelar() : type = AtalhoTelaType.cancelar;

  const AtalhoTelaIntent.confirmar() : type = AtalhoTelaType.confirmar;

  const AtalhoTelaIntent.importarProduto() : type = AtalhoTelaType.importarProduto;

  const AtalhoTelaIntent.encerrarVenda() : type = AtalhoTelaType.encerrarVenda;

  const AtalhoTelaIntent.escape() : type = AtalhoTelaType.escape;

  final AtalhoTelaType type;
}

enum AtalhoTelaType {
  fechamentoRapido,
  identificarVendedor,
  identificarCliente,
  acessarOpcoesGerenciais,
  recuperarVenda,
  concederDesconto,
  cancelar,
  confirmar,
  importarProduto,
  encerrarVenda,
  escape,
}
