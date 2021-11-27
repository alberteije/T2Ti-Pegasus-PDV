/*
Title: T2Ti ERP 3.0                                                                
Description: AbaDetalhe ListaPage relacionada à tabela [PRODUTO_FICHA_TECNICA] 
                                                                                
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
import 'package:pegasus_pdv/src/infra/biblioteca.dart';

import 'package:pegasus_pdv/src/infra/constantes.dart';

import 'package:pegasus_pdv/src/database/database_classes.dart';
import 'package:pegasus_pdv/src/view/page/cadastros/produto/produto_page.dart';

import 'package:pegasus_pdv/src/view/shared/view_util_lib.dart';
import 'package:pegasus_pdv/src/infra/atalhos_desktop_web.dart';

import 'produto_ficha_tecnica_persiste_page.dart';

class ProdutoFichaTecnicaListaPage extends StatefulWidget {
  final Produto? produto;
  final FocusNode? foco;
  final Function? salvarProdutoCallBack;

  const ProdutoFichaTecnicaListaPage({Key? key, this.produto, this.foco, this.salvarProdutoCallBack}) : super(key: key);

  @override
  _ProdutoFichaTecnicaListaPageState createState() => _ProdutoFichaTecnicaListaPageState();
}

class _ProdutoFichaTecnicaListaPageState extends State<ProdutoFichaTecnicaListaPage> {
  Map<LogicalKeySet, Intent>? _shortcutMap; 
  Map<Type, Action<Intent>>? _actionMap;

  @override
  void initState() {
    super.initState();
    _shortcutMap = getAtalhosAbaPage();

    _actionMap = <Type, Action<Intent>>{
      AtalhoTelaIntent: CallbackAction<AtalhoTelaIntent>(
        onInvoke: _tratarAcoesAtalhos,
      ),
    };
  }

  void _tratarAcoesAtalhos(AtalhoTelaIntent intent) {
    switch (intent.type) {
      case AtalhoTelaType.inserir:
        _inserir();
        break;
      case AtalhoTelaType.salvar:
        widget.salvarProdutoCallBack!();
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
        child: Scaffold(
          floatingActionButton: FloatingActionButton(
            focusNode: widget.foco,
            autofocus: true,
            focusColor: ViewUtilLib.getBotaoFocusColor(),
            tooltip: Constantes.botaoInserirDica,
            backgroundColor: ViewUtilLib.getBackgroundColorBotaoInserir(),
            child: ViewUtilLib.getIconBotaoInserir(),
            onPressed: () {
              _inserir();
            }),
          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
          body: Scrollbar(
            child: ListView(
              padding: const EdgeInsets.all(2.0),
              children: <Widget>[
                const Divider(color: Colors.black,),
                Text('Produto Pai: ' + (widget.produto?.nome ?? ''),
                  style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 18.0, color: Colors.blue, fontStyle: FontStyle.italic),
                ),
                const Divider(color: Colors.black,),
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

  void _inserir() async {
    ProdutoFichaTecnica? _produtoFichaTecnica = ProdutoFichaTecnica(id: null);
    _produtoFichaTecnica = await Navigator.of(context)
      .push(MaterialPageRoute(
        builder: (BuildContext context) =>
          ProdutoFichaTecnicaPersistePage(
            produto: widget.produto,
            produtoFichaTecnica: _produtoFichaTecnica,
            title: 'Produto Ficha Tecnica - Inserindo',
            operacao: 'I')));
      if (_produtoFichaTecnica != null) { 
        listaProdutoFichaTecnica.add(_produtoFichaTecnica);
      }
      setState(() {
        _getRows();
      });
  }
  
  List<DataColumn> _getColumns() {
    List<DataColumn> lista = [];
    lista.add(const DataColumn(label: Text('Produto / Insumo')));
    lista.add(const DataColumn(numeric: true, label: Text('Quantidade')));
    lista.add(const DataColumn(numeric: true, label: Text('Valor Custo')));
    lista.add(const DataColumn(numeric: true, label: Text('Percentual Custo')));
    return lista;
  }

  List<DataRow> _getRows() {
    List<DataRow> lista = [];
    for (var produtoFichaTecnica in listaProdutoFichaTecnica) {
      List<DataCell> _celulas = [];

      _celulas = [
          DataCell(Text(produtoFichaTecnica.descricao ?? ''), onTap: () { 
            _detalharProdutoFichaTecnica(widget.produto, produtoFichaTecnica, context);
          }),
          DataCell(Text(Biblioteca.formatarValorDecimal(produtoFichaTecnica.quantidade)), onTap: () {
            _detalharProdutoFichaTecnica(widget.produto, produtoFichaTecnica, context);
          }),
          DataCell(Text(Biblioteca.formatarValorDecimal(produtoFichaTecnica.valorCusto)), onTap: () {
            _detalharProdutoFichaTecnica(widget.produto, produtoFichaTecnica, context);
          }),
          DataCell(Text(Biblioteca.formatarValorDecimal(produtoFichaTecnica.percentualCusto)), onTap: () {
            _detalharProdutoFichaTecnica(widget.produto, produtoFichaTecnica, context);
          }),
      ];

      lista.add(DataRow(cells: _celulas));
    }
    return lista;
  }

  void _detalharProdutoFichaTecnica(Produto? produto, ProdutoFichaTecnica produtoFichaTecnica, BuildContext context) {
        Navigator.of(context)
          .push(MaterialPageRoute(
            builder: (BuildContext context) => ProdutoFichaTecnicaPersistePage(
              produto: produto,
              produtoFichaTecnica: produtoFichaTecnica,
			  title: "Produto Ficha Tecnica - Editando",
			  operacao: "A"
			)))
          .then((_) {
            setState(() {
              _getRows();
            });
          });
  }
  
}