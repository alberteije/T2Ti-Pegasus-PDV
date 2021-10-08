/*
Title: T2Ti ERP 3.0                                                                
Description: Classe que armazena algumas constantes para a aplicação.
                                                                                
The MIT License                                                                 
                                                                                
Copyright: Copyright (C) 2021 T2Ti.COM                                          
                                                                                
Permission is hereby granted, free of charge, to any person                     
obtaining a copy of this software and associated documentation                  
files (the 'Software'), to deal in the Software without                         
restriction, including without limitation the rights to use,                    
copy, modify, merge, publish, distribute, sublicense, and/or sell               
copies of the Software, and to permit persons to whom the                       
Software is furnished to do so, subject to the following                        
conditions:                                                                     
                                                                                
The above copyright notice and this permission notice shall be                  
included in all copies or substantial portions of the Software.                 
                                                                                
THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND,                 
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
import 'package:flutter/material.dart' hide Key;
import 'package:flutter/foundation.dart' hide Key;
import 'package:intl/intl.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart' as DotEnv;
import 'package:encrypt/encrypt.dart';
import 'package:pegasus_pdv/src/infra/infra.dart';

import 'biblioteca.dart';

class Constantes {

  /// singleton
  factory Constantes() {
    _this ??= Constantes._();
    return _this;
  }
  static Constantes _this;
  Constantes._() : super();

  static const String versaoApp =  'versão 1.0.8 - Julho/2021';

// #region Arquivo ENV
  static String chave = '#Sua-Chave-de-32-caracteres-aqui'; // #Sua-Chave-de-32-caracteres-aqui tem que alterar para produção e gerar os valores do ENV com a chave correta
  static Key key = Key.fromUtf8(Constantes.chave);
  static IV iv = IV.fromUtf8('');
  static Encrypter encrypter = Encrypter(AES(key, mode: AESMode.ecb));

  static String sentryDns = (kDebugMode && Biblioteca.isDesktop()) ? DotEnv.env['SENTRY_DNS'] : encrypter.decrypt64(DotEnv.env['SENTRY_DNS'], iv: iv);
  static String linguagemServidor = (kDebugMode && Biblioteca.isDesktop()) ? DotEnv.env['LINGUAGEM_SERVIDOR'] : encrypter.decrypt64(DotEnv.env['LINGUAGEM_SERVIDOR'], iv: iv);
  static String enderecoServidor = (kDebugMode && Biblioteca.isDesktop()) ? DotEnv.env['ENDERECO_SERVIDOR'] : encrypter.decrypt64(DotEnv.env['ENDERECO_SERVIDOR'], iv: iv);
  static String complementoEnderecoServidor = (kDebugMode && Biblioteca.isDesktop()) ? DotEnv.env['COMPLEMENTO_ENDERECO_SERVIDOR'] : encrypter.decrypt64(DotEnv.env['COMPLEMENTO_ENDERECO_SERVIDOR'], iv: iv);
  static String portaServidor = (kDebugMode && Biblioteca.isDesktop()) ? DotEnv.env['PORTA_SERVIDOR'] : encrypter.decrypt64(DotEnv.env['PORTA_SERVIDOR'], iv: iv);

  // static String sentryDns = encrypter.decrypt64(DotEnv.env['SENTRY_DNS'], iv: iv);
  // static String linguagemServidor = encrypter.decrypt64(DotEnv.env['LINGUAGEM_SERVIDOR'], iv: iv);
  // static String enderecoServidor = encrypter.decrypt64(DotEnv.env['ENDERECO_SERVIDOR'], iv: iv);
  // static String complementoEnderecoServidor = encrypter.decrypt64(DotEnv.env['COMPLEMENTO_ENDERECO_SERVIDOR'], iv: iv);
  // static String portaServidor = encrypter.decrypt64(DotEnv.env['PORTA_SERVIDOR'], iv: iv);

  // static String sentryDns = DotEnv.env['SENTRY_DNS'];
  // static String linguagemServidor = DotEnv.env['LINGUAGEM_SERVIDOR'];
  // static String enderecoServidor = DotEnv.env['ENDERECO_SERVIDOR'];
  // static String complementoEnderecoServidor = DotEnv.env['COMPLEMENTO_ENDERECO_SERVIDOR'];
  // static String portaServidor = DotEnv.env['PORTA_SERVIDOR'];
// #endregion Arquivo ENV  


// #region Inteiros
  static final int decimaisTaxa = 2;
  static final int decimaisValor = Sessao.configuracaoPdv.decimaisValor ?? 2;
  static final int decimaisQuantidade = Sessao.configuracaoPdv.decimaisQuantidade ?? 3;
  static final int paginatedDataTableLinhasPorPagina = PaginatedDataTable.defaultRowsPerPage;
// #endregion Inteiros  


// #region Double
  static final double paddingListViewListaPage = 8.0;
  static final double flutterBootstrapGutterSize = 10.0;
// #region Double


// #region Decimais
  static final formatoDecimalTaxa = NumberFormat('#,##0.00', 'pt_BR');
  static final formatoDecimalValor = NumberFormat('#,##0.00', 'pt_BR');
  static final formatoDecimalQuantidade = 
    NumberFormat((Sessao.configuracaoPdv.decimaisQuantidade == 2 ? '#,##0.00' : '#,##0.000'), 'pt_BR');
// #endregion Decimais


// #region Strings
  static const String nomeApp =  'T2Ti Pegasus PDV';
  static const String menuCadastrosString = 'T2Ti ERP Fenix - Cadastros';
  static const String menuFinanceiroString = 'T2Ti ERP Fenix - Financeiro';
  static const String menuTributacaoString = 'T2Ti ERP Fenix - Tributação';
  static const String menuEstoqueString = 'T2Ti ERP Fenix - Estoque';
  static const String menuVendasString = 'T2Ti ERP Fenix - Vendas';
  static const String menuComprasString = 'T2Ti ERP Fenix - Compras';
  static const String menuComissoesString = 'T2Ti ERP Fenix - Gestão de Comissões';
  static const String menuOsString = 'T2Ti ERP Fenix - Ordem de Serviço';
  static const String menuAfvString = 'T2Ti ERP Fenix - AFV';
  static const String menuNfseString = 'T2Ti ERP Fenix - NFS-e';

  static const String tituloAbaDetalhePrincipal = 'Detalhes';

  static const String impressaoFormularioA4 = 'Formulário A4';
  static const String impressaoBobina57 = 'Bobina 57';
  static const String impressaoBobina80 = 'Bobina 80';

  static const String tituloCaixaAberto = '[Caixa Aberto]';
  static const String tituloCaixaFechado = '[Caixa Fechado]';
  static const String tituloCaixaVendaEmAndamento = '[Vendendo]';

  // Descrição botões
  static const String botaoFiltrarDescricao = kIsWeb == true ? 'Filtro [Ctrl+F11]' : 'Filtro [F11]';
  static const String botaoImprimirDescricao = kIsWeb == true ? 'Relatório [Ctrl+F8]': 'Relatório [F8]';
  static const String botaoExcluirDescricao = kIsWeb == true ? 'Excluir [Ctrl+F9]': 'Excluir [F9]';
  static const String botaoAlterarDescricao = kIsWeb == true ? 'Alterar [Ctrl+F3]': 'Alterar [F3]';
  static const String botaoSalvarDescricao = kIsWeb == true ? 'Salvar [Ctrl+F12]': 'Salvar [12]';
  // - Caixa
  static final String botaoCaixaSalvar = Biblioteca.isDesktop() ? 'Salvar [F12]' : 'Salvar';
  static final String botaoCaixaCancelar = Biblioteca.isDesktop() ? 'Cancelar [F11]' : 'Cancelar';
  static final String botaoCaixaRecuperar = Biblioteca.isDesktop() ? 'Recuperar [F9]' : 'Recuperar';
  static final String botaoCaixaDesconto = Biblioteca.isDesktop() ? 'Desconto [F10]' : 'Desconto';
  static final String botaoCaixaVendedor = Biblioteca.isDesktop() ? 'Vendedor [F3]' : 'Vendedor';
  static final String botaoCaixaCliente = Biblioteca.isDesktop() ? 'Cliente [F4]' : 'Cliente';
  static final String botaoCaixaOpcoes = Biblioteca.isDesktop() ? 'Opções [F5]' : 'Opções';

  // Dicas botões
  static const String botaoInserirDica = 'Inserir Item [F2]';
  static const String botaoFiltrarDica = 'Aplicar Filtro';
  static const String botaoImprimirDica = 'Relatório PDF';
  static const String botaoExcluirDica = 'Excluir Registro';
  static const String botaoAlterarDica = 'Alterar Registro';
  static const String botaoSalvarDica = 'Salvar';
  // - Caixa
  static const String botaoCaixaImportarProdutoDica = 'Importar Produto [F6]';

  // Perguntas
  static const String perguntaGerarRelatorio = 'Desejar gerar o relatório?';
  static const String perguntaSalvarAlteracoes = 'Desejar salvar as alterações?';
  
  // Mensagens
  static const String mensagemCorrijaErrosFormSalvar = 'Por favor, corrija os erros apresentados antes de continuar.';


// #endregion Strings  


// #region Máscaras
  static const String mascaraCPF = '000.000.000-00';
  static const String mascaraCNPJ = '00.000.000/0000-00';
  static const String mascaraCEP = '00000-000';
  static const String mascaraTELEFONE = '(00)00000-0000';
  static const String mascaraMES_ANO = '00/0000';
  static const String mascaraHORA = '00:00:00';
  static const String mascaraDIA = '00';
  static const String mascaraANO = '0000';
  static const String mascaraQUANTIDADE_INTEIRO = '00000';
// #endregion Máscaras  


// #region Fontes
  static const String quickFont = 'Quicksand';
  static const String ralewayFont = 'Raleway';
  static const String quickBoldFont = 'Quicksand_Bold.otf';
  static const String quickNormalFont = 'Quicksand_Book.otf';
  static const String quickLightFont = 'Quicksand_Light.otf';
// #endregion Fontes


// #region Imagens
  //images
  static const String imageDir = 'assets/images';
  static const String t2tiLogo = '$imageDir/t2ti-32.png';
  static const String t2tiLogo48 = '$imageDir/t2ti-48.png';
  static const String t2tiLogoGrande = '$imageDir/logo_t2ti.png';
  static const String t2tiLogoPegasusPdv = '$imageDir/logo_pegasus_pdv.png';
  static const String t2tiBackgroundImage = '$imageDir/t2ti_background.jpg';
  static const String profileImage = '$imageDir/profile.jpg';
  static const String googleMapFake = '$imageDir/maps.png';

  //images menu
  static const String menuCadastrosImage = '$imageDir/menu_cadastros.jpg';
  static const String menuNfeImage = '$imageDir/menu_nfe.jpg';
  static const String menuNfceImage = '$imageDir/menu_nfce.jpg';
  static const String menuNfseImage = '$imageDir/menu_nfse.jpg';
  static const String menuCteImage = '$imageDir/menu_cte.jpg';
  static const String menuSpedImage = '$imageDir/menu_sped.jpg';
  static const String menuSatImage = '$imageDir/menu_sat.jpg';
  static const String menuGedImage = '$imageDir/menu_ged.jpg';
  static const String menuLojaImage = '$imageDir/menu_loja.jpg';
  static const String menuPagarImage = '$imageDir/menu_pagar.jpg';
  static const String menuVendasImage = '$imageDir/menu_vendas.jpg';
  static const String menuEstoqueImage = '$imageDir/menu_estoque.jpg';
  static const String menuReceberImage = '$imageDir/menu_receber.jpg';
  static const String menuTesourariaImage = '$imageDir/menu_tesouraria.jpg';
  static const String menuBancoImage = '$imageDir/menu_banco.jpg';
  static const String menuFluxoCaixaImage = '$imageDir/menu_fluxo_caixa.jpg';
  static const String menuConciliacaoImage = '$imageDir/menu_conciliacao.jpg';
  static const String menuTributacaoImage = '$imageDir/menu_tributacao.jpg';
  static const String menuComprasImage = '$imageDir/menu_compras.jpg';
  static const String menuAfvImage = '$imageDir/menu_afv.jpg';
  static const String menuComissoesImage = '$imageDir/menu_comissoes.jpg';
  static const String menuOsImage = '$imageDir/menu_os.jpg';
  static const String menuCrmImage = '$imageDir/menu_crm.jpg';
  static const String menuBiImage = '$imageDir/menu_bi.jpg';

  // outras imagens
  static const String suprimentoSangriaIcon = '$imageDir/suprimento-sangria-icon.jpg';
  static const String informaValorIcon = '$imageDir/informa-valor-icon.png';
  static const String opcoesGerenteIcon = '$imageDir/opcoes-gerente-icon.png';
  static const String caixaIcon = '$imageDir/caixa-icon.png';
  static const String pagamentoIcon = '$imageDir/pagamento-icon.png';
  static const String produtoIcon = '$imageDir/produto-icon.png';
  static const String dashboardIcon = '$imageDir/dashboard-icon.png';
  static const String parcelamentoIcon = '$imageDir/parcelas-icon.png';
  static const String dialogQuestionIcon = '$imageDir/dialog-question-icon.png';
  static const String dialogInfoIcon = '$imageDir/dialog-info-icon.png';
  static const String dialogErrorIcon = '$imageDir/dialog-error-icon.png';
  static const String nfceBanner = '$imageDir/nfce-banner.png';
  
// #endregion Imagens

}

enum StatusCaixa {
  aberto,
  fechado,
  vendaEmAndamento,
}