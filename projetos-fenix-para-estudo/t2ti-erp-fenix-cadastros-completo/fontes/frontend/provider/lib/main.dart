import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:fenix/src/infra/locator.dart';
import 'package:fenix/src/infra/rotas.dart';
import 'package:fenix/src/infra/constantes.dart';
import 'package:fenix/src/view_model/view_model.dart';

void main() {
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => locator<BancoViewModel>()),
        ChangeNotifierProvider(create: (_) => locator<BancoAgenciaViewModel>()),
        ChangeNotifierProvider(create: (_) => locator<PessoaViewModel>()),
        ChangeNotifierProvider(create: (_) => locator<ProdutoViewModel>()),
        ChangeNotifierProvider(
            create: (_) => locator<BancoContaCaixaViewModel>()),
        ChangeNotifierProvider(create: (_) => locator<CargoViewModel>()),
        ChangeNotifierProvider(create: (_) => locator<CepViewModel>()),
        ChangeNotifierProvider(create: (_) => locator<CfopViewModel>()),
        ChangeNotifierProvider(create: (_) => locator<ClienteViewModel>()),
        ChangeNotifierProvider(create: (_) => locator<CnaeViewModel>()),
        ChangeNotifierProvider(create: (_) => locator<ColaboradorViewModel>()),
        ChangeNotifierProvider(create: (_) => locator<SetorViewModel>()),
        ChangeNotifierProvider(create: (_) => locator<ContadorViewModel>()),
        ChangeNotifierProvider(create: (_) => locator<CsosnViewModel>()),
        ChangeNotifierProvider(create: (_) => locator<CstCofinsViewModel>()),
        ChangeNotifierProvider(create: (_) => locator<CstIcmsViewModel>()),
        ChangeNotifierProvider(create: (_) => locator<CstIpiViewModel>()),
        ChangeNotifierProvider(create: (_) => locator<CstPisViewModel>()),
        ChangeNotifierProvider(create: (_) => locator<EstadoCivilViewModel>()),
        ChangeNotifierProvider(create: (_) => locator<FornecedorViewModel>()),
        ChangeNotifierProvider(create: (_) => locator<MunicipioViewModel>()),
        ChangeNotifierProvider(create: (_) => locator<NcmViewModel>()),
        ChangeNotifierProvider(
            create: (_) => locator<NivelFormacaoViewModel>()),
        ChangeNotifierProvider(
            create: (_) => locator<TransportadoraViewModel>()),
        ChangeNotifierProvider(create: (_) => locator<UfViewModel>()),
        ChangeNotifierProvider(create: (_) => locator<VendedorViewModel>()),
		ChangeNotifierProvider(create: (_) => locator<ProdutoGrupoViewModel>()),
		ChangeNotifierProvider(create: (_) => locator<ProdutoMarcaViewModel>()),
		ChangeNotifierProvider(create: (_) => locator<ProdutoSubgrupoViewModel>()),
		ChangeNotifierProvider(create: (_) => locator<ProdutoUnidadeViewModel>()),
		ChangeNotifierProvider(create: (_) => locator<FinChequeEmitidoViewModel>()),
		ChangeNotifierProvider(create: (_) => locator<FinChequeRecebidoViewModel>()),
		ChangeNotifierProvider(create: (_) => locator<FinConfiguracaoBoletoViewModel>()),
		ChangeNotifierProvider(create: (_) => locator<FinDocumentoOrigemViewModel>()),
		ChangeNotifierProvider(create: (_) => locator<FinExtratoContaBancoViewModel>()),
		ChangeNotifierProvider(create: (_) => locator<FinFechamentoCaixaBancoViewModel>()),
		ChangeNotifierProvider(create: (_) => locator<FinLancamentoPagarViewModel>()),
		ChangeNotifierProvider(create: (_) => locator<FinLancamentoReceberViewModel>()),
		ChangeNotifierProvider(create: (_) => locator<FinNaturezaFinanceiraViewModel>()),
		ChangeNotifierProvider(create: (_) => locator<FinStatusParcelaViewModel>()),
		ChangeNotifierProvider(create: (_) => locator<FinTipoPagamentoViewModel>()),
		ChangeNotifierProvider(create: (_) => locator<FinTipoRecebimentoViewModel>()),
		ChangeNotifierProvider(create: (_) => locator<TalonarioChequeViewModel>()),
	],
      child: MaterialApp(
        theme: ThemeData(),
        initialRoute: '/',
        title: Constantes.appNameString,
        onGenerateRoute: Rotas.definirRotas,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
