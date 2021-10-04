import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:fenix/src/view/shared/common_drawer.dart';

import 'package:fenix/src/view/shared/view_util_lib.dart';
import 'package:fenix/src/view/shared/custom_background.dart';
import 'package:fenix/src/view/shared/profile_tile.dart';
import 'package:fenix/src/view/menu/menu_interno_botoes.dart';

class MenuCadastros extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(ViewUtilLib.menuCadastrosString),
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
                  Container(
                    height: 40,
                    child: Card(
                      color: Colors.black54,
                      elevation: 2.0,
                      child: Center(
                          child: Text("Grupo Pessoa",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                shadows: <Shadow>[
                                  Shadow(
                                    offset: Offset(1.0, 1.0),
                                    blurRadius: 2.0,
                                    color: Color.fromARGB(255, 0, 0, 0),
                                  ),
                                ],
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              ))),
                    ),
                  ),
                  MenuInternoBotoes(
                    primeiroBotao: BotaoMenu(
                        icon: FontAwesomeIcons.solidUser,
                        label: "Pessoa",
                        circleColor: Colors.blue,
                        rota: "/pessoaLista"),
                    segundoBotao: BotaoMenu(
                        icon: FontAwesomeIcons.addressCard,
                        label: "Cliente",
                        circleColor: Colors.orange),
                    terceiroBotao: BotaoMenu(
                        icon: FontAwesomeIcons.truckLoading,
                        label: "Fornecedor",
                        circleColor: Colors.purple),
                    quartoBotao: BotaoMenu(
                        icon: FontAwesomeIcons.shippingFast,
                        label: "Transportadora",
                        circleColor: Colors.indigo),
                  ),
                  MenuInternoBotoes(
                    primeiroBotao: BotaoMenu(
                        icon: FontAwesomeIcons.userTie,
                        label: "Contador",
                        circleColor: Colors.red),
                    segundoBotao: BotaoMenu(
                        icon: FontAwesomeIcons.ring,
                        label: "Estado Civil",
                        circleColor: Colors.teal),
                    terceiroBotao: BotaoMenu(
                        icon: FontAwesomeIcons.userGraduate,
                        label: "Nível Formação",
                        circleColor: Colors.lime),
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
                  Container(
                    height: 40,
                    child: Card(
                      color: Colors.black54,
                      elevation: 2.0,
                      child: Center(
                          child: Text("Grupo Colaborador",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                shadows: <Shadow>[
                                  Shadow(
                                    offset: Offset(1.0, 1.0),
                                    blurRadius: 2.0,
                                    color: Color.fromARGB(255, 0, 0, 0),
                                  ),
                                ],
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              ))),
                    ),
                  ),
                  MenuInternoBotoes(
                    primeiroBotao: BotaoMenu(
                        icon: FontAwesomeIcons.peopleCarry,
                        label: "Cargo",
                        circleColor: Colors.blue),
                    segundoBotao: BotaoMenu(
                        icon: FontAwesomeIcons.poll,
                        label: "Setor",
                        circleColor: Colors.orange),
                    terceiroBotao: null,
                    quartoBotao: null,
                  ),
                  MenuInternoBotoes(
                    primeiroBotao: BotaoMenu(
                        icon: FontAwesomeIcons.idBadge,
                        label: "Colaborador",
                        circleColor: Colors.purple),
                    segundoBotao: BotaoMenu(
                        icon: FontAwesomeIcons.userLock,
                        label: "Usuário",
                        circleColor: Colors.indigo),
                    terceiroBotao: BotaoMenu(
                        icon: FontAwesomeIcons.cashRegister,
                        label: "Vendedor",
                        circleColor: Colors.red),
                    quartoBotao: null,
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
                  Container(
                    height: 40,
                    child: Card(
                      color: Colors.black54,
                      elevation: 2.0,
                      child: Center(
                          child: Text("Grupo Financeiro",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                shadows: <Shadow>[
                                  Shadow(
                                    offset: Offset(1.0, 1.0),
                                    blurRadius: 2.0,
                                    color: Color.fromARGB(255, 0, 0, 0),
                                  ),
                                ],
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              ))),
                    ),
                  ),
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
                        circleColor: Colors.purple),
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
                  Container(
                    height: 40,
                    child: Card(
                      color: Colors.black54,
                      elevation: 2.0,
                      child: Center(
                          child: Text("Grupo Produto",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                shadows: <Shadow>[
                                  Shadow(
                                    offset: Offset(1.0, 1.0),
                                    blurRadius: 2.0,
                                    color: Color.fromARGB(255, 0, 0, 0),
                                  ),
                                ],
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              ))),
                    ),
                  ),
                  MenuInternoBotoes(
                    primeiroBotao: BotaoMenu(
                        icon: FontAwesomeIcons.tags,
                        label: "Marca",
                        circleColor: Colors.blue),
                    segundoBotao: BotaoMenu(
                        icon: FontAwesomeIcons.archive,
                        label: "Unidade",
                        circleColor: Colors.orange),
                    terceiroBotao: null,
                    quartoBotao: null,
                  ),
                  MenuInternoBotoes(
                    primeiroBotao: BotaoMenu(
                        icon: FontAwesomeIcons.boxes,
                        label: "Grupo",
                        circleColor: Colors.purple),
                    segundoBotao: BotaoMenu(
                        icon: FontAwesomeIcons.cube,
                        label: "Subgrupo",
                        circleColor: Colors.indigo),
                    terceiroBotao: BotaoMenu(
                        icon: FontAwesomeIcons.boxOpen,
                        label: "Produto",
                        circleColor: Colors.red),
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
                  Container(
                    height: 40,
                    child: Card(
                      color: Colors.black54,
                      elevation: 2.0,
                      child: Center(
                          child: Text("Grupo Dados Pré-Existentes",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                shadows: <Shadow>[
                                  Shadow(
                                    offset: Offset(1.0, 1.0),
                                    blurRadius: 2.0,
                                    color: Color.fromARGB(255, 0, 0, 0),
                                  ),
                                ],
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              ))),
                    ),
                  ),
                  MenuInternoBotoes(
                    primeiroBotao: BotaoMenu(
                        icon: FontAwesomeIcons.map,
                        label: "CEP",
                        circleColor: Colors.blue),
                    segundoBotao: BotaoMenu(
                        icon: FontAwesomeIcons.mapMarked,
                        label: "UF",
                        circleColor: Colors.orange),
                    terceiroBotao: BotaoMenu(
                        icon: FontAwesomeIcons.mapMarker,
                        label: "Município",
                        circleColor: Colors.purple),
                    quartoBotao: BotaoMenu(
                        icon: FontAwesomeIcons.file,
                        label: "CFOP",
                        circleColor: Colors.indigo),
                  ),
                  MenuInternoBotoes(
                    primeiroBotao: BotaoMenu(
                        icon: FontAwesomeIcons.fileAlt,
                        label: "CST ICMS",
                        circleColor: Colors.red),
                    segundoBotao: BotaoMenu(
                        icon: FontAwesomeIcons.fileAlt,
                        label: "CST PIS",
                        circleColor: Colors.teal),
                    terceiroBotao: BotaoMenu(
                        icon: FontAwesomeIcons.fileAlt,
                        label: "CST COFINS",
                        circleColor: Colors.lime),
                    quartoBotao: BotaoMenu(
                        icon: FontAwesomeIcons.fileAlt,
                        label: "CST IPI",
                        circleColor: Colors.pink),
                  ),
                  MenuInternoBotoes(
                    primeiroBotao: BotaoMenu(
                        icon: FontAwesomeIcons.fileInvoice,
                        label: "NCM",
                        circleColor: Colors.green),
                    segundoBotao: BotaoMenu(
                        icon: FontAwesomeIcons.fileInvoice,
                        label: "CNAE",
                        circleColor: Colors.amber),
                    terceiroBotao: BotaoMenu(
                        icon: FontAwesomeIcons.fileInvoice,
                        label: "CSOSN",
                        circleColor: Colors.cyan),
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
                  Container(
                    height: 40,
                    child: Card(
                      color: Colors.black54,
                      elevation: 2.0,
                      child: Center(
                          child: Text("Avisos e Alertas",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                shadows: <Shadow>[
                                  Shadow(
                                    offset: Offset(1.0, 1.0),
                                    blurRadius: 2.0,
                                    color: Color.fromARGB(255, 0, 0, 0),
                                  ),
                                ],
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              ))),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Divider(),
                      Text(
                        "Nenhum aviso para ser exibido no momento",
                        style: TextStyle(fontFamily: ViewUtilLib.ralewayFont),
                      ),
                      Divider(),
                      Text(
                        "---",
                        style: TextStyle(
                            fontFamily: ViewUtilLib.ralewayFont,
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
