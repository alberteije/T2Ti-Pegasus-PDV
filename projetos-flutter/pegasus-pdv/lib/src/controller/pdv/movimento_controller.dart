/*
Title: T2Ti ERP 3.0
Description: Controller utilizado para o Movimento
                                                                                
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
import 'package:pegasus_pdv/src/controller/controller.dart';
import 'package:pegasus_pdv/src/database/database.dart';
import 'package:pegasus_pdv/src/infra/infra.dart';

class MovimentoController {

  /// Passos:
  /// 01-busca um movimento com status = 'A' (aberto)
  /// 02-se não existir movimento, abre
  /// 03-se existir um movimento
  /// 03.1-verifica se o movimento é de outro dia
  /// 03.1.1 - se for um movimento de outro dia, encerra movimento e abre outro
  /// 03.1.2 - se for um movimento do mesmo dia, atribui para o movimento da sessão 
  static Future tratarMovimento() async {
    Sessao.movimento = await Sessao.db.pdvMovimentoDao.consultarObjeto('A'); 
    if (Sessao.movimento == null) {
      Sessao.movimento = PdvMovimento(id: null, dataAbertura: DateTime.now(), horaAbertura: Biblioteca.formatarHora(DateTime.now()), statusMovimento: 'A');
      Sessao.movimento = await Sessao.db.pdvMovimentoDao.iniciarMovimento(Sessao.movimento!);
    } else {
      if (Biblioteca.formatarData(Sessao.movimento!.dataAbertura) != Biblioteca.formatarData(DateTime.now())) {
        await Sessao.db.pdvMovimentoDao.encerrarMovimento(Sessao.movimento!);
        await SincronizaController.subirDadosMovimento();
        Sessao.movimento = PdvMovimento(id: null, dataAbertura: DateTime.now(), horaAbertura: Biblioteca.formatarHora(DateTime.now()), statusMovimento: 'A');
        Sessao.movimento = await Sessao.db.pdvMovimentoDao.iniciarMovimento(Sessao.movimento!);
      }
    }
  }

}