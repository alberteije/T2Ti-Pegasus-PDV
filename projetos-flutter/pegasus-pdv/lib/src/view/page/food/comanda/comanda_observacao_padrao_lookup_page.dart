/*
Title: T2Ti ERP 3.0                                                                
Description: Página de lookup específica para a observação da comanda
                                                                                
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

import 'package:pegasus_pdv/src/view/shared/view_util_lib.dart';
import 'package:pegasus_pdv/src/view/shared/botoes.dart';

class ComandaObservacaoPadraoLookupPage extends StatefulWidget {
  const ComandaObservacaoPadraoLookupPage({Key? key}) : super(key: key);

  @override
  _ComandaObservacaoPadraoLookupPageState createState() => _ComandaObservacaoPadraoLookupPageState();
}

class _ComandaObservacaoPadraoLookupPageState extends State<ComandaObservacaoPadraoLookupPage> {
  List<ComandaObservacaoPadrao> _listaComandaObservacaoPadrao = [];
  final _itensSelecionados = [];

  Map<LogicalKeySet, Intent>? _shortcutMap; 
  Map<Type, Action<Intent>>? _actionMap;

  @override
  void initState() {
    super.initState();
    _shortcutMap = getAtalhosPersistePage();

    _actionMap = <Type, Action<Intent>>{
      AtalhoTelaIntent: CallbackAction<AtalhoTelaIntent>(
        onInvoke: _tratarAcoesAtalhos,
      ),
    };

    WidgetsBinding.instance!.addPostFrameCallback((_) => _refrescarTela());
  }
  
  void _tratarAcoesAtalhos(AtalhoTelaIntent intent) {
    switch (intent.type) {
      case AtalhoTelaType.salvar:
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
            title: const Text('Selecione as observações desejadas'),
            actions: const <Widget>[],
          ),
          bottomNavigationBar: BottomAppBar(
            color: ViewUtilLib.getBottomAppBarColor(),          
            shape: const CircularNotchedRectangle(),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: _getBotoesRodape(context: context),
            ),
          ),
          body: RefreshIndicator(
            onRefresh: _refrescarTela,
            child: Scrollbar(
              child: ListView(
                padding: const EdgeInsets.all(Constantes.paddingListViewListaPage),
                children: <Widget>[
                  DataTable(  
                    showCheckboxColumn: true,                     
                    columns: const [
                      DataColumn(
                        label: Text('Código'),
                        tooltip: 'Código',
                      ),
                      DataColumn(
                        label: Text('Descrição'),
                        tooltip: 'Descrição',
                      ),
                    ],
                    rows: _getRows(),
                  ),
                ],
              ),
            ),
          ),          
        ),
      ),
    );
  }

  List<DataRow> _getRows() {
    List<DataRow> lista = [];
    
    for (var comandaObservacaoPadrao in _listaComandaObservacaoPadrao) {
      List<DataCell> celulas = [];

      celulas = [
        DataCell(Text(comandaObservacaoPadrao.codigo ?? ''),),
        DataCell(Text(comandaObservacaoPadrao.descricao ?? ''),),
      ];

      final itemEncontrado = _itensSelecionados.where((descricao) => descricao == comandaObservacaoPadrao.descricao).toList();    

      lista.add(
        DataRow(
          selected: itemEncontrado.isNotEmpty,
          cells: celulas, 
          onSelectChanged: (value) {
            if (itemEncontrado.isEmpty) {
              _itensSelecionados.add(comandaObservacaoPadrao.descricao!);
            } else {
              _itensSelecionados.removeWhere((descricao) => descricao == comandaObservacaoPadrao.descricao);
            }
            debugPrint(_itensSelecionados.toString());
            setState(() {
            });            
          },
        ),
      );
    }
    return lista;
  }

  Future _refrescarTela() async {
    _listaComandaObservacaoPadrao = (await Sessao.db.comandaObservacaoPadraoDao.consultarLista())!;
    setState(() {
    });
  }
 
  List<Widget> _getBotoesRodape({required BuildContext context}) {
    List<Widget> listaBotoes = [];
    listaBotoes.add(
      SizedBox(
        width: Biblioteca.isTelaPequena(context)! ? 130 : 150,
        child: getBotaoGenericoPdv(
          descricao: Biblioteca.isMobile() ? 'Cancelar' : 'Cancelar [F11]',
          cor: Colors.red, 
          onPressed: () {
            Navigator.pop(context, false);
          }
        ),        
      ),
    );
    listaBotoes.add(
      const SizedBox(width: 10.0, height: 50,),
    );
    listaBotoes.add(
      SizedBox(
        width: Biblioteca.isTelaPequena(context)! ? 130 : 150,
        child: getBotaoGenericoPdv(
          descricao: Biblioteca.isMobile() ? 'Confirmar' : 'Confirmar [F12]',
          cor: Colors.green.shade900, 
          onPressed: () {
            Navigator.pop(context, _itensSelecionados);
          }
        ),
      ),
    );
    return listaBotoes;
  }

}

