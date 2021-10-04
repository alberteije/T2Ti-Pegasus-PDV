/*
Title: T2Ti ERP Fenix                                                                
Description: DetalhePage relacionada à tabela [CLIENTE] 
                                                                                
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
import 'package:provider/provider.dart';

import 'package:fenix/src/model/model.dart';
import 'package:fenix/src/view_model/view_model.dart';
import 'package:fenix/src/view/shared/erro_page.dart';
import 'package:fenix/src/view/shared/view_util_lib.dart';
import 'package:fenix/src/infra/constantes.dart';
import 'package:intl/intl.dart';
import 'cliente_persiste_page.dart';

class ClienteDetalhePage extends StatelessWidget {
  final Cliente cliente;

  const ClienteDetalhePage({Key key, this.cliente}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var clienteProvider = Provider.of<ClienteViewModel>(context);

    if (clienteProvider.objetoJsonErro != null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Cliente'),
          actions: <Widget>[],
        ),
        body: ErroPage(
            objetoJsonErro:
                Provider.of<ClienteViewModel>(context).objetoJsonErro),
      );
    } else {
      return Theme(
          data: ViewUtilLib.getThemeDataDetalhePage(context),
          child: Scaffold(
            appBar: AppBar(title: Text('Cliente'), actions: <Widget>[
              IconButton(
                icon: ViewUtilLib.getIconBotaoExcluir(),
                onPressed: () {
                  return ViewUtilLib.gerarDialogBoxExclusao(context, () {
                    clienteProvider.excluir(cliente.id);
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                  });
                },
              ),
              IconButton(
                icon: ViewUtilLib.getIconBotaoAlterar(),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => ClientePersistePage(
                          cliente: cliente,
                          title: 'Cliente - Editando',
                          operacao: 'A')));
                },
              ),
            ]),
            body: SingleChildScrollView(
              child: Theme(
                data: ThemeData(fontFamily: 'Raleway'),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    ViewUtilLib.getPaddingDetalhePage('Detalhes de Cliente'),
                    Card(
                      color: Colors.white,
                      elevation: 2.0,
                      child: Column(
                        children: <Widget>[
                        ViewUtilLib.getListTileDataDetalhePageId(
                            cliente.id?.toString() ?? '', 'Id'),
						ViewUtilLib.getListTileDataDetalhePage(
							cliente.pessoa?.nome?.toString() ?? '', 'Pessoa'),
						ViewUtilLib.getListTileDataDetalhePage(
							cliente.desde != null ? DateFormat('dd/MM/yyyy').format(cliente.desde) : '', 'É Cliente Desde'),
						ViewUtilLib.getListTileDataDetalhePage(
							cliente.dataCadastro != null ? DateFormat('dd/MM/yyyy').format(cliente.dataCadastro) : '', 'Data de Cadastro'),
						ViewUtilLib.getListTileDataDetalhePage(
							cliente.taxaDesconto != null ? Constantes.formatoDecimalTaxa.format(cliente.taxaDesconto) : 0.toStringAsFixed(Constantes.decimaisTaxa), 'Taxa de Desconto'),
						ViewUtilLib.getListTileDataDetalhePage(
							cliente.limiteCredito != null ? Constantes.formatoDecimalValor.format(cliente.limiteCredito) : 0.toStringAsFixed(Constantes.decimaisValor), 'Limite de Crédito'),
						ViewUtilLib.getListTileDataDetalhePage(
							cliente.observacao ?? '', 'Observação'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ));
    }
  }
}