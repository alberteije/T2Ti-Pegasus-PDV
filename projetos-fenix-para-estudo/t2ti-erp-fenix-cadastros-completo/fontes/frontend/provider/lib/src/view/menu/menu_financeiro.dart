/*
Title: T2Ti ERP Fenix                                                                
Description: Menu interno para o bloco financeiro
                                                                                
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

class MenuFinanceiro extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Constantes.menuFinanceiroString),
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
            actionMenuGrupoCadastros(),
            SizedBox(
              height: tamanhoDoDispositivo(context).height * 0.01,
            ),
            actionMenuGrupoPagar(),
            SizedBox(
              height: tamanhoDoDispositivo(context).height * 0.01,
            ),
            actionMenuGrupoReceber(),
            SizedBox(
              height: tamanhoDoDispositivo(context).height * 0.01,
            ),
            actionMenuGrupoMovimento(),
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
                    subtitle: "Bem Vindo ao Bloco Financeiro",
                    textColor: Colors.white,
                  ),
                ],
              ),
            ],
          ),
        ),
      );

  Widget actionMenuGrupoCadastros() => Padding(
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
                  MenuTituloGrupoMenuInterno(titulo: "Cadastros - Financeiro"),
                  MenuInternoBotoes(
                    primeiroBotao: BotaoMenu(
                        icon: FontAwesomeIcons.solidUser,
                        label: "Natureza Financeira",
                        circleColor: Colors.blue,
                        rota: "/finNaturezaFinanceiraLista"),
                    segundoBotao: BotaoMenu(
                        icon: FontAwesomeIcons.addressCard,
                        label: "Tipo de Recebimento",
                        circleColor: Colors.orange,
                        rota: "/finTipoRecebimentoLista"),
                    terceiroBotao: null,
                    quartoBotao: null,
                  ),
                  MenuInternoBotoes(
                    primeiroBotao: BotaoMenu(
                        icon: FontAwesomeIcons.truckLoading,
                        label: "Tipo de Pagamento",
                        circleColor: Colors.purple,
                        rota: "/finTipoPagamentoLista"),
                    segundoBotao: BotaoMenu(
                        icon: FontAwesomeIcons.shippingFast,
                        label: "Status Parcela",
                        circleColor: Colors.indigo,
                        rota: "/finStatusParcelaLista"),
                    terceiroBotao: null,
                    quartoBotao: null,
                  ),
                  MenuInternoBotoes(
                    primeiroBotao: BotaoMenu(
                        icon: FontAwesomeIcons.userTie,
                        label: "Documento Origem",
                        circleColor: Colors.red,
                        rota: "/finDocumentoOrigemLista"),
                    segundoBotao: BotaoMenu(
                        icon: FontAwesomeIcons.ring,
                        label: "Config Boleto",
                        circleColor: Colors.teal,
                        rota: "/finConfiguracaoBoletoLista"),
                    terceiroBotao: BotaoMenu(
                        icon: FontAwesomeIcons.userGraduate,
                        label: "Cheques",
                        circleColor: Colors.lime,
                        rota: "/talonarioChequeLista"),
                    quartoBotao: null,
                  ),
                ],
              ),
            ),
          ),
        ),
      );

  Widget actionMenuGrupoPagar() => Padding(
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
                  MenuTituloGrupoMenuInterno(titulo: "Contas a Pagar"),
                  MenuInternoBotoes(
                    primeiroBotao: BotaoMenu(
                        icon: FontAwesomeIcons.peopleCarry,
                        label: "Lançamento a Pagar",
                        circleColor: Colors.blue,
                        rota: "/finLancamentoPagarLista"),
                    segundoBotao: BotaoMenu(
                        icon: FontAwesomeIcons.poll,
                        label: "Pagamento",
                        circleColor: Colors.orange,
                        rota: "/pagamento"),
                    terceiroBotao:null,
                    quartoBotao: null,
                  ),
                ],
              ),
            ),
          ),
        ),
      );

  Widget actionMenuGrupoReceber() => Padding(
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
                  MenuTituloGrupoMenuInterno(titulo: "Contas a Receber"),
                  MenuInternoBotoes(
                    primeiroBotao: BotaoMenu(
                        icon: FontAwesomeIcons.moneyBill,
                        label: "Lançamento a Receber",
                        circleColor: Colors.blue,
                        rota: "/finLancamentoReceberLista"),
                    segundoBotao: BotaoMenu(
                        icon: FontAwesomeIcons.building,
                        label: "Recebimento",
                        circleColor: Colors.orange,
                        rota: "/recebimento"),
                    terceiroBotao: null,
                    quartoBotao: null,
                  ),
                ],
              ),
            ),
          ),
        ),
      );

  Widget actionMenuGrupoMovimento() => Padding(
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
                  MenuTituloGrupoMenuInterno(titulo: "Movimento e Gerencial"),
                  MenuInternoBotoes(
                    primeiroBotao: BotaoMenu(
                        icon: FontAwesomeIcons.tags,
                        label: "Movimento Caixa/Banco",
                        circleColor: Colors.blue,
                        rota: "/movimentoCaixaBanco"),
                    segundoBotao: BotaoMenu(
                        icon: FontAwesomeIcons.archive,
                        label: "Resumo Tesouraria",
                        circleColor: Colors.orange,
                        rota: "/tesouraria"),
                    terceiroBotao: null,
                    quartoBotao: null,
                  ),
                  MenuInternoBotoes(
                    primeiroBotao: BotaoMenu(
                        icon: FontAwesomeIcons.boxes,
                        label: "Fluxo de Caixa",
                        circleColor: Colors.purple,
                        rota: "/fluxoCaixa"),
                    segundoBotao: BotaoMenu(
                        icon: FontAwesomeIcons.cube,
                        label: "Conciliação Bancária",
                        circleColor: Colors.indigo,
                        rota: "/conciliacaoBancaria"),
                    terceiroBotao: null,
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