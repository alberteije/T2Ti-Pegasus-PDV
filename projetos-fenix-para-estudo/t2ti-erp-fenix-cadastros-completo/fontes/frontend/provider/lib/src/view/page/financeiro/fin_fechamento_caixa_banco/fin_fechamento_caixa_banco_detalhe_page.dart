/*
Title: T2Ti ERP Fenix                                                                
Description: DetalhePage relacionada à tabela [FIN_FECHAMENTO_CAIXA_BANCO] 
                                                                                
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
import 'fin_fechamento_caixa_banco_persiste_page.dart';

class FinFechamentoCaixaBancoDetalhePage extends StatelessWidget {
  final FinFechamentoCaixaBanco finFechamentoCaixaBanco;

  const FinFechamentoCaixaBancoDetalhePage({Key key, this.finFechamentoCaixaBanco}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var finFechamentoCaixaBancoProvider = Provider.of<FinFechamentoCaixaBancoViewModel>(context);

    if (finFechamentoCaixaBancoProvider.objetoJsonErro != null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Fechamento Caixa Banco'),
          actions: <Widget>[],
        ),
        body: ErroPage(
            objetoJsonErro:
                Provider.of<FinFechamentoCaixaBancoViewModel>(context).objetoJsonErro),
      );
    } else {
      return Theme(
          data: ViewUtilLib.getThemeDataDetalhePage(context),
          child: Scaffold(
            appBar: AppBar(title: Text('Fechamento Caixa Banco'), actions: <Widget>[
              IconButton(
                icon: ViewUtilLib.getIconBotaoExcluir(),
                onPressed: () {
                  return ViewUtilLib.gerarDialogBoxExclusao(context, () {
                    finFechamentoCaixaBancoProvider.excluir(finFechamentoCaixaBanco.id);
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                  });
                },
              ),
              IconButton(
                icon: ViewUtilLib.getIconBotaoAlterar(),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => FinFechamentoCaixaBancoPersistePage(
                          finFechamentoCaixaBanco: finFechamentoCaixaBanco,
                          title: 'Fechamento Caixa Banco - Editando',
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
                    ViewUtilLib.getPaddingDetalhePage('Detalhes de Fechamento Caixa Banco'),
                    Card(
                      color: Colors.white,
                      elevation: 2.0,
                      child: Column(
                        children: <Widget>[
                        ViewUtilLib.getListTileDataDetalhePageId(
                            finFechamentoCaixaBanco.id?.toString() ?? '', 'Id'),
						ViewUtilLib.getListTileDataDetalhePage(
							finFechamentoCaixaBanco.bancoContaCaixa?.nome?.toString() ?? '', 'Conta Caixa'),
						ViewUtilLib.getListTileDataDetalhePage(
							finFechamentoCaixaBanco.dataFechamento != null ? DateFormat('dd/MM/yyyy').format(finFechamentoCaixaBanco.dataFechamento) : '', 'Data do Fechamento'),
						ViewUtilLib.getListTileDataDetalhePage(
							finFechamentoCaixaBanco.mesAno ?? '', 'Mês/Ano'),
						ViewUtilLib.getListTileDataDetalhePage(
							finFechamentoCaixaBanco.mes ?? '', 'Mês'),
						ViewUtilLib.getListTileDataDetalhePage(
							finFechamentoCaixaBanco.ano ?? '', 'Ano'),
						ViewUtilLib.getListTileDataDetalhePage(
							finFechamentoCaixaBanco.saldoAnterior != null ? Constantes.formatoDecimalValor.format(finFechamentoCaixaBanco.saldoAnterior) : 0.toStringAsFixed(Constantes.decimaisValor), 'Valor Saldo Anterior'),
						ViewUtilLib.getListTileDataDetalhePage(
							finFechamentoCaixaBanco.recebimentos != null ? Constantes.formatoDecimalValor.format(finFechamentoCaixaBanco.recebimentos) : 0.toStringAsFixed(Constantes.decimaisValor), 'Total Recebimentos'),
						ViewUtilLib.getListTileDataDetalhePage(
							finFechamentoCaixaBanco.pagamentos != null ? Constantes.formatoDecimalValor.format(finFechamentoCaixaBanco.pagamentos) : 0.toStringAsFixed(Constantes.decimaisValor), 'Total Pagamentos'),
						ViewUtilLib.getListTileDataDetalhePage(
							finFechamentoCaixaBanco.saldoConta != null ? Constantes.formatoDecimalValor.format(finFechamentoCaixaBanco.saldoConta) : 0.toStringAsFixed(Constantes.decimaisValor), 'Saldo em Conta'),
						ViewUtilLib.getListTileDataDetalhePage(
							finFechamentoCaixaBanco.chequeNaoCompensado != null ? Constantes.formatoDecimalValor.format(finFechamentoCaixaBanco.chequeNaoCompensado) : 0.toStringAsFixed(Constantes.decimaisValor), 'Cheques Não Compensados'),
						ViewUtilLib.getListTileDataDetalhePage(
							finFechamentoCaixaBanco.saldoDisponivel != null ? Constantes.formatoDecimalValor.format(finFechamentoCaixaBanco.saldoDisponivel) : 0.toStringAsFixed(Constantes.decimaisValor), 'Saldo Disponível'),
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