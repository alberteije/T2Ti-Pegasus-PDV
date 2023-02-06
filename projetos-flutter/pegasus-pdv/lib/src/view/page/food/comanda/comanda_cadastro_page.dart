/*
Title: T2Ti ERP 3.0                                                                
Description: PersistePage relacionada à tabela [COMANDA] 
                                                                                
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
import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_spinbox/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pegasus_pdv/src/database/database_classes.dart';

import 'package:pegasus_pdv/src/infra/infra.dart';
import 'package:pegasus_pdv/src/view/page/page.dart';
import 'package:pegasus_pdv/src/view/shared/page/lookup_local_page.dart';

import 'package:pegasus_pdv/src/view/shared/view_util_lib.dart';
import 'package:pegasus_pdv/src/view/shared/widgets_input.dart';

class ComandaCadastroPage extends StatefulWidget {
  final ComandaMontado comandaMontado;

  const ComandaCadastroPage(this.comandaMontado, {Key? key}) : super(key: key);

  @override
  ComandaCadastroPageState createState() => ComandaCadastroPageState();
}

class ComandaCadastroPageState extends State<ComandaCadastroPage> {
  final _importaClienteController = TextEditingController();
  final _importaColaboradorController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _importaClienteController.text = widget.comandaMontado.cliente?.nome ?? '';
    _importaColaboradorController.text = widget.comandaMontado.colaborador?.nome ?? '';

    return Scaffold(
      backgroundColor: Color.lerp(Colors.grey[850], Colors.blueGrey, 0.8),
      body: _getCorpo(),
    );
  }

  Widget _getCorpo() {
    return ListView(
      padding: const EdgeInsets.only(top: 0.0), 
      children: [
        Stack(
          children: [
            Container(
              color: Color.lerp(Colors.grey[850], Colors.white, 0.4),
              height: 100,
            ),
            const SizedBox(
              height: 300,
            ),
            Positioned(
              top: 10,
              left: (MediaQuery.of(context).size.width ~/ 2) - 100,
              child: ComandaTileDetalhePage(
                widget.comandaMontado,
        				altura: 274,
                largura: 200,
                tamanhoFonteLabelComanda: 14,
                tamanhoFonteNumeroComanda: 20,
                tamanhoFonteQuantidadeItens: 14,
                tamanhoFonteQuantidadePessoas: 14,
                tamanhoFonteValorTotal: 14,
                tamanhoFontevalorPorPessoa: 14,
                paddingComandaData: const EdgeInsets.fromLTRB(85, 15, 5, 0),
              ),
            ),
            Positioned(
              top: 10,
              left: 10,
              child: IconButton(
                tooltip: 'Salvar e Sair',
                icon: const Icon(Icons.arrow_back_outlined),
                onPressed: () { _salvar();  }, 
              ),
            ),
          ],
        ),
        ListTile(
          contentPadding: const EdgeInsets.only(top: 5, bottom: 5, left: 5, right: 5),
          leading: Wrap( 
            spacing: 12,
            children: const [
              SizedBox(width: 1,),
              Icon(
                FontAwesomeIcons.user,
                color: Colors.black54,
              ),
            ]
          ),
          title: Row(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: SizedBox(
                  child: TextFormField(
                    style: TextStyle(
                      color: Colors.grey.shade300,
                      fontWeight: FontWeight.bold
                    ),                    
                    validator: ValidaCampoFormulario.validarObrigatorio,
                    controller: _importaClienteController,
                    readOnly: true,
                    decoration: getInputDecoration(
                      'Conteúdo para o campo Cliente',
                      'Cliente',
                      false),
                    onSaved: (String? value) {
                    },
                    onChanged: (text) {
                    },
                  ),
                ),
              ),
              Expanded(
                flex: 0,
                child: IconButton(
                  tooltip: 'Importar Cliente',
                  icon: ViewUtilLib.getIconBotaoLookup(),
                  onPressed: () async {
                    ///chamando o lookup
                    Map<String, dynamic>? objetoJsonRetorno =
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) =>
                          LookupLocalPage(
                            title: 'Importar Cliente',
                            colunas: ClienteDao.colunas,
                            campos: ClienteDao.campos,
                            campoPesquisaPadrao: 'Nome',
                            valorPesquisaPadrao: '%',
                            metodoConsultaCallBack: _filtrarClienteLookup,                                             
                            permiteCadastro: true,
                            metodoCadastroCallBack: () { Navigator.pushNamed(context, '/clienteLista',); },
                          ),
                          fullscreenDialog: true,
                        ));
                    if (objetoJsonRetorno != null) {
                      if (objetoJsonRetorno['nome'] != null) {
                        _importaClienteController.text = objetoJsonRetorno['nome'];
                        widget.comandaMontado.comanda = widget.comandaMontado.comanda!.copyWith(idCliente: objetoJsonRetorno['id']);
                        widget.comandaMontado.cliente = widget.comandaMontado.cliente!.copyWith(
                          nome: objetoJsonRetorno['nome'],
                        );          
                      }
                    }
                  },
                ),
              ),
            ],
          ),                             
        ),  

        ListTile(
          contentPadding: const EdgeInsets.only(top: 5, bottom: 5, left: 5, right: 5),
          leading: Wrap( 
            spacing: 12,
            children: const [
              SizedBox(width: 1,),
              Icon(
                // ignore: deprecated_member_use
                FontAwesomeIcons.portrait,
                color: Colors.black54,
              ),
            ]
          ),
          title: Row(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: SizedBox(
                  child: TextFormField(
                    style: TextStyle(
                      color: Colors.grey.shade300,
                      fontWeight: FontWeight.bold
                    ),                    
                    validator: ValidaCampoFormulario.validarObrigatorio,
                    controller: _importaColaboradorController,
                    readOnly: true,
                    decoration: getInputDecoration(
                      'Conteúdo para o campo Colaborador',
                      'Colaborador',
                      false),
                    onSaved: (String? value) {
                    },
                    onChanged: (text) {
                    },
                  ),
                ),
              ),
              Expanded(
                flex: 0,
                child: IconButton(
                  tooltip: 'Importar Colaborador',
                  icon: ViewUtilLib.getIconBotaoLookup(),
                  onPressed: () async {
                    ///chamando o lookup
                    Map<String, dynamic>? objetoJsonRetorno =
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) =>
                          LookupLocalPage(
                            title: 'Importar Colaborador',
                            colunas: ColaboradorDao.colunas,
                            campos: ColaboradorDao.campos,
                            campoPesquisaPadrao: 'Nome',
                            valorPesquisaPadrao: '%',
                            metodoConsultaCallBack: _filtrarColaboradorLookup,                                             
                            permiteCadastro: true,
                            metodoCadastroCallBack: () { Navigator.pushNamed(context, '/colaboradorLista',); },
                          ),
                          fullscreenDialog: true,
                        ));
                    if (objetoJsonRetorno != null) {
                      if (objetoJsonRetorno['nome'] != null) {
                        _importaColaboradorController.text = objetoJsonRetorno['nome'];
                        widget.comandaMontado.comanda = widget.comandaMontado.comanda!.copyWith(idColaborador: objetoJsonRetorno['id']);
                        widget.comandaMontado.colaborador = widget.comandaMontado.colaborador!.copyWith(
                          nome: objetoJsonRetorno['nome'],
                        );          
                      }
                    }
                  },
                ),
              ),
            ],
          ),                             
        ),  

        ListTile(
          contentPadding: const EdgeInsets.only(top: 5, bottom: 5, left: 5, right: 15),
          leading: Wrap( 
            spacing: 12,
            children: const [
              SizedBox(width: 1,),
              Icon(
                FontAwesomeIcons.users,
                color: Colors.black54,
              ),
            ]
          ),
          title: Text("Quantidade de Pessoas",
            style: TextStyle(
              color: Colors.grey.shade300,
              fontSize: Biblioteca.isTelaPequena(context)! ? 14.0 : 16.0,
              fontWeight: FontWeight.bold
            ),
          ),                    
          trailing:
          SizedBox(
            width: Biblioteca.isTelaPequena(context)! ? 120 : 200,
            child: SliderTheme(
              data: ViewUtilLib.sliderThemeData(context),
              child: SpinBox( 
                textStyle: TextStyle(
                  color: Colors.grey.shade300,
                  fontSize: Biblioteca.isTelaPequena(context)! ? 14.0 : 16.0
                ),
                max: 20,
                min: 1,
                value: widget.comandaMontado.comanda!.quantidadePessoas?.toDouble() ?? 0,
                decimals: 0,
                step: 1,
                onChanged: (value) { 
                  widget.comandaMontado.comanda = widget.comandaMontado.comanda!.copyWith(quantidadePessoas: value.toInt());
                  setState(() {
                  });
                },
              ),                          
            ),    
          ),
        ),  
        
      ],
    );
  }

  Future _salvar() async {
    await Sessao.db.comandaDao.alterar(widget.comandaMontado);
    if (!mounted) return;
    Navigator.pop(context);
  }

  void _filtrarClienteLookup(String campo, String valor) async {
    final listaFiltrada = await Sessao.db.clienteDao.consultarListaFiltro(campo, valor);
    Sessao.retornoJsonLookup = jsonEncode(listaFiltrada);
  }  

  void _filtrarColaboradorLookup(String campo, String valor) async {
    final listaFiltrada = await Sessao.db.colaboradorDao.consultarListaFiltro(campo, valor);
    Sessao.retornoJsonLookup = jsonEncode(listaFiltrada);
  }  

}