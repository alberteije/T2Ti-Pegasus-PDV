/*
Title: T2Ti ERP 3.0                                                                
Description: AbaMestre ListaPage relacionada à tabela [TRIBUT_CONFIGURA_OF_GT] 
                                                                                
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

import 'package:pegasus_pdv/src/database/database.dart';
import 'package:pegasus_pdv/src/database/database_classes.dart';

import 'package:pegasus_pdv/src/infra/infra.dart';
import 'package:pegasus_pdv/src/infra/atalhos_desktop_web.dart';
import 'package:pegasus_pdv/src/view/shared/caixas_de_dialogo.dart';

import 'package:pegasus_pdv/src/view/shared/view_util_lib.dart';

import 'tribut_configura_of_gt_page.dart';

class TributConfiguraOfGtListaPage extends StatefulWidget {
  @override
  _TributConfiguraOfGtListaPageState createState() => _TributConfiguraOfGtListaPageState();
}

class _TributConfiguraOfGtListaPageState extends State<TributConfiguraOfGtListaPage> {
  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;
  int _sortColumnIndex;
  bool _sortAscending = true;

  Map<LogicalKeySet, Intent> _shortcutMap; 
  Map<Type, Action<Intent>> _actionMap;

  @override
  void initState() {
    super.initState();
    _shortcutMap = getAtalhosListaPage();

    _actionMap = <Type, Action<Intent>>{
      AtalhoTelaIntent: CallbackAction<AtalhoTelaIntent>(
        onInvoke: _tratarAcoesAtalhos,
      ),
    };

    WidgetsBinding.instance.addPostFrameCallback((_) => _refrescarTela());
  }

  void _tratarAcoesAtalhos(AtalhoTelaIntent intent) {
    switch (intent.type) {
      case AtalhoTelaType.inserir:
        _inserir();
        break;
      default:
        break;
    }
  }
  
  @override
  Widget build(BuildContext context) {
    final _listaTributConfiguraOfGtMontado = Sessao.db.tributConfiguraOfGtDao.listaTributConfiguraOfGtMontado;

    final _TributConfiguraOfGtDataSource _tributConfiguraOfGtDataSource = _TributConfiguraOfGtDataSource(_listaTributConfiguraOfGtMontado, context, _refrescarTela);

    void _sort<T>(Comparable<T> getField(TributConfiguraOfGtMontado tributConfiguraOfGt), int columnIndex, bool ascending) {
      _tributConfiguraOfGtDataSource._sort<T>(getField, ascending);
      setState(() {
        _sortColumnIndex = columnIndex;
        _sortAscending = ascending;
      });
    }

    return FocusableActionDetector(
      actions: _actionMap,
      shortcuts: _shortcutMap,
      child: Focus(
        autofocus: true,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Configura OF-GT'),
            actions: <Widget>[],
          ),
          floatingActionButton: FloatingActionButton(
            focusColor: ViewUtilLib.getBotaoFocusColor(),
            tooltip: Constantes.botaoInserirDica,
            backgroundColor: ViewUtilLib.getBackgroundColorBotaoInserir(),
            child: ViewUtilLib.getIconBotaoInserir(),
            onPressed: () {
              _inserir();
            }),
          floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
          bottomNavigationBar: BottomAppBar(
            color: ViewUtilLib.getBottomAppBarColor(),
            shape: CircularNotchedRectangle(),
            child: Row(
              children: [],
            ),
          ),
          body: RefreshIndicator(
            onRefresh: _refrescarTela,
            child: Scrollbar(
              child: _listaTributConfiguraOfGtMontado == null
              ? Center(child: CircularProgressIndicator())
              : ListView(
                padding: EdgeInsets.all(Constantes.paddingListViewListaPage),
                children: <Widget>[
                  PaginatedDataTable(
                    header: const Text('Relação - Configura OF-GT'),
                    rowsPerPage: _rowsPerPage,
                    onRowsPerPageChanged: (int value) {
                      setState(() {
                        _rowsPerPage = value;
                      });
                    },
                    sortColumnIndex: _sortColumnIndex,
                    sortAscending: _sortAscending,
                    columns: <DataColumn>[
                      DataColumn(
                        numeric: true,
                        label: const Text('Id'),
                        tooltip: 'Id',
                        onSort: (int columnIndex, bool ascending) =>
                          _sort<num>((TributConfiguraOfGtMontado tributConfiguraOfGt) => tributConfiguraOfGt.tributConfiguraOfGt.id, columnIndex, ascending),
                      ),
                      DataColumn(
                        label: const Text('Grupo Tributário'),
                        tooltip: 'Grupo Tributário',
                        onSort: (int columnIndex, bool ascending) =>
                          _sort<String>((TributConfiguraOfGtMontado tributConfiguraOfGt) => tributConfiguraOfGt.tributGrupoTributario?.descricao, columnIndex, ascending),
                      ),
                      DataColumn(
                        label: const Text('Operação Fiscal'),
                        tooltip: 'Operação Fiscal',
                        onSort: (int columnIndex, bool ascending) =>
                          _sort<String>((TributConfiguraOfGtMontado tributConfiguraOfGt) => tributConfiguraOfGt.tributOperacaoFiscal?.descricao, columnIndex, ascending),
                      ),
                    ],
                    source: _tributConfiguraOfGtDataSource,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _inserir() {
    Navigator.of(context)
      .push(MaterialPageRoute(
        builder: (BuildContext context) =>
          TributConfiguraOfGtPage(tributConfiguraOfGtMontado: TributConfiguraOfGtMontado(
            tributConfiguraOfGt: TributConfiguraOfGt(id: null),
            tributIcmsUf: TributIcmsUf(id: null, ufDestino: Sessao.empresa.uf),
            tributCofins: TributCofins(id: null, cstCofins: '99', modalidadeBaseCalculo: '0-Percentual', aliquotaPorcento: 0,),
            tributPis: TributPis(id: null, cstPis: '99', modalidadeBaseCalculo: '0-Percentual', aliquotaPorcento: 0,),
            tributGrupoTributario: TributGrupoTributario(id: null),
            tributOperacaoFiscal: TributOperacaoFiscal(id: null),
          ), title: 'Configura OF-GT - Inserindo', operacao: 'I')))
      .then((_) async {
        await _refrescarTela();
    });
  }

  Future _refrescarTela() async {
    if (Sessao.empresa.uf == null || Sessao.empresa.crt == null) {
      Navigator.pop(context);
      showInSnackBar('Cadastre a UF e o CRT da empresa.', context);
    } else {
      await Sessao.db.tributConfiguraOfGtDao.consultarListaMontado();
      setState(() {
      });
    }
  }

}

/// codigo referente a fonte de dados
class _TributConfiguraOfGtDataSource extends DataTableSource {
  final List<TributConfiguraOfGtMontado> listaTributConfiguraOfGt;
  final BuildContext context;
  final Function refrescarTela;

  _TributConfiguraOfGtDataSource(this.listaTributConfiguraOfGt, this.context, this.refrescarTela);

  void _sort<T>(Comparable<T> getField(TributConfiguraOfGtMontado tributConfiguraOfGt), bool ascending) {
    listaTributConfiguraOfGt.sort((TributConfiguraOfGtMontado a, TributConfiguraOfGtMontado b) {
      if (!ascending) {
        final TributConfiguraOfGtMontado c = a;
        a = b;
        b = c;
      }
      Comparable<T> aValue = getField(a);
      Comparable<T> bValue = getField(b);

      if (aValue == null) aValue = '' as Comparable<T>;
      if (bValue == null) bValue = '' as Comparable<T>;

      return Comparable.compare(aValue, bValue);
    });
  }

  int _selectedCount = 0;

  @override
  DataRow getRow(int index) {
    assert(index >= 0);
    if (index >= listaTributConfiguraOfGt.length) return null;
    final TributConfiguraOfGtMontado tributConfiguraOfGtMontado = listaTributConfiguraOfGt[index];
    final TributConfiguraOfGt tributConfiguraOfGt = tributConfiguraOfGtMontado.tributConfiguraOfGt;
    return DataRow.byIndex(
      index: index,
      cells: <DataCell>[
        DataCell(Text('${tributConfiguraOfGt.id ?? ''}'), onTap: () {
          _detalharTributConfiguraOfGt(tributConfiguraOfGtMontado, context, refrescarTela);
        }),
        DataCell(Text('${tributConfiguraOfGtMontado.tributGrupoTributario?.descricao ?? ''}'), onTap: () {
          _detalharTributConfiguraOfGt(tributConfiguraOfGtMontado, context, refrescarTela);
        }),
        DataCell(Text('${tributConfiguraOfGtMontado.tributOperacaoFiscal?.descricao ?? ''}'), onTap: () {
          _detalharTributConfiguraOfGt(tributConfiguraOfGtMontado, context, refrescarTela);
        }),
      ],
    );
  }

  @override
  int get rowCount => listaTributConfiguraOfGt.length ?? 0;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => _selectedCount;
}

void _detalharTributConfiguraOfGt(TributConfiguraOfGtMontado tributConfiguraOfGtMontado, BuildContext context, Function refrescarTela) {
  Navigator.of(context)
    .push(MaterialPageRoute(
      builder: (BuildContext context) => TributConfiguraOfGtPage(
        tributConfiguraOfGtMontado: tributConfiguraOfGtMontado, 
        title: 'Configura OF-GT - Editando', 
        operacao: 'A'
      )))
    .then((_) async {    
      await refrescarTela();
   });
}