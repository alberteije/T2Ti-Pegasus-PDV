/*
Title: T2Ti ERP Fenix                                                                
Description: DetalhePage relacionada à tabela [FIN_CHEQUE_RECEBIDO] 
                                                                                
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
import 'fin_cheque_recebido_persiste_page.dart';

class FinChequeRecebidoDetalhePage extends StatelessWidget {
  final FinChequeRecebido finChequeRecebido;

  const FinChequeRecebidoDetalhePage({Key key, this.finChequeRecebido}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var finChequeRecebidoProvider = Provider.of<FinChequeRecebidoViewModel>(context);

    if (finChequeRecebidoProvider.objetoJsonErro != null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Cheque Recebido'),
          actions: <Widget>[],
        ),
        body: ErroPage(
            objetoJsonErro:
                Provider.of<FinChequeRecebidoViewModel>(context).objetoJsonErro),
      );
    } else {
      return Theme(
          data: ViewUtilLib.getThemeDataDetalhePage(context),
          child: Scaffold(
            appBar: AppBar(title: Text('Cheque Recebido'), actions: <Widget>[
              IconButton(
                icon: ViewUtilLib.getIconBotaoExcluir(),
                onPressed: () {
                  return ViewUtilLib.gerarDialogBoxExclusao(context, () {
                    finChequeRecebidoProvider.excluir(finChequeRecebido.id);
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                  });
                },
              ),
              IconButton(
                icon: ViewUtilLib.getIconBotaoAlterar(),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => FinChequeRecebidoPersistePage(
                          finChequeRecebido: finChequeRecebido,
                          title: 'Cheque Recebido - Editando',
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
                    ViewUtilLib.getPaddingDetalhePage('Detalhes de Cheque Recebido'),
                    Card(
                      color: Colors.white,
                      elevation: 2.0,
                      child: Column(
                        children: <Widget>[
                        ViewUtilLib.getListTileDataDetalhePageId(
                            finChequeRecebido.id?.toString() ?? '', 'Id'),
						ViewUtilLib.getListTileDataDetalhePage(
							finChequeRecebido.pessoa?.nome?.toString() ?? '', 'Pessoa'),
						ViewUtilLib.getListTileDataDetalhePage(
							finChequeRecebido.cpf ?? '', 'CPF'),
						ViewUtilLib.getListTileDataDetalhePage(
							finChequeRecebido.cnpj ?? '', 'CNPJ'),
						ViewUtilLib.getListTileDataDetalhePage(
							finChequeRecebido.nome ?? '', 'Nome'),
						ViewUtilLib.getListTileDataDetalhePage(
							finChequeRecebido.codigoBanco ?? '', 'Código Banco'),
						ViewUtilLib.getListTileDataDetalhePage(
							finChequeRecebido.codigoAgencia ?? '', 'Código Agência'),
						ViewUtilLib.getListTileDataDetalhePage(
							finChequeRecebido.conta ?? '', 'Conta'),
						ViewUtilLib.getListTileDataDetalhePage(
							finChequeRecebido.numero?.toString() ?? '', 'Número do Cheque'),
						ViewUtilLib.getListTileDataDetalhePage(
							finChequeRecebido.dataEmissao != null ? DateFormat('dd/MM/yyyy').format(finChequeRecebido.dataEmissao) : '', 'Data de Emissão'),
						ViewUtilLib.getListTileDataDetalhePage(
							finChequeRecebido.bomPara != null ? DateFormat('dd/MM/yyyy').format(finChequeRecebido.bomPara) : '', 'Cheque Bom Para'),
						ViewUtilLib.getListTileDataDetalhePage(
							finChequeRecebido.dataCompensacao != null ? DateFormat('dd/MM/yyyy').format(finChequeRecebido.dataCompensacao) : '', 'Data de Compensação'),
						ViewUtilLib.getListTileDataDetalhePage(
							finChequeRecebido.valor != null ? Constantes.formatoDecimalValor.format(finChequeRecebido.valor) : 0.toStringAsFixed(Constantes.decimaisValor), 'Valor'),
						ViewUtilLib.getListTileDataDetalhePage(
							finChequeRecebido.custodiaTarifa != null ? Constantes.formatoDecimalValor.format(finChequeRecebido.custodiaTarifa) : 0.toStringAsFixed(Constantes.decimaisValor), 'Tarifa Custódia'),
						ViewUtilLib.getListTileDataDetalhePage(
							finChequeRecebido.custodiaComissao != null ? Constantes.formatoDecimalValor.format(finChequeRecebido.custodiaComissao) : 0.toStringAsFixed(Constantes.decimaisValor), 'Custódia Comissão'),
						ViewUtilLib.getListTileDataDetalhePage(
							finChequeRecebido.descontoTarifa != null ? Constantes.formatoDecimalValor.format(finChequeRecebido.descontoTarifa) : 0.toStringAsFixed(Constantes.decimaisValor), 'Tarifa Desconto'),
						ViewUtilLib.getListTileDataDetalhePage(
							finChequeRecebido.descontoComissao != null ? Constantes.formatoDecimalValor.format(finChequeRecebido.descontoComissao) : 0.toStringAsFixed(Constantes.decimaisValor), 'Desconto Comissão'),
						ViewUtilLib.getListTileDataDetalhePage(
							finChequeRecebido.valorRecebido != null ? Constantes.formatoDecimalValor.format(finChequeRecebido.valorRecebido) : 0.toStringAsFixed(Constantes.decimaisValor), 'Valor Recebido'),
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