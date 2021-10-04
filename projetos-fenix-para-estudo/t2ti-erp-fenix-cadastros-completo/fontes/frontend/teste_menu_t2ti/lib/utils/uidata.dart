import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

class UIData {
  //routes
  static const String homeRoute = "/home";
  static const String profileOneRoute = "/View Profile";
  static const String profileTwoRoute = "/Profile 2";
  static const String notFoundRoute = "/No Search Result";
  static const String timelineOneRoute = "/Feed";
  static const String timelineTwoRoute = "/Tweets";
  static const String settingsOneRoute = "/Device Settings";
  static const String shoppingOneRoute = "/Shopping List";
  static const String shoppingTwoRoute = "/Shopping Details";
  static const String shoppingThreeRoute = "/Product Details";
  static const String paymentOneRoute = "/Credit Card";
  static const String paymentTwoRoute = "/Payment Success";
  static const String loginOneRoute = "/Login With OTP";
  static const String loginTwoRoute = "/Login 2";
  static const String dashboardOneRoute = "/Dashboard 1";
  static const String dashboardTwoRoute = "/Dashboard 2";
  static const String cadastrosRoute = "/Dashboard 1";

  //strings
  static const String appName = "T2Ti ERP Fenix";

  //fonts
  static const String quickFont = "Quicksand";
  static const String ralewayFont = "Raleway";
  static const String quickBoldFont = "Quicksand_Bold.otf";
  static const String quickNormalFont = "Quicksand_Book.otf";
  static const String quickLightFont = "Quicksand_Light.otf";

  //images
  static const String imageDir = "assets/images";
  static const String t2tiLogo = "$imageDir/t2ti-32.png";
  static const String t2tiLogo48 = "$imageDir/t2ti-48.png";
  static const String pkImage = "$imageDir/pk.jpg";
  static const String profileImage = "$imageDir/profile.jpg";
  static const String blankImage = "$imageDir/blank.jpg";
  static const String dashboardImage = "$imageDir/dashboard.jpg";
  static const String loginImage = "$imageDir/login.jpg";
  static const String paymentImage = "$imageDir/payment.jpg";
  static const String settingsImage = "$imageDir/setting.jpeg";
  static const String shoppingImage = "$imageDir/shopping.jpeg";
  static const String timelineImage = "$imageDir/timeline.jpeg";
  static const String verifyImage = "$imageDir/verification.jpg";

  //images menu
  static const String menuCadastrosImage = "$imageDir/menu_cadastros.jpg";
  static const String menuNfeImage = "$imageDir/menu_nfe.jpg";
  static const String menuNfceImage = "$imageDir/menu_nfce.jpg";
  static const String menuNfseImage = "$imageDir/menu_nfse.jpg";
  static const String menuCteImage = "$imageDir/menu_cte.jpg";
  static const String menuSpedImage = "$imageDir/menu_sped.jpg";
  static const String menuSatImage = "$imageDir/menu_sat.jpg";
  static const String menuGedImage = "$imageDir/menu_ged.jpg";
  static const String menuLojaImage = "$imageDir/menu_loja.jpg";
  static const String menuPagarImage = "$imageDir/menu_pagar.jpg";
  static const String menuVendasImage = "$imageDir/menu_vendas.jpg";
  static const String menuEstoqueImage = "$imageDir/menu_estoque.jpg";
  static const String menuReceberImage = "$imageDir/menu_receber.jpg";
  static const String menuTesourariaImage = "$imageDir/menu_tesouraria.jpg";
  static const String menuBancoImage = "$imageDir/menu_banco.jpg";
  static const String menuFluxoCaixaImage = "$imageDir/menu_fluxo_caixa.jpg";
  static const String menuConciliacaoImage = "$imageDir/menu_conciliacao.jpg";
  static const String menuTributacaoImage = "$imageDir/menu_tributacao.jpg";
  static const String menuComprasImage = "$imageDir/menu_compras.jpg";
  static const String menuAfvImage = "$imageDir/menu_afv.jpg";
  static const String menuComissoesImage = "$imageDir/menu_comissoes.jpg";
  static const String menuOsImage = "$imageDir/menu_os.jpg";
  static const String menuCrmImage = "$imageDir/menu_crm.jpg";
  static const String menuBiImage = "$imageDir/menu_bi.jpg";
  

  //login
  static const String enter_code_label = "Telefone";
  static const String enter_code_hint = "Telefone: 10 dígitos";
  static const String enter_otp_label = "OTP";
  static const String enter_otp_hint = "4 Digit OTP";
  static const String get_otp = "Get OTP";
  static const String resend_otp = "Resend OTP";
  static const String login = "Login";
  static const String enter_valid_number = "Informe 10 dígitos para o telefone";
  static const String enter_valid_otp = "Informe 4 dígitos para o OTP";

  //gneric
  static const String error = "Erro";
  static const String success = "Successo";
  static const String ok = "OK";
  static const String forgot_password = "Esqueceu a Senha?";
  static const String something_went_wrong = "Alguma coisa saiu errada";
  static const String coming_soon = "Em breve";

  static const MaterialColor ui_kit_color = Colors.grey;

//colors
  static List<Color> kitGradients = [
    // new Color.fromRGBO(103, 218, 255, 1.0),
    // new Color.fromRGBO(3, 169, 244, 1.0),
    // new Color.fromRGBO(0, 122, 193, 1.0),
    Colors.blueGrey.shade800,
    Colors.black87,
  ];
  static List<Color> kitGradients2 = [
    Colors.cyan.shade600,
    Colors.blue.shade900
  ];

  //randomcolor
  static final Random _random = new Random();

  /// Returns a random color.
  static Color next() {
    return new Color(0xFF000000 + _random.nextInt(0x00FFFFFF));
  }
}
