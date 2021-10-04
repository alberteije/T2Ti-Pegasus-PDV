/*
Title: T2Ti ERP 3.0                                                                
Description: Armazena widgets e métodos relacionados ao controle dos 
            atalhos para dispositivos desktop e navegadores web.
                                                                                
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

Map<LogicalKeySet, Intent> getAtalhosListaPage() {
    return <LogicalKeySet, Intent>{
      kIsWeb == true ? LogicalKeySet(LogicalKeyboardKey.control, LogicalKeyboardKey.f2) : LogicalKeySet(LogicalKeyboardKey.f2):
          const AtalhoTelaIntent.inserir(),
      kIsWeb == true ? LogicalKeySet(LogicalKeyboardKey.control, LogicalKeyboardKey.f8) : LogicalKeySet(LogicalKeyboardKey.f8):
          const AtalhoTelaIntent.imprimir(),
      kIsWeb == true ? LogicalKeySet(LogicalKeyboardKey.control, LogicalKeyboardKey.f11) : LogicalKeySet(LogicalKeyboardKey.f11):
          const AtalhoTelaIntent.filtrar(),
    };
}

Map<LogicalKeySet, Intent> getAtalhosDetalhePage() {
    return <LogicalKeySet, Intent>{
      kIsWeb == true ? LogicalKeySet(LogicalKeyboardKey.control, LogicalKeyboardKey.f3) : LogicalKeySet(LogicalKeyboardKey.f3):
          const AtalhoTelaIntent.alterar(),
      kIsWeb == true ? LogicalKeySet(LogicalKeyboardKey.control, LogicalKeyboardKey.f9) : LogicalKeySet(LogicalKeyboardKey.f9):
          const AtalhoTelaIntent.excluir(),
    };
}

Map<LogicalKeySet, Intent> getAtalhosPersistePage() {
    return <LogicalKeySet, Intent>{
      kIsWeb == true ? LogicalKeySet(LogicalKeyboardKey.control, LogicalKeyboardKey.f9) : LogicalKeySet(LogicalKeyboardKey.f9):
          const AtalhoTelaIntent.excluir(),
      kIsWeb == true ? LogicalKeySet(LogicalKeyboardKey.control, LogicalKeyboardKey.f12) : LogicalKeySet(LogicalKeyboardKey.f12):
          const AtalhoTelaIntent.salvar(),
    };
}

Map<LogicalKeySet, Intent> getAtalhosAbaPage() {
    return <LogicalKeySet, Intent>{
      kIsWeb == true ? LogicalKeySet(LogicalKeyboardKey.control, LogicalKeyboardKey.f2) : LogicalKeySet(LogicalKeyboardKey.f2):
          const AtalhoTelaIntent.inserir(),
      kIsWeb == true ? LogicalKeySet(LogicalKeyboardKey.control, LogicalKeyboardKey.f12) : LogicalKeySet(LogicalKeyboardKey.f12):
          const AtalhoTelaIntent.salvar(),
    };
}

class AtalhoTelaIntent extends Intent {
  const AtalhoTelaIntent({@required this.type});

  const AtalhoTelaIntent.inserir() : type = AtalhoTelaType.inserir;

  const AtalhoTelaIntent.alterar() : type = AtalhoTelaType.alterar;

  const AtalhoTelaIntent.imprimir() : type = AtalhoTelaType.imprimir;

  const AtalhoTelaIntent.excluir() : type = AtalhoTelaType.excluir;

  const AtalhoTelaIntent.filtrar() : type = AtalhoTelaType.filtrar;

  const AtalhoTelaIntent.salvar() : type = AtalhoTelaType.salvar;

  final AtalhoTelaType type;
}

enum AtalhoTelaType {
  inserir,
  alterar,
  imprimir,
  excluir,
  filtrar,
  salvar,
}
