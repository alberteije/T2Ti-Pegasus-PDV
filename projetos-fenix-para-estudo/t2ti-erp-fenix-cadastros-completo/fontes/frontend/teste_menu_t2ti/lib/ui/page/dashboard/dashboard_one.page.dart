import 'package:flutter/material.dart';
import 'package:flutter_uikit/ui/page/dashboard/dashboard_one/dashboard_menu_row.dart';
import 'package:flutter_uikit/ui/widgets/login_background.dart';
import 'package:flutter_uikit/ui/widgets/profile_tile.dart';
import 'package:flutter_uikit/utils/uidata.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_uikit/ui/widgets/common_drawer.dart';

class DashboardOnePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('T2Ti ERP Fenix - Cadastros'),
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
          LoginBackground(
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
                  DashboardMenuRow(
                    primeiroBotao: BotaoMenu(
                        FontAwesomeIcons.solidUser, "Pessoa", Colors.blue),
                    segundoBotao: BotaoMenu(
                        FontAwesomeIcons.addressCard, "Cliente", Colors.orange),
                    terceiroBotao: BotaoMenu(FontAwesomeIcons.truckLoading,
                        "Fornecedor", Colors.purple),
                    quartoBotao: BotaoMenu(FontAwesomeIcons.shippingFast,
                        "Transportadora", Colors.indigo),
                  ),
                  DashboardMenuRow(
                    primeiroBotao: BotaoMenu(
                        FontAwesomeIcons.userTie, "Contador", Colors.red),
                    segundoBotao: BotaoMenu(
                        FontAwesomeIcons.ring, "Estado Civil", Colors.teal),
                    terceiroBotao: BotaoMenu(FontAwesomeIcons.userGraduate,
                        "Nível Formação", Colors.lime),
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
                  DashboardMenuRow(
                    primeiroBotao: BotaoMenu(
                        FontAwesomeIcons.peopleCarry, "Cargo", Colors.blue),
                    segundoBotao: BotaoMenu(
                        FontAwesomeIcons.poll, "Setor", Colors.orange),
                    terceiroBotao: null,
                    quartoBotao: null,
                  ),
                  DashboardMenuRow(
                    primeiroBotao: BotaoMenu(
                        FontAwesomeIcons.idBadge, "Colaborador", Colors.purple),
                    segundoBotao: BotaoMenu(
                        FontAwesomeIcons.userLock, "Usuário", Colors.indigo),
                    terceiroBotao: BotaoMenu(
                        FontAwesomeIcons.cashRegister, "Vendedor", Colors.red),
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
                  DashboardMenuRow(
                    primeiroBotao: BotaoMenu(
                        FontAwesomeIcons.moneyBill, "Banco", Colors.blue),
                    segundoBotao: BotaoMenu(
                        FontAwesomeIcons.building, "Agência", Colors.orange),
                    terceiroBotao: BotaoMenu(FontAwesomeIcons.moneyCheck,
                        "Conta Caixa", Colors.purple),
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
                  DashboardMenuRow(
                    primeiroBotao:
                        BotaoMenu(FontAwesomeIcons.tags, "Marca", Colors.blue),
                    segundoBotao: BotaoMenu(
                        FontAwesomeIcons.archive, "Unidade", Colors.orange),
                    terceiroBotao: null,
                    quartoBotao: null,
                  ),
                  DashboardMenuRow(
                    primeiroBotao: BotaoMenu(
                        FontAwesomeIcons.boxes, "Grupo", Colors.purple),
                    segundoBotao: BotaoMenu(
                        FontAwesomeIcons.cube, "Subgrupo", Colors.indigo),
                    terceiroBotao: BotaoMenu(
                        FontAwesomeIcons.boxOpen, "Produto", Colors.red),
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
                  DashboardMenuRow(
                    primeiroBotao:
                        BotaoMenu(FontAwesomeIcons.map, "CEP", Colors.blue),
                    segundoBotao: BotaoMenu(
                        FontAwesomeIcons.mapMarked, "UF", Colors.orange),
                    terceiroBotao: BotaoMenu(
                        FontAwesomeIcons.mapMarker, "Município", Colors.purple),
                    quartoBotao:
                        BotaoMenu(FontAwesomeIcons.file, "CFOP", Colors.indigo),
                  ),
                  DashboardMenuRow(
                    primeiroBotao: BotaoMenu(
                        FontAwesomeIcons.fileAlt, "CST ICMS", Colors.red),
                    segundoBotao: BotaoMenu(
                        FontAwesomeIcons.fileAlt, "CST PIS", Colors.teal),
                    terceiroBotao: BotaoMenu(
                        FontAwesomeIcons.fileAlt, "CST COFINS", Colors.lime),
                    quartoBotao: BotaoMenu(
                        FontAwesomeIcons.fileAlt, "CST IPI", Colors.pink),
                  ),
                  DashboardMenuRow(
                    primeiroBotao: BotaoMenu(
                        FontAwesomeIcons.fileInvoice, "NCM", Colors.green),
                    segundoBotao: BotaoMenu(
                        FontAwesomeIcons.fileInvoice, "CNAE", Colors.amber),
                    terceiroBotao: BotaoMenu(
                        FontAwesomeIcons.fileInvoice, "CSOSN", Colors.cyan),
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
                        style: TextStyle(fontFamily: UIData.ralewayFont),
                      ),
                      Divider(),
                      Text(
                        "---",
                        style: TextStyle(
                            fontFamily: UIData.ralewayFont,
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
