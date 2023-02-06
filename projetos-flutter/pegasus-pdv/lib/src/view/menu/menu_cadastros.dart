/*
Title: T2Ti ERP 3.0                                                                
Description: Menu interno para o módulo de cadastros do PDV
                                                                                
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

Based on: Flutter UIKit by Pawan Kumar - https://github.com/iampawan/Flutter-UI-Kit
*******************************************************************************/
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:pegasus_pdv/src/infra/infra.dart';

import 'package:pegasus_pdv/src/view/shared/custom_background.dart';
import 'package:pegasus_pdv/src/view/shared/profile_tile.dart';

import 'package:pegasus_pdv/src/view/menu/menu_interno_botoes.dart';
import 'package:pegasus_pdv/src/view/menu/menu_titulo_grupo_menu_interno.dart';

class MenuCadastros extends StatelessWidget {
  const MenuCadastros({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("T2Ti Pegasus PDV - Cadastros"),
        backgroundColor: Colors.black87,
      ),
      // drawer: CommonDrawer(),
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          CustomBackground(
            showIcon: false,
          ),
          allCards(context),
        ],
      ),
    );
  }

  Widget allCards(BuildContext context) => SingleChildScrollView(
        child: Column(
          children: <Widget>[
            appBarColumn(context),
            const SizedBox(height: 10,),
            actionMenuGrupoPessoa(),
            const SizedBox(height: 10,),
            actionMenuGrupoProduto(),
            const SizedBox(height: 10,),
            actionMenuGrupoGeral(),
            const SizedBox(height: 10,),
            // só apresenta o cadastro da tributação se não for o módulo gratuito
            Sessao.configuracaoPdv!.modulo == 'G' ? const SizedBox(height: 1,) : actionMenuGrupoTributacao(), 
            Sessao.configuracaoPdv!.modulo == 'G' ? const SizedBox(height: 1,) : const SizedBox(height: 20,),
          ],
        ),
      );

  Widget appBarColumn(BuildContext context) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 18.0),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const <Widget>[
                  ProfileTile(
                    title: "T2Ti Pegasus PDV",
                    subtitle: "Módulo Cadastros",
                    textColor: Colors.white,
                  ),
                ],
              ),
            ],
          ),
        ),
      );

  Widget actionMenuGrupoPessoa() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Card(
          elevation: 2.0,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  const MenuTituloGrupoMenuInterno(titulo: "Grupo Pessoa"),
                  MenuInternoBotoes(
                    primeiroBotao: BotaoMenu(
                        icon: FontAwesomeIcons.addressCard,
                        label: "Cliente",
                        circleColor: Colors.orange,
                        rota: "/clienteLista"),
                    segundoBotao: BotaoMenu(
                        // ignore: deprecated_member_use
                        icon: FontAwesomeIcons.truckLoading,
                        label: "Fornecedor",
                        circleColor: Colors.teal,
                        rota: "/fornecedorLista"),
                    terceiroBotao: BotaoMenu(
                        icon: FontAwesomeIcons.idBadge,
                        label: "Colaborador",
                        circleColor: Colors.purple,
                        rota: "/colaboradorLista"),
                    quartoBotao: null,
                  ),
                ],
              ),
            ),
          ),
        ),
      );

  Widget actionMenuGrupoProduto() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Card(
          color: Colors.amber[50],
          elevation: 2.0,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  const MenuTituloGrupoMenuInterno(titulo: "Grupo Produto"),
                  MenuInternoBotoes(
                    primeiroBotao: BotaoMenu(
                        // ignore: deprecated_member_use
                        icon: FontAwesomeIcons.archive,
                        label: "Tipo Produto",
                        circleColor: Colors.indigo,
                        rota: "/produtoTipoLista"),
                    segundoBotao: BotaoMenu(
                        // ignore: deprecated_member_use
                        icon: FontAwesomeIcons.archive,
                        label: "Unidade",
                        circleColor: Colors.orange,
                        rota: "/produtoUnidadeLista"),
                    terceiroBotao: null,
                    quartoBotao: null,
                  ),
                  MenuInternoBotoes(
                    primeiroBotao: BotaoMenu(
                        // ignore: deprecated_member_use
                        icon: FontAwesomeIcons.boxes,
                        label: "Grupo",
                        circleColor: Colors.purple,
                        rota: "/produtoGrupoLista"),
                    segundoBotao: BotaoMenu(
                        icon: FontAwesomeIcons.cube,
                        label: "Subgrupo",
                        circleColor: Colors.indigo,
                        rota: "/produtoSubgrupoLista"),
                    terceiroBotao: BotaoMenu(
                        icon: FontAwesomeIcons.boxOpen,
                        label: "Produto",
                        circleColor: Colors.red,
                        rota: '/produtoLista'),
                    quartoBotao: null,
                  ),
                ],
              ),
            ),
          ),
        ),
      );

  Widget actionMenuGrupoGeral() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Card(
          color: Colors.amber[50],
          elevation: 2.0,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  const MenuTituloGrupoMenuInterno(titulo: "Grupo Geral"),
                  MenuInternoBotoes(
                    primeiroBotao: BotaoMenu(
                        icon: FontAwesomeIcons.building,
                        label: "Empresa",
                        circleColor: Colors.blue,
                        rota: "/empresaPersiste"),
                    segundoBotao: BotaoMenu(
                        icon: FontAwesomeIcons.moneyBill,
                        label: "Tipo Pagamento",
                        circleColor: Colors.orange,
                        rota: "/pdvTipoPagamentoLista"),
                    terceiroBotao: null,
                    quartoBotao: null,
                  ),                  
                ],
              ),
            ),
          ),
        ),
      );


  Widget actionMenuGrupoTributacao() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Card(
          elevation: 2.0,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  const MenuTituloGrupoMenuInterno(titulo: "Cadastros - Tributação"),
                  MenuInternoBotoes(
                    primeiroBotao: BotaoMenu(
                        icon: FontAwesomeIcons.solidUser,
                        label: "Operação Fiscal",
                        circleColor: Colors.blue,
                        rota: "/tributOperacaoFiscalLista"),
                    segundoBotao: BotaoMenu(
                        icon: FontAwesomeIcons.addressCard,
                        label: "Grupo Tributário",
                        circleColor: Colors.orange,
                        rota: "/tributGrupoTributarioLista"),
                    terceiroBotao: null,
                    quartoBotao: null,
                  ),
                  MenuInternoBotoes(
                    primeiroBotao: null,
                    segundoBotao: null,
                    terceiroBotao: BotaoMenu(
                        // ignore: deprecated_member_use
                        icon: FontAwesomeIcons.truckLoading,
                        label: "Configura Tributação",
                        circleColor: Colors.purple,
                        rota: "/tributConfiguraOfGtLista"),
                    quartoBotao: null,
                  ),
                ],
              ),
            ),
          ),
        ),
      );

}