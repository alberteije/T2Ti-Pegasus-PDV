/*
Title: T2Ti ERP Fenix                                                                
Description: AbaMestre DetalhePage relacionada à tabela [FIN_LANCAMENTO_RECEBER] 
                                                                                
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
import 'fin_lancamento_receber_page.dart';

class FinLancamentoReceberDetalhePage extends StatelessWidget {
  final FinLancamentoReceber finLancamentoReceber;

  const FinLancamentoReceberDetalhePage({Key key, this.finLancamentoReceber}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var finLancamentoReceberProvider = Provider.of<FinLancamentoReceberViewModel>(context);

    if (finLancamentoReceberProvider.objetoJsonErro != null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Lancamento Receber'),
          actions: <Widget>[],
        ),
        body: ErroPage(
            objetoJsonErro:
                Provider.of<FinLancamentoReceberViewModel>(context).objetoJsonErro),
      );
    } else {
      return Theme(
          data: ViewUtilLib.getThemeDataDetalhePage(context),
          child: Scaffold(
            appBar: AppBar(title: Text('Lancamento Receber'), actions: <Widget>[
              IconButton(
                icon: ViewUtilLib.getIconBotaoExcluir(),
                onPressed: () {
                  return ViewUtilLib.gerarDialogBoxExclusao(context, () {
                    finLancamentoReceberProvider.excluir(finLancamentoReceber.id);
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                  });
                },
              ),
              IconButton(
                icon: ViewUtilLib.getIconBotaoAlterar(),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => FinLancamentoReceberPage(
                          finLancamentoReceber: finLancamentoReceber,
                          title: 'Lancamento Receber - Editando',
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
                    ViewUtilLib.getPaddingDetalhePage('Detalhes de Lancamento Receber'),
                    Card(
                      color: Colors.white,
                      elevation: 2.0,
                      child: Column(
                        children: <Widget>[
                        ViewUtilLib.getListTileDataDetalhePageId(
                            finLancamentoReceber.id?.toString() ?? '', 'Id'),
						ViewUtilLib.getListTileDataDetalhePage(
							finLancamentoReceber.finDocumentoOrigem?.sigla?.toString() ?? '', 'Documento de Origem'),
						ViewUtilLib.getListTileDataDetalhePage(
							finLancamentoReceber.finNaturezaFinanceira?.descricao?.toString() ?? '', 'Natureza Financeira'),
						ViewUtilLib.getListTileDataDetalhePage(
							finLancamentoReceber.cliente?.pessoa?.nome?.toString() ?? '', 'Cliente'),
						ViewUtilLib.getListTileDataDetalhePage(
							finLancamentoReceber.quantidadeParcela?.toString() ?? '', 'Quantidade de Parcelas'),
						ViewUtilLib.getListTileDataDetalhePage(
							finLancamentoReceber.valorTotal != null ? Constantes.formatoDecimalValor.format(finLancamentoReceber.valorTotal) : 0.toStringAsFixed(Constantes.decimaisValor), 'Valor Total'),
						ViewUtilLib.getListTileDataDetalhePage(
							finLancamentoReceber.valorAReceber != null ? Constantes.formatoDecimalValor.format(finLancamentoReceber.valorAReceber) : 0.toStringAsFixed(Constantes.decimaisValor), 'Valor a Receber'),
						ViewUtilLib.getListTileDataDetalhePage(
							finLancamentoReceber.dataLancamento != null ? DateFormat('dd/MM/yyyy').format(finLancamentoReceber.dataLancamento) : '', 'Data de Lançamento'),
						ViewUtilLib.getListTileDataDetalhePage(
							finLancamentoReceber.numeroDocumento ?? '', 'Número do Documento'),
						ViewUtilLib.getListTileDataDetalhePage(
							finLancamentoReceber.primeiroVencimento != null ? DateFormat('dd/MM/yyyy').format(finLancamentoReceber.primeiroVencimento) : '', 'Data do Primeiro Vencimento'),
						ViewUtilLib.getListTileDataDetalhePage(
							finLancamentoReceber.taxaComissao != null ? Constantes.formatoDecimalTaxa.format(finLancamentoReceber.taxaComissao) : 0.toStringAsFixed(Constantes.decimaisTaxa), 'Taxa de Comissão'),
						ViewUtilLib.getListTileDataDetalhePage(
							finLancamentoReceber.valorComissao != null ? Constantes.formatoDecimalValor.format(finLancamentoReceber.valorComissao) : 0.toStringAsFixed(Constantes.decimaisValor), 'Valor Comissão'),
						ViewUtilLib.getListTileDataDetalhePage(
							finLancamentoReceber.intervaloEntreParcelas?.toString() ?? '', 'Intervalo Entre Parcelas'),
						ViewUtilLib.getListTileDataDetalhePage(
							finLancamentoReceber.diaFixo ?? '', 'Dia Fixo'),
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