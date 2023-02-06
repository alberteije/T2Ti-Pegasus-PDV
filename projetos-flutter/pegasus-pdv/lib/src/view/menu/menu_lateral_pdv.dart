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
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pegasus_pdv/src/controller/controller.dart';
import 'package:pegasus_pdv/src/service/infra/sincroniza_service.dart';
import 'package:pegasus_pdv/src/view/menu/menu_food.dart';

import 'package:url_launcher/url_launcher.dart';

import 'package:pegasus_pdv/src/infra/infra.dart';

import 'package:pegasus_pdv/src/view/menu/menu_cadastros.dart';
import 'package:pegasus_pdv/src/view/menu/menu_financeiro.dart';
import 'package:pegasus_pdv/src/view/menu/menu_fiscal.dart';
import 'package:pegasus_pdv/src/view/page/page.dart';

import 'package:pegasus_pdv/src/view/shared/about_tile.dart';
import 'package:pegasus_pdv/src/view/shared/caixas_de_dialogo.dart';

class MenuLateralPDV extends StatefulWidget {
  const MenuLateralPDV({Key? key}) : super(key: key);


  @override
  MenuLateralPDVState createState() => MenuLateralPDVState();
}

class MenuLateralPDVState extends State<MenuLateralPDV> {  

  final ScrollController controllerScroll = ScrollController();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) => _verificarCnpjEmpresa());
  }
  
  void _verificarCnpjEmpresa() {
    if (Sessao.empresa!.cnpj == null) {
      EmpresaController.obrigarCadastroCnpj(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: AbsorbPointer(
        absorbing: (Sessao.statusCaixa == StatusCaixa.vendaEmAndamento), // se houver uma venda em andamento, desabilita as opções do menu
        child: ListView(
          controller: controllerScroll,
          padding: EdgeInsets.zero,
          children: <Widget>[

            ///
            /// Cabeçalho
            /// 
            UserAccountsDrawerHeader(  
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFF3366FF),
                    Color(0xFF00CCFF),
                  ],
                  begin: FractionalOffset(0.0, 0.0),
                  end: FractionalOffset(1.0, 0.0),
                  stops: [0.0, 1.0],
                  tileMode: TileMode.clamp
                ),
              ),                      
              accountName: const Text(
                "Opções Gerenciais",
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20.0),              
              ),
              accountEmail: Text(
                Sessao.empresa!.nomeFantasia ?? 'Cadastre o nome da empresa',
              ),
              currentAccountPicture: const CircleAvatar(
                backgroundImage: AssetImage(Constantes.profileImage),
              ),
            ),

            ///
            /// Contratação NFC-e
            /// 
            ((Sessao.configuracaoPdv!.modulo == 'G' || Sessao.nfcePlanoPagamento == null) && NfceController.ufPermiteSistemaNfce(Sessao.empresa!.uf))
            ?
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    padding: const EdgeInsets.only(top: 0, left: 20, right: 0),
                    child: const Text(
                      "Contrate o Módulo NFC-e",
                      style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12.0, fontStyle: FontStyle.italic),              
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 2,
                      padding: const EdgeInsets.all(0),
                      primary: Colors.white, 
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
                    ),                    
                    onPressed: () { 
                      Navigator.of(context)
                        .push(MaterialPageRoute(
                            builder: (BuildContext context) =>
                                const NfceContrataPage()))
                        .then((_) {
                        });
                      },
                    child: Container(
                      height: 120.0,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(Constantes.nfceBanner),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10,),
                ],
              )
            : const SizedBox(height: 1,),

            ///
            /// Opções Caixa
            /// 
            Container(
              padding: const EdgeInsets.only(top: 0, left: 20, right: 0),
              child: const Text(
                "Opções Caixa",
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12.0, fontStyle: FontStyle.italic),              
              ),
            ),
            ListTile(
              onTap:  () { 
                Navigator.of(context)
                  .push(MaterialPageRoute(
                      builder: (BuildContext context) =>
                          const MovimentoEncerraPage(title: 'Encerra Movimento')))
                  .then((_) {
                  });
                },
              title: const Text(
                "Movimento",
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18.0),
              ),
              leading: const Icon(
                FontAwesomeIcons.cashRegister,
                color: Colors.green,
              ),
            ),
            ListTile(
              onTap: () => _efetuarSuprimento(context),
              title: const Text(
                "Suprimento",
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18.0),
              ),
              leading: Icon(
                // ignore: deprecated_member_use
                FontAwesomeIcons.funnelDollar,
                color: Colors.blueAccent.shade200,
              ),
            ),
            ListTile(
              onTap:  ()  => _efetuarSangria(context),
              title: const Text(
                "Sangria",
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18.0),
              ),
              leading: Icon(
                FontAwesomeIcons.fileInvoiceDollar,
                color: Colors.redAccent.shade200,
              ),
            ),

            const Divider(),

            ///
            /// Módulos
            /// 
            Container(
              padding: const EdgeInsets.only(top: 0, left: 20, right: 0),
              child: const Text(
                "Módulos",
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12.0, fontStyle: FontStyle.italic),              
              ),
            ),
            ListTile(
              onTap: () { 
                Navigator.of(context)
                  .push(MaterialPageRoute(
                    builder: (BuildContext context) => const MenuCadastros()))
                  .then((_) {
                    //Provider.of<BancoViewModel>(context).consultarLista();
                  });
                },
              title: const Text(
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
                    builder: (BuildContext context) => const CompraPedidoCabecalhoListaPage()))
                  .then((_) {
                    //Provider.of<BancoViewModel>(context).consultarLista();
                  });
                },
              title: const Text(
                "Compras",
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18.0),
              ),
              leading: Icon(
                // ignore: deprecated_member_use
                FontAwesomeIcons.shoppingBasket,
                color: Colors.blueGrey.shade700,
                // color: Colors.deepOrange.shade700,
              ),
            ),
            ListTile(
              onTap: () { 
                Navigator.of(context)
                  .push(MaterialPageRoute(
                    builder: (BuildContext context) => const EstoqueListaPage()))
                  .then((_) {
                    //Provider.of<BancoViewModel>(context).consultarLista();
                  });
                },
              title: const Text(
                "Estoque",
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18.0),
              ),
              leading: Icon(
                // ignore: deprecated_member_use
                FontAwesomeIcons.truckLoading,
                color: Colors.blueGrey.shade700,
                // color: Colors.deepPurple.shade700,
              ),
            ),
            ListTile(
              onTap: () { 
                Navigator.of(context)
                  .push(MaterialPageRoute(
                    builder: (BuildContext context) => const MenuFinanceiro()))
                  .then((_) {
                    //Provider.of<BancoViewModel>(context).consultarLista();
                  });
                },
              title: const Text(
                "Financeiro",
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18.0),
              ),
              leading: Icon(
                // ignore: deprecated_member_use
                FontAwesomeIcons.moneyBillAlt,
                color: Colors.blueGrey.shade700,
                // color: Colors.indigoAccent.shade700,
              ),
            ),

            ListTile(
              onTap: () { 
                Navigator.of(context)
                  .push(MaterialPageRoute(
                    builder: (BuildContext context) => const DashboardPage()))
                  .then((_) {
                    //Provider.of<BancoViewModel>(context).consultarLista();
                  });
                },
              title: const Text(
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
                    builder: (BuildContext context) => const VendasListaPage()))
                  .then((_) {
                    //Provider.of<BancoViewModel>(context).consultarLista();
                  });
                },
              title: const Text(
                "Vendas",
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18.0),
              ),
              leading: Icon(
                // ignore: deprecated_member_use
                FontAwesomeIcons.shoppingCart,
                color: Colors.blueAccent.shade700,
                // color: Colors.deepOrange.shade700,
              ),
            ),

            // só apresenta o cadastro do Food se o CNAE da empresa for de alimentação
            Sessao.cnaePermiteModuloFood
            ?
              ListTile(
                onTap: () { 
                  Navigator.of(context)
                    .push(MaterialPageRoute(
                      builder: (BuildContext context) => const MenuFood()))
                    .then((_) {
                    });
                  },
                title: const Text(
                  "Módulo Food",
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18.0),
                ),
                leading: Icon(
                  FontAwesomeIcons.utensils,
                  color: Colors.red.shade700,
                  // color: Colors.deepOrange.shade700,
                ),
              )
            : const SizedBox(height: 1,),


            Sessao.configuracaoPdv!.moduloFiscalPrincipal == 'NFC' 
            ? 
              ListTile(
                onTap: () { 
                  Navigator.of(context)
                    .push(MaterialPageRoute(
                      builder: (BuildContext context) => const MenuFiscal()))
                    .then((_) {
                      //Provider.of<BancoViewModel>(context).consultarLista();
                    });
                  },
                title: const Text(
                  "NFC-e",
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18.0),
                ),
                leading: Icon(
                  FontAwesomeIcons.fileInvoice,
                  color: Colors.green.shade700,
                  // color: Colors.deepOrange.shade700,
                ),
              )
            : const SizedBox(height: 1,),

            const Divider(),

            ///
            /// Preferências
            /// 
            Container(
              padding: const EdgeInsets.only(top: 0, left: 20, right: 0),
              child: const Text(
                "Outros",
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12.0, fontStyle: FontStyle.italic),              
              ),
            ),
            ListTile(
              onTap:  () {    
                Navigator.of(context)
                  .push(MaterialPageRoute(
                    builder: (BuildContext context) => const ConfiguracaoPage()))
                  .then((_) {
                    //Provider.of<BancoViewModel>(context).consultarLista();
                  });
              },
              title: const Text(
                "Configurações",
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18.0),
              ),
              leading: const Icon(
                // ignore: deprecated_member_use
                FontAwesomeIcons.cog,
                color: Colors.brown,
              ),
            ),
            ListTile(
              onTap: () async { 
                const url = 'https://www.youtube.com/playlist?list=PLMqoOoxxICPfegpWl8Mj2mthn5QocLGuL';
                // ignore: deprecated_member_use
                await canLaunch(url) ? await launch(url) : throw 'URL não pode ser carregada: $url';
                if (!mounted) return;
                Navigator.pop(context); 
              },
              title: const Text(
                "Ajuda",
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18.0),
              ),
              leading: Icon(
                // ignore: deprecated_member_use
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
                // ignore: prefer_interpolation_to_compose_strings
                final url = 'https://t2tisistemas.com/contact.php?'
                'nome=' + Sessao.empresa!.nomeFantasia! + 
                '&email=' + Sessao.empresa!.email! + 
                '&assunto=Contato Pegasus PDV&mensagem='
                'Olá Equipe T2Ti,'
                '%0DEstou usando o T2Ti Pegasus PDV e preciso do seguinte auxílio: ';
                // ignore: deprecated_member_use
                await canLaunch(url) ? await launch(url) : throw 'URL não pode ser carregada: $url';
                if (!mounted) return;
                Navigator.pop(context); 
              },
              title: const Text(
                "Contato",
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18.0),
              ),
              leading: Icon(
                FontAwesomeIcons.addressBook,
                color: Colors.redAccent.shade700,
              ),
            ),

            const Divider(),
            ListTile(
              onTap: () async { 
                gerarDialogBoxConfirmacao(context, 'Deseja subir os dados para o servidor?\n\nCertifique-se de que este é o dispositivo principal de cadastros e movimento.', () async {
                  gerarDialogBoxEspera(context);
                  // descomente o código abaixo para subir o banco de dados SQLite completo para o servidor
                  File file = File(Sessao.caminhoBancoDados);
                  String arquivoBase64 = base64.encode(file.readAsBytesSync());
                  SincronizaService sincronizaService = SincronizaService();
                  final retorno = await sincronizaService.subirDadosServidor(arquivoBase64);        
                  // descomente para subir os dados no formato JSON
                  // final retorno = await SincronizaController.subirTabelasCentrais();
                  if (!mounted) return;
                  if (retorno) {
                    Navigator.popUntil(context, ModalRoute.withName('/'));
                    showInSnackBar('Dados atualizados com sucesso no servidor.', context, corFundo: Colors.blue);
                  } else {
                    Navigator.popUntil(context, ModalRoute.withName('/'));
                    showInSnackBar('Ocorreu um problema ao tentar enviar atualizar os dados no Servidor.', context, corFundo: Colors.red);
                  }
                });
              },
              title: const Text(
                "Upload Dados",
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18.0),
              ),
              leading: Icon(
                FontAwesomeIcons.upload,
                color: Colors.blueAccent.shade700,
              ),
            ),

            ListTile(
              onTap: () async { 
                gerarDialogBoxConfirmacao(context, 'Deseja atualizar os dados a partir do servidor?\n\nCertifique-se de que este NÃO é o dispositivo principal de cadastros e movimento.', () async {
                  gerarDialogBoxEspera(context);
                  final retorno = await SincronizaController.sincronizarDadosVindosDoServidor();
                  if (!mounted) return;
                  if (retorno) {
                    Navigator.popUntil(context, ModalRoute.withName('/'));
                    showInSnackBar('Dados sincronizados com sucesso.', context, corFundo: Colors.blue);
                  } else {
                    Navigator.popUntil(context, ModalRoute.withName('/'));
                    showInSnackBar('Ocorreu um problema ao tentar baixar os dados do servidor.', context, corFundo: Colors.red);
                  }
                });
              },
              title: const Text(
                "Download Dados",
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18.0),
              ),
              leading: Icon(
                FontAwesomeIcons.download,
                color: Colors.greenAccent.shade700,
              ),
            ),

            ListTile(
              onTap: () async { 
                gerarDialogBoxConfirmacao(context, 'Deseja sair da aplicação?', () async {
                  if (Biblioteca.isDesktop()) {
                    exit(0);
                  } else {
                    Future.delayed(const Duration(milliseconds: 1000), () {
                      SystemChannels.platform.invokeMethod('SystemNavigator.pop');
                    });                  
                  }
                });
              },
              title: const Text(
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
            const MyAboutTile()
          ],
        ),
      ),
    );
  }

  void _efetuarSuprimento(BuildContext context) async {
      bool? gravouSuprimento = await showDialog(context: context, 
        builder: (BuildContext context){
          return const InformaValorPage(title: 'Suprimento', operacao: 'SUPRIMENTO', );
        });

      if (!mounted) return;
      if (gravouSuprimento ?? false) {
        gerarDialogBoxInformacao(context, 'Suprimento realizado com sucesso.');
      }
  }

  void _efetuarSangria(BuildContext context) async {
      bool? gravouSangria = await showDialog(context: context, 
        builder: (BuildContext context){
          return const InformaValorPage(title: 'Sangria', operacao: 'SANGRIA', );
        });

      if (!mounted) return;
      if (gravouSangria ?? false) {
        gerarDialogBoxInformacao(context, 'Sangria realizada com sucesso.');
      }
  }
}
