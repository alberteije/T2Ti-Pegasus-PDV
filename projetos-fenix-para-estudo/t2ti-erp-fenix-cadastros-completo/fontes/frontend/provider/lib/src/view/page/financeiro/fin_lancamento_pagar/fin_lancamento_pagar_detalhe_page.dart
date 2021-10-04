/*
Title: T2Ti ERP Fenix                                                                
Description: AbaMestre DetalhePage relacionada à tabela [FIN_LANCAMENTO_PAGAR] 
                                                                                
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
import 'fin_lancamento_pagar_page.dart';

class FinLancamentoPagarDetalhePage extends StatelessWidget {
  final FinLancamentoPagar finLancamentoPagar;

  const FinLancamentoPagarDetalhePage({Key key, this.finLancamentoPagar}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var finLancamentoPagarProvider = Provider.of<FinLancamentoPagarViewModel>(context);

    if (finLancamentoPagarProvider.objetoJsonErro != null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Lancamento Pagar'),
          actions: <Widget>[],
        ),
        body: ErroPage(
            objetoJsonErro:
                Provider.of<FinLancamentoPagarViewModel>(context).objetoJsonErro),
      );
    } else {
      return Theme(
          data: ViewUtilLib.getThemeDataDetalhePage(context),
          child: Scaffold(
            appBar: AppBar(title: Text('Lancamento Pagar'), actions: <Widget>[
              IconButton(
                icon: ViewUtilLib.getIconBotaoExcluir(),
                onPressed: () {
                  return ViewUtilLib.gerarDialogBoxExclusao(context, () {
                    finLancamentoPagarProvider.excluir(finLancamentoPagar.id);
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                  });
                },
              ),
              IconButton(
                icon: ViewUtilLib.getIconBotaoAlterar(),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => FinLancamentoPagarPage(
                          finLancamentoPagar: finLancamentoPagar,
                          title: 'Lancamento Pagar - Editando',
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
                    ViewUtilLib.getPaddingDetalhePage('Detalhes de Lancamento Pagar'),
                    Card(
                      color: Colors.white,
                      elevation: 2.0,
                      child: Column(
                        children: <Widget>[
                        ViewUtilLib.getListTileDataDetalhePageId(
                            finLancamentoPagar.id?.toString() ?? '', 'Id'),
						ViewUtilLib.getListTileDataDetalhePage(
							finLancamentoPagar.finDocumentoOrigem?.sigla?.toString() ?? '', 'Documento de Origem'),
						ViewUtilLib.getListTileDataDetalhePage(
							finLancamentoPagar.finNaturezaFinanceira?.descricao?.toString() ?? '', 'Natureza Financeira'),
						ViewUtilLib.getListTileDataDetalhePage(
							finLancamentoPagar.fornecedor?.pessoa?.nome?.toString() ?? '', 'Fornecedor'),
						ViewUtilLib.getListTileDataDetalhePage(
							finLancamentoPagar.quantidadeParcela?.toString() ?? '', 'Quantidade de Parcelas'),
						ViewUtilLib.getListTileDataDetalhePage(
							finLancamentoPagar.valorTotal != null ? Constantes.formatoDecimalValor.format(finLancamentoPagar.valorTotal) : 0.toStringAsFixed(Constantes.decimaisValor), 'Valor Total'),
						ViewUtilLib.getListTileDataDetalhePage(
							finLancamentoPagar.valorAPagar != null ? Constantes.formatoDecimalValor.format(finLancamentoPagar.valorAPagar) : 0.toStringAsFixed(Constantes.decimaisValor), 'Valor a Pagar'),
						ViewUtilLib.getListTileDataDetalhePage(
							finLancamentoPagar.dataLancamento != null ? DateFormat('dd/MM/yyyy').format(finLancamentoPagar.dataLancamento) : '', 'Data de Lançamento'),
						ViewUtilLib.getListTileDataDetalhePage(
							finLancamentoPagar.numeroDocumento ?? '', 'Número do Documento'),
						ViewUtilLib.getListTileDataDetalhePage(
							finLancamentoPagar.imagemDocumento ?? '', 'Imagem Documento'),
						ViewUtilLib.getListTileDataDetalhePage(
							finLancamentoPagar.primeiroVencimento != null ? DateFormat('dd/MM/yyyy').format(finLancamentoPagar.primeiroVencimento) : '', 'Data do Primeiro Vencimento'),
						ViewUtilLib.getListTileDataDetalhePage(
							finLancamentoPagar.intervaloEntreParcelas?.toString() ?? '', 'Intervalo Entre Parcelas'),
						ViewUtilLib.getListTileDataDetalhePage(
							finLancamentoPagar.diaFixo ?? '', 'Dia Fixo'),
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