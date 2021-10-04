/*
Title: T2Ti ERP 3.0                                                                
Description: Relatório de encerramento do Movimento
                                                                                
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
Adaptado de: https://github.com/DavBfr/dart_pdf/tree/master/printing
*******************************************************************************/
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pegasus_pdv/src/database/database.dart';
import 'package:printing/printing.dart';

import 'package:pegasus_pdv/src/infra/infra.dart';
import 'package:pegasus_pdv/src/infra/atalhos_pdv.dart';

PdvMovimento _movimento;
List<PdvFechamento> _listaPagamentosDeclarados;
List<PdvTotalTipoPagamento> _listaPagamentosRegistrados;

class EncerraMovimentoRelatorio extends StatefulWidget {
  final PdvMovimento movimento;

  const EncerraMovimentoRelatorio({Key key, this.movimento}): super(key: key);

  @override
  _EncerraMovimentoRelatorioState createState() => _EncerraMovimentoRelatorioState();
}

class _EncerraMovimentoRelatorioState extends State<EncerraMovimentoRelatorio> {
  Map<LogicalKeySet, Intent> _shortcutMap; 
  Map<Type, Action<Intent>> _actionMap;

  @override
  void initState() {
    super.initState();
    _shortcutMap = getAtalhosCaixa();
    _actionMap = <Type, Action<Intent>>{
      AtalhoTelaIntent: CallbackAction<AtalhoTelaIntent>(
        onInvoke: _tratarAcoesAtalhos,
      ),
    };

    WidgetsBinding.instance.addPostFrameCallback((_) => _carregarListas());
  }

  Future _carregarListas() async {
    _listaPagamentosDeclarados = await Sessao.db.pdvFechamentoDao.consultarListaMovimento(_movimento.id);
    _listaPagamentosRegistrados = await Sessao.db.pdvTotalTipoPagamentoDao.consultarListaTotaisAgrupado(_movimento.id);
    setState(() {
    });
  }

  void _tratarAcoesAtalhos(AtalhoTelaIntent intent) {
    switch (intent.type) {
      case AtalhoTelaType.escape:
        Navigator.pop(context);
        break;
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    _movimento = widget.movimento;
    return FocusableActionDetector(
      actions: _actionMap,
      shortcuts: _shortcutMap,
      child: Focus(
        autofocus: true,
        child: Scaffold(
          appBar: AppBar(
            title: Text('Encerramento do Movimento'),
          ),
          body: PdfPreview(          
            maxPageWidth: 800,
            canChangePageFormat: false,
            build: (format) => _gerarRelatorio(),
          ),
        ),
      ),
    );
  }
}

Future<Uint8List> _gerarRelatorio() async {
  final recibo = Relatorio();
  return await recibo.buildPdf(PdfPageFormat.a4);
}

class Relatorio {
  PdfColor _baseColor = PdfColors.blue900;
  PdfColor _accentColor = PdfColors.black;
  PdfColor _darkColor = PdfColors.blueGrey800;
  // PdfColor _baseTextColor = PdfColors.blue900.luminance < 0.5 ? PdfColors.white : PdfColors.blueGrey800;
  // PdfColor _accentTextColor = PdfColors.blue900.luminance < 0.5 ? PdfColors.white : PdfColors.blueGrey800;

  pw.MemoryImage _logotipo;
  pw.MemoryImage _rodape;

  Future<Uint8List> buildPdf(PdfPageFormat pageFormat) async {
    // Create a PDF document.
    final doc = pw.Document();

    _logotipo = pw.MemoryImage(
      Sessao.empresa.logotipo,
    );
    _rodape = pw.MemoryImage(
      (await rootBundle.load('assets/images/rodape_recibo.png')).buffer.asUint8List(),
    );

    final _fontNormal = await rootBundle.load('assets/fonts/roboto-normal.ttf');
    final _fontBold = await rootBundle.load('assets/fonts/roboto-bold.ttf');
    final _fontItalic = await rootBundle.load('assets/fonts/roboto-italic.ttf');

    // Add page to the PDF
    doc.addPage(
      pw.MultiPage(
        pageTheme: _buildTheme(
          pageFormat,
          pw.Font.ttf(_fontNormal),
          pw.Font.ttf(_fontBold),
          pw.Font.ttf(_fontItalic),
        ),
        header: _buildHeader,
        footer: _buildFooter,
        build: (context) => [
          _dadosMovimento(context),
          pw.SizedBox(height: 20),
          _totaisMovimento(context),
          pw.SizedBox(height: 20),
          _resumoMeiosPagamento(context),
        ],
      ),
    );

    // Return the PDF file content
    return doc.save();
  }

  pw.PageTheme _buildTheme(PdfPageFormat pageFormat, pw.Font base, pw.Font bold, pw.Font italic) {
    return pw.PageTheme(
      pageFormat: pageFormat,
      theme: pw.ThemeData.withFont(
        base: base,
        bold: bold,
        italic: italic,
      ),
      buildBackground: (context) => pw.FullPage(
        ignoreMargins: true,
        child: pw.Image(_rodape),
      ),
    );
  }

