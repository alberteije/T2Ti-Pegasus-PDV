/*
Title: T2Ti ERP Fenix                                                                
Description: Define as rotas da aplicação
                                                                                
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
import 'package:flutter/material.dart';

import 'package:fenix/src/view/menu/home_page.dart';
// import 'package:fenix/src/view/login/login_page.dart';
import 'package:fenix/src/view/menu/menu_cadastros.dart';
import 'package:fenix/src/view/menu/menu_financeiro.dart';

import 'package:fenix/src/model/model.dart';
import 'package:fenix/src/view/page/page.dart';

class Rotas {
  static Route<dynamic> definirRotas(RouteSettings settings) {
    switch (settings.name) {
      
      // Login
      case '/':
        return MaterialPageRoute(builder: (_) => HomePage());//LoginPage());

      // Home
      case '/home':
        return MaterialPageRoute(builder: (_) => HomePage());

      // Menus
      case '/cadastrosMenu':
        return MaterialPageRoute(builder: (_) => MenuCadastros());
      case '/financeiroMenu':
        return MaterialPageRoute(builder: (_) => MenuFinanceiro());

      // Banco
      case '/bancoLista':
        return MaterialPageRoute(builder: (_) => BancoListaPage());
      case '/bancoDetalhe':
        var banco = settings.arguments as Banco;
        return MaterialPageRoute(
            builder: (_) => BancoDetalhePage(banco: banco));
      case '/bancoPersiste':
        return MaterialPageRoute(builder: (_) => BancoPersistePage());

      // BancoAgencia
      case '/bancoAgenciaLista':
        return MaterialPageRoute(builder: (_) => BancoAgenciaListaPage());
      case '/bancoAgenciaDetalhe':
        var bancoAgencia = settings.arguments as BancoAgencia;
        return MaterialPageRoute(
            builder: (_) =>
                BancoAgenciaDetalhePage(bancoAgencia: bancoAgencia));
      case '/bancoAgenciaPersiste':
        return MaterialPageRoute(builder: (_) => BancoAgenciaPersistePage());

      // Pessoa
      case '/pessoaLista':
        return MaterialPageRoute(builder: (_) => PessoaListaPage());
      case '/pessoaDetalhe':
        var pessoa = settings.arguments as Pessoa;
        return MaterialPageRoute(
            builder: (_) => PessoaDetalhePage(pessoa: pessoa));
      case '/pessoaPersiste':
        return MaterialPageRoute(builder: (_) => PessoaPersistePage());

      // Produto
      case '/produtoLista':
        return MaterialPageRoute(builder: (_) => ProdutoListaPage());
      case '/produtoDetalhe':
        var produto = settings.arguments as Produto;
        return MaterialPageRoute(
            builder: (_) => ProdutoDetalhePage(produto: produto));
      case '/produtoPersiste':
        return MaterialPageRoute(builder: (_) => ProdutoPersistePage());

			// BancoContaCaixa
			case '/bancoContaCaixaLista':
			  return MaterialPageRoute(builder: (_) => BancoContaCaixaListaPage());
			case '/bancoContaCaixaDetalhe':
			  var bancoContaCaixa = settings.arguments as BancoContaCaixa;
			  return MaterialPageRoute(
				  builder: (_) =>
					  BancoContaCaixaDetalhePage(bancoContaCaixa: bancoContaCaixa));
			case '/bancoContaCaixaPersiste':
			  return MaterialPageRoute(builder: (_) => BancoContaCaixaPersistePage());

			// Cargo
			case '/cargoLista':
			  return MaterialPageRoute(builder: (_) => CargoListaPage());
			case '/cargoDetalhe':
			  var cargo = settings.arguments as Cargo;
			  return MaterialPageRoute(
				  builder: (_) =>
					  CargoDetalhePage(cargo: cargo));
			case '/cargoPersiste':
			  return MaterialPageRoute(builder: (_) => CargoPersistePage());

			// Cep
			case '/cepLista':
			  return MaterialPageRoute(builder: (_) => CepListaPage());
			case '/cepDetalhe':
			  var cep = settings.arguments as Cep;
			  return MaterialPageRoute(
				  builder: (_) =>
					  CepDetalhePage(cep: cep));
			case '/cepPersiste':
			  return MaterialPageRoute(builder: (_) => CepPersistePage());

			// Cfop
			case '/cfopLista':
			  return MaterialPageRoute(builder: (_) => CfopListaPage());
			case '/cfopDetalhe':
			  var cfop = settings.arguments as Cfop;
			  return MaterialPageRoute(
				  builder: (_) =>
					  CfopDetalhePage(cfop: cfop));
			case '/cfopPersiste':
			  return MaterialPageRoute(builder: (_) => CfopPersistePage());

			// Cliente
			case '/clienteLista':
			  return MaterialPageRoute(builder: (_) => ClienteListaPage());
			case '/clienteDetalhe':
			  var cliente = settings.arguments as Cliente;
			  return MaterialPageRoute(
			      builder: (_) =>
			          ClienteDetalhePage(cliente: cliente));
			case '/clientePersiste':
			  return MaterialPageRoute(builder: (_) => ClientePersistePage());
			
			// Cnae
			case '/cnaeLista':
			  return MaterialPageRoute(builder: (_) => CnaeListaPage());
			case '/cnaeDetalhe':
			  var cnae = settings.arguments as Cnae;
			  return MaterialPageRoute(
			      builder: (_) =>
			          CnaeDetalhePage(cnae: cnae));
			case '/cnaePersiste':
			  return MaterialPageRoute(builder: (_) => CnaePersistePage());

			// Colaborador
			case '/colaboradorLista':
			  return MaterialPageRoute(builder: (_) => ColaboradorListaPage());
			case '/colaboradorDetalhe':
			  var colaborador = settings.arguments as Colaborador;
			  return MaterialPageRoute(
			      builder: (_) =>
			          ColaboradorDetalhePage(colaborador: colaborador));
			case '/colaboradorPersiste':
			  return MaterialPageRoute(builder: (_) => ColaboradorPersistePage());

			// Setor
			case '/setorLista':
			  return MaterialPageRoute(builder: (_) => SetorListaPage());
			case '/setorDetalhe':
			  var setor = settings.arguments as Setor;
			  return MaterialPageRoute(
			      builder: (_) =>
			          SetorDetalhePage(setor: setor));
			case '/setorPersiste':
			  return MaterialPageRoute(builder: (_) => SetorPersistePage());
			  
			// Contador
			case '/contadorLista':
			  return MaterialPageRoute(builder: (_) => ContadorListaPage());
			case '/contadorDetalhe':
			  var contador = settings.arguments as Contador;
			  return MaterialPageRoute(
			      builder: (_) =>
			          ContadorDetalhePage(contador: contador));
			case '/contadorPersiste':
			  return MaterialPageRoute(builder: (_) => ContadorPersistePage());
			
			// Csosn
			case '/csosnLista':
			  return MaterialPageRoute(builder: (_) => CsosnListaPage());
			case '/csosnDetalhe':
			  var csosn = settings.arguments as Csosn;
			  return MaterialPageRoute(
			      builder: (_) =>
			          CsosnDetalhePage(csosn: csosn));
			case '/csosnPersiste':
			  return MaterialPageRoute(builder: (_) => CsosnPersistePage());
			
			// CstCofins
			case '/cstCofinsLista':
			  return MaterialPageRoute(builder: (_) => CstCofinsListaPage());
			case '/cstCofinsDetalhe':
			  var cstCofins = settings.arguments as CstCofins;
			  return MaterialPageRoute(
			      builder: (_) =>
			          CstCofinsDetalhePage(cstCofins: cstCofins));
			case '/cstCofinsPersiste':
			  return MaterialPageRoute(builder: (_) => CstCofinsPersistePage());
			
			// CstIcms
			case '/cstIcmsLista':
			  return MaterialPageRoute(builder: (_) => CstIcmsListaPage());
			case '/cstIcmsDetalhe':
			  var cstIcms = settings.arguments as CstIcms;
			  return MaterialPageRoute(
			      builder: (_) =>
			          CstIcmsDetalhePage(cstIcms: cstIcms));
			case '/cstIcmsPersiste':
			  return MaterialPageRoute(builder: (_) => CstIcmsPersistePage());
			
			// CstIpi
			case '/cstIpiLista':
			  return MaterialPageRoute(builder: (_) => CstIpiListaPage());
			case '/cstIpiDetalhe':
			  var cstIpi = settings.arguments as CstIpi;
			  return MaterialPageRoute(
			      builder: (_) =>
			          CstIpiDetalhePage(cstIpi: cstIpi));
			case '/cstIpiPersiste':
			  return MaterialPageRoute(builder: (_) => CstIpiPersistePage());
			
			// CstPis
			case '/cstPisLista':
			  return MaterialPageRoute(builder: (_) => CstPisListaPage());
			case '/cstPisDetalhe':
			  var cstPis = settings.arguments as CstPis;
			  return MaterialPageRoute(
			      builder: (_) =>
			          CstPisDetalhePage(cstPis: cstPis));
			case '/cstPisPersiste':
			  return MaterialPageRoute(builder: (_) => CstPisPersistePage());

			// EstadoCivil
			case '/estadoCivilLista':
			  return MaterialPageRoute(builder: (_) => EstadoCivilListaPage());
			case '/estadoCivilDetalhe':
			  var estadoCivil = settings.arguments as EstadoCivil;
			  return MaterialPageRoute(
			      builder: (_) =>
			          EstadoCivilDetalhePage(estadoCivil: estadoCivil));
			case '/estadoCivilPersiste':
			  return MaterialPageRoute(builder: (_) => EstadoCivilPersistePage());
			
			// Fornecedor
			case '/fornecedorLista':
			  return MaterialPageRoute(builder: (_) => FornecedorListaPage());
			case '/fornecedorDetalhe':
			  var fornecedor = settings.arguments as Fornecedor;
			  return MaterialPageRoute(
			      builder: (_) =>
			          FornecedorDetalhePage(fornecedor: fornecedor));
			case '/fornecedorPersiste':
			  return MaterialPageRoute(builder: (_) => FornecedorPersistePage());
			
			// Municipio
			case '/municipioLista':
			  return MaterialPageRoute(builder: (_) => MunicipioListaPage());
			case '/municipioDetalhe':
			  var municipio = settings.arguments as Municipio;
			  return MaterialPageRoute(
			      builder: (_) =>
			          MunicipioDetalhePage(municipio: municipio));
			case '/municipioPersiste':
			  return MaterialPageRoute(builder: (_) => MunicipioPersistePage());
			
			// Ncm
			case '/ncmLista':
			  return MaterialPageRoute(builder: (_) => NcmListaPage());
			case '/ncmDetalhe':
			  var ncm = settings.arguments as Ncm;
			  return MaterialPageRoute(
			      builder: (_) =>
			          NcmDetalhePage(ncm: ncm));
			case '/ncmPersiste':
			  return MaterialPageRoute(builder: (_) => NcmPersistePage());
			
			// NivelFormacao
			case '/nivelFormacaoLista':
			  return MaterialPageRoute(builder: (_) => NivelFormacaoListaPage());
			case '/nivelFormacaoDetalhe':
			  var nivelFormacao = settings.arguments as NivelFormacao;
			  return MaterialPageRoute(
			      builder: (_) =>
			          NivelFormacaoDetalhePage(nivelFormacao: nivelFormacao));
			case '/nivelFormacaoPersiste':
			  return MaterialPageRoute(builder: (_) => NivelFormacaoPersistePage());
						
			// Transportadora
			case '/transportadoraLista':
			  return MaterialPageRoute(builder: (_) => TransportadoraListaPage());
			case '/transportadoraDetalhe':
			  var transportadora = settings.arguments as Transportadora;
			  return MaterialPageRoute(
			      builder: (_) =>
			          TransportadoraDetalhePage(transportadora: transportadora));
			case '/transportadoraPersiste':
			  return MaterialPageRoute(builder: (_) => TransportadoraPersistePage());
			
			// Uf
			case '/ufLista':
			  return MaterialPageRoute(builder: (_) => UfListaPage());
			case '/ufDetalhe':
			  var uf = settings.arguments as Uf;
			  return MaterialPageRoute(
			      builder: (_) =>
			          UfDetalhePage(uf: uf));
			case '/ufPersiste':
			  return MaterialPageRoute(builder: (_) => UfPersistePage());
						
			// Vendedor
			case '/vendedorLista':
			  return MaterialPageRoute(builder: (_) => VendedorListaPage());
			case '/vendedorDetalhe':
			  var vendedor = settings.arguments as Vendedor;
			  return MaterialPageRoute(
			      builder: (_) =>
			          VendedorDetalhePage(vendedor: vendedor));
			case '/vendedorPersiste':
			  return MaterialPageRoute(builder: (_) => VendedorPersistePage());

			// ProdutoGrupo
			case '/produtoGrupoLista':
			  return MaterialPageRoute(builder: (_) => ProdutoGrupoListaPage());
			case '/produtoGrupoDetalhe':
			  var produtoGrupo = settings.arguments as ProdutoGrupo;
			  return MaterialPageRoute(
			      builder: (_) =>
			          ProdutoGrupoDetalhePage(produtoGrupo: produtoGrupo));
			case '/produtoGrupoPersiste':
			  return MaterialPageRoute(builder: (_) => ProdutoGrupoPersistePage());
			
			// ProdutoMarca
			case '/produtoMarcaLista':
			  return MaterialPageRoute(builder: (_) => ProdutoMarcaListaPage());
			case '/produtoMarcaDetalhe':
			  var produtoMarca = settings.arguments as ProdutoMarca;
			  return MaterialPageRoute(
			      builder: (_) =>
			          ProdutoMarcaDetalhePage(produtoMarca: produtoMarca));
			case '/produtoMarcaPersiste':
			  return MaterialPageRoute(builder: (_) => ProdutoMarcaPersistePage());
			
			// ProdutoSubgrupo
			case '/produtoSubgrupoLista':
			  return MaterialPageRoute(builder: (_) => ProdutoSubgrupoListaPage());
			case '/produtoSubgrupoDetalhe':
			  var produtoSubgrupo = settings.arguments as ProdutoSubgrupo;
			  return MaterialPageRoute(
			      builder: (_) =>
			          ProdutoSubgrupoDetalhePage(produtoSubgrupo: produtoSubgrupo));
			case '/produtoSubgrupoPersiste':
			  return MaterialPageRoute(builder: (_) => ProdutoSubgrupoPersistePage());
			
			// ProdutoUnidade
			case '/produtoUnidadeLista':
			  return MaterialPageRoute(builder: (_) => ProdutoUnidadeListaPage());
			case '/produtoUnidadeDetalhe':
			  var produtoUnidade = settings.arguments as ProdutoUnidade;
			  return MaterialPageRoute(
			      builder: (_) =>
			          ProdutoUnidadeDetalhePage(produtoUnidade: produtoUnidade));
			case '/produtoUnidadePersiste':
			  return MaterialPageRoute(builder: (_) => ProdutoUnidadePersistePage());

			// FinChequeEmitido
			case '/finChequeEmitidoLista':
			  return MaterialPageRoute(builder: (_) => FinChequeEmitidoListaPage());
			case '/finChequeEmitidoDetalhe':
			  var finChequeEmitido = settings.arguments as FinChequeEmitido;
			  return MaterialPageRoute(
			      builder: (_) =>
			          FinChequeEmitidoDetalhePage(finChequeEmitido: finChequeEmitido));
			case '/finChequeEmitidoPersiste':
			  return MaterialPageRoute(builder: (_) => FinChequeEmitidoPersistePage());
			
			// FinChequeRecebido
			case '/finChequeRecebidoLista':
			  return MaterialPageRoute(builder: (_) => FinChequeRecebidoListaPage());
			case '/finChequeRecebidoDetalhe':
			  var finChequeRecebido = settings.arguments as FinChequeRecebido;
			  return MaterialPageRoute(
			      builder: (_) =>
			          FinChequeRecebidoDetalhePage(finChequeRecebido: finChequeRecebido));
			case '/finChequeRecebidoPersiste':
			  return MaterialPageRoute(builder: (_) => FinChequeRecebidoPersistePage());
			
			// FinConfiguracaoBoleto
			case '/finConfiguracaoBoletoLista':
			  return MaterialPageRoute(builder: (_) => FinConfiguracaoBoletoListaPage());
			case '/finConfiguracaoBoletoDetalhe':
			  var finConfiguracaoBoleto = settings.arguments as FinConfiguracaoBoleto;
			  return MaterialPageRoute(
			      builder: (_) =>
			          FinConfiguracaoBoletoDetalhePage(finConfiguracaoBoleto: finConfiguracaoBoleto));
			case '/finConfiguracaoBoletoPersiste':
			  return MaterialPageRoute(builder: (_) => FinConfiguracaoBoletoPersistePage());
			
			// FinDocumentoOrigem
			case '/finDocumentoOrigemLista':
			  return MaterialPageRoute(builder: (_) => FinDocumentoOrigemListaPage());
			case '/finDocumentoOrigemDetalhe':
			  var finDocumentoOrigem = settings.arguments as FinDocumentoOrigem;
			  return MaterialPageRoute(
			      builder: (_) =>
			          FinDocumentoOrigemDetalhePage(finDocumentoOrigem: finDocumentoOrigem));
			case '/finDocumentoOrigemPersiste':
			  return MaterialPageRoute(builder: (_) => FinDocumentoOrigemPersistePage());
			
			// FinExtratoContaBanco
			case '/finExtratoContaBancoLista':
			  return MaterialPageRoute(builder: (_) => FinExtratoContaBancoListaPage());
			case '/finExtratoContaBancoDetalhe':
			  var finExtratoContaBanco = settings.arguments as FinExtratoContaBanco;
			  return MaterialPageRoute(
			      builder: (_) =>
			          FinExtratoContaBancoDetalhePage(finExtratoContaBanco: finExtratoContaBanco));
			case '/finExtratoContaBancoPersiste':
			  return MaterialPageRoute(builder: (_) => FinExtratoContaBancoPersistePage());
			
			// FinFechamentoCaixaBanco
			case '/finFechamentoCaixaBancoLista':
			  return MaterialPageRoute(builder: (_) => FinFechamentoCaixaBancoListaPage());
			case '/finFechamentoCaixaBancoDetalhe':
			  var finFechamentoCaixaBanco = settings.arguments as FinFechamentoCaixaBanco;
			  return MaterialPageRoute(
			      builder: (_) =>
			          FinFechamentoCaixaBancoDetalhePage(finFechamentoCaixaBanco: finFechamentoCaixaBanco));
			case '/finFechamentoCaixaBancoPersiste':
			  return MaterialPageRoute(builder: (_) => FinFechamentoCaixaBancoPersistePage());
			
			// FinLancamentoPagar
			case '/finLancamentoPagarLista':
			  return MaterialPageRoute(builder: (_) => FinLancamentoPagarListaPage());
			case '/finLancamentoPagarDetalhe':
			  var finLancamentoPagar = settings.arguments as FinLancamentoPagar;
			  return MaterialPageRoute(
			      builder: (_) =>
			          FinLancamentoPagarDetalhePage(finLancamentoPagar: finLancamentoPagar));
			case '/finLancamentoPagarPersiste':
			  return MaterialPageRoute(builder: (_) => FinLancamentoPagarPersistePage());
			
			// FinLancamentoReceber
			case '/finLancamentoReceberLista':
			  return MaterialPageRoute(builder: (_) => FinLancamentoReceberListaPage());
			case '/finLancamentoReceberDetalhe':
			  var finLancamentoReceber = settings.arguments as FinLancamentoReceber;
			  return MaterialPageRoute(
			      builder: (_) =>
			          FinLancamentoReceberDetalhePage(finLancamentoReceber: finLancamentoReceber));
			case '/finLancamentoReceberPersiste':
			  return MaterialPageRoute(builder: (_) => FinLancamentoReceberPersistePage());
			
			// FinNaturezaFinanceira
			case '/finNaturezaFinanceiraLista':
			  return MaterialPageRoute(builder: (_) => FinNaturezaFinanceiraListaPage());
			case '/finNaturezaFinanceiraDetalhe':
			  var finNaturezaFinanceira = settings.arguments as FinNaturezaFinanceira;
			  return MaterialPageRoute(
			      builder: (_) =>
			          FinNaturezaFinanceiraDetalhePage(finNaturezaFinanceira: finNaturezaFinanceira));
			case '/finNaturezaFinanceiraPersiste':
			  return MaterialPageRoute(builder: (_) => FinNaturezaFinanceiraPersistePage());

			// FinStatusParcela
			case '/finStatusParcelaLista':
			  return MaterialPageRoute(builder: (_) => FinStatusParcelaListaPage());
			case '/finStatusParcelaDetalhe':
			  var finStatusParcela = settings.arguments as FinStatusParcela;
			  return MaterialPageRoute(
			      builder: (_) =>
			          FinStatusParcelaDetalhePage(finStatusParcela: finStatusParcela));
			case '/finStatusParcelaPersiste':
			  return MaterialPageRoute(builder: (_) => FinStatusParcelaPersistePage());
			
			// FinTipoPagamento
			case '/finTipoPagamentoLista':
			  return MaterialPageRoute(builder: (_) => FinTipoPagamentoListaPage());
			case '/finTipoPagamentoDetalhe':
			  var finTipoPagamento = settings.arguments as FinTipoPagamento;
			  return MaterialPageRoute(
			      builder: (_) =>
			          FinTipoPagamentoDetalhePage(finTipoPagamento: finTipoPagamento));
			case '/finTipoPagamentoPersiste':
			  return MaterialPageRoute(builder: (_) => FinTipoPagamentoPersistePage());
			
			// FinTipoRecebimento
			case '/finTipoRecebimentoLista':
			  return MaterialPageRoute(builder: (_) => FinTipoRecebimentoListaPage());
			case '/finTipoRecebimentoDetalhe':
			  var finTipoRecebimento = settings.arguments as FinTipoRecebimento;
			  return MaterialPageRoute(
			      builder: (_) =>
			          FinTipoRecebimentoDetalhePage(finTipoRecebimento: finTipoRecebimento));
			case '/finTipoRecebimentoPersiste':
			  return MaterialPageRoute(builder: (_) => FinTipoRecebimentoPersistePage());

			// TalonarioCheque
			case '/talonarioChequeLista':
			  return MaterialPageRoute(builder: (_) => TalonarioChequeListaPage());
			case '/talonarioChequeDetalhe':
			  var talonarioCheque = settings.arguments as TalonarioCheque;
			  return MaterialPageRoute(
			      builder: (_) =>
			          TalonarioChequeDetalhePage(talonarioCheque: talonarioCheque));
			case '/talonarioChequePersiste':
			  return MaterialPageRoute(builder: (_) => TalonarioChequePersistePage());
			  
			  









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
