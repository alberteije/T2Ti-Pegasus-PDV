import 'dart:async';
import 'package:flutter/material.dart';

import 'package:fenix/src/model/menu/menu.dart';
import 'package:fenix/src/infra/constantes.dart';

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
          image: Constantes.menuCadastrosImage,
          route: "/cadastrosMenu",),
      Menu(
          title: "Bloco Financeiro",
          menuColor: Color(0xffc7d8f4),
          icon: Icons.account_balance_wallet,
          image: Constantes.menuPagarImage,
          route: "/financeiroMenu"),
      /*
      25042020 - EIJE - Comentado para utilizar apenas um ícone para todo o grupo financeiro
      Menu(
          title: "Contas a Pagar",
          menuColor: Color(0xffc7d8f4),
          icon: Icons.account_balance_wallet,
          image: Constantes.menuPagarImage,
          route: ""),
      Menu(
          title: "Contas a Receber",
          menuColor: Color(0xff7f5741),
          icon: Icons.account_balance,
          image: Constantes.menuReceberImage,
          route: ""),
      Menu(
          title: "Tesouraria",
          menuColor: Colors.black,
          icon: Icons.attach_money,
          image: Constantes.menuTesourariaImage,
          route: ""),
      Menu(
          title: "Fluxo de Caixa",
          menuColor: Color(0xff7f5741),
          icon: Icons.money_off,
          image: Constantes.menuFluxoCaixaImage,
          route: ""),
      Menu(
          title: "Caixa e Bancos",
          menuColor: Color(0xff7f5741),
          icon: Icons.card_travel,
          image: Constantes.menuBancoImage,
          route: ""),
      Menu(
          title: "Conciliação Bancária",
          menuColor: Color(0xff7f5741),
          icon: Icons.check_circle,
          image: Constantes.menuConciliacaoImage,
          route: ""),
      */
      Menu(
          title: "Tributação",
          menuColor: Color(0xff7f5741),
          icon: Icons.assessment,
          image: Constantes.menuTributacaoImage,
          route: ""),
      Menu(
          title: "Compras",
          menuColor: Color(0xff7f5741),
          icon: Icons.add_shopping_cart,
          image: Constantes.menuComprasImage,
          route: ""),
      Menu(
          title: "Estoque",
          menuColor: Color(0xff7f5741),
          icon: Icons.category,
          image: Constantes.menuEstoqueImage,
          route: ""),
      Menu(
          title: "Vendas",
          menuColor: Color(0xff2a8ccf),
          icon: Icons.business_center,
          image: Constantes.menuVendasImage,
          route: ""),
      Menu(
          title: "AFV",
          menuColor: Color(0xff2a8ccf),
          icon: Icons.business,
          image: Constantes.menuAfvImage,
          route: ""),
      Menu(
          title: "Comissões",
          menuColor: Color(0xff2a8ccf),
          icon: Icons.assignment_ind,
          image: Constantes.menuComissoesImage,
          route: ""),
      Menu(
          title: "Ordem de Serviço",
          menuColor: Color(0xff2a8ccf),
          icon: Icons.chat,
          image: Constantes.menuOsImage,
          route: ""),
      Menu(
          title: "NF-e",
          menuColor: Colors.black,
          icon: Icons.receipt,
          image: Constantes.menuNfeImage,
          route: ""),
      Menu(
          title: "NFS-e",
          menuColor: Color(0xff261d33),
          icon: Icons.receipt,
          image: Constantes.menuNfseImage,
          route: ""),
      Menu(
          title: "NFC-e",
          menuColor: Color(0xff261d33),
          icon: Icons.chrome_reader_mode,
          image: Constantes.menuNfceImage,
          route: ""),
      Menu(
          title: "SAT",
          menuColor: Color(0xff261d33),
          icon: Icons.chrome_reader_mode,
          image: Constantes.menuSatImage,
          route: ""),
      Menu(
          title: "CT-e",
          menuColor: Color(0xff261d33),
          icon: Icons.date_range,
          image: Constantes.menuCteImage,
          route: ""),
      Menu(
          title: "SPED",
          menuColor: Color(0xff261d33),
          icon: Icons.content_copy,
          image: Constantes.menuSpedImage,
          route: ""),
      Menu(
          title: "GED",
          menuColor: Color(0xffe19b6b),
          icon: Icons.desktop_mac,
          image: Constantes.menuGedImage,
          route: ""),
      Menu(
          title: "Loja Virtual",
          menuColor: Color(0xffddcec2),
          icon: Icons.shopping_cart,
          image: Constantes.menuLojaImage,
          route: ""),
      Menu(
          title: "CRM",
          menuColor: Color(0xffe19b6b),
          icon: Icons.folder_shared,
          image: Constantes.menuCrmImage,
          route: ""),
      Menu(
          title: "BI",
          menuColor: Color(0xffe19b6b),
          icon: Icons.extension,
          image: Constantes.menuBiImage,
          route: ""),
    ];
  }
}