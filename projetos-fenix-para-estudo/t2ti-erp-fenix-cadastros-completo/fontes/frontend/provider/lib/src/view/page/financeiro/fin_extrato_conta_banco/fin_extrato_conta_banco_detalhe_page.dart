/*
Title: T2Ti ERP Fenix                                                                
Description: DetalhePage relacionada à tabela [FIN_EXTRATO_CONTA_BANCO] 
                                                                                
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
import 'fin_extrato_conta_banco_persiste_page.dart';

class FinExtratoContaBancoDetalhePage extends StatelessWidget {
  final FinExtratoContaBanco finExtratoContaBanco;

  const FinExtratoContaBancoDetalhePage({Key key, this.finExtratoContaBanco}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var finExtratoContaBancoProvider = Provider.of<FinExtratoContaBancoViewModel>(context);

    if (finExtratoContaBancoProvider.objetoJsonErro != null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Extrato Conta Banco'),
          actions: <Widget>[],
        ),
        body: ErroPage(
            objetoJsonErro:
                Provider.of<FinExtratoContaBancoViewModel>(context).objetoJsonErro),
      );
    } else {
      return Theme(
          data: ViewUtilLib.getThemeDataDetalhePage(context),
          child: Scaffold(
            appBar: AppBar(title: Text('Extrato Conta Banco'), actions: <Widget>[
              IconButton(
                icon: ViewUtilLib.getIconBotaoExcluir(),
                onPressed: () {
                  return ViewUtilLib.gerarDialogBoxExclusao(context, () {
                    finExtratoContaBancoProvider.excluir(finExtratoContaBanco.id);
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                  });
                },
              ),
              IconButton(
                icon: ViewUtilLib.getIconBotaoAlterar(),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => FinExtratoContaBancoPersistePage(
                          finExtratoContaBanco: finExtratoContaBanco,
                          title: 'Extrato Conta Banco - Editando',
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
                    ViewUtilLib.getPaddingDetalhePage('Detalhes de Extrato Conta Banco'),
                    Card(
                      color: Colors.white,
                      elevation: 2.0,
                      child: Column(
                        children: <Widget>[
                        ViewUtilLib.getListTileDataDetalhePageId(
                            finExtratoContaBanco.id?.toString() ?? '', 'Id'),
						ViewUtilLib.getListTileDataDetalhePage(
							finExtratoContaBanco.bancoContaCaixa?.nome?.toString() ?? '', 'Conta Caixa'),
						ViewUtilLib.getListTileDataDetalhePage(
							finExtratoContaBanco.mesAno ?? '', 'Mês/Ano'),
						ViewUtilLib.getListTileDataDetalhePage(
							finExtratoContaBanco.mes ?? '', 'Mês'),
						ViewUtilLib.getListTileDataDetalhePage(
							finExtratoContaBanco.ano ?? '', 'Ano'),
						ViewUtilLib.getListTileDataDetalhePage(
							finExtratoContaBanco.dataMovimento != null ? DateFormat('dd/MM/yyyy').format(finExtratoContaBanco.dataMovimento) : '', 'Data de Movimento'),
						ViewUtilLib.getListTileDataDetalhePage(
							finExtratoContaBanco.dataBalancete != null ? DateFormat('dd/MM/yyyy').format(finExtratoContaBanco.dataBalancete) : '', 'Data do Balancete'),
						ViewUtilLib.getListTileDataDetalhePage(
							finExtratoContaBanco.historico ?? '', 'Histórico'),
						ViewUtilLib.getListTileDataDetalhePage(
							finExtratoContaBanco.documento ?? '', 'Documento'),
						ViewUtilLib.getListTileDataDetalhePage(
							finExtratoContaBanco.valor != null ? Constantes.formatoDecimalValor.format(finExtratoContaBanco.valor) : 0.toStringAsFixed(Constantes.decimaisValor), 'Valor'),
						ViewUtilLib.getListTileDataDetalhePage(
							finExtratoContaBanco.conciliado ?? '', 'Conciliado'),
						ViewUtilLib.getListTileDataDetalhePage(
							finExtratoContaBanco.observacao ?? '', 'Observação'),
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