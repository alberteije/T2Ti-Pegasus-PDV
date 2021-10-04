import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_uikit/model/menu.dart';
import 'package:flutter_uikit/utils/uidata.dart';

class MenuViewModel {
  final menuStreamController = StreamController<List<Menu>>();
  Stream<List<Menu>> get menuItemsStream => menuStreamController.stream;

  MenuViewModel() {
    menuStreamController.add(getMenuItems());
  }

  List<Menu> menuItems;
  getMenuItems() {
    return menuItems = <Menu>[
      Menu(
          title: "Cadastros",
          menuColor: Colors.black,
          icon: Icons.person,
          image: UIData.menuCadastrosImage,
          items: [
           "Dashboard 1",
            "View Profile",
            "Profile 2",
            "Profile 3",
            "Profile 4"
          ]),
      Menu(
          title: "Contas a Pagar",
          menuColor: Color(0xffc7d8f4),
          icon: Icons.account_balance_wallet,
          image: UIData.menuPagarImage,
          items: ["Login With OTP", "Login 2", "Sign Up", "Login 4"]),
      Menu(
          title: "Contas a Receber",
          menuColor: Color(0xff7f5741),
          icon: Icons.account_balance,
          image: UIData.menuReceberImage,
          items: ["Feed", "Tweets", "Timeline 3", "Timeline 4"]),
      Menu(
          title: "Tesouraria",
          menuColor: Colors.black,
          icon: Icons.attach_money,
          image: UIData.menuTesourariaImage,
          items: [
            "Dashboard 1",
            "View Profile",
            "Profile 2",
            "Profile 3",
            "Profile 4"
          ]),
      Menu(
          title: "Fluxo de Caixa",
          menuColor: Color(0xff7f5741),
          icon: Icons.money_off,
          image: UIData.menuFluxoCaixaImage,
          items: ["Feed", "Tweets", "Timeline 3", "Timeline 4"]),
      Menu(
          title: "Caixa e Bancos",
          menuColor: Color(0xff7f5741),
          icon: Icons.card_travel,
          image: UIData.menuBancoImage,
          items: ["Feed", "Tweets", "Timeline 3", "Timeline 4"]),
      Menu(
          title: "Conciliação Bancária",
          menuColor: Color(0xff7f5741),
          icon: Icons.check_circle,
          image: UIData.menuConciliacaoImage,
          items: ["Feed", "Tweets", "Timeline 3", "Timeline 4"]),
      Menu(
          title: "Tributação",
          menuColor: Color(0xff7f5741),
          icon: Icons.assessment,
          image: UIData.menuTributacaoImage,
          items: ["Feed", "Tweets", "Timeline 3", "Timeline 4"]),
      Menu(
          title: "Compras",
          menuColor: Color(0xff7f5741),
          icon: Icons.add_shopping_cart,
          image: UIData.menuComprasImage,
          items: ["Feed", "Tweets", "Timeline 3", "Timeline 4"]),
      Menu(
          title: "Estoque",
          menuColor: Color(0xff7f5741),
          icon: Icons.category,
          image: UIData.menuEstoqueImage,
          items: ["Feed", "Tweets", "Timeline 3", "Timeline 4"]),
      Menu(
          title: "Vendas",
          menuColor: Color(0xff2a8ccf),
          icon: Icons.business_center,
          image: UIData.menuVendasImage,
          items: ["Dashboard 2", "Settings 2", "Settings 3", "Settings 4"]),
      Menu(
          title: "AFV",
          menuColor: Color(0xff2a8ccf),
          icon: Icons.business,
          image: UIData.menuAfvImage,
          items: ["Dashboard 2", "Settings 2", "Settings 3", "Settings 4"]),
      Menu(
          title: "Comissões",
          menuColor: Color(0xff2a8ccf),
          icon: Icons.assignment_ind,
          image: UIData.menuComissoesImage,
          items: ["Dashboard 2", "Settings 2", "Settings 3", "Settings 4"]),
      Menu(
          title: "Ordem de Serviço",
          menuColor: Color(0xff2a8ccf),
          icon: Icons.chat,
          image: UIData.menuOsImage,
          items: ["Dashboard 2", "Settings 2", "Settings 3", "Settings 4"]),
      Menu(
          title: "NF-e",
          menuColor: Colors.black,
          icon: Icons.receipt,
          image: UIData.menuNfeImage,
          items: [
            "Login 2",
            "Shopping Details",
            "Product Details",
            "Shopping 4"
          ]),
      Menu(
          title: "NFS-e",
          menuColor: Color(0xff261d33),
          icon: Icons.receipt,
          image: UIData.menuNfseImage,
          items: ["Credit Card", "Dashboard 2", "Dashboard 3", "Dashboard 4"]),
      Menu(
          title: "NFC-e",
          menuColor: Color(0xff261d33),
          icon: Icons.chrome_reader_mode,
          image: UIData.menuNfceImage,
          items: ["Credit Card", "Dashboard 2", "Dashboard 3", "Dashboard 4"]),
      Menu(
          title: "SAT",
          menuColor: Color(0xff261d33),
          icon: Icons.chrome_reader_mode,
          image: UIData.menuSatImage,
          items: ["Credit Card", "Dashboard 2", "Dashboard 3", "Dashboard 4"]),
      Menu(
          title: "CT-e",
          menuColor: Color(0xff261d33),
          icon: Icons.date_range,
          image: UIData.menuCteImage,
          items: ["Credit Card", "Dashboard 2", "Dashboard 3", "Dashboard 4"]),
      Menu(
          title: "SPED",
          menuColor: Color(0xff261d33),
          icon: Icons.content_copy,
          image: UIData.menuSpedImage,
          items: ["Credit Card", "Dashboard 2", "Dashboard 3", "Dashboard 4"]),
      Menu(
          title: "GED",
          menuColor: Color(0xffe19b6b),
          icon: Icons.desktop_mac,
          image: UIData.menuGedImage,
          items: ["Device Settings", "No Internet", "No Item 3", "No Item 4"]),
      Menu(
          title: "Loja Virtual",
          menuColor: Color(0xffddcec2),
          icon: Icons.shopping_cart,
          image: UIData.menuLojaImage,
          items: [
            "Shopping List",
            "Credit Card",
            "Payment Success",
            "Payment 3",
            "Payment 4"
          ]),
      Menu(
          title: "CRM",
          menuColor: Color(0xffe19b6b),
          icon: Icons.folder_shared,
          image: UIData.menuCrmImage,
          items: ["Device Settings", "No Internet", "No Item 3", "No Item 4"]),
      Menu(
          title: "BI",
          menuColor: Color(0xffe19b6b),
          icon: Icons.extension,
          image: UIData.menuBiImage,
          items: ["Device Settings", "No Internet", "No Item 3", "No Item 4"]),
    ];
  }
}