  pw.Widget _buildHeader(pw.Context context) {
    return pw.Column(
      children: [
        pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
            pw.Column(
              mainAxisSize: pw.MainAxisSize.min,
              children: [
                pw.Container(
                  alignment: pw.Alignment.center,
                  padding: pw.EdgeInsets.all(2),
                  height: 60,
                  child: pw.Image(_logotipo),
                ),
              ],
            ),
            pw.Expanded(
              child: pw.Column(
                children: [
                  pw.Container(
                    height: 20,
                    padding: pw.EdgeInsets.all(5),
                    alignment: pw.Alignment.center,
                    child: pw.Text(
                      Sessao.empresa.nomeFantasia,
                      style: pw.TextStyle(
                        color: _baseColor,
                        fontWeight: pw.FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  pw.Container(
                    height: 20,
                    padding: pw.EdgeInsets.all(5),
                    alignment: pw.Alignment.center,
                    child: pw.Text(
                      'Relatório de Encerramento do Movimento',
                      style: pw.TextStyle(
                        color: _accentColor,
                        // fontWeight: pw.FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  pw.Container(
                    height: 10,
                    padding: pw.EdgeInsets.only(top: 10),
                    alignment: pw.Alignment.bottomRight,
                    child: pw.Text(
                      'Impresso em: ' + Biblioteca.formatarDataHora(DateTime.now()),
                      style: pw.TextStyle(
                        color: _accentColor,
                        // fontWeight: pw.FontWeight.bold,
                        fontSize: 8,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        pw.Divider(color: _accentColor),
        if (context.pageNumber > 1) pw.SizedBox(height: 20)
      ],
    );
  }

  pw.Widget _buildFooter(pw.Context context) {
    return pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.end,
      children: [
        pw.Text(
          'Page ${context.pageNumber}/${context.pagesCount}',
          style: pw.TextStyle(
            fontSize: 12,
            color: PdfColors.black,
          ),
        ),
      ],
    );
  }

  pw.Widget _dadosMovimento(pw.Context context) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          'Dados do Movimento [ ID = ' + _movimento.id.toString() + ' ] - Status: ' 
          + (_movimento.statusMovimento == 'A' ? 'ABERTO' : 'FECHADO'),
          style: pw.TextStyle(
            fontSize: 12,
            color: _baseColor,
            fontWeight: pw.FontWeight.bold,
          ),
        ),    
        pw.Divider(color: _accentColor),
        pw.Row(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Expanded(
              child: pw.DefaultTextStyle(
                style: pw.TextStyle(
                  fontSize: 10,
                  color: _darkColor,
                ),
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Text('Data de Abertura: '),
                        pw.Text(Biblioteca.formatarData(_movimento.dataAbertura)),
                      ],
                    ),
                    pw.SizedBox(height: 5),
                    pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Text('Hora de Abertura: '),
                        pw.Text(_movimento.horaAbertura),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            pw.SizedBox(width: 20),
            pw.Expanded(
              child: pw.DefaultTextStyle(
                style: pw.TextStyle(
                  fontSize: 10,
                  color: _darkColor,
                ),
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Text('Data de Fechamento: '),
                        pw.Text(Biblioteca.formatarData(_movimento.dataFechamento)),
                      ],
                    ),
                    pw.SizedBox(height: 5),
                    pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Text('Hora de Fechamento: '),
                        pw.Text(_movimento.horaFechamento ?? ''),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  pw.Widget _totaisMovimento(pw.Context context) {
    return pw.Row(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Expanded(
          flex: 1,
          child: pw.Column(
            children: [
            ],
          ),
        ),
        pw.Expanded(
          flex: 1,
          child: pw.DefaultTextStyle(
            style: pw.TextStyle(
              fontSize: 10,
              color: _darkColor,
            ),
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: _listaTotaisMovimento(),
            ),
          ),
        ),
      ],
    );
  }

  List<pw.Widget> _listaTotaisMovimento() {
    List<pw.Widget> listaValoresMovimento = [];
    listaValoresMovimento.add(
        pw.Text(
        'Valores Totais do Movimento',
        style: pw.TextStyle(
          fontSize: 12,
          color: _baseColor,
          fontWeight: pw.FontWeight.bold,
        ),
      ),
    );
    listaValoresMovimento.add(pw.Divider(color: _accentColor),);
    listaValoresMovimento.add(pw.SizedBox(height: 5),);
    listaValoresMovimento.add(
      pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          pw.Text('Suprimento: '),
          pw.Text(
            'R\$ ${Constantes.formatoDecimalValor.format(_movimento.totalSuprimento ?? 0)}'
          ),
        ],
      ),
    );
    listaValoresMovimento.add(pw.SizedBox(height: 5),);
    listaValoresMovimento.add(
      pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          pw.Text('Sangria: '),
          pw.Text(
            'R\$ ${Constantes.formatoDecimalValor.format(_movimento.totalSangria ?? 0)}'
          ),
        ],
      ),
    );
    listaValoresMovimento.add(pw.SizedBox(height: 5),);
    listaValoresMovimento.add(
      pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          pw.Text('Total Venda: '),
          pw.Text(
            'R\$ ${Constantes.formatoDecimalValor.format(_movimento.totalVenda ?? 0)}'
          ),
        ],
      ),
    );
    listaValoresMovimento.add(pw.SizedBox(height: 5),);
    listaValoresMovimento.add(
      pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          pw.Text('Desconto: '),
          pw.Text(
            'R\$ ${Constantes.formatoDecimalValor.format(_movimento.totalDesconto ?? 0)}'
          ),
        ],
      ),
    );
    listaValoresMovimento.add(pw.SizedBox(height: 5),);
    listaValoresMovimento.add(
      pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          pw.Text('Recebido: '),
          pw.Text(
            'R\$ ${Constantes.formatoDecimalValor.format(_movimento.totalRecebido ?? 0)}'
          ),
        ],
      ),
    );
    listaValoresMovimento.add(pw.SizedBox(height: 5),);
    listaValoresMovimento.add(
      pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          pw.Text('Troco: '),
          pw.Text(
            'R\$ ${Constantes.formatoDecimalValor.format(_movimento.totalTroco ?? 0)}'
          ),
        ],
      ),
    );
    listaValoresMovimento.add(pw.SizedBox(height: 5),);
    listaValoresMovimento.add(
      pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          pw.Text('Cancelado: '),
          pw.Text(
            'R\$ ${Constantes.formatoDecimalValor.format(_movimento.totalCancelado ?? 0)}'
          ),
        ],
      ),
    );
    listaValoresMovimento.add(pw.SizedBox(height: 5),);
    listaValoresMovimento.add(
      pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          pw.Text('Total Final: '),
          pw.Text(
            'R\$ ${Constantes.formatoDecimalValor.format(_movimento.totalFinal ?? 0)}'
          ),
        ],
      ),
    );
                
    return listaValoresMovimento;     
  }

  pw.Widget _resumoMeiosPagamento(pw.Context context) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Divider(color: _accentColor),
        pw.Text(
          'Resumo dos Meios de Pagamento',
          style: pw.TextStyle(
            fontSize: 12,
            color: _baseColor,
            fontWeight: pw.FontWeight.bold,
          ),
        ),    
        pw.Divider(color: _accentColor),
        pw.Row(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Expanded(
              child: pw.DefaultTextStyle(
                style: pw.TextStyle(
                  fontSize: 10,
                  color: _darkColor,
                ),
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: _listaMeiosPagamentoDeclarados(),
                ),
              ),
            ),
            pw.SizedBox(width: 20),
            pw.Expanded(
              child: pw.DefaultTextStyle(
                style: pw.TextStyle(
                  fontSize: 10,
                  color: _darkColor,
                ),
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: _listaMeiosPagamentoRegistrados(),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  List<pw.Widget> _listaMeiosPagamentoDeclarados() {
    List<pw.Widget> listaValores = [];
    listaValores.add(
        pw.Text(
        'Valores Declarados pelo Usuário',
        style: pw.TextStyle(
          fontSize: 12,
          color: PdfColors.green,
          fontWeight: pw.FontWeight.bold,
        ),
      ),
    );
    listaValores.add(pw.Divider(color: _accentColor),);
    listaValores.add(pw.SizedBox(height: 5),);
    
    for (var item in _listaPagamentosDeclarados) {
      var tipoFiltrado = Sessao.listaTipoPagamento.where( ((tipo) => tipo.id == item.idPdvTipoPagamento)).toList();    
      listaValores.add(
        pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
            pw.Text(tipoFiltrado[0].descricao),
            pw.Text(
              'R\$ ${Constantes.formatoDecimalValor.format(item.valor ?? 0)}'
            ),
          ],
        ),
      );
      listaValores.add(pw.SizedBox(height: 5),);
    }                
    return listaValores;     
  }

  List<pw.Widget> _listaMeiosPagamentoRegistrados() {
    List<pw.Widget> listaValores = [];
    listaValores.add(
        pw.Text(
        'Valores Registrados pelo Sistema',
        style: pw.TextStyle(
          fontSize: 12,
          color: PdfColors.red,
          fontWeight: pw.FontWeight.bold,
        ),
      ),
    );
    listaValores.add(pw.Divider(color: _accentColor),);
    listaValores.add(pw.SizedBox(height: 5),);
    
    for (var item in _listaPagamentosRegistrados) {
      var tipoFiltrado = Sessao.listaTipoPagamento.where( ((tipo) => tipo.id == item.idPdvTipoPagamento)).toList();    
      listaValores.add(
        pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
            pw.Text(tipoFiltrado[0].descricao),
            pw.Text(
              'R\$ ${Constantes.formatoDecimalValor.format(item.valor ?? 0)}'
            ),
          ],
        ),
      );
      listaValores.add(pw.SizedBox(height: 5),);
    }                
    return listaValores;     
  }

}
