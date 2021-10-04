import 'dart:async';
import 'package:flutter/material.dart';
import 'package:fenix/src/model/menu/menu.dart';
import 'package:fenix/src/view/shared/view_util_lib.dart';

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
          image: ViewUtilLib.menuCadastrosImage,
          route: "/cadastrosMenu",),
      Menu(
          title: "Contas a Pagar",
          menuColor: Color(0xffc7d8f4),
          icon: Icons.account_balance_wallet,
          image: ViewUtilLib.menuPagarImage,
          route: ""),
      Menu(
          title: "Contas a Receber",
          menuColor: Color(0xff7f5741),
          icon: Icons.account_balance,
          image: ViewUtilLib.menuReceberImage,
          route: ""),
      Menu(
          title: "Tesouraria",
          menuColor: Colors.black,
          icon: Icons.attach_money,
          image: ViewUtilLib.menuTesourariaImage,
          route: ""),
      Menu(
          title: "Fluxo de Caixa",
          menuColor: Color(0xff7f5741),
          icon: Icons.money_off,
          image: ViewUtilLib.menuFluxoCaixaImage,
          route: ""),
      Menu(
          title: "Caixa e Bancos",
          menuColor: Color(0xff7f5741),
          icon: Icons.card_travel,
          image: ViewUtilLib.menuBancoImage,
          route: ""),
      Menu(
          title: "Conciliação Bancária",
          menuColor: Color(0xff7f5741),
          icon: Icons.check_circle,
          image: ViewUtilLib.menuConciliacaoImage,
          route: ""),
      Menu(
          title: "Tributação",
          menuColor: Color(0xff7f5741),
          icon: Icons.assessment,
          image: ViewUtilLib.menuTributacaoImage,
          route: ""),
      Menu(
          title: "Compras",
          menuColor: Color(0xff7f5741),
          icon: Icons.add_shopping_cart,
          image: ViewUtilLib.menuComprasImage,
          route: ""),
      Menu(
          title: "Estoque",
          menuColor: Color(0xff7f5741),
          icon: Icons.category,
          image: ViewUtilLib.menuEstoqueImage,
          route: ""),
      Menu(
          title: "Vendas",
          menuColor: Color(0xff2a8ccf),
          icon: Icons.business_center,
          image: ViewUtilLib.menuVendasImage,
          route: ""),
      Menu(
          title: "AFV",
          menuColor: Color(0xff2a8ccf),
          icon: Icons.business,
          image: ViewUtilLib.menuAfvImage,
          route: ""),
      Menu(
          title: "Comissões",
          menuColor: Color(0xff2a8ccf),
          icon: Icons.assignment_ind,
          image: ViewUtilLib.menuComissoesImage,
          route: ""),
      Menu(
          title: "Ordem de Serviço",
          menuColor: Color(0xff2a8ccf),
          icon: Icons.chat,
          image: ViewUtilLib.menuOsImage,
          route: ""),
      Menu(
          title: "NF-e",
          menuColor: Colors.black,
          icon: Icons.receipt,
          image: ViewUtilLib.menuNfeImage,
          route: ""),
      Menu(
          title: "NFS-e",
          menuColor: Color(0xff261d33),
          icon: Icons.receipt,
          image: ViewUtilLib.menuNfseImage,
          route: ""),
      Menu(
          title: "NFC-e",
          menuColor: Color(0xff261d33),
          icon: Icons.chrome_reader_mode,
          image: ViewUtilLib.menuNfceImage,
          route: ""),
      Menu(
          title: "SAT",
          menuColor: Color(0xff261d33),
          icon: Icons.chrome_reader_mode,
          image: ViewUtilLib.menuSatImage,
          route: ""),
      Menu(
          title: "CT-e",
          menuColor: Color(0xff261d33),
          icon: Icons.date_range,
          image: ViewUtilLib.menuCteImage,
          route: ""),
      Menu(
          title: "SPED",
          menuColor: Color(0xff261d33),
          icon: Icons.content_copy,
          image: ViewUtilLib.menuSpedImage,
          route: ""),
      Menu(
          title: "GED",
          menuColor: Color(0xffe19b6b),
          icon: Icons.desktop_mac,
          image: ViewUtilLib.menuGedImage,
          route: ""),
      Menu(
          title: "Loja Virtual",
          menuColor: Color(0xffddcec2),
          icon: Icons.shopping_cart,
          image: ViewUtilLib.menuLojaImage,
          route: ""),
      Menu(
          title: "CRM",
          menuColor: Color(0xffe19b6b),
          icon: Icons.folder_shared,
          image: ViewUtilLib.menuCrmImage,
          route: ""),
      Menu(
          title: "BI",
          menuColor: Color(0xffe19b6b),
          icon: Icons.extension,
          image: ViewUtilLib.menuBiImage,
          route: ""),
    ];
  }
}
