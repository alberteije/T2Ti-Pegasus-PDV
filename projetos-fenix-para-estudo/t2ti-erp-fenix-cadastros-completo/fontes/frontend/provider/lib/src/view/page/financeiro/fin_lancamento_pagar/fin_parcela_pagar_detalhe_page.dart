/*
Title: T2Ti ERP Fenix                                                                
Description: AbaDetalhe DetalhePage relacionada à tabela [FIN_PARCELA_PAGAR] 
                                                                                
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

import 'package:fenix/src/model/model.dart';
import 'package:fenix/src/view/shared/view_util_lib.dart';
import 'package:fenix/src/infra/constantes.dart';
import 'package:intl/intl.dart';
import 'fin_parcela_pagar_persiste_page.dart';

class FinParcelaPagarDetalhePage extends StatefulWidget {
  final FinLancamentoPagar finLancamentoPagar;
  final FinParcelaPagar finParcelaPagar;

  const FinParcelaPagarDetalhePage({Key key, this.finLancamentoPagar, this.finParcelaPagar})
      : super(key: key);

  @override
  _FinParcelaPagarDetalhePageState createState() =>
      _FinParcelaPagarDetalhePageState();
}

class _FinParcelaPagarDetalhePageState extends State<FinParcelaPagarDetalhePage> {
  @override
  Widget build(BuildContext context) {
    return Theme(
        data: ViewUtilLib.getThemeDataDetalhePage(context),
        child: Scaffold(
          appBar: AppBar(title: Text('Parcela Pagar'), actions: <Widget>[
            IconButton(
              icon: ViewUtilLib.getIconBotaoExcluir(),
              onPressed: () {
                return ViewUtilLib.gerarDialogBoxExclusao(context, () {
                  widget.finLancamentoPagar.listaFinParcelaPagar.remove(widget.finParcelaPagar);
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                });
              },
            ),
            IconButton(
              icon: ViewUtilLib.getIconBotaoAlterar(),
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(
                        builder: (BuildContext context) =>
                            FinParcelaPagarPersistePage(
                                finLancamentoPagar: widget.finLancamentoPagar,
                                finParcelaPagar: widget.finParcelaPagar,
                                title: 'Parcela Pagar - Editando',
                                operacao: 'A')))
                    .then((_) {
                  setState(() {});
                });
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
				  ViewUtilLib.getPaddingDetalhePage('Detalhes de FinLancamentoPagar'),
                  Card(
                    color: Colors.white,
                    elevation: 2.0,
                    child: Column(
                      children: <Widget>[
						ViewUtilLib.getListTileDataDetalhePage(
							widget.finParcelaPagar.finStatusParcela?.descricao?.toString() ?? '', 'Status Parcela'),
						ViewUtilLib.getListTileDataDetalhePage(
							widget.finParcelaPagar.bancoContaCaixa?.nome?.toString() ?? '', 'Conta Caixa'),
						ViewUtilLib.getListTileDataDetalhePage(
							widget.finParcelaPagar.finTipoPagamento?.descricao?.toString() ?? '', 'Tipo Pagamento'),
						ViewUtilLib.getListTileDataDetalhePage(
							widget.finParcelaPagar.finChequeEmitido?.cheque?.numero?.toString() ?? '', 'Cheque'),
						ViewUtilLib.getListTileDataDetalhePage(
							widget.finParcelaPagar.numeroParcela?.toString() ?? '', 'Número da Parcela'),
						ViewUtilLib.getListTileDataDetalhePage(
							widget.finParcelaPagar.dataEmissao != null ? DateFormat('dd/MM/yyyy').format(widget.finParcelaPagar.dataEmissao) : '', 'Data de Emissão'),
						ViewUtilLib.getListTileDataDetalhePage(
							widget.finParcelaPagar.dataVencimento != null ? DateFormat('dd/MM/yyyy').format(widget.finParcelaPagar.dataVencimento) : '', 'Data de Vencimento'),
						ViewUtilLib.getListTileDataDetalhePage(
							widget.finParcelaPagar.valor != null ? Constantes.formatoDecimalValor.format(widget.finParcelaPagar.valor) : 0.toStringAsFixed(Constantes.decimaisValor), 'Valor'),
						ViewUtilLib.getListTileDataDetalhePage(
							widget.finParcelaPagar.taxaJuro != null ? Constantes.formatoDecimalTaxa.format(widget.finParcelaPagar.taxaJuro) : 0.toStringAsFixed(Constantes.decimaisTaxa), 'Taxa Juros'),
						ViewUtilLib.getListTileDataDetalhePage(
							widget.finParcelaPagar.taxaMulta != null ? Constantes.formatoDecimalTaxa.format(widget.finParcelaPagar.taxaMulta) : 0.toStringAsFixed(Constantes.decimaisTaxa), 'Taxa Multa'),
						ViewUtilLib.getListTileDataDetalhePage(
							widget.finParcelaPagar.taxaDesconto != null ? Constantes.formatoDecimalTaxa.format(widget.finParcelaPagar.taxaDesconto) : 0.toStringAsFixed(Constantes.decimaisTaxa), 'Taxa Desconto'),
						ViewUtilLib.getListTileDataDetalhePage(
							widget.finParcelaPagar.valorJuro != null ? Constantes.formatoDecimalValor.format(widget.finParcelaPagar.valorJuro) : 0.toStringAsFixed(Constantes.decimaisValor), 'Valor Juros'),
						ViewUtilLib.getListTileDataDetalhePage(
							widget.finParcelaPagar.valorMulta != null ? Constantes.formatoDecimalValor.format(widget.finParcelaPagar.valorMulta) : 0.toStringAsFixed(Constantes.decimaisValor), 'Valor Multa'),
						ViewUtilLib.getListTileDataDetalhePage(
							widget.finParcelaPagar.valorDesconto != null ? Constantes.formatoDecimalValor.format(widget.finParcelaPagar.valorDesconto) : 0.toStringAsFixed(Constantes.decimaisValor), 'Valor Desconto'),
						ViewUtilLib.getListTileDataDetalhePage(
							widget.finParcelaPagar.valorPago != null ? Constantes.formatoDecimalValor.format(widget.finParcelaPagar.valorPago) : 0.toStringAsFixed(Constantes.decimaisValor), 'Valor Pago'),
						ViewUtilLib.getListTileDataDetalhePage(
							widget.finParcelaPagar.historico ?? '', 'Histórico'),
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
