/*
Title: T2Ti ERP 3.0                                                                
Description: PersistePage relacionada à devolução de mercadoria
                                                                                
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
*******************************************************************************/
import 'package:flutter/material.dart';
import 'package:pegasus_pdv/src/database/database_classes.dart';
import 'package:pegasus_pdv/src/infra/infra.dart';
import 'package:pegasus_pdv/src/infra/atalhos_desktop_web.dart';

class NfeDevolucaoPersistePage extends StatefulWidget {
  final NfeCabecalhoMontado? nfeCabecalhoMontado;
  final Map<String, bool>? itensSelecionados;
  final GlobalKey<FormState>? formKey;
  final GlobalKey<ScaffoldState>? scaffoldKey;
  final FocusNode? foco;

  const NfeDevolucaoPersistePage(
      {Key? key,
      this.formKey,
      this.scaffoldKey,
      this.nfeCabecalhoMontado,
      this.itensSelecionados,
      this.foco})
      : super(key: key);

  @override
  NfeDevolucaoPersistePageState createState() => NfeDevolucaoPersistePageState();
}

class NfeDevolucaoPersistePageState extends State<NfeDevolucaoPersistePage> {
  Map<LogicalKeySet, Intent>? _shortcutMap;
  Map<Type, Action<Intent>>? _actionMap;
  //Map<String, bool> itensSelecionados = {};

  @override
  void initState() {
    super.initState();
    _shortcutMap = getAtalhosPersistePage();

    _actionMap = <Type, Action<Intent>>{
      AtalhoTelaIntent: CallbackAction<AtalhoTelaIntent>(
        onInvoke: _tratarAcoesAtalhos,
      ),
    };
  }

  void _tratarAcoesAtalhos(AtalhoTelaIntent intent) {
    switch (intent.type) {
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
        child: Scaffold(
          body: Scrollbar(
            child: ListView(
              padding: const EdgeInsets.all(2.0),
              children: <Widget>[
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Card(
                    color: Colors.white,
                    elevation: 2.0,
                    child: DataTable(columns: _getColumns(), rows: _getRows()),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<DataColumn> _getColumns() {
    List<DataColumn> lista = [];

    if (!widget.itensSelecionados!.containsKey("-1")) {
      widget.itensSelecionados!["-1"] = false;
    }

    lista.add(DataColumn(label: Checkbox(value: widget.itensSelecionados!["-1"], onChanged: (bool? newValue) {
      setState(() {
        widget.itensSelecionados!.updateAll((key, value) => newValue!);
      });
    } )));
    lista.add(const DataColumn(label: Text('Produto')));
    lista.add(const DataColumn(label: Text('Código do Produto')));
    lista.add(const DataColumn(label: Text('GTIN')));
    lista.add(const DataColumn(label: Text('Unidade')));
    lista.add(const DataColumn(numeric: true, label: Text('Quantidade')));
    lista.add(const DataColumn(numeric: true, label: Text('Valor Unitário')));
    lista.add(const DataColumn(numeric: true, label: Text('Valor Desconto')));
    lista.add(const DataColumn(numeric: true, label: Text('Valor Subtotal')));
    lista.add(const DataColumn(numeric: true, label: Text('Valor Total')));
    return lista;
  }

  List<DataRow> _getRows() {
    List<DataRow> lista = [];
    for (var nfeDetalheMontado
        in widget.nfeCabecalhoMontado!.listaNfeDetalheMontado!) {
      List<DataCell> celulas = [];

      if (nfeDetalheMontado.nfeDetalhe!.percentualDevolvido == null && !widget.itensSelecionados!.containsKey(nfeDetalheMontado.nfeDetalhe!.id.toString())) {
        widget.itensSelecionados![nfeDetalheMontado.nfeDetalhe!.id.toString()] = false;
      }

      celulas = [
        DataCell(nfeDetalheMontado.nfeDetalhe!.percentualDevolvido != null ? const Text("Item já devolvido") :
          Checkbox(value: widget.itensSelecionados![nfeDetalheMontado.nfeDetalhe!.id.toString()], onChanged: (bool? newValue) { setState(() {
            widget.itensSelecionados![nfeDetalheMontado.nfeDetalhe!.id.toString()] =  newValue!;
          });}),
        ),
        // DataCell(Text('${nfeDetalheMontado.nfeDetalhe.numeroItem ?? ''}'), ),
        DataCell(
          Text(nfeDetalheMontado.nfeDetalhe!.nomeProduto ?? ''),
        ),
        DataCell(
          Text(nfeDetalheMontado.nfeDetalhe!.codigoProduto ?? ''),
        ),
        DataCell(
          Text(nfeDetalheMontado.nfeDetalhe!.gtin ?? ''),
        ),
        DataCell(
          Text(nfeDetalheMontado.nfeDetalhe!.unidadeComercial ?? ''),
        ),
        DataCell(
          Text(Biblioteca.formatarValorDecimal(
              nfeDetalheMontado.nfeDetalhe!.quantidadeComercial)),
        ),
        DataCell(
          Text(Biblioteca.formatarValorDecimal(
              nfeDetalheMontado.nfeDetalhe!.valorUnitarioComercial)),
        ),
        DataCell(
          Text(Biblioteca.formatarValorDecimal(
              nfeDetalheMontado.nfeDetalhe!.valorDesconto)),
        ),
        DataCell(
          Text(Biblioteca.formatarValorDecimal(
              nfeDetalheMontado.nfeDetalhe!.valorSubtotal)),
        ),
        DataCell(
          Text(Biblioteca.formatarValorDecimal(
              nfeDetalheMontado.nfeDetalhe!.valorTotal)),
        ),
      ];

      lista.add(DataRow(cells: celulas));
    }
    return lista;
  }

}
