/*
Title: T2Ti ERP Fenix                                                                
Description: AbaMestre DetalhePage relacionada à tabela [COLABORADOR] 
                                                                                
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
import 'package:provider/provider.dart';

import 'package:fenix/src/model/model.dart';
import 'package:fenix/src/view_model/view_model.dart';
import 'package:fenix/src/view/shared/erro_page.dart';
import 'package:fenix/src/view/shared/view_util_lib.dart';
import 'package:intl/intl.dart';
import 'colaborador_page.dart';

class ColaboradorDetalhePage extends StatelessWidget {
  final Colaborador colaborador;

  const ColaboradorDetalhePage({Key key, this.colaborador}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var colaboradorProvider = Provider.of<ColaboradorViewModel>(context);

    if (colaboradorProvider.objetoJsonErro != null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Colaborador'),
          actions: <Widget>[],
        ),
        body: ErroPage(
            objetoJsonErro:
                Provider.of<ColaboradorViewModel>(context).objetoJsonErro),
      );
    } else {
      return Theme(
          data: ViewUtilLib.getThemeDataDetalhePage(context),
          child: Scaffold(
            appBar: AppBar(title: Text('Colaborador'), actions: <Widget>[
              IconButton(
                icon: ViewUtilLib.getIconBotaoExcluir(),
                onPressed: () {
                  return ViewUtilLib.gerarDialogBoxExclusao(context, () {
                    colaboradorProvider.excluir(colaborador.id);
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                  });
                },
              ),
              IconButton(
                icon: ViewUtilLib.getIconBotaoAlterar(),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => ColaboradorPage(
                          colaborador: colaborador,
                          title: 'Colaborador - Editando',
                          operacao: 'A')));
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
                    ViewUtilLib.getPaddingDetalhePage('Detalhes de Colaborador'),
                    Card(
                      color: Colors.white,
                      elevation: 2.0,
                      child: Column(
                        children: <Widget>[
                        ViewUtilLib.getListTileDataDetalhePageId(
                            colaborador.id?.toString() ?? '', 'Id'),
						ViewUtilLib.getListTileDataDetalhePage(
							colaborador.pessoa.nome?.toString() ?? '', 'Pessoa'),
						ViewUtilLib.getListTileDataDetalhePage(
							colaborador.cargo.nome?.toString() ?? '', 'Cargo'),
						ViewUtilLib.getListTileDataDetalhePage(
							colaborador.setor.nome?.toString() ?? '', 'Setor'),
						ViewUtilLib.getListTileDataDetalhePage(
							colaborador.pessoa.nome ?? '', 'Nome'),
						ViewUtilLib.getListTileDataDetalhePage(
							colaborador.dataCadastro != null ? DateFormat('dd/MM/yyyy').format(colaborador.dataCadastro) : '', 'Data de Cadastro'),
						ViewUtilLib.getListTileDataDetalhePage(
							colaborador.dataAdmissao != null ? DateFormat('dd/MM/yyyy').format(colaborador.dataAdmissao) : '', 'Data de Admissão'),
						ViewUtilLib.getListTileDataDetalhePage(
							colaborador.dataDemissao != null ? DateFormat('dd/MM/yyyy').format(colaborador.dataDemissao) : '', 'Data de Demissão'),
						ViewUtilLib.getListTileDataDetalhePage(
							colaborador.ctpsNumero ?? '', 'Número CTPS'),
						ViewUtilLib.getListTileDataDetalhePage(
							colaborador.ctpsSerie ?? '', 'Série CTPS'),
						ViewUtilLib.getListTileDataDetalhePage(
							colaborador.ctpsDataExpedicao != null ? DateFormat('dd/MM/yyyy').format(colaborador.ctpsDataExpedicao) : '', 'Data de Expedição'),
						ViewUtilLib.getListTileDataDetalhePage(
							colaborador.ctpsUf ?? '', 'UF CTPS'),
						ViewUtilLib.getListTileDataDetalhePage(
							colaborador.observacao ?? '', 'Observação'),
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
}