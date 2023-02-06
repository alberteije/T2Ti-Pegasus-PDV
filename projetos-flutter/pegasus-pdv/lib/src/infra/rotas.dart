/*
Title: T2Ti ERP 3.0                                                                
Description: Define as rotas da aplicação
                                                                                
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
*******************************************************************************/
import 'package:flutter/material.dart';
import 'package:pegasus_pdv/src/view/page/page.dart';

class Rotas {
  static Route<dynamic> definirRotas(RouteSettings settings) {
    switch (settings.name) {
      
      // Login
      case '/':
        return MaterialPageRoute(builder: (_) => const CaixaPage());//LoginPage());//HomePage());//LoginPage());

			// Dashboard
			case '/dashboard':
			  return MaterialPageRoute(builder: (_) => const DashboardPage());

      ////////////////////////////////////////////////////////// 
      /// CADASTROS
      //////////////////////////////////////////////////////////

			// Cliente
			case '/clienteLista':
			  return MaterialPageRoute(builder: (_) => const ClienteListaPage());

			// Fornecedor
			case '/fornecedorLista':
			  return MaterialPageRoute(builder: (_) => const FornecedorListaPage());

			// Colaborador
			case '/colaboradorLista':
			  return MaterialPageRoute(builder: (_) => const ColaboradorListaPage());

			// Empresa
			case '/empresaLista':
			  return MaterialPageRoute(builder: (_) => const EmpresaListaPage());
			case '/empresaPersiste':
			  return MaterialPageRoute(builder: (_) => const EmpresaPersistePage());

			// Tipo Pagamento
			case '/pdvTipoPagamentoLista':
			  return MaterialPageRoute(builder: (_) => const PdvTipoPagamentoListaPage());

			// Unidade
			case '/produtoUnidadeLista':
			  return MaterialPageRoute(builder: (_) => const ProdutoUnidadeListaPage());

			// Tipo Produto
			case '/produtoTipoLista':
			  return MaterialPageRoute(builder: (_) => const ProdutoTipoListaPage());

			// Grupo Produto
			case '/produtoGrupoLista':
			  return MaterialPageRoute(builder: (_) => const ProdutoGrupoListaPage());

			// Grupo SubProduto
			case '/produtoSubgrupoLista':
			  return MaterialPageRoute(builder: (_) => const ProdutoSubgrupoListaPage());

			// Produto
			case '/produtoLista':
			  return MaterialPageRoute(builder: (_) => const ProdutoListaPage());

      ////////////////////////////////////////////////////////// 
      /// COMPRAS
      //////////////////////////////////////////////////////////

			case '/compraPedidoLista':
			  return MaterialPageRoute(builder: (_) => const CompraPedidoCabecalhoListaPage());

      ////////////////////////////////////////////////////////// 
      /// FINANCEIRO
      //////////////////////////////////////////////////////////

			case '/contasPagarLista':
			  return MaterialPageRoute(builder: (_) => const ContasPagarListaPage());

			case '/contasReceberLista':
			  return MaterialPageRoute(builder: (_) => const ContasReceberListaPage());

      ////////////////////////////////////////////////////////// 
      /// ESTOQUE
      //////////////////////////////////////////////////////////

			case '/estoqueLista':
			  return MaterialPageRoute(builder: (_) => const EstoqueListaPage());


      ////////////////////////////////////////////////////////// 
      /// TRIBUTAÇÃO
      //////////////////////////////////////////////////////////

			// TributConfiguraOfGt
			case '/tributConfiguraOfGtLista':
			  return MaterialPageRoute(builder: (_) => const TributConfiguraOfGtListaPage());
			case '/tributConfiguraOfGtPersiste':
			  return MaterialPageRoute(builder: (_) => const TributConfiguraOfGtPersistePage());
			
			// TributGrupoTributario
			case '/tributGrupoTributarioLista':
			  return MaterialPageRoute(builder: (_) => const TributGrupoTributarioListaPage());
			case '/tributGrupoTributarioPersiste':
			  return MaterialPageRoute(builder: (_) => const TributGrupoTributarioPersistePage());
			
			// TributOperacaoFiscal
			case '/tributOperacaoFiscalLista':
			  return MaterialPageRoute(builder: (_) => const TributOperacaoFiscalListaPage());
			case '/tributOperacaoFiscalPersiste':
			  return MaterialPageRoute(builder: (_) => const TributOperacaoFiscalPersistePage());


      ////////////////////////////////////////////////////////// 
      /// NFC-E
      //////////////////////////////////////////////////////////

			case '/nfceContingenciadas':
			  return MaterialPageRoute(builder: (_) => const NfeCabecalhoListaPage());

			case '/nfceInutilizaNumero':
			  return MaterialPageRoute(builder: (_) => const NfceInutilizaNumeroPage());

			case '/nfeDevolucao':
			  return MaterialPageRoute(builder: (_) => const NfeDevolucaoPage());

      ////////////////////////////////////////////////////////// 
      /// FOOD
      //////////////////////////////////////////////////////////

			case '/cozinhaLista':
			  return MaterialPageRoute(builder: (_) => const CozinhaListaPage());

			case '/mesaPage':
			  return MaterialPageRoute(builder: (_) => const MesaPage());

			case '/cardapioPage':
			  return MaterialPageRoute(builder: (_) => const CardapioPage());

			case '/reservaLista':
			  return MaterialPageRoute(builder: (_) => const ReservaListaPage());

			case '/comandaObservacaoPadraoLista':
			  return MaterialPageRoute(builder: (_) => const ComandaObservacaoPadraoListaPage());

			case '/deliveryLista':
			  return MaterialPageRoute(builder: (_) => const DeliveryListaPage());

      ////////////////////////////////////////////////////////// 
      /// DELIVERY
      //////////////////////////////////////////////////////////

			case '/taxaEntregaLista':
			  return MaterialPageRoute(builder: (_) => const TaxaEntregaListaPage());




      // Home
//      case '/home':
//        return MaterialPageRoute(builder: (_) => HomePage());
		
      // default
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
              body: Center(
            child: Text('Nenhuma rota definida para {$settings.name}'),
          )),
        );
    }
  }
}
