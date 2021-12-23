/*
Title: T2Ti ERP 3.0                                                                
Description: Página de relatório da comanda - formato Bobina 80 Colunas
                                                                                
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
@contributor Denis Silva (denyjav@yahoo.com.br)                 
@version 1.0.0
Adaptado de: https://github.com/DavBfr/dart_pdf/tree/master/printing

OBS: este relatório e o relatório 57 colunas devem ser feitos num mesmo arquivo
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

class ComandaRelatorio80 extends StatefulWidget {
  const ComandaRelatorio80({Key? key}) : super(key: key);

  @override
  _ComandaRelatorio80State createState() => _ComandaRelatorio80State();
}

class _ComandaRelatorio80State extends State<ComandaRelatorio80> {
  Map<LogicalKeySet, Intent>? _shortcutMap;
  Map<Type, Action<Intent>>? _actionMap;

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
            title: const Text('Comanda'),
          ),
          body: PdfPreview(
            maxPageWidth: 400,
            canChangePageFormat: false,
            build: (format) => _gerarComanda(),
          ),
        ),
      ),
    );
  }
}

Future<Uint8List> _gerarComanda() async {
  final recibo = Comanda80();
  return await recibo.buildPdf(
    PdfPageFormat(
      (Sessao.configuracaoPdv!.reciboLarguraPagina ?? 80) * 2.83, 
      double.infinity, 
      marginAll: (Sessao.configuracaoPdv!.reciboMargemPagina ?? 5) * 2.83)
  );
}

class Comanda80 {
  final PdfColor _baseColor = PdfColors.black;
  final PdfColor _accentColor = PdfColors.black;
  final PdfColor _darkColor = PdfColors.black;
  final PdfColor _baseTextColor = PdfColors.blue900.luminance < 0.5 ? PdfColors.white : PdfColors.blueGrey800;

  Future<Uint8List> buildPdf(PdfPageFormat pageFormat) async {
 
    // Create a PDF document.
    final doc = pw.Document();

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
            _conteudoItens(context),
            pw.SizedBox(height: 10),
            _totais(context),
            _dadosDelivery(context),
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
    List<pw.Widget> lista = [];

    lista.add(
      pw.Divider(color: _accentColor),      
    );
    lista.add(
        pw.Column(
          mainAxisSize: pw.MainAxisSize.min,
          children: [
            pw.Container(
              alignment: pw.Alignment.center,
              child: pw.Text(
                'COMANDA: ' + Sessao.comandaMontadoAtual!.comanda!.id.toString().padLeft(8, '0'),
                style: pw.TextStyle(                  
                  color: _baseColor,
                  fontWeight: pw.FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
    );
    lista.add(
      pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          pw.Text(
            'Data: ' + Biblioteca.formatarData(Sessao.comandaMontadoAtual!.comanda!.dataChegada),
            style: pw.TextStyle(
              fontWeight: pw.FontWeight.normal,
              fontSize: 8,
              fontStyle: pw.FontStyle.italic,
            ),
          ),
          pw.Text(
            'Hora: ' + Sessao.comandaMontadoAtual!.comanda!.horaChegada!,
            style: pw.TextStyle(
              fontWeight: pw.FontWeight.normal,
              fontSize: 8,
              fontStyle: pw.FontStyle.italic,
            ),
          ),
        ] 
      ),
    );

    // pega apenas uma parte do nome do colaborador para não estrapolar o tamanho na comanda
    var nomeResponsavel = Sessao.comandaMontadoAtual!.colaborador?.nome ?? 'NÃO INFORMADO';
    if (Sessao.comandaMontadoAtual!.colaborador?.nome != null) {
      if (Sessao.comandaMontadoAtual!.colaborador!.nome!.length > 20) {
        nomeResponsavel = Sessao.comandaMontadoAtual!.colaborador!.nome!.substring(0,20);
      }
    }
    // pega apenas uma parte do nome do cliente para não estrapolar o tamanho na comanda
    var nomeCliente = Sessao.comandaMontadoAtual!.cliente?.nome ?? 'NÃO INFORMADO';
    if (Sessao.comandaMontadoAtual!.cliente?.nome != null) {
      if (Sessao.comandaMontadoAtual!.cliente!.nome!.length > 50) {
        nomeCliente = Sessao.comandaMontadoAtual!.cliente!.nome!.substring(0,50);
      }
    }
    
    // =========================
    // comanda Indoor - início
    // =========================
    if (Sessao.comandaMontadoAtual!.comanda!.tipo == 'I') {
      lista.add(
        pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
            pw.Text(
              'Mesa: ' + Sessao.comandaMontadoAtual!.mesa!.numero!.padLeft(3, '0'),
              style: pw.TextStyle(
                fontWeight: pw.FontWeight.normal,
                fontSize: 8,
                fontStyle: pw.FontStyle.italic,
              ),
            ),
            pw.Text(
              'Responsável: ' + nomeResponsavel,
              style: pw.TextStyle(
                fontWeight: pw.FontWeight.normal,
                fontSize: 8,
                fontStyle: pw.FontStyle.italic,
              ),
            ),
          ] 
        ),
      );
      lista.add(
        pw.Row(
          children: [
            pw.Text(
              'Quantidade de Pessoas na Comanda: ' + Sessao.comandaMontadoAtual!.comanda!.quantidadePessoas!.toString().padLeft(2, '0'),
              style: pw.TextStyle(
                fontWeight: pw.FontWeight.normal,
                fontSize: 8,
                fontStyle: pw.FontStyle.italic,
              ),
            ),
          ] 
        ),
      );
    }

    lista.add(
      pw.Container(
        alignment: pw.Alignment.topLeft,
        child: pw.Text(
          'Cliente: ' + nomeCliente,
          style: pw.TextStyle(
            color: _darkColor,
            fontWeight: pw.FontWeight.bold,
            fontSize: 10,
          ),
        ),
      ),
    );

    lista.add(
      pw.Divider(color: _accentColor),      
    );

    return pw.Column(
      children: lista,
    );
  }

  pw.Widget _conteudoItens(pw.Context context) {
    List<pw.Widget> lista = [];

    lista.add(
      pw.Table(        
        children: [
          pw.TableRow(
            children: [
              pw.Container(
                color: _darkColor,
                height: 15,
                width: 1,
                child: pw.Row(
                  children: _pegarColunasTabela(),
                ),
              ),
            ],
          )
        ]
      ),
    );

    lista.add(
      pw.Table(        
        children: _pegarLinhasTabela(),
      ),
    );

    return pw.Column(
      children: lista,
    );
  }

  List<pw.Widget> _pegarColunasTabela() {
    return [
      pw.Expanded(                    
        flex: 12,
        child: pw.Text(''),
      ),
      pw.Expanded(
        flex: 38,
        child: pw.Text(
          'Descrição', 
          style: pw.TextStyle(
            color: _baseTextColor,
            fontSize: 8,
            fontWeight: pw.FontWeight.bold,
          ),
        ),
      ),
      pw.Expanded(
        flex: 15,
        child: pw.Align(
          alignment: pw.Alignment.centerRight, 
          child: pw.Text(
            'V.Uni',
            style: pw.TextStyle(
              color: _baseTextColor,
              fontSize: 8,
              fontWeight: pw.FontWeight.bold,                        
            ),
          ),
        ),
      ),
      pw.Expanded(
        flex: 15,
        child: pw.Align(
          alignment: pw.Alignment.centerRight, 
          child: pw.Text(
            'Qtde',
            style: pw.TextStyle(
              color: _baseTextColor,
              fontSize: 8,
              fontWeight: pw.FontWeight.bold,                        
            ),
          ),
        ),
      ),
      pw.Expanded(
        flex: 20,
        child: pw.Align(
          alignment: pw.Alignment.centerRight, 
          child: pw.Text(
            'V.Tot ',
            style: pw.TextStyle(
              color: _baseTextColor,
              fontSize: 8,
              fontWeight: pw.FontWeight.bold,                        
            ),
          ),
        ),
      ),
    ];
  }

  List<pw.TableRow> _pegarLinhasTabela() {
    List<pw.TableRow> lista = [];

    for (var i = 0; i < Sessao.comandaMontadoAtual!.listaComandaDetalheMontado!.length; i++) {
      double totalGeralItem = 0;
  
      final item = Sessao.comandaMontadoAtual!.listaComandaDetalheMontado![i];
      final totalItem = (item.comandaDetalhe!.quantidade ?? 0) * (item.comandaDetalhe!.valorUnitario ?? 0);
      totalGeralItem = totalGeralItem + totalItem;

      if (i > 0) {
        lista.add(
          pw.TableRow(
            children: [
              pw.Padding(
                padding: const pw.EdgeInsets.only(top: -5, bottom: -5),      
                child: pw.Divider(color: _accentColor),
              ),
            ],
          ),
        );
      }

      // Item
      lista.add(
        pw.TableRow(
          children: [
            pw.Container(
              color: _baseTextColor,
              width: 1,
              child: pw.Row(
                children: [
                  pw.Expanded( 
                    flex: 12,
                    child: pw.Paragraph(
                      margin: const pw.EdgeInsets.fromLTRB(0, 1, 0, 0),
                      textAlign: pw.TextAlign.center,
                      text: (i+1).toString(), 
                      style: pw.TextStyle(
                        color: _baseColor,
                        fontSize: 6,
                        fontWeight: pw.FontWeight.normal,
                      ),
                    ),
                  ),
                  pw.Expanded(
                    flex: 38,
                    child: pw.Paragraph(
                      margin: const pw.EdgeInsets.fromLTRB(0, 1, 0, 0),
                      textAlign: pw.TextAlign.left,
                      text: item.produtoMontado!.produto!.nome!, 
                      style: pw.TextStyle(
                        color: _baseColor,
                        fontSize: 6,
                        fontWeight: pw.FontWeight.normal,
                      ),
                    ),
                  ),
                  pw.Expanded(
                    flex: 15,
                    child: pw.Paragraph(
                      margin: const pw.EdgeInsets.fromLTRB(0, 1, 0, 0),
                      textAlign: pw.TextAlign.right,
                      text: Biblioteca.formatarValorDecimal(item.comandaDetalhe!.valorUnitario), 
                      style: pw.TextStyle(
                        color: _baseColor,
                        fontSize: 6,
                        fontWeight: pw.FontWeight.normal,
                      ),
                    ),
                  ),
                  pw.Expanded(
                    flex: 15,
                    child: pw.Paragraph(
                      margin: const pw.EdgeInsets.fromLTRB(0, 1, 0, 0),
                      textAlign: pw.TextAlign.right,
                      text: Biblioteca.formatarValorDecimal(item.comandaDetalhe!.quantidade), 
                      style: pw.TextStyle(
                        color: _baseColor,
                        fontSize: 6,
                        fontWeight: pw.FontWeight.normal,
                      ),
                    ),
                  ),
                  pw.Expanded(
                    flex: 20,
                    child: pw.Paragraph(
                      margin: const pw.EdgeInsets.fromLTRB(0, 1, 0, 0),
                      textAlign: pw.TextAlign.right,
                      text: Biblioteca.formatarValorDecimal(totalItem), 
                      style: pw.TextStyle(
                        color: _baseColor,
                        fontSize: 6,
                        fontWeight: pw.FontWeight.normal,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );

      // Complementos
      if (item.listaComandaDetalheComplemento!.isNotEmpty) {
        lista.add(
          pw.TableRow(
            children: [
              pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Align(
                    alignment: pw.Alignment.topLeft, 
                    child: pw.Text(
                      'Complementos',
                      style: pw.TextStyle(
                        color: _baseColor,
                        fontSize: 7,
                        fontWeight: pw.FontWeight.bold,                        
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );

        for (var j = 0; j < item.listaComandaDetalheComplemento!.length; j++) {
          final complemento = item.listaComandaDetalheComplemento![j];
          totalGeralItem = totalGeralItem + complemento.valorTotal!;
        
          lista.add(
            pw.TableRow(
              children: [
                pw.Container(
                  color: _baseTextColor,
                  width: 1,
                  child: pw.Row(
                    children: [
                      pw.Expanded(                    
                        flex: 12,
                        child: pw.Align(
                          alignment: pw.Alignment.centerRight, 
                          child: pw.Text(
                            (j+1).toString(),
                            style: pw.TextStyle(
                              color: _baseColor,
                              fontSize: 6,
                              fontWeight: pw.FontWeight.normal,                        
                            ),
                          ),
                        ),
                      ),
                      pw.Expanded(
                        flex: 5,
                        child: pw.SizedBox(width: 5)
                      ),
                      pw.Expanded(
                        flex: 61,
                        child: pw.Text(
                          complemento.nomeProduto!, 
                          style: pw.TextStyle(
                            color: _baseColor,
                            fontSize: 6,
                            fontWeight: pw.FontWeight.normal,
                          ),
                        ),
                      ),
                      pw.Expanded(
                        flex: 1,
                        child: pw.SizedBox(width: 1)
                      ),
                      pw.Expanded(
                        flex: 1,
                        child: pw.SizedBox(width: 1)
                      ),
                      pw.Expanded(
                        flex: 20,
                        child: pw.Align(
                          alignment: pw.Alignment.centerRight, 
                          child: pw.Text(
                            Biblioteca.formatarValorDecimal(complemento.valorTotal ?? 0),
                            style: pw.TextStyle(
                              color: _baseColor,
                              fontSize: 6,
                              fontWeight: pw.FontWeight.normal,                        
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }
      }

      // Observações
      if (item.comandaDetalhe!.observacao != null && item.comandaDetalhe!.observacao != '') {
        lista.add(
          pw.TableRow(                        
            children: [
              pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Align(
                    alignment: pw.Alignment.topLeft, 
                    child: pw.Text(
                      'Observações',
                      style: pw.TextStyle(
                        color: _baseColor,
                        fontSize: 7,
                        fontWeight: pw.FontWeight.bold,                        
                      ),
                    ),
                  ),
                  pw.Align(
                    alignment: pw.Alignment.topLeft, 
                    child: pw.Text(
                      item.comandaDetalhe!.observacao!,
                      style: pw.TextStyle(
                        color: _baseColor,
                        fontSize: 6,
                        fontWeight: pw.FontWeight.normal,                        
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      }

      // total geral do item
      lista.add(
        pw.TableRow(
          children: [
            pw.Container(
              padding: const pw.EdgeInsets.fromLTRB(0, 2, 0, 0),
              color: _baseTextColor,
              width: 1,
              child: pw.Row(
                children: [
                  pw.Expanded(                    
                    flex: 12,
                    child: pw.SizedBox(width: 12)
                  ),
                  pw.Expanded(
                    flex: 5,
                    child: pw.SizedBox(width: 5)
                  ),
                  pw.Expanded(
                    flex: 61,
                    child: pw.Text(
                      'Total do Item + Complementos: ', 
                      style: pw.TextStyle(
                        color: _baseColor,
                        fontSize: 6,
                        fontWeight: pw.FontWeight.normal,
                        fontStyle: pw.FontStyle.italic,
                      ),
                    ),
                  ),
                  pw.Expanded(
                    flex: 1,
                    child: pw.SizedBox(width: 1)
                  ),
                  pw.Expanded(
                    flex: 1,
                    child: pw.SizedBox(width: 1)
                  ),
                  pw.Expanded(
                    flex: 20,
                    child: pw.Align(
                      alignment: pw.Alignment.centerRight, 
                      child: pw.Text(
                        Biblioteca.formatarValorDecimal(totalGeralItem),
                        style: pw.TextStyle(
                          color: _baseColor,
                          fontSize: 6,
                          fontWeight: pw.FontWeight.normal,                        
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
            
    }
    
    return lista;
  }

  pw.Widget _totais(pw.Context context) {
    final taxaDesconto = Biblioteca.dividirMonetario(
      ((Sessao.comandaMontadoAtual!.comanda!.valorDesconto ?? 0) * 100),
      (Sessao.comandaMontadoAtual!.comanda!.valorSubtotal ?? 0)
    );
    return pw.Column(
      children: [
        pw.Container(
          alignment: pw.Alignment.topRight,
          child: pw.DefaultTextStyle(
            style: pw.TextStyle(
              color: _baseColor,
              fontSize: 10,
              // fontWeight: pw.FontWeight.bold,
            ),
            child: pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Text('Subtotal: '),
                pw.Text(
                    'R\$ ${Biblioteca.formatarValorDecimal(Sessao.comandaMontadoAtual!.comanda!.valorSubtotal ?? 0)}'),
              ],
            ),
          ),
        ),
        pw.Container(
          alignment: pw.Alignment.topRight,
          child: pw.DefaultTextStyle(
            style: pw.TextStyle(
              color: _baseColor,
              fontSize: 10,
              // fontWeight: pw.FontWeight.bold,
            ),
            child: pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Text('Desconto: '),
                pw.Text(
                        '(${Biblioteca.formatarValorDecimal(taxaDesconto)}%)' 
                        ' R\$ ${Biblioteca.formatarValorDecimal(Sessao.comandaMontadoAtual!.comanda!.valorDesconto)}',
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
              fontSize: 10,
              // fontWeight: pw.FontWeight.bold,
            ),
            child: pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Text('Total:'),
                pw.Text(
                  'R\$ ${Biblioteca.formatarValorDecimal(Sessao.comandaMontadoAtual!.comanda!.valorTotal)}',
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
              fontSize: 10,
              // fontWeight: pw.FontWeight.bold,
            ),
            child: pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Text('Total por Pessoa:'),
                pw.Text(
                  'R\$ ${Biblioteca.formatarValorDecimal(Sessao.comandaMontadoAtual!.comanda!.valorPorPessoa)}',
                ),
              ],
            ),
          ),
        ),
      ],
    );          
  }

  pw.Widget _dadosDelivery(pw.Context context) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: _pegarDadosEntrega(),
    );
  }

  List<pw.Widget> _pegarDadosEntrega() {
    List<pw.Widget> listaDadosEntrega = [];
    listaDadosEntrega.add(
      pw.Padding(
        padding: const pw.EdgeInsets.only(top: -5, bottom: -5),      
        child: pw.Divider(color: _accentColor),
      ),
    );
    if (Sessao.comandaMontadoAtual!.comanda!.tipo == 'D') {
      listaDadosEntrega.add(
        pw.Text(
          'Dados para Entrega',
          style: pw.TextStyle(
            fontSize: 12,
            color: _baseColor,
            fontWeight: pw.FontWeight.bold,
          ),
        ),
      );
      listaDadosEntrega.add(
        pw.SizedBox(height: 2),
      );
      listaDadosEntrega.add(
        pw.Paragraph(
          margin: const pw.EdgeInsets.fromLTRB(0, 1, 0, 0),
          textAlign: pw.TextAlign.left,
          text: 'Cliente: ' + (Sessao.comandaMontadoAtual?.cliente?.nome ?? ''), 
          style: pw.TextStyle(
            color: _baseColor,
            fontSize: 9,
            fontWeight: pw.FontWeight.normal,
          ),
        ),        
      );
      listaDadosEntrega.add(
        pw.Paragraph(
          margin: const pw.EdgeInsets.fromLTRB(0, 1, 0, 0),
          textAlign: pw.TextAlign.left,
          text: 'Logradouro: ' + (Sessao.comandaMontadoAtual?.cliente?.logradouro ?? ''), 
          style: pw.TextStyle(
            color: _baseColor,
            fontSize: 9,
            fontWeight: pw.FontWeight.normal,
          ),
        ),        
      );
      listaDadosEntrega.add(
        pw.Paragraph(
          margin: const pw.EdgeInsets.fromLTRB(0, 1, 0, 0),
          textAlign: pw.TextAlign.left,
          text: 'Número: ' + (Sessao.comandaMontadoAtual?.cliente?.numero ?? ''), 
          style: pw.TextStyle(
            color: _baseColor,
            fontSize: 9,
            fontWeight: pw.FontWeight.normal,
          ),
        ),        
      );
      listaDadosEntrega.add(
        pw.Paragraph(
          margin: const pw.EdgeInsets.fromLTRB(0, 1, 0, 0),
          textAlign: pw.TextAlign.left,
          text: 'Complemento: ' + (Sessao.comandaMontadoAtual?.cliente?.complemento ?? ''), 
          style: pw.TextStyle(
            color: _baseColor,
            fontSize: 9,
            fontWeight: pw.FontWeight.normal,
          ),
        ),        
      );
      listaDadosEntrega.add(
        pw.Paragraph(
          margin: const pw.EdgeInsets.fromLTRB(0, 1, 0, 0),
          textAlign: pw.TextAlign.left,
          text: 'Bairro: ' + (Sessao.comandaMontadoAtual?.cliente?.bairro ?? ''), 
          style: pw.TextStyle(
            color: _baseColor,
            fontSize: 9,
            fontWeight: pw.FontWeight.normal,
          ),
        ),        
      );
      listaDadosEntrega.add(
        pw.Paragraph(
          margin: const pw.EdgeInsets.fromLTRB(0, 1, 0, 0),
          textAlign: pw.TextAlign.left,
          text: 'Cidade: ' + (Sessao.comandaMontadoAtual?.cliente?.cidade ?? '') + ' - ' + (Sessao.comandaMontadoAtual?.cliente?.uf ?? ''), 
          style: pw.TextStyle(
            color: _baseColor,
            fontSize: 9,
            fontWeight: pw.FontWeight.normal,
          ),
        ),        
      );
      listaDadosEntrega.add(
        pw.Paragraph(
          margin: const pw.EdgeInsets.fromLTRB(0, 1, 0, 0),
          textAlign: pw.TextAlign.left,
          text: 'CEP: ' + (Sessao.comandaMontadoAtual?.cliente?.cep ?? ''), 
          style: pw.TextStyle(
            color: _baseColor,
            fontSize: 9,
            fontWeight: pw.FontWeight.normal,
          ),
        ),        
      );
      listaDadosEntrega.add(
        pw.Paragraph(
          margin: const pw.EdgeInsets.fromLTRB(0, 1, 0, 0),
          textAlign: pw.TextAlign.left,
          text: 'Telefones: ' + (Sessao.comandaMontadoAtual?.cliente?.telefone ?? '') + ' - ' + (Sessao.comandaMontadoAtual?.cliente?.celular ?? ''), 
          style: pw.TextStyle(
            color: _baseColor,
            fontSize: 9,
            fontWeight: pw.FontWeight.normal,
          ),
        ),        
      );
      listaDadosEntrega.add(
        pw.Padding(
          padding: const pw.EdgeInsets.only(top: -5, bottom: -5),      
          child: pw.Divider(color: _accentColor),
        ),
      );
    }

    return listaDadosEntrega;
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
                margin: const pw.EdgeInsets.only(top: 5, bottom: 1),
              ),
              pw.Text(
                'Não possui valor fiscal',
                style: pw.TextStyle(
                  color: _darkColor,
                  fontWeight: pw.FontWeight.bold,
                  fontSize: 12,
                ),
              ),
              pw.Text(
                Constantes.nomeApp + ' ' + Constantes.versaoApp,
                style: pw.TextStyle(
                  color: _darkColor,
                  fontWeight: pw.FontWeight.normal,
                  fontStyle: pw.FontStyle.italic,
                  fontSize: 7,
                ),
              ),
              pw.Text(
                Constantes.dadosSoftwareHouse,
                style: pw.TextStyle(
                  color: _darkColor,
                  fontWeight: pw.FontWeight.normal,
                  fontSize: 6,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

}
