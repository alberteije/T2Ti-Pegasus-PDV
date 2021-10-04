/*
Title: T2Ti ERP 3.0                                                                
Description: Página de relatório do recibo - formato A4
                                                                                
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
import 'package:printing/printing.dart';

import 'package:pegasus_pdv/src/infra/infra.dart';
import 'package:pegasus_pdv/src/infra/atalhos_pdv.dart';

class ReciboRelatorioA4 extends StatefulWidget {

  @override
  _ReciboRelatorioA4State createState() => _ReciboRelatorioA4State();
}

class _ReciboRelatorioA4State extends State<ReciboRelatorioA4> {
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
    return FocusableActionDetector(
      actions: _actionMap,
      shortcuts: _shortcutMap,
      child: Focus(
        autofocus: true,
        child: Scaffold(
          appBar: AppBar(
            title: Text('Recibo'),
          ),
          body: PdfPreview(          
            maxPageWidth: 800,
            canChangePageFormat: false,
            build: (format) => _gerarRecibo(),
          ),
        ),
      ),
    );
  }
}

Future<Uint8List> _gerarRecibo() async {
  final recibo = ReciboA4();
  return await recibo.buildPdf(PdfPageFormat.a4);
}

class ReciboA4 {
  PdfColor _baseColor = PdfColors.blue900;
  PdfColor _accentColor = PdfColors.black;
  PdfColor _darkColor = PdfColors.blueGrey800;
  PdfColor _baseTextColor = PdfColors.blue900.luminance < 0.5 ? PdfColors.white : PdfColors.blueGrey800;
  PdfColor _accentTextColor = PdfColors.blue900.luminance < 0.5 ? PdfColors.white : PdfColors.blueGrey800;

  pw.MemoryImage _logotipoImagem;
  pw.MemoryImage _rodapeImagem;

  Future<Uint8List> buildPdf(PdfPageFormat pageFormat) async {

    // Create a PDF document.
    final doc = pw.Document();

    _logotipoImagem = pw.MemoryImage(
      Sessao.empresa.logotipo,
    );
    _rodapeImagem = pw.MemoryImage(
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
        header: _cabecalho,
        footer: _rodape,
        build: (context) => [
          _conteudoCabecalho(context),
          _conteudoItens(context),
          pw.SizedBox(height: 20),
          _conteudoRodape(context),
          pw.SizedBox(height: 20),
          _dadosPagamento(context),
          pw.SizedBox(height: 20),
          _parcelamentoCabecalho(context),
          _conteudoParcelamento(context),
          pw.SizedBox(height: 20),
          _termosCondicoes(context),
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
        child: pw.Image(_rodapeImagem),
      ),
    );
  }

  pw.Widget _cabecalho(pw.Context context) {
    return pw.Column(
      children: [
        pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
            pw.Expanded(
              child: pw.Column(
                mainAxisSize: pw.MainAxisSize.min,
                children: [
                  pw.Container(
                    alignment: pw.Alignment.center,
                    padding: pw.EdgeInsets.only(bottom: 8, right: 30),
                    height: 120,
                    child: pw.Image(_logotipoImagem),
                  ),
                ],
              ),
            ),
            pw.Expanded(
              child: pw.Column(
                children: [
                  pw.Container(
                    height: 50,
                    padding: pw.EdgeInsets.only(left: 20),
                    alignment: pw.Alignment.centerLeft,
                    child: pw.Text(
                      'RECIBO',
                      style: pw.TextStyle(
                        color: _baseColor,
                        fontWeight: pw.FontWeight.bold,
                        fontSize: 40,
                      ),
                    ),
                  ),
                  pw.Container(
                    decoration: pw.BoxDecoration(
                      borderRadius: pw.BorderRadius.all(pw.Radius.circular(2)),
                      color: _accentColor,
                    ),
                    padding: pw.EdgeInsets.only(left: 40, top: 10, bottom: 10, right: 20),
                    alignment: pw.Alignment.centerLeft,
                    height: 35,
                    child: pw.DefaultTextStyle(
                      style: pw.TextStyle(
                        color: _accentTextColor,
                        fontSize: 12,
                      ),
                      child: pw.GridView(
                        crossAxisCount: 2,
                        children: [
                          pw.Text('Data:'),
                          pw.Text(Biblioteca.formatarData(Sessao.vendaAtual.dataVenda)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        if (context.pageNumber > 1) pw.SizedBox(height: 20)
      ],
    );
  }

  pw.Widget _rodape(pw.Context context) {
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

  pw.Widget _conteudoCabecalho(pw.Context context) {
    return pw.Row(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Expanded(
          child: pw.Container(
            margin: pw.EdgeInsets.symmetric(horizontal: 20),
            height: 70,
            child: pw.FittedBox(
              child: pw.Text(
                'Total R\$ ${Constantes.formatoDecimalValor.format(Sessao.vendaAtual.valorFinal ?? 0)}',
                style: pw.TextStyle(
                  color: _baseColor,
                  fontStyle: pw.FontStyle.italic,
                ),
              ),
            ),
          ),
        ),
        pw.Expanded(
          child: pw.Row(
            children: [
              pw.Container(
                margin: pw.EdgeInsets.only(left: 10, right: 10),
                height: 70,
                child: pw.Text(
                  'Cliente:',
                  style: pw.TextStyle(
                    color: _darkColor,
                    fontWeight: pw.FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
              pw.Expanded(
                child: pw.Container(
                  height: 70,
                  child: pw.RichText(
                      text: pw.TextSpan(
                          text: Sessao.vendaAtual.nomeCliente == null ? 'Nome Não Informado' : Sessao.vendaAtual.nomeCliente,
                          style: pw.TextStyle(
                            color: _darkColor,
                            fontWeight: pw.FontWeight.bold,
                            fontSize: 12,
                          ),
                          children: [
                          pw.TextSpan(
                          text: '\n',
                          style: pw.TextStyle(
                            fontSize: 5,
                          ),
                        ),
                        pw.TextSpan(
                          text: 'CPF/CNPJ: ' + (Sessao.vendaAtual.cpfCnpjCliente ?? ''),
                          style: pw.TextStyle(
                            fontWeight: pw.FontWeight.normal,
                            fontSize: 10,
                          ),
                        ),
                      ])),
                ),
              ),
              _dadosVendedor(),
            ],
          ),
        ),
      ],
    );
  }

  pw.Widget _dadosVendedor() {
    if (Sessao.vendaAtual.idColaborador != null) {
      return pw.Container(
        alignment: pw.Alignment.topRight,
        child: pw.Text(
          'Vendedor: ' + Sessao.vendaAtual.idColaborador.toString(),
          style: pw.TextStyle(
            fontWeight: pw.FontWeight.normal,
            fontSize: 10,
            fontStyle: pw.FontStyle.italic,
          ),
        ),
      );
    } else {
      return pw.SizedBox(height: 1);
    }
  }

  pw.Widget _conteudoItens(pw.Context context) {
    const tableHeaders = [
      'Código',
      'Descrição',
      'Unitário',
      'Quantidade',
      'Total  '
    ];

    return pw.Table.fromTextArray(
      border: null,
      cellAlignment: pw.Alignment.centerLeft,
      headerDecoration: pw.BoxDecoration(
        borderRadius: pw.BorderRadius.all(pw.Radius.circular(2)),
        color: _baseColor,
      ),
      headerHeight: 25,
      cellHeight: 40,
      cellAlignments: {
        0: pw.Alignment.centerLeft,
        1: pw.Alignment.centerLeft,
        2: pw.Alignment.centerRight,
        3: pw.Alignment.center,
        4: pw.Alignment.centerRight,
      },
      headerStyle: pw.TextStyle(
        color: _baseTextColor,
        fontSize: 10,
        fontWeight: pw.FontWeight.bold,
      ),
      cellStyle: pw.TextStyle(
        color: _darkColor,
        fontSize: 10,
      ),
      rowDecoration: pw.BoxDecoration(
        border: pw.Border(
          bottom: pw.BorderSide(
            color: _accentColor,
            width: .5,
          ),
        ),
      ),
      headers: List<String>.generate(
        tableHeaders.length,
        (col) => tableHeaders[col],
      ),
      data: List<List<String>>.generate(
        Sessao.listaVendaAtualDetalhe.length,
        (row) => List<String>.generate(
          tableHeaders.length,
          (col) => Sessao.listaVendaAtualDetalhe[row].getIndex(col),
        ),
      ),
    );
  }

  pw.Widget _conteudoRodape(pw.Context context) {
    return pw.Row(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Expanded(
          flex: 2,
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(
                'Obrigado. Volte sempre!',
                style: pw.TextStyle(
                  color: _darkColor,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
              pw.Container(
                margin: pw.EdgeInsets.only(top: 20, bottom: 8),
                child: pw.Text(
                  Sessao.empresa.razaoSocial,
                  style: pw.TextStyle(
                    color: _baseColor,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
              ),
              pw.Text(
                'Email: ' + (Sessao.empresa.email ?? '') +
                ' | ' +
                'Fone: ' + (Sessao.empresa.fone ?? '') +
                ' | ' +
                'Bairro: ' + (Sessao.empresa.bairro ?? '') +
                ' | ' +
                'Cidade: ' + (Sessao.empresa.cidade ?? ''),
                style: pw.TextStyle(
                  fontSize: 8,
                  lineSpacing: 5,
                  color: _darkColor,
                ),
              ),
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
              children: [
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Text('Subtotal:'),
                    pw.Text(
                      'R\$ ${Constantes.formatoDecimalValor.format(Sessao.vendaAtual.valorVenda ?? 0)}'
                    ),
                  ],
                ),
                pw.SizedBox(height: 5),
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Text('Desconto:'),
                    pw.Text(
                      Sessao.vendaAtual.valorDesconto != null 
                      ? '(${Sessao.vendaAtual.taxaDesconto ?? 0}%)'+' R\$ ${Constantes.formatoDecimalValor.format(Sessao.vendaAtual.valorDesconto ?? 0)}'
                      : '(${Sessao.vendaAtual.taxaDesconto ?? 0}%)'+'R\$ ${Constantes.formatoDecimalValor.format(0)}',
                    ),
                  ],
                ),
                pw.Divider(color: _accentColor),
                pw.DefaultTextStyle(
                  style: pw.TextStyle(
                    color: _baseColor,
                    fontSize: 14,
                    fontWeight: pw.FontWeight.bold,
                  ),
                  child: pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Text('Total:'),
                      pw.Text(
                        'R\$ ${Constantes.formatoDecimalValor.format(Sessao.vendaAtual.valorFinal ?? 0)}',
                      ),
                    ],
                  ),
                ),
                pw.SizedBox(height: 5),
                pw.DefaultTextStyle(
                  style: pw.TextStyle(
                    color: PdfColors.red,
                    fontSize: 12,
                    fontWeight: pw.FontWeight.bold,
                  ),
                  child: pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Text('Troco:'),
                      pw.Text(
                        'R\$ ${Constantes.formatoDecimalValor.format(Sessao.vendaAtual.valorTroco ?? 0)}',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  pw.Widget _termosCondicoes(pw.Context context) {
    final textoRecibo = 'Recebemos do cliente identificado acima o Total informado referente à venda dos '
                      'itens discriminados neste documento.';
    return pw.Row(
      crossAxisAlignment: pw.CrossAxisAlignment.end,
      children: [
        pw.Expanded(
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Container(
                decoration: pw.BoxDecoration(
                  border: pw.Border(top: pw.BorderSide(color: _accentColor)),
                ),
                padding: pw.EdgeInsets.only(top: 10, bottom: 4),
                child: pw.Text(
                  'Termos e Condições',
                  style: pw.TextStyle(
                    fontSize: 12,
                    color: _baseColor,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
              ),
              pw.Text(
                textoRecibo,
                textAlign: pw.TextAlign.justify,
                style: pw.TextStyle(
                  fontSize: 6,
                  lineSpacing: 2,
                  color: _darkColor,
                ),
              ),
            ],
          ),
        ),
        pw.Expanded(child: pw.SizedBox(),
        ),
      ],
    );
  }

  pw.Widget _dadosPagamento(pw.Context context) {
    return pw.Row(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Expanded(
          flex: 2,
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
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
              children: _listaPagamento(),
            ),
          ),
        ),
      ],
    );
  }

  List<pw.Widget> _listaPagamento() {
    List<pw.Widget> listaPagamentos = [];
    listaPagamentos.add(pw.Divider(color: _accentColor),);
    listaPagamentos.add(
        pw.Text(
        'Dados de Pagamento',
        style: pw.TextStyle(
          fontSize: 12,
          color: _baseColor,
          fontWeight: pw.FontWeight.bold,
        ),
      ),
    );
    listaPagamentos.add(pw.SizedBox(height: 5),);
                
    for (var itemPagamento in Sessao.listaDadosPagamento) {
      var tipoFiltrado = Sessao.listaTipoPagamento.where( ((tipo) => tipo.id == itemPagamento.idPdvTipoPagamento)).toList();    
      listaPagamentos.add(
        pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
            pw.Text(tipoFiltrado[0].descricao),
            pw.Text(
              'R\$ ${Constantes.formatoDecimalValor.format(itemPagamento.valor ?? 0)}'
            ),
          ],
        ),
      );
      listaPagamentos.add(pw.SizedBox(height: 5),);
    }      

    return listaPagamentos;     
  }
  
  pw.Widget _parcelamentoCabecalho(pw.Context context) {
    if (Sessao.listaParcelamento.length > 0) {
      return pw.Column(children: [
        pw.Divider(color: _accentColor),
        pw.Text(
          'Informação de Parcelamento',
          style: pw.TextStyle(
            fontSize: 12,
            color: PdfColors.green,
            fontWeight: pw.FontWeight.bold,
          ),
        ),
        pw.Divider(color: _accentColor),
      ]);
    } else {
      return pw.SizedBox(height: 1);
    }
  }

  pw.Widget _conteudoParcelamento(pw.Context context) {
    if (Sessao.listaParcelamento.length > 0) {
      const tableHeaders = [
        'Vencimento',
        'Histórico',
        'Valor'
      ];

      return  pw.Table.fromTextArray(
          border: null,
          cellAlignment: pw.Alignment.centerLeft,
          headerDecoration: pw.BoxDecoration(
            borderRadius: pw.BorderRadius.all(pw.Radius.circular(2)),
            color: PdfColors.green,
          ),
          headerHeight: 25,
          cellHeight: 40,
          cellAlignments: {
            0: pw.Alignment.centerLeft,
            1: pw.Alignment.center,
            2: pw.Alignment.centerRight,
          },
          headerStyle: pw.TextStyle(
            color: _baseTextColor,
            fontSize: 10,
            fontWeight: pw.FontWeight.bold,
          ),
          cellStyle: pw.TextStyle(
            color: _darkColor,
            fontSize: 10,
          ),
          rowDecoration: pw.BoxDecoration(
            border: pw.Border(
              bottom: pw.BorderSide(
                color: _accentColor,
                width: .5,
              ),
            ),
          ),
          headers: List<String>.generate(
            tableHeaders.length,
            (col) => tableHeaders[col],
          ),
          data: List<List<String>>.generate(
            Sessao.listaParcelamento.length,
            (row) => List<String>.generate(
              tableHeaders.length,
              (col) => Sessao.listaParcelamento[row].getIndex(col),
            ),
          ),
      );
      
    } else {
      return pw.SizedBox(height: 1);
    }
  }

}
