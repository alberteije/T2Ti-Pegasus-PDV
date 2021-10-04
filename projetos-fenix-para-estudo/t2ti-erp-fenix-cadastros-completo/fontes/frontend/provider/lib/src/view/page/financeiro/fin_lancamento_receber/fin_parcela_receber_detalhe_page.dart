/*
Title: T2Ti ERP Fenix                                                                
Description: AbaDetalhe DetalhePage relacionada à tabela [FIN_PARCELA_RECEBER] 
                                                                                
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
import 'fin_parcela_receber_persiste_page.dart';

class FinParcelaReceberDetalhePage extends StatefulWidget {
  final FinLancamentoReceber finLancamentoReceber;
  final FinParcelaReceber finParcelaReceber;

  const FinParcelaReceberDetalhePage({Key key, this.finLancamentoReceber, this.finParcelaReceber})
      : super(key: key);

  @override
  _FinParcelaReceberDetalhePageState createState() =>
      _FinParcelaReceberDetalhePageState();
}

class _FinParcelaReceberDetalhePageState extends State<FinParcelaReceberDetalhePage> {
  @override
  Widget build(BuildContext context) {
    return Theme(
        data: ViewUtilLib.getThemeDataDetalhePage(context),
        child: Scaffold(
          appBar: AppBar(title: Text('Parcela Receber'), actions: <Widget>[
            IconButton(
              icon: ViewUtilLib.getIconBotaoExcluir(),
              onPressed: () {
                return ViewUtilLib.gerarDialogBoxExclusao(context, () {
                  widget.finLancamentoReceber.listaFinParcelaReceber.remove(widget.finParcelaReceber);
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
                            FinParcelaReceberPersistePage(
                                finLancamentoReceber: widget.finLancamentoReceber,
                                finParcelaReceber: widget.finParcelaReceber,
                                title: 'Parcela Receber - Editando',
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
				  ViewUtilLib.getPaddingDetalhePage('Detalhes de FinLancamentoReceber'),
                  Card(
                    color: Colors.white,
                    elevation: 2.0,
                    child: Column(
                      children: <Widget>[
						ViewUtilLib.getListTileDataDetalhePage(
							widget.finParcelaReceber.finStatusParcela?.descricao?.toString() ?? '', 'Status Parcela'),
						ViewUtilLib.getListTileDataDetalhePage(
							widget.finParcelaReceber.finTipoRecebimento?.descricao?.toString() ?? '', 'Tipo Recebimento'),
						ViewUtilLib.getListTileDataDetalhePage(
							widget.finParcelaReceber.bancoContaCaixa?.nome?.toString() ?? '', 'Conta Caixa'),
						ViewUtilLib.getListTileDataDetalhePage(
							widget.finParcelaReceber.finChequeRecebido?.numero?.toString() ?? '', 'Cheque'),
						ViewUtilLib.getListTileDataDetalhePage(
							widget.finParcelaReceber.numeroParcela?.toString() ?? '', 'Número da Parcela'),
						ViewUtilLib.getListTileDataDetalhePage(
							widget.finParcelaReceber.dataEmissao != null ? DateFormat('dd/MM/yyyy').format(widget.finParcelaReceber.dataEmissao) : '', 'Data de Emissão'),
						ViewUtilLib.getListTileDataDetalhePage(
							widget.finParcelaReceber.dataVencimento != null ? DateFormat('dd/MM/yyyy').format(widget.finParcelaReceber.dataVencimento) : '', 'Data de Vencimento'),
						ViewUtilLib.getListTileDataDetalhePage(
							widget.finParcelaReceber.valor != null ? Constantes.formatoDecimalValor.format(widget.finParcelaReceber.valor) : 0.toStringAsFixed(Constantes.decimaisValor), 'Valor'),
						ViewUtilLib.getListTileDataDetalhePage(
							widget.finParcelaReceber.taxaJuro != null ? Constantes.formatoDecimalTaxa.format(widget.finParcelaReceber.taxaJuro) : 0.toStringAsFixed(Constantes.decimaisTaxa), 'Taxa Juros'),
						ViewUtilLib.getListTileDataDetalhePage(
							widget.finParcelaReceber.taxaMulta != null ? Constantes.formatoDecimalTaxa.format(widget.finParcelaReceber.taxaMulta) : 0.toStringAsFixed(Constantes.decimaisTaxa), 'Taxa Multa'),
						ViewUtilLib.getListTileDataDetalhePage(
							widget.finParcelaReceber.taxaDesconto != null ? Constantes.formatoDecimalTaxa.format(widget.finParcelaReceber.taxaDesconto) : 0.toStringAsFixed(Constantes.decimaisTaxa), 'Taxa Desconto'),
						ViewUtilLib.getListTileDataDetalhePage(
							widget.finParcelaReceber.valorJuro != null ? Constantes.formatoDecimalValor.format(widget.finParcelaReceber.valorJuro) : 0.toStringAsFixed(Constantes.decimaisValor), 'Valor Juros'),
						ViewUtilLib.getListTileDataDetalhePage(
							widget.finParcelaReceber.valorMulta != null ? Constantes.formatoDecimalValor.format(widget.finParcelaReceber.valorMulta) : 0.toStringAsFixed(Constantes.decimaisValor), 'Valor Multa'),
						ViewUtilLib.getListTileDataDetalhePage(
							widget.finParcelaReceber.valorDesconto != null ? Constantes.formatoDecimalValor.format(widget.finParcelaReceber.valorDesconto) : 0.toStringAsFixed(Constantes.decimaisValor), 'Valor Desconto'),
						ViewUtilLib.getListTileDataDetalhePage(
							widget.finParcelaReceber.emitiuBoleto ?? '', 'Emitiu Boleto'),
						ViewUtilLib.getListTileDataDetalhePage(
							widget.finParcelaReceber.boletoNossoNumero ?? '', 'Boleto Nosso Número'),
						ViewUtilLib.getListTileDataDetalhePage(
							widget.finParcelaReceber.valorRecebido != null ? Constantes.formatoDecimalValor.format(widget.finParcelaReceber.valorRecebido) : 0.toStringAsFixed(Constantes.decimaisValor), 'Valor Recebido'),
						ViewUtilLib.getListTileDataDetalhePage(
							widget.finParcelaReceber.historico ?? '', 'Histórico'),
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
