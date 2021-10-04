/*
Title: T2Ti ERP Fenix                                                                
Description: Localizador e instanciador de classes
                                                                                
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
import 'package:get_it/get_it.dart';

import 'package:fenix/src/service/service.dart';
import 'package:fenix/src/view_model/view_model.dart';

GetIt locator = GetIt();

void setupLocator() {
  locator.registerLazySingleton(() => BancoService());
  locator.registerFactory(() => BancoViewModel());

  locator.registerLazySingleton(() => BancoAgenciaService());
  locator.registerFactory(() => BancoAgenciaViewModel());

  locator.registerLazySingleton(() => PessoaService());
  locator.registerFactory(() => PessoaViewModel());

  locator.registerLazySingleton(() => ProdutoService());
  locator.registerFactory(() => ProdutoViewModel());  

  locator.registerLazySingleton(() => BancoContaCaixaService());
  locator.registerFactory(() => BancoContaCaixaViewModel());

  locator.registerLazySingleton(() => CargoService());
  locator.registerFactory(() => CargoViewModel());

  locator.registerLazySingleton(() => CepService());
  locator.registerFactory(() => CepViewModel());

  locator.registerLazySingleton(() => CfopService());
  locator.registerFactory(() => CfopViewModel());
 
  locator.registerLazySingleton(() => ClienteService());
  locator.registerFactory(() => ClienteViewModel());
	
  locator.registerLazySingleton(() => CnaeService());
  locator.registerFactory(() => CnaeViewModel());

  locator.registerLazySingleton(() => ColaboradorService());
  locator.registerFactory(() => ColaboradorViewModel());
  
  locator.registerLazySingleton(() => SetorService());
  locator.registerFactory(() => SetorViewModel());
  
	locator.registerLazySingleton(() => ContadorService());
	locator.registerFactory(() => ContadorViewModel());
	
	locator.registerLazySingleton(() => CsosnService());
	locator.registerFactory(() => CsosnViewModel());
	
	locator.registerLazySingleton(() => CstCofinsService());
	locator.registerFactory(() => CstCofinsViewModel());
	
	locator.registerLazySingleton(() => CstIcmsService());
	locator.registerFactory(() => CstIcmsViewModel());
	
	locator.registerLazySingleton(() => CstIpiService());
	locator.registerFactory(() => CstIpiViewModel());
	
	locator.registerLazySingleton(() => CstPisService());
	locator.registerFactory(() => CstPisViewModel());

	locator.registerLazySingleton(() => EstadoCivilService());
	locator.registerFactory(() => EstadoCivilViewModel());
		
	locator.registerLazySingleton(() => FornecedorService());
	locator.registerFactory(() => FornecedorViewModel());
		
	locator.registerLazySingleton(() => MunicipioService());
	locator.registerFactory(() => MunicipioViewModel());
	
	locator.registerLazySingleton(() => NcmService());
	locator.registerFactory(() => NcmViewModel());
	
	locator.registerLazySingleton(() => NivelFormacaoService());
	locator.registerFactory(() => NivelFormacaoViewModel());
		
	locator.registerLazySingleton(() => TransportadoraService());
	locator.registerFactory(() => TransportadoraViewModel());
	
	locator.registerLazySingleton(() => UfService());
	locator.registerFactory(() => UfViewModel());
		
	locator.registerLazySingleton(() => VendedorService());
	locator.registerFactory(() => VendedorViewModel());

	locator.registerLazySingleton(() => ProdutoGrupoService());
	locator.registerFactory(() => ProdutoGrupoViewModel());
	
	locator.registerLazySingleton(() => ProdutoMarcaService());
	locator.registerFactory(() => ProdutoMarcaViewModel());
	
	locator.registerLazySingleton(() => ProdutoSubgrupoService());
	locator.registerFactory(() => ProdutoSubgrupoViewModel());
	
	locator.registerLazySingleton(() => ProdutoUnidadeService());
	locator.registerFactory(() => ProdutoUnidadeViewModel());

	locator.registerLazySingleton(() => FinChequeEmitidoService());
	locator.registerFactory(() => FinChequeEmitidoViewModel());
	
	locator.registerLazySingleton(() => FinChequeRecebidoService());
	locator.registerFactory(() => FinChequeRecebidoViewModel());
	
	locator.registerLazySingleton(() => FinConfiguracaoBoletoService());
	locator.registerFactory(() => FinConfiguracaoBoletoViewModel());
	
	locator.registerLazySingleton(() => FinDocumentoOrigemService());
	locator.registerFactory(() => FinDocumentoOrigemViewModel());
	
	locator.registerLazySingleton(() => FinExtratoContaBancoService());
	locator.registerFactory(() => FinExtratoContaBancoViewModel());
	
	locator.registerLazySingleton(() => FinFechamentoCaixaBancoService());
	locator.registerFactory(() => FinFechamentoCaixaBancoViewModel());
	
	locator.registerLazySingleton(() => FinLancamentoPagarService());
	locator.registerFactory(() => FinLancamentoPagarViewModel());
	
	locator.registerLazySingleton(() => FinLancamentoReceberService());
	locator.registerFactory(() => FinLancamentoReceberViewModel());
	
	locator.registerLazySingleton(() => FinNaturezaFinanceiraService());
	locator.registerFactory(() => FinNaturezaFinanceiraViewModel());
		
	locator.registerLazySingleton(() => FinStatusParcelaService());
	locator.registerFactory(() => FinStatusParcelaViewModel());
	
	locator.registerLazySingleton(() => FinTipoPagamentoService());
	locator.registerFactory(() => FinTipoPagamentoViewModel());
	
	locator.registerLazySingleton(() => FinTipoRecebimentoService());
	locator.registerFactory(() => FinTipoRecebimentoViewModel());

	locator.registerLazySingleton(() => TalonarioChequeService());
	locator.registerFactory(() => TalonarioChequeViewModel());
	
}