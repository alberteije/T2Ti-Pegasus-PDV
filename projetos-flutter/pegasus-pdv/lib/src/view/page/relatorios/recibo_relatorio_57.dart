/*
Title: T2Ti ERP 3.0                                                                
Description: Página de relatório do recibo - formato Bobina 57 Colunas
                                                                                
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

OBS: este relatório e o relatório 80 colunas devem ser feitos num mesmo arquivo
alterando apenas as características comuns de cada um. Por enquanto eles ficarão
separados por questões didáticas para o Treinamento T2Ti ERP.
*******************************************************************************/
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import 'package:pegasus_pdv/src/infra/infra.dart';
import 'package:pegasus_pdv/src/infra/atalhos_pdv.dart';

class ReciboRelatorio57 extends StatefulWidget {
  @override
  _ReciboRelatorio57State createState() => _ReciboRelatorio57State();
}

class _ReciboRelatorio57State extends State<ReciboRelatorio57> {
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
            maxPageWidth: 300,
            canChangePageFormat: false,
            build: (format) => _gerarRecibo(),
          ),
        ),
      ),
    );
  }
}

Future<Uint8List> _gerarRecibo() async {
  final recibo = Recibo57();
  return await recibo.buildPdf(
    PdfPageFormat(
      (Sessao.configuracaoPdv.reciboLarguraPagina ?? 57) * 2.83, 
      double.infinity, 
      marginAll: (Sessao.configuracaoPdv.reciboMargemPagina ?? 5) * 2.83)
  );
}

class Recibo57 {
  PdfColor _baseColor = PdfColors.black;
  PdfColor _accentColor = PdfColors.black;
  PdfColor _darkColor = PdfColors.black;
  PdfColor _baseTextColor = PdfColors.blue900.luminance < 0.5 ? PdfColors.white : PdfColors.blueGrey800;

  pw.MemoryImage _logotipoImagem;

  Future<Uint8List> buildPdf(PdfPageFormat pageFormat) async {
 
    // Create a PDF document.
    final doc = pw.Document();

    _logotipoImagem = pw.MemoryImage(
      Sessao.empresa.logotipo,
    );

    final _fontNormal = await rootBundle.load('assets/fonts/lucida-console.ttf');
    final _fontBold = await rootBundle.load('assets/fonts/roboto-bold.ttf');
    final _fontItalic = await rootBundle.load('assets/fonts/roboto-italic.ttf');

    // Add page to the PDF
    doc.addPage(
      pw.Page(
        pageTheme: _buildTheme(
          pageFormat,
          pw.Font.ttf(_fontNormal),
          pw.Font.ttf(_fontBold),
          pw.Font.ttf(_fontItalic),
        ),
        build: (context) => pw.Column(
          children: [
            _cabecalho(context),
            _conteudoCabecalho(context),
            _conteudoItens(context),
            pw.SizedBox(height: 10),
            _totais(context),
            _dadosPagamento(context),
            _parcelamentoCabecalho(context),
            _conteudoParcelamento(context),
            _rodape(context),
          ],
        ),
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
        ignoreMargins: false,
      ),
    );
  }

  pw.Widget _cabecalho(pw.Context context) {
    return pw.Column(
      children: [
        pw.Container(
          alignment: pw.Alignment.center,
          child: pw.Column(
            mainAxisSize: pw.MainAxisSize.min,
            children: [
              pw.Container(
                alignment: pw.Alignment.center,
                padding: pw.EdgeInsets.only(top: -10),
                height: 40,
                child: pw.Image(_logotipoImagem),
              ),
            ],
          ),
        ),
        pw.Container(
          alignment: pw.Alignment.center,
          margin: pw.EdgeInsets.only(top: -2),
          child: pw.Text(
            Sessao.empresa.razaoSocial,
            style: pw.TextStyle(
              color: _baseColor,
              fontWeight: pw.FontWeight.bold,
              fontSize: 10,
            ),
            textAlign: pw.TextAlign.center,  
          ),
        ),
        pw.Container(
          alignment: pw.Alignment.center,
          child: pw.Text(
            'Email: ' + (Sessao.empresa.email ?? '') +
            ' | ' +
            'Fone: ' + (Sessao.empresa.fone ?? '') +
            ' | ' +
            'Bairro: ' + (Sessao.empresa.bairro ?? '') +
            ' | ' +
            'Cidade: ' + (Sessao.empresa.cidade ?? ''),
            textAlign: pw.TextAlign.center,
            style: pw.TextStyle(
              fontSize: 8,
              lineSpacing: 1,
              color: _darkColor,
            ),
          ),
        ),
        pw.Padding(
          padding: const pw.EdgeInsets.only(top: -5, bottom: -5),      
          child: pw.Divider(color: _accentColor),
        ),
        pw.Column(
          mainAxisSize: pw.MainAxisSize.min,
          children: [
            pw.Container(
              alignment: pw.Alignment.center,
              child: pw.Text(
                'RECIBO',
                style: pw.TextStyle(                  
                  color: _baseColor,
                  fontWeight: pw.FontWeight.bold,
                  fontSize: 11,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  pw.Widget _conteudoCabecalho(pw.Context context) {
    return pw.Column(
      children: [
        pw.Container(
          alignment: pw.Alignment.topLeft,
          child: pw.Text(
            'Cliente: ' + (Sessao.vendaAtual.nomeCliente == null ? 'Nome Não Informado' : Sessao.vendaAtual.nomeCliente),
            style: pw.TextStyle(
              color: _darkColor,
              fontWeight: pw.FontWeight.bold,
              fontSize: 9,
            ),
          ),
        ),
        pw.Container(
          alignment: pw.Alignment.topLeft,
          child: pw.Text(
            'CPF/CNPJ: ' + (Sessao.vendaAtual.cpfCnpjCliente ?? ''),
            style: pw.TextStyle(
              fontWeight: pw.FontWeight.normal,
              fontSize: 9,
            ),
          ),
        ),
        pw.Container(
          alignment: pw.Alignment.topRight,
          child: pw.Text(
            'Data: ' + Biblioteca.formatarData(Sessao.vendaAtual.dataVenda),
            style: pw.TextStyle(
              fontWeight: pw.FontWeight.normal,
              fontSize: 8,
              fontStyle: pw.FontStyle.italic,
            ),
          ),
        ),
        _dadosVendedor(),
        pw.SizedBox(height: 5),
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
            fontSize: 8,
            fontStyle: pw.FontStyle.italic,
          ),
        ),
      );
    } else {
      return pw.SizedBox(height: 1);
    }
  }
  
  pw.Widget _conteudoItens(pw.Context context) {
    const tableHeaders = ['It', 'Desc', 'Uni', 'Qtd', 'Tot'];

    return pw.Table.fromTextArray(
      border: null,
      cellAlignment: pw.Alignment.center,
      headerDecoration: pw.BoxDecoration(
        borderRadius: pw.BorderRadius.all(pw.Radius.zero),
        color: _baseColor,
      ),
      cellHeight: 20,
      columnWidths: {
        0: pw.FlexColumnWidth(10),
        1: pw.FlexColumnWidth(25),
        2: pw.FlexColumnWidth(20),
        3: pw.FlexColumnWidth(20),
        4: pw.FlexColumnWidth(25),
      },
      cellAlignments: {
        0: pw.Alignment.centerLeft,
        1: pw.Alignment.centerLeft,
        2: pw.Alignment.centerRight,
        3: pw.Alignment.centerRight,
        4: pw.Alignment.centerRight,
      },
      headerStyle: pw.TextStyle(
        color: _baseTextColor,
        fontSize: 7,
        fontWeight: pw.FontWeight.bold,
      ),
      cellStyle: pw.TextStyle(
        color: _darkColor,
        fontWeight: pw.FontWeight.normal,
        fontSize: 5,
      ),
      rowDecoration: pw.BoxDecoration(
        border: pw.Border(
          bottom: pw.BorderSide(
            color: _accentColor,
            width: .8,
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
          (col) => col == 0 ? Sessao.listaVendaAtualDetalhe[row].getIndex(5) : Sessao.listaVendaAtualDetalhe[row].getIndex(col),
        ),
      ),
    );
  }

  pw.Widget _totais(pw.Context context) {
    return pw.Column(
      children: [
        pw.Container(
          alignment: pw.Alignment.topRight,
          child: pw.DefaultTextStyle(
            style: pw.TextStyle(
              color: _baseColor,
              fontSize: 8,
              // fontWeight: pw.FontWeight.bold,
            ),
            child: pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Text('Subtotal: '),
                pw.Text(
                    'R\$ ${Constantes.formatoDecimalValor.format(Sessao.vendaAtual.valorVenda ?? 0)}'),
              ],
            ),
          ),
        ),
        pw.Container(
          alignment: pw.Alignment.topRight,
          child: pw.DefaultTextStyle(
            style: pw.TextStyle(
              color: _baseColor,
              fontSize: 8,
              // fontWeight: pw.FontWeight.bold,
            ),
            child: pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Text('Desconto: '),
                pw.Text(
                  Sessao.vendaAtual.valorDesconto != null
                      ? '(${Constantes.formatoDecimalValor.format(Sessao.vendaAtual.taxaDesconto ?? 0)}%)' +
                          ' R\$ ${Constantes.formatoDecimalValor.format(Sessao.vendaAtual.valorDesconto ?? 0)}'
                      : '(${Sessao.vendaAtual.taxaDesconto ?? 0}%)' +
                          'R\$ ${Constantes.formatoDecimalValor.format(0)}',
                ),
              ],
            ),
          ),
        ),
        pw.Container(
          alignment: pw.Alignment.topRight,
          child: pw.DefaultTextStyle(
            style: pw.TextStyle(
              color: _baseColor,
              fontSize: 8,
              // fontWeight: pw.FontWeight.bold,
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
        ),
        pw.Container(
          alignment: pw.Alignment.topRight,
          child: pw.DefaultTextStyle(
            style: pw.TextStyle(
              color: _baseColor,
              fontSize: 8,
              // fontWeight: pw.FontWeight.bold,
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
        ),
      ],
    );          
  }

  pw.Widget _dadosPagamento(pw.Context context) {
    return pw.Row(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Expanded(
          flex: 10,
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [],
          ),
        ),
        pw.Expanded(
          flex: 90,
          child: pw.DefaultTextStyle(
            style: pw.TextStyle(
              fontSize: 8,
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
    listaPagamentos.add(
      pw.Padding(
        padding: const pw.EdgeInsets.only(top: -5, bottom: -5),      
        child: pw.Divider(color: _accentColor),
      ),
    );
    if (Sessao.listaDadosPagamento.length > 0) {
      listaPagamentos.add(
        pw.Text(
          'Dados de Pagamento',
          style: pw.TextStyle(
            fontSize: 8,
            color: _baseColor,
            fontWeight: pw.FontWeight.bold,
          ),
        ),
      );
    }

    for (var itemPagamento in Sessao.listaDadosPagamento) {
      var tipoFiltrado = Sessao.listaTipoPagamento
          .where(((tipo) => tipo.id == itemPagamento.idPdvTipoPagamento))
          .toList();
      if (Sessao.listaDadosPagamento.length > 0) {
        listaPagamentos.add(
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Text(tipoFiltrado[0].descricao),
              pw.Text(
                  'R\$ ${Constantes.formatoDecimalValor.format(itemPagamento.valor ?? 0)}'),
            ],
          ),
        );
      }
    }

    return listaPagamentos;
  }

  pw.Widget _parcelamentoCabecalho(pw.Context context) {
    if (Sessao.listaParcelamento.length > 0) {
      return pw.Column(children: [
        pw.Padding(
          padding: const pw.EdgeInsets.only(top: -5, bottom: -5),      
          child: pw.Divider(color: _accentColor),
        ),
        pw.Text(
          'Parcelas',
          style: pw.TextStyle(
            fontSize: 9,
            color: _baseColor,
            fontWeight: pw.FontWeight.bold,
          ),
        ),
        pw.Padding(
          padding: const pw.EdgeInsets.only(top: -5, bottom: -5),      
          child: pw.Divider(color: _accentColor),
        ),
      ]);
    } else {
      return pw.SizedBox(height: 1);
    }
  }

  pw.Widget _conteudoParcelamento(pw.Context context) {
    if (Sessao.listaParcelamento.length > 0) {
      const tableHeaders = ['Venc', 'Histórico', 'Valor'];

      return pw.Table.fromTextArray(
        border: null,
        cellAlignment: pw.Alignment.centerLeft,
        headerDecoration: pw.BoxDecoration(
          borderRadius: pw.BorderRadius.all(pw.Radius.circular(2)),
          color: _baseColor,
        ),
        headerHeight: 20,
        columnWidths: {
          0: pw.FlexColumnWidth(35),
          1: pw.FlexColumnWidth(40),
          2: pw.FlexColumnWidth(25),
        },
        cellAlignments: {
          0: pw.Alignment.centerLeft,
          1: pw.Alignment.center,
          2: pw.Alignment.centerRight,
        },
        headerStyle: pw.TextStyle(
          color: _baseTextColor,
          fontSize: 7,
          fontWeight: pw.FontWeight.bold,
        ),
        cellStyle: pw.TextStyle(
          color: _darkColor,
          fontSize: 5,
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

  pw.Widget _rodape(pw.Context context) {
    return pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.end,
      children: [
        pw.Expanded(
          flex: 2,
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.center,
            children: [
              pw.Container(
                margin: pw.EdgeInsets.only(top: 5, bottom: 1),
              ),
              pw.Text(
                'Obrigado. Volte sempre!',
                style: pw.TextStyle(
                  color: _darkColor,
                  fontWeight: pw.FontWeight.bold,
                  fontSize: 8,
                ),
              ),
              pw.Text(
                'Não possui valor fiscal.',
                style: pw.TextStyle(
                  color: _darkColor,
                  fontWeight: pw.FontWeight.bold,
                  fontSize: 8,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

}
