/*
Title: T2Ti ERP 3.0                                                                
Description: Drawer padrão para ser carregada como menu lateral
                                                                                
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
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pegasus_pdv/src/controller/controller.dart';

import 'package:url_launcher/url_launcher.dart';

import 'package:pegasus_pdv/src/infra/infra.dart';

import 'package:pegasus_pdv/src/view/menu/menu_cadastros.dart';
import 'package:pegasus_pdv/src/view/menu/menu_financeiro.dart';
import 'package:pegasus_pdv/src/view/menu/menu_fiscal.dart';
import 'package:pegasus_pdv/src/view/page/page.dart';

import 'package:pegasus_pdv/src/view/shared/about_tile.dart';
import 'package:pegasus_pdv/src/view/shared/caixas_de_dialogo.dart';

class MenuLateralPDV extends StatefulWidget {

  @override
  _MenuLateralPDVState createState() => _MenuLateralPDVState();
}

class _MenuLateralPDVState extends State<MenuLateralPDV> {  
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) => _verificarCnpjEmpresa());
  }
  
  void _verificarCnpjEmpresa() {
    if (Sessao.empresa.cnpj == null) {
      EmpresaController.obrigarCadastroCnpj(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: AbsorbPointer(
        absorbing: (Sessao.statusCaixa == StatusCaixa.vendaEmAndamento), // se houver uma venda em andamento, desabilita as opções do menu
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[

            ///
            /// Cabeçalho
            /// 
            UserAccountsDrawerHeader(  
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    const Color(0xFF3366FF),
                    const Color(0xFF00CCFF),
                  ],
                  begin: const FractionalOffset(0.0, 0.0),
                  end: const FractionalOffset(1.0, 0.0),
                  stops: [0.0, 1.0],
                  tileMode: TileMode.clamp
                ),
              ),                      
              accountName: Text(
                "Opções Gerenciais",
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20.0),              
              ),
              accountEmail: Text(
                Sessao.empresa.nomeFantasia ?? 'Cadastre o nome da empresa',
              ),
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage(Constantes.profileImage),
              ),
            ),

            ///
            /// Contratação NFC-e
            /// 
            ((Sessao.configuracaoPdv.modulo == 'G' || Sessao.nfcePlanoPagamento == null) && NfceController.ufPermiteSistemaNfce(Sessao.empresa.uf))
            ?
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    padding: EdgeInsets.only(top: 0, left: 20, right: 0),
                    child: Text(
                      "Contrate o Módulo NFC-e",
                      style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12.0, fontStyle: FontStyle.italic),              
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 2,
                      padding: EdgeInsets.all(0),
                      primary: Colors.white, 
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
                    ),                    
                    onPressed: () { 
                      Navigator.of(context)
                        .push(MaterialPageRoute(
                            builder: (BuildContext context) =>
                                NfceContrataPage()))
                        .then((_) {
                        });
                      },
                    child: Container(
                      height: 120.0,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(Constantes.nfceBanner),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10,),
                ],
              )
            : SizedBox(height: 1,),

            ///
            /// Opções Caixa
            /// 
            Container(
              padding: EdgeInsets.only(top: 0, left: 20, right: 0),
              child: Text(
                "Opções Caixa",
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12.0, fontStyle: FontStyle.italic),              
              ),
            ),
            ListTile(
              onTap:  () { 
                Navigator.of(context)
                  .push(MaterialPageRoute(
                      builder: (BuildContext context) =>
                          MovimentoEncerraPage(title: 'Encerra Movimento')))
                  .then((_) {
                  });
                },
              title: Text(
                "Movimento",
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18.0),
              ),
              leading: Icon(
                FontAwesomeIcons.cashRegister,
                color: Colors.green,
              ),
            ),
            ListTile(
              onTap: () => _efetuarSuprimento(context),
              title: Text(
                "Suprimento",
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18.0),
              ),
              leading: Icon(
                FontAwesomeIcons.funnelDollar,
                color: Colors.blueAccent.shade200,
              ),
            ),
            ListTile(
              onTap:  ()  => _efetuarSangria(context),
              title: Text(
                "Sangria",
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18.0),
              ),
              leading: Icon(
                FontAwesomeIcons.fileInvoiceDollar,
                color: Colors.redAccent.shade200,
              ),
            ),

            Divider(),

            ///
            /// Módulos
            /// 
            Container(
              padding: EdgeInsets.only(top: 0, left: 20, right: 0),
              child: Text(
                "Módulos",
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12.0, fontStyle: FontStyle.italic),              
              ),
            ),
            ListTile(
              onTap: () { 
                Navigator.of(context)
                  .push(MaterialPageRoute(
                    builder: (BuildContext context) => MenuCadastros()))
                  .then((_) {
                    //Provider.of<BancoViewModel>(context).consultarLista();
                  });
                },
              title: Text(
                "Cadastros",
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18.0),
              ),
              leading: Icon(
                FontAwesomeIcons.addressCard,
                color: Colors.blueGrey.shade700,
                // color: Colors.cyanAccent.shade700,
              ),
            ),
            ListTile(
              onTap: () { 
                Navigator.of(context)
                  .push(MaterialPageRoute(
                    builder: (BuildContext context) => CompraPedidoCabecalhoListaPage()))
                  .then((_) {
                    //Provider.of<BancoViewModel>(context).consultarLista();
                  });
                },
              title: Text(
                "Compras",
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18.0),
              ),
              leading: Icon(
                FontAwesomeIcons.shoppingBasket,
                color: Colors.blueGrey.shade700,
                // color: Colors.deepOrange.shade700,
              ),
            ),
            ListTile(
              onTap: () { 
                Navigator.of(context)
                  .push(MaterialPageRoute(
                    builder: (BuildContext context) => EstoqueListaPage()))
                  .then((_) {
                    //Provider.of<BancoViewModel>(context).consultarLista();
                  });
                },
              title: Text(
                "Estoque",
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18.0),
              ),
              leading: Icon(
                FontAwesomeIcons.truckLoading,
                color: Colors.blueGrey.shade700,
                // color: Colors.deepPurple.shade700,
              ),
            ),
            ListTile(
              onTap: () { 
                Navigator.of(context)
                  .push(MaterialPageRoute(
                    builder: (BuildContext context) => MenuFinanceiro()))
                  .then((_) {
                    //Provider.of<BancoViewModel>(context).consultarLista();
                  });
                },
              title: Text(
                "Financeiro",
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18.0),
              ),
              leading: Icon(
                FontAwesomeIcons.moneyBillAlt,
                color: Colors.blueGrey.shade700,
                // color: Colors.indigoAccent.shade700,
              ),
            ),

            ListTile(
              onTap: () { 
                Navigator.of(context)
                  .push(MaterialPageRoute(
                    builder: (BuildContext context) => DashboardPage()))
                  .then((_) {
                    //Provider.of<BancoViewModel>(context).consultarLista();
                  });
                },
              title: Text(
                "Dashboard",
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18.0),
              ),
              leading: Icon(
                FontAwesomeIcons.chartLine,
                color: Colors.blueGrey.shade700,
              ),
            ),

            ListTile(
              onTap: () { 
                Navigator.of(context)
                  .push(MaterialPageRoute(
                    builder: (BuildContext context) => VendasListaPage()))
                  .then((_) {
                    //Provider.of<BancoViewModel>(context).consultarLista();
                  });
                },
              title: Text(
                "Vendas",
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18.0),
              ),
              leading: Icon(
                FontAwesomeIcons.shoppingCart,
                color: Colors.blueAccent.shade700,
                // color: Colors.deepOrange.shade700,
              ),
            ),

            Sessao.configuracaoPdv.moduloFiscalPrincipal == 'NFC' 
            ? 
              ListTile(
                onTap: () { 
                  Navigator.of(context)
                    .push(MaterialPageRoute(
                      builder: (BuildContext context) => MenuFiscal()))
                    .then((_) {
                      //Provider.of<BancoViewModel>(context).consultarLista();
                    });
                  },
                title: Text(
                  "NFC-e",
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18.0),
                ),
                leading: Icon(
                  FontAwesomeIcons.fileInvoice,
                  color: Colors.green.shade700,
                  // color: Colors.deepOrange.shade700,
                ),
              )
            : SizedBox(height: 1,),

            Divider(),

            ///
            /// Preferências
            /// 
            Container(
              padding: EdgeInsets.only(top: 0, left: 20, right: 0),
              child: Text(
                "Outros",
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12.0, fontStyle: FontStyle.italic),              
              ),
            ),
            ListTile(
              onTap:  () {    
                Navigator.of(context)
                  .push(MaterialPageRoute(
                    builder: (BuildContext context) => ConfiguracaoPage()))
                  .then((_) {
                    //Provider.of<BancoViewModel>(context).consultarLista();
                  });
              },
              title: Text(
                "Configurações",
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18.0),
              ),
              leading: Icon(
                FontAwesomeIcons.cog,
                color: Colors.brown,
              ),
            ),
            ListTile(
              onTap: () async { 
                final _url = 'https://www.youtube.com/playlist?list=PLMqoOoxxICPfegpWl8Mj2mthn5QocLGuL';
                await canLaunch(_url) ? await launch(_url) : throw 'URL não pode ser carregada: $_url';
                Navigator.pop(context); 
              },
              title: Text(
                "Ajuda",
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18.0),
              ),
              leading: Icon(
                FontAwesomeIcons.questionCircle,
                color: Colors.lightBlueAccent.shade700,
              ),
            ),
            ListTile(
              onTap: () async { 
                // final Uri _emailLaunchUri = Uri(
                //   scheme: 'mailto',
                //   path: 't2ti.com@gmail.com',
                //   queryParameters: {
                //     'subject': 'T2Ti ERP Pegasus - Dúvidas'
                //   }
                // );
                // launch(_emailLaunchUri.toString());
                // Navigator.pop(context); 

                // %0D - serve para inserir uma quebra de linha
                final _url = 'https://t2tisistemas.com/contact.php?'
                'nome=' + Sessao.empresa.nomeFantasia + 
                '&email=' + Sessao.empresa.email + 
                '&assunto=Contato Pegasus PDV&mensagem='
                'Olá Equipe T2Ti,'
                '%0DEstou usando o T2Ti Pegasus PDV e preciso do seguinte auxílio: ';
                await canLaunch(_url) ? await launch(_url) : throw 'URL não pode ser carregada: $_url';
                Navigator.pop(context); 
              },
              title: Text(
                "Contato",
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18.0),
              ),
              leading: Icon(
                FontAwesomeIcons.addressBook,
                color: Colors.redAccent.shade700,
              ),
            ),

            Divider(),
            ListTile(
              onTap: () async { 
                if (Biblioteca.isDesktop()) {
                  exit(0);
                } else {
                  Future.delayed(const Duration(milliseconds: 1000), () {
                    SystemChannels.platform.invokeMethod('SystemNavigator.pop');
                  });                  
                }
              },
              title: Text(
                "Sair",
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18.0),
              ),
              leading: Icon(
                FontAwesomeIcons.doorOpen,
                color: Colors.redAccent.shade700,
              ),
            ),

            ///
            /// About
            /// 
            MyAboutTile()
          ],
        ),
      ),
    );
  }

  void _efetuarSuprimento(BuildContext context) async {
      bool gravouSuprimento = await showDialog(context: context, 
        builder: (BuildContext context){
          return InformaValorPage(title: 'Suprimento', operacao: 'SUPRIMENTO', );
        });

      if (gravouSuprimento ?? false) {
        gerarDialogBoxInformacao(context, 'Suprimento realizado com sucesso.');
      }
  }

  void _efetuarSangria(BuildContext context) async {
      bool gravouSangria = await showDialog(context: context, 
        builder: (BuildContext context){
          return InformaValorPage(title: 'Sangria', operacao: 'SANGRIA', );
        });

      if (gravouSangria ?? false) {
        gerarDialogBoxInformacao(context, 'Sangria realizada com sucesso.');
      }
  }
}
