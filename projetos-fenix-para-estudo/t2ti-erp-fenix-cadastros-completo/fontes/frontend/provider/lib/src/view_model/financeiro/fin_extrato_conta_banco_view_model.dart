/*
Title: T2Ti ERP Fenix                                                                
Description: ViewModel relacionado à tabela [FIN_EXTRATO_CONTA_BANCO] 
                                                                                
The MIT License                                                                 
                                                                                
Copyright: Copyright (C) 2020 T2Ti.COM                                          
                                                                                
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

import 'package:fenix/src/infra/locator.dart';
import 'package:fenix/src/model/model.dart';
import 'package:fenix/src/model/filtro.dart';
import 'package:fenix/src/model/retorno_json_erro.dart';
import 'package:fenix/src/service/service.dart';

class FinExtratoContaBancoViewModel extends ChangeNotifier {
  FinExtratoContaBancoService _finExtratoContaBancoService = locator<FinExtratoContaBancoService>();
  List<FinExtratoContaBanco> listaFinExtratoContaBanco;
  RetornoJsonErro objetoJsonErro;

  FinExtratoContaBancoViewModel();

  Future<List<FinExtratoContaBanco>> consultarLista({Filtro filtro}) async {
    listaFinExtratoContaBanco = await _finExtratoContaBancoService.consultarLista(filtro: filtro);
    if (listaFinExtratoContaBanco == null) {
      objetoJsonErro = _finExtratoContaBancoService.objetoJsonErro;
    }
    notifyListeners();
    return listaFinExtratoContaBanco;
  }

  Future<FinExtratoContaBanco> consultarObjeto(int id) async {
    var result = await _finExtratoContaBancoService.consultarObjeto(id);
    if (result == null) {
      objetoJsonErro = _finExtratoContaBancoService.objetoJsonErro;
    }
    notifyListeners();
    return result;
  }

  Future<FinExtratoContaBanco> inserir(FinExtratoContaBanco finExtratoContaBanco) async {
    var result = await _finExtratoContaBancoService.inserir(finExtratoContaBanco);
    if (result == null) {
      objetoJsonErro = _finExtratoContaBancoService.objetoJsonErro;
    }
    notifyListeners();
    return result;
  }

  Future<FinExtratoContaBanco> alterar(FinExtratoContaBanco finExtratoContaBanco) async {
    var result = await _finExtratoContaBancoService.alterar(finExtratoContaBanco);
    if (result == null) {
      objetoJsonErro = _finExtratoContaBancoService.objetoJsonErro;
    }
    notifyListeners();
    return result;
  }

  Future<bool> excluir(int id) async {
    var result = await _finExtratoContaBancoService.excluir(id);
    if (result == false) {
      objetoJsonErro = _finExtratoContaBancoService.objetoJsonErro;
      notifyListeners();
    } else {
      consultarLista();
    }
    return result;
  }
}