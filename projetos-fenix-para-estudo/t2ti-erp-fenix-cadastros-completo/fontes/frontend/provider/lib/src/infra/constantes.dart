/*
Title: T2Ti ERP Fenix                                                                
Description: Classe que armazena algumas constantes para a aplicação.
                                                                                
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
*******************************************************************************/
import 'package:intl/intl.dart';

class Constantes {
  /// singleton
  factory Constantes() {
    _this ??= Constantes._();
    return _this;
  }
  static Constantes _this;
  Constantes._() : super();

// #region Inteiros
  static const int decimaisValor = 2;
  static const int decimaisTaxa = 2;
  static const int decimaisQuantidade = 3;
// #endregion Inteiros  


// #region Decimais
  static final formatoDecimalValor = new NumberFormat("#,##0.00", "pt_BR");
  static final formatoDecimalTaxa = new NumberFormat("#,##0.00", "pt_BR");
  static final formatoDecimalQuantidade = new NumberFormat("#,##0.000", "pt_BR");
// #endregion Decimais


// #region Strings
  static const String appNameString = "T2Ti ERP Fenix";
  static const String menuCadastrosString = "T2Ti ERP Fenix - Cadastros";
  static const String menuFinanceiroString = "T2Ti ERP Fenix - Financeiro";
// #endregion Strings  


// #region Máscaras
  static const String mascaraCPF = "000.000.000-00";
  static const String mascaraCNPJ = "00.000.000/0000-00";
  static const String mascaraCEP = "00000-000";
  static const String mascaraTELEFONE = "(00)00000-0000";
  static const String mascaraMES_ANO = "00/0000";
// #endregion Máscaras  


// #region Fontes
  static const String quickFont = "Quicksand";
  static const String ralewayFont = "Raleway";
  static const String quickBoldFont = "Quicksand_Bold.otf";
  static const String quickNormalFont = "Quicksand_Book.otf";
  static const String quickLightFont = "Quicksand_Light.otf";
// #endregion Fontes


// #region Imagens
  //images
  static const String imageDir = "assets/images";
  static const String t2tiLogo = "$imageDir/t2ti-32.png";
  static const String t2tiLogo48 = "$imageDir/t2ti-48.png";
  static const String t2tiBackgroundImage = "$imageDir/t2ti_background.jpg";
  static const String profileImage = "$imageDir/profile.jpg";

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
// #endregion Imagens

}
