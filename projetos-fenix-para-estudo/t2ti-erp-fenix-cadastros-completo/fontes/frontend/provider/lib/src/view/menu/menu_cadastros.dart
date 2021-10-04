/*
Title: T2Ti ERP Fenix                                                                
Description: Menu interno para o módulo de cadastros
                                                                                
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

Based on: Flutter UIKit by Pawan Kumar - https://github.com/iampawan/Flutter-UI-Kit
*******************************************************************************/
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:fenix/src/infra/constantes.dart';
import 'package:fenix/src/view/shared/common_drawer.dart';
import 'package:fenix/src/view/shared/custom_background.dart';
import 'package:fenix/src/view/shared/profile_tile.dart';

import 'package:fenix/src/view/menu/menu_interno_botoes.dart';
import 'package:fenix/src/view/menu/menu_titulo_grupo_menu_interno.dart';

class MenuCadastros extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Constantes.menuCadastrosString),
        backgroundColor: Colors.black87,
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              tooltip: 'Abre o menu de navegação',
            );
          },
        ),
      ),
      drawer: CommonDrawer(),
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

  Size tamanhoDoDispositivo(BuildContext context) {
    return MediaQuery.of(context).size;
  }

  Widget allCards(BuildContext context) => SingleChildScrollView(
        child: Column(
          children: <Widget>[
            appBarColumn(context),
            SizedBox(
              height: tamanhoDoDispositivo(context).height * 0.01,
            ),
            actionMenuGrupoPessoa(),
            SizedBox(
              height: tamanhoDoDispositivo(context).height * 0.01,
            ),
            actionMenuGrupoColaborador(),
            SizedBox(
              height: tamanhoDoDispositivo(context).height * 0.01,
            ),
            actionMenuGrupoFinanceiro(),
            SizedBox(
              height: tamanhoDoDispositivo(context).height * 0.01,
            ),
            actionMenuGrupoProduto(),
            SizedBox(
              height: tamanhoDoDispositivo(context).height * 0.01,
            ),
            actionMenuGrupoPreExistentes(),
            SizedBox(
              height: tamanhoDoDispositivo(context).height * 0.01,
            ),
            cardAvisos(),
          ],
        ),
      );

  Widget appBarColumn(BuildContext context) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 18.0),
          child: new Column(
            children: <Widget>[
              new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new ProfileTile(
                    title: "Olá, Albert Eije",
                    subtitle: "Bem Vindo ao módulo Cadastros",
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
                  MenuTituloGrupoMenuInterno(titulo: "Grupo Pessoa"),
                  MenuInternoBotoes(
                    primeiroBotao: BotaoMenu(
                        icon: FontAwesomeIcons.solidUser,
                        label: "Pessoa",
                        circleColor: Colors.blue,
                        rota: "/pessoaLista"),
                    segundoBotao: BotaoMenu(
                        icon: FontAwesomeIcons.addressCard,
                        label: "Cliente",
                        circleColor: Colors.orange,
                        rota: "/clienteLista"),
                    terceiroBotao: BotaoMenu(
                        icon: FontAwesomeIcons.truckLoading,
                        label: "Fornecedor",
                        circleColor: Colors.purple,
                        rota: "/fornecedorLista"),
                    quartoBotao: BotaoMenu(
                        icon: FontAwesomeIcons.shippingFast,
                        label: "Transportadora",
                        circleColor: Colors.indigo,
                        rota: "/transportadoraLista"),
                  ),
                  MenuInternoBotoes(
                    primeiroBotao: BotaoMenu(
                        icon: FontAwesomeIcons.userTie,
                        label: "Contador",
                        circleColor: Colors.red,
                        rota: "/contadorLista"),
                    segundoBotao: BotaoMenu(
                        icon: FontAwesomeIcons.ring,
                        label: "Estado Civil",
                        circleColor: Colors.teal,
                        rota: "/estadoCivilLista"),
                    terceiroBotao: BotaoMenu(
                        icon: FontAwesomeIcons.userGraduate,
                        label: "Nível Formação",
                        circleColor: Colors.lime,
                        rota: "/nivelFormacaoLista"),
                    quartoBotao: null,
                  ),
                ],
              ),
            ),
          ),
        ),
      );

  Widget actionMenuGrupoColaborador() => Padding(
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
                  MenuTituloGrupoMenuInterno(titulo: "Grupo Colaborador"),
                  MenuInternoBotoes(
                    primeiroBotao: BotaoMenu(
                        icon: FontAwesomeIcons.peopleCarry,
                        label: "Cargo",
                        circleColor: Colors.blue,
                        rota: "/cargoLista"),
                    segundoBotao: BotaoMenu(
                        icon: FontAwesomeIcons.poll,
                        label: "Setor",
                        circleColor: Colors.orange,
                        rota: "/setorLista"),
                    terceiroBotao: BotaoMenu(
                        icon: FontAwesomeIcons.idBadge,
                        label: "Colaborador",
                        circleColor: Colors.purple,
                        rota: "/colaboradorLista"),
                    quartoBotao: BotaoMenu(
                        icon: FontAwesomeIcons.cashRegister,
                        label: "Vendedor",
                        circleColor: Colors.red,
                        rota: "/vendedorLista"),
                  ),
                ],
              ),
            ),
          ),
        ),
      );

  Widget actionMenuGrupoFinanceiro() => Padding(
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
                  MenuTituloGrupoMenuInterno(titulo: "Grupo Financeiro"),
                  MenuInternoBotoes(
                    primeiroBotao: BotaoMenu(
                        icon: FontAwesomeIcons.moneyBill,
                        label: "Banco",
                        circleColor: Colors.blue,
                        rota: "/bancoLista"),
                    segundoBotao: BotaoMenu(
                        icon: FontAwesomeIcons.building,
                        label: "Agência",
                        circleColor: Colors.orange,
                        rota: "/bancoAgenciaLista"),
                    terceiroBotao: BotaoMenu(
                        icon: FontAwesomeIcons.moneyCheck,
                        label: "Conta Caixa",
                        circleColor: Colors.purple,
                        rota: "/bancoContaCaixaLista"),
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
                  MenuTituloGrupoMenuInterno(titulo: "Grupo Produto"),
                  MenuInternoBotoes(
                    primeiroBotao: BotaoMenu(
                        icon: FontAwesomeIcons.tags,
                        label: "Marca",
                        circleColor: Colors.blue,
                        rota: "/produtoMarcaLista"),
                    segundoBotao: BotaoMenu(
                        icon: FontAwesomeIcons.archive,
                        label: "Unidade",
                        circleColor: Colors.orange,
                        rota: "/produtoUnidadeLista"),
                    terceiroBotao: null,
                    quartoBotao: null,
                  ),
                  MenuInternoBotoes(
                    primeiroBotao: BotaoMenu(
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

  Widget actionMenuGrupoPreExistentes() => Padding(
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
                  MenuTituloGrupoMenuInterno(titulo: "Grupo Dados Pré-Existentes"),
                  MenuInternoBotoes(
                    primeiroBotao: BotaoMenu(
                        icon: FontAwesomeIcons.map,
                        label: "CEP",
                        circleColor: Colors.blue,
                        rota: "/cepLista"),
                    segundoBotao: BotaoMenu(
                        icon: FontAwesomeIcons.mapMarked,
                        label: "UF",
                        circleColor: Colors.orange,
                        rota: "/ufLista"),
                    terceiroBotao: BotaoMenu(
                        icon: FontAwesomeIcons.mapMarker,
                        label: "Município",
                        circleColor: Colors.purple,
                        rota: "/municipioLista"),
                    quartoBotao: BotaoMenu(
                        icon: FontAwesomeIcons.file,
                        label: "CFOP",
                        circleColor: Colors.indigo,
                        rota: "/cfopLista"),
                  ),
                  MenuInternoBotoes(
                    primeiroBotao: BotaoMenu(
                        icon: FontAwesomeIcons.fileAlt,
                        label: "CST ICMS",
                        circleColor: Colors.red,
                        rota: "/cstIcmsLista"),
                    segundoBotao: BotaoMenu(
                        icon: FontAwesomeIcons.fileAlt,
                        label: "CST PIS",
                        circleColor: Colors.teal,
                        rota: "/cstPisLista"),
                    terceiroBotao: BotaoMenu(
                        icon: FontAwesomeIcons.fileAlt,
                        label: "CST COFINS",
                        circleColor: Colors.lime,
                        rota: "/cstCofinsLista"),
                    quartoBotao: BotaoMenu(
                        icon: FontAwesomeIcons.fileAlt,
                        label: "CST IPI",
                        circleColor: Colors.pink,
                        rota: "/cstIpiLista"),
                  ),
                  MenuInternoBotoes(
                    primeiroBotao: BotaoMenu(
                        icon: FontAwesomeIcons.fileInvoice,
                        label: "NCM",
                        circleColor: Colors.green,
                         rota: "/ncmLista"),
                   segundoBotao: BotaoMenu(
                        icon: FontAwesomeIcons.fileInvoice,
                        label: "CNAE",
                        circleColor: Colors.amber,
                        rota: "/cnaeLista"),
                    terceiroBotao: BotaoMenu(
                        icon: FontAwesomeIcons.fileInvoice,
                        label: "CSOSN",
                        circleColor: Colors.cyan,
                         rota: "/csosnLista"),
                   quartoBotao: null,
                  ),
                ],
              ),
            ),
          ),
        ),
      );

  Widget cardAvisos() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Card(
          elevation: 2.0,
          color: Colors.blueGrey[50],
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  MenuTituloGrupoMenuInterno(titulo: "Avisos e Alertas"),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Divider(),
                      Text(
                        "Nenhum aviso para ser exibido no momento",
                        style: TextStyle(fontFamily: Constantes.ralewayFont),
                      ),
                      Divider(),
                      Text(
                        "---",
                        style: TextStyle(
                            fontFamily: Constantes.ralewayFont,
                            fontWeight: FontWeight.w700,
                            color: Colors.green,
                            fontSize: 25.0),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      );
}