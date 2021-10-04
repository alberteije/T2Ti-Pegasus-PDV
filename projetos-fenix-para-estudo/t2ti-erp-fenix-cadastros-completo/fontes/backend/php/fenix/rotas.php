<?php

// banco
$app->get('/banco[/]', \BancoController::class . ':consultarLista');
$app->get('/banco/{id}', \BancoController::class . ':consultarObjeto');
$app->post('/banco', \BancoController::class . ':inserir');
$app->put('/banco/{id}', \BancoController::class . ':alterar');
$app->delete('/banco/{id}', \BancoController::class . ':excluir');
// Allow preflight requests
// you must add the OPTIONS method. Read about preflight.
$app->options('/banco[/{id}]', \ControllerBase::class . ':browserOptionsRetornarResponse');

// banco-agencia
$app->get('/banco-agencia[/]', \BancoAgenciaController::class . ':consultarLista');
$app->get('/banco-agencia/{id}', \BancoAgenciaController::class . ':consultarObjeto');
$app->post('/banco-agencia', \BancoAgenciaController::class . ':inserir');
$app->put('/banco-agencia/{id}', \BancoAgenciaController::class . ':alterar');
$app->delete('/banco-agencia/{id}', \BancoAgenciaController::class . ':excluir');
$app->options('/banco-agencia[/{id}]', \ControllerBase::class . ':browserOptionsRetornarResponse');

// pessoa
$app->get('/pessoa[/]', \PessoaController::class . ':consultarLista');
$app->get('/pessoa/{id}', \PessoaController::class . ':consultarObjeto');
$app->post('/pessoa', \PessoaController::class . ':inserir');
$app->put('/pessoa/{id}', \PessoaController::class . ':alterar');
$app->delete('/pessoa/{id}', \PessoaController::class . ':excluir');
$app->options('/pessoa[/{id}]', \ControllerBase::class . ':browserOptionsRetornarResponse');

// produto
$app->get('/produto[/]', \ProdutoController::class . ':consultarLista');
$app->get('/produto/{id}', \ProdutoController::class . ':consultarObjeto');
$app->post('/produto', \ProdutoController::class . ':inserir');
$app->put('/produto/{id}', \ProdutoController::class . ':alterar');
$app->delete('/produto/{id}', \ProdutoController::class . ':excluir');
$app->options('/produto[/{id}]', \ControllerBase::class . ':browserOptionsRetornarResponse');

// produto-marca
$app->get('/produto-marca[/]', \ProdutoMarcaController::class . ':consultarLista');
$app->get('/produto-marca/{id}', \ProdutoMarcaController::class . ':consultarObjeto');
$app->post('/produto-marca', \ProdutoMarcaController::class . ':inserir');
$app->put('/produto-marca/{id}', \ProdutoMarcaController::class . ':alterar');
$app->delete('/produto-marca/{id}', \ProdutoMarcaController::class . ':excluir');
$app->options('/produto-marca[/{id}]', \ControllerBase::class . ':browserOptionsRetornarResponse');

// produto-unidade
$app->get('/produto-unidade[/]', \ProdutoUnidadeController::class . ':consultarLista');
$app->get('/produto-unidade/{id}', \ProdutoUnidadeController::class . ':consultarObjeto');
$app->post('/produto-unidade', \ProdutoUnidadeController::class . ':inserir');
$app->put('/produto-unidade/{id}', \ProdutoUnidadeController::class . ':alterar');
$app->delete('/produto-unidade/{id}', \ProdutoUnidadeController::class . ':excluir');
$app->options('/produto-unidade[/{id}]', \ControllerBase::class . ':browserOptionsRetornarResponse');

// produto-grupo
$app->get('/produto-grupo[/]', \ProdutoGrupoController::class . ':consultarLista');
$app->get('/produto-grupo/{id}', \ProdutoGrupoController::class . ':consultarObjeto');
$app->post('/produto-grupo', \ProdutoGrupoController::class . ':inserir');
$app->put('/produto-grupo/{id}', \ProdutoGrupoController::class . ':alterar');
$app->delete('/produto-grupo/{id}', \ProdutoGrupoController::class . ':excluir');
$app->options('/produto-grupo[/{id}]', \ControllerBase::class . ':browserOptionsRetornarResponse');

// produto-subgrupo
$app->get('/produto-subgrupo[/]', \ProdutoSubgrupoController::class . ':consultarLista');
$app->get('/produto-subgrupo/{id}', \ProdutoSubgrupoController::class . ':consultarObjeto');
$app->post('/produto-subgrupo', \ProdutoSubgrupoController::class . ':inserir');
$app->put('/produto-subgrupo/{id}', \ProdutoSubgrupoController::class . ':alterar');
$app->delete('/produto-subgrupo/{id}', \ProdutoSubgrupoController::class . ':excluir');
$app->options('/produto-subgrupo[/{id}]', \ControllerBase::class . ':browserOptionsRetornarResponse');

// nivel-formacao
$app->get('/nivel-formacao[/]', \NivelFormacaoController::class . ':consultarLista');
$app->get('/nivel-formacao/{id}', \NivelFormacaoController::class . ':consultarObjeto');
$app->post('/nivel-formacao', \NivelFormacaoController::class . ':inserir');
$app->put('/nivel-formacao/{id}', \NivelFormacaoController::class . ':alterar');
$app->delete('/nivel-formacao/{id}', \NivelFormacaoController::class . ':excluir');
$app->options('/nivel-formacao[/{id}]', \ControllerBase::class . ':browserOptionsRetornarResponse');

// estado-civil
$app->get('/estado-civil[/]', \EstadoCivilController::class . ':consultarLista');
$app->get('/estado-civil/{id}', \EstadoCivilController::class . ':consultarObjeto');
$app->post('/estado-civil', \EstadoCivilController::class . ':inserir');
$app->put('/estado-civil/{id}', \EstadoCivilController::class . ':alterar');
$app->delete('/estado-civil/{id}', \EstadoCivilController::class . ':excluir');
$app->options('/estado-civil[/{id}]', \ControllerBase::class . ':browserOptionsRetornarResponse');

// banco-conta-caixa
$app->get('/banco-conta-caixa[/]', \BancoContaCaixaController::class . ':consultarLista');
$app->get('/banco-conta-caixa/{id}', \BancoContaCaixaController::class . ':consultarObjeto');
$app->post('/banco-conta-caixa', \BancoContaCaixaController::class . ':inserir');
$app->put('/banco-conta-caixa/{id}', \BancoContaCaixaController::class . ':alterar');
$app->delete('/banco-conta-caixa/{id}', \BancoContaCaixaController::class . ':excluir');
$app->options('/banco-conta-caixa[/{id}]', \ControllerBase::class . ':browserOptionsRetornarResponse');

// cargo
$app->get('/cargo[/]', \CargoController::class . ':consultarLista');
$app->get('/cargo/{id}', \CargoController::class . ':consultarObjeto');
$app->post('/cargo', \CargoController::class . ':inserir');
$app->put('/cargo/{id}', \CargoController::class . ':alterar');
$app->delete('/cargo/{id}', \CargoController::class . ':excluir');
$app->options('/cargo[/{id}]', \ControllerBase::class . ':browserOptionsRetornarResponse');

// cep
$app->get('/cep[/]', \CepController::class . ':consultarLista');
$app->get('/cep/{id}', \CepController::class . ':consultarObjeto');
$app->post('/cep', \CepController::class . ':inserir');
$app->put('/cep/{id}', \CepController::class . ':alterar');
$app->delete('/cep/{id}', \CepController::class . ':excluir');
$app->options('/cep[/{id}]', \ControllerBase::class . ':browserOptionsRetornarResponse');

// cfop
$app->get('/cfop[/]', \CfopController::class . ':consultarLista');
$app->get('/cfop/{id}', \CfopController::class . ':consultarObjeto');
$app->post('/cfop', \CfopController::class . ':inserir');
$app->put('/cfop/{id}', \CfopController::class . ':alterar');
$app->delete('/cfop/{id}', \CfopController::class . ':excluir');
$app->options('/cfop[/{id}]', \ControllerBase::class . ':browserOptionsRetornarResponse');

// cliente
$app->get('/cliente[/]', \ClienteController::class . ':consultarLista');
$app->get('/cliente/{id}', \ClienteController::class . ':consultarObjeto');
$app->post('/cliente', \ClienteController::class . ':inserir');
$app->put('/cliente/{id}', \ClienteController::class . ':alterar');
$app->delete('/cliente/{id}', \ClienteController::class . ':excluir');
$app->options('/cliente[/{id}]', \ControllerBase::class . ':browserOptionsRetornarResponse');

// cnae
$app->get('/cnae[/]', \CnaeController::class . ':consultarLista');
$app->get('/cnae/{id}', \CnaeController::class . ':consultarObjeto');
$app->post('/cnae', \CnaeController::class . ':inserir');
$app->put('/cnae/{id}', \CnaeController::class . ':alterar');
$app->delete('/cnae/{id}', \CnaeController::class . ':excluir');
$app->options('/cnae[/{id}]', \ControllerBase::class . ':browserOptionsRetornarResponse');

// colaborador
$app->get('/colaborador[/]', \ColaboradorController::class . ':consultarLista');
$app->get('/colaborador/{id}', \ColaboradorController::class . ':consultarObjeto');
$app->post('/colaborador', \ColaboradorController::class . ':inserir');
$app->put('/colaborador/{id}', \ColaboradorController::class . ':alterar');
$app->delete('/colaborador/{id}', \ColaboradorController::class . ':excluir');
$app->options('/colaborador[/{id}]', \ControllerBase::class . ':browserOptionsRetornarResponse');

// contador
$app->get('/contador[/]', \ContadorController::class . ':consultarLista');
$app->get('/contador/{id}', \ContadorController::class . ':consultarObjeto');
$app->post('/contador', \ContadorController::class . ':inserir');
$app->put('/contador/{id}', \ContadorController::class . ':alterar');
$app->delete('/contador/{id}', \ContadorController::class . ':excluir');
$app->options('/contador[/{id}]', \ControllerBase::class . ':browserOptionsRetornarResponse');

// csosn
$app->get('/csosn[/]', \CsosnController::class . ':consultarLista');
$app->get('/csosn/{id}', \CsosnController::class . ':consultarObjeto');
$app->post('/csosn', \CsosnController::class . ':inserir');
$app->put('/csosn/{id}', \CsosnController::class . ':alterar');
$app->delete('/csosn/{id}', \CsosnController::class . ':excluir');
$app->options('/csosn[/{id}]', \ControllerBase::class . ':browserOptionsRetornarResponse');

// cst-cofins
$app->get('/cst-cofins[/]', \CstCofinsController::class . ':consultarLista');
$app->get('/cst-cofins/{id}', \CstCofinsController::class . ':consultarObjeto');
$app->post('/cst-cofins', \CstCofinsController::class . ':inserir');
$app->put('/cst-cofins/{id}', \CstCofinsController::class . ':alterar');
$app->delete('/cst-cofins/{id}', \CstCofinsController::class . ':excluir');
$app->options('/cst-cofins[/{id}]', \ControllerBase::class . ':browserOptionsRetornarResponse');

// cst-icms
$app->get('/cst-icms[/]', \CstIcmsController::class . ':consultarLista');
$app->get('/cst-icms/{id}', \CstIcmsController::class . ':consultarObjeto');
$app->post('/cst-icms', \CstIcmsController::class . ':inserir');
$app->put('/cst-icms/{id}', \CstIcmsController::class . ':alterar');
$app->delete('/cst-icms/{id}', \CstIcmsController::class . ':excluir');
$app->options('/cst-icms[/{id}]', \ControllerBase::class . ':browserOptionsRetornarResponse');

// cst-ipi
$app->get('/cst-ipi[/]', \CstIpiController::class . ':consultarLista');
$app->get('/cst-ipi/{id}', \CstIpiController::class . ':consultarObjeto');
$app->post('/cst-ipi', \CstIpiController::class . ':inserir');
$app->put('/cst-ipi/{id}', \CstIpiController::class . ':alterar');
$app->delete('/cst-ipi/{id}', \CstIpiController::class . ':excluir');
$app->options('/cst-ipi[/{id}]', \ControllerBase::class . ':browserOptionsRetornarResponse');

// cst-pis
$app->get('/cst-pis[/]', \CstPisController::class . ':consultarLista');
$app->get('/cst-pis/{id}', \CstPisController::class . ':consultarObjeto');
$app->post('/cst-pis', \CstPisController::class . ':inserir');
$app->put('/cst-pis/{id}', \CstPisController::class . ':alterar');
$app->delete('/cst-pis/{id}', \CstPisController::class . ':excluir');
$app->options('/cst-pis[/{id}]', \ControllerBase::class . ':browserOptionsRetornarResponse');

// fornecedor
$app->get('/fornecedor[/]', \FornecedorController::class . ':consultarLista');
$app->get('/fornecedor/{id}', \FornecedorController::class . ':consultarObjeto');
$app->post('/fornecedor', \FornecedorController::class . ':inserir');
$app->put('/fornecedor/{id}', \FornecedorController::class . ':alterar');
$app->delete('/fornecedor/{id}', \FornecedorController::class . ':excluir');
$app->options('/fornecedor[/{id}]', \ControllerBase::class . ':browserOptionsRetornarResponse');

// municipio
$app->get('/municipio[/]', \MunicipioController::class . ':consultarLista');
$app->get('/municipio/{id}', \MunicipioController::class . ':consultarObjeto');
$app->post('/municipio', \MunicipioController::class . ':inserir');
$app->put('/municipio/{id}', \MunicipioController::class . ':alterar');
$app->delete('/municipio/{id}', \MunicipioController::class . ':excluir');
$app->options('/municipio[/{id}]', \ControllerBase::class . ':browserOptionsRetornarResponse');

// ncm
$app->get('/ncm[/]', \NcmController::class . ':consultarLista');
$app->get('/ncm/{id}', \NcmController::class . ':consultarObjeto');
$app->post('/ncm', \NcmController::class . ':inserir');
$app->put('/ncm/{id}', \NcmController::class . ':alterar');
$app->delete('/ncm/{id}', \NcmController::class . ':excluir');
$app->options('/ncm[/{id}]', \ControllerBase::class . ':browserOptionsRetornarResponse');

// papel
$app->get('/papel[/]', \PapelController::class . ':consultarLista');
$app->get('/papel/{id}', \PapelController::class . ':consultarObjeto');
$app->post('/papel', \PapelController::class . ':inserir');
$app->put('/papel/{id}', \PapelController::class . ':alterar');
$app->delete('/papel/{id}', \PapelController::class . ':excluir');
$app->options('/papel[/{id}]', \ControllerBase::class . ':browserOptionsRetornarResponse');

// setor
$app->get('/setor[/]', \SetorController::class . ':consultarLista');
$app->get('/setor/{id}', \SetorController::class . ':consultarObjeto');
$app->post('/setor', \SetorController::class . ':inserir');
$app->put('/setor/{id}', \SetorController::class . ':alterar');
$app->delete('/setor/{id}', \SetorController::class . ':excluir');
$app->options('/setor[/{id}]', \ControllerBase::class . ':browserOptionsRetornarResponse');

// transportadora
$app->get('/transportadora[/]', \TransportadoraController::class . ':consultarLista');
$app->get('/transportadora/{id}', \TransportadoraController::class . ':consultarObjeto');
$app->post('/transportadora', \TransportadoraController::class . ':inserir');
$app->put('/transportadora/{id}', \TransportadoraController::class . ':alterar');
$app->delete('/transportadora/{id}', \TransportadoraController::class . ':excluir');
$app->options('/transportadora[/{id}]', \ControllerBase::class . ':browserOptionsRetornarResponse');

// uf
$app->get('/uf[/]', \UfController::class . ':consultarLista');
$app->get('/uf/{id}', \UfController::class . ':consultarObjeto');
$app->post('/uf', \UfController::class . ':inserir');
$app->put('/uf/{id}', \UfController::class . ':alterar');
$app->delete('/uf/{id}', \UfController::class . ':excluir');
$app->options('/uf[/{id}]', \ControllerBase::class . ':browserOptionsRetornarResponse');

// usuario
$app->get('/usuario[/]', \UsuarioController::class . ':consultarLista');
$app->get('/usuario/{id}', \UsuarioController::class . ':consultarObjeto');
$app->post('/usuario', \UsuarioController::class . ':inserir');
$app->put('/usuario/{id}', \UsuarioController::class . ':alterar');
$app->delete('/usuario/{id}', \UsuarioController::class . ':excluir');
$app->options('/usuario[/{id}]', \ControllerBase::class . ':browserOptionsRetornarResponse');

// vendedor
$app->get('/vendedor[/]', \VendedorController::class . ':consultarLista');
$app->get('/vendedor/{id}', \VendedorController::class . ':consultarObjeto');
$app->post('/vendedor', \VendedorController::class . ':inserir');
$app->put('/vendedor/{id}', \VendedorController::class . ':alterar');
$app->delete('/vendedor/{id}', \VendedorController::class . ':excluir');
$app->options('/vendedor[/{id}]', \ControllerBase::class . ':browserOptionsRetornarResponse');

// fin-cheque-emitido
$app->get('/fin-cheque-emitido[/]', \FinChequeEmitidoController::class . ':consultarLista');
$app->get('/fin-cheque-emitido/{id}', \FinChequeEmitidoController::class . ':consultarObjeto');
$app->post('/fin-cheque-emitido', \FinChequeEmitidoController::class . ':inserir');
$app->put('/fin-cheque-emitido/{id}', \FinChequeEmitidoController::class . ':alterar');
$app->delete('/fin-cheque-emitido/{id}', \FinChequeEmitidoController::class . ':excluir');
$app->options('/fin-cheque-emitido[/{id}]', \ControllerBase::class . ':browserOptionsRetornarResponse');

// fin-cheque-recebido
$app->get('/fin-cheque-recebido[/]', \FinChequeRecebidoController::class . ':consultarLista');
$app->get('/fin-cheque-recebido/{id}', \FinChequeRecebidoController::class . ':consultarObjeto');
$app->post('/fin-cheque-recebido', \FinChequeRecebidoController::class . ':inserir');
$app->put('/fin-cheque-recebido/{id}', \FinChequeRecebidoController::class . ':alterar');
$app->delete('/fin-cheque-recebido/{id}', \FinChequeRecebidoController::class . ':excluir');
$app->options('/fin-cheque-recebido[/{id}]', \ControllerBase::class . ':browserOptionsRetornarResponse');

// fin-configuracao-boleto
$app->get('/fin-configuracao-boleto[/]', \FinConfiguracaoBoletoController::class . ':consultarLista');
$app->get('/fin-configuracao-boleto/{id}', \FinConfiguracaoBoletoController::class . ':consultarObjeto');
$app->post('/fin-configuracao-boleto', \FinConfiguracaoBoletoController::class . ':inserir');
$app->put('/fin-configuracao-boleto/{id}', \FinConfiguracaoBoletoController::class . ':alterar');
$app->delete('/fin-configuracao-boleto/{id}', \FinConfiguracaoBoletoController::class . ':excluir');
$app->options('/fin-configuracao-boleto[/{id}]', \ControllerBase::class . ':browserOptionsRetornarResponse');

// fin-documento-origem
$app->get('/fin-documento-origem[/]', \FinDocumentoOrigemController::class . ':consultarLista');
$app->get('/fin-documento-origem/{id}', \FinDocumentoOrigemController::class . ':consultarObjeto');
$app->post('/fin-documento-origem', \FinDocumentoOrigemController::class . ':inserir');
$app->put('/fin-documento-origem/{id}', \FinDocumentoOrigemController::class . ':alterar');
$app->delete('/fin-documento-origem/{id}', \FinDocumentoOrigemController::class . ':excluir');
$app->options('/fin-documento-origem[/{id}]', \ControllerBase::class . ':browserOptionsRetornarResponse');

// fin-extrato-conta-banco
$app->get('/fin-extrato-conta-banco[/]', \FinExtratoContaBancoController::class . ':consultarLista');
$app->get('/fin-extrato-conta-banco/{id}', \FinExtratoContaBancoController::class . ':consultarObjeto');
$app->post('/fin-extrato-conta-banco', \FinExtratoContaBancoController::class . ':inserir');
$app->put('/fin-extrato-conta-banco/{id}', \FinExtratoContaBancoController::class . ':alterar');
$app->delete('/fin-extrato-conta-banco/{id}', \FinExtratoContaBancoController::class . ':excluir');
$app->options('/fin-extrato-conta-banco[/{id}]', \ControllerBase::class . ':browserOptionsRetornarResponse');

// fin-fechamento-caixa-banco
$app->get('/fin-fechamento-caixa-banco[/]', \FinFechamentoCaixaBancoController::class . ':consultarLista');
$app->get('/fin-fechamento-caixa-banco/{id}', \FinFechamentoCaixaBancoController::class . ':consultarObjeto');
$app->post('/fin-fechamento-caixa-banco', \FinFechamentoCaixaBancoController::class . ':inserir');
$app->put('/fin-fechamento-caixa-banco/{id}', \FinFechamentoCaixaBancoController::class . ':alterar');
$app->delete('/fin-fechamento-caixa-banco/{id}', \FinFechamentoCaixaBancoController::class . ':excluir');
$app->options('/fin-fechamento-caixa-banco[/{id}]', \ControllerBase::class . ':browserOptionsRetornarResponse');

// fin-lancamento-pagar
$app->get('/fin-lancamento-pagar[/]', \FinLancamentoPagarController::class . ':consultarLista');
$app->get('/fin-lancamento-pagar/{id}', \FinLancamentoPagarController::class . ':consultarObjeto');
$app->post('/fin-lancamento-pagar', \FinLancamentoPagarController::class . ':inserir');
$app->put('/fin-lancamento-pagar/{id}', \FinLancamentoPagarController::class . ':alterar');
$app->delete('/fin-lancamento-pagar/{id}', \FinLancamentoPagarController::class . ':excluir');
$app->options('/fin-lancamento-pagar[/{id}]', \ControllerBase::class . ':browserOptionsRetornarResponse');

// fin-lancamento-receber
$app->get('/fin-lancamento-receber[/]', \FinLancamentoReceberController::class . ':consultarLista');
$app->get('/fin-lancamento-receber/{id}', \FinLancamentoReceberController::class . ':consultarObjeto');
$app->post('/fin-lancamento-receber', \FinLancamentoReceberController::class . ':inserir');
$app->put('/fin-lancamento-receber/{id}', \FinLancamentoReceberController::class . ':alterar');
$app->delete('/fin-lancamento-receber/{id}', \FinLancamentoReceberController::class . ':excluir');
$app->options('/fin-lancamento-receber[/{id}]', \ControllerBase::class . ':browserOptionsRetornarResponse');

// fin-natureza-financeira
$app->get('/fin-natureza-financeira[/]', \FinNaturezaFinanceiraController::class . ':consultarLista');
$app->get('/fin-natureza-financeira/{id}', \FinNaturezaFinanceiraController::class . ':consultarObjeto');
$app->post('/fin-natureza-financeira', \FinNaturezaFinanceiraController::class . ':inserir');
$app->put('/fin-natureza-financeira/{id}', \FinNaturezaFinanceiraController::class . ':alterar');
$app->delete('/fin-natureza-financeira/{id}', \FinNaturezaFinanceiraController::class . ':excluir');
$app->options('/fin-natureza-financeira[/{id}]', \ControllerBase::class . ':browserOptionsRetornarResponse');

// fin-status-parcela
$app->get('/fin-status-parcela[/]', \FinStatusParcelaController::class . ':consultarLista');
$app->get('/fin-status-parcela/{id}', \FinStatusParcelaController::class . ':consultarObjeto');
$app->post('/fin-status-parcela', \FinStatusParcelaController::class . ':inserir');
$app->put('/fin-status-parcela/{id}', \FinStatusParcelaController::class . ':alterar');
$app->delete('/fin-status-parcela/{id}', \FinStatusParcelaController::class . ':excluir');
$app->options('/fin-status-parcela[/{id}]', \ControllerBase::class . ':browserOptionsRetornarResponse');

// fin-tipo-pagamento
$app->get('/fin-tipo-pagamento[/]', \FinTipoPagamentoController::class . ':consultarLista');
$app->get('/fin-tipo-pagamento/{id}', \FinTipoPagamentoController::class . ':consultarObjeto');
$app->post('/fin-tipo-pagamento', \FinTipoPagamentoController::class . ':inserir');
$app->put('/fin-tipo-pagamento/{id}', \FinTipoPagamentoController::class . ':alterar');
$app->delete('/fin-tipo-pagamento/{id}', \FinTipoPagamentoController::class . ':excluir');
$app->options('/fin-tipo-pagamento[/{id}]', \ControllerBase::class . ':browserOptionsRetornarResponse');

// fin-tipo-recebimento
$app->get('/fin-tipo-recebimento[/]', \FinTipoRecebimentoController::class . ':consultarLista');
$app->get('/fin-tipo-recebimento/{id}', \FinTipoRecebimentoController::class . ':consultarObjeto');
$app->post('/fin-tipo-recebimento', \FinTipoRecebimentoController::class . ':inserir');
$app->put('/fin-tipo-recebimento/{id}', \FinTipoRecebimentoController::class . ':alterar');
$app->delete('/fin-tipo-recebimento/{id}', \FinTipoRecebimentoController::class . ':excluir');
$app->options('/fin-tipo-recebimento[/{id}]', \ControllerBase::class . ':browserOptionsRetornarResponse');

// talonario-cheque
$app->get('/talonario-cheque[/]', \TalonarioChequeController::class . ':consultarLista');
$app->get('/talonario-cheque/{id}', \TalonarioChequeController::class . ':consultarObjeto');
$app->post('/talonario-cheque', \TalonarioChequeController::class . ':inserir');
$app->put('/talonario-cheque/{id}', \TalonarioChequeController::class . ':alterar');
$app->delete('/talonario-cheque/{id}', \TalonarioChequeController::class . ':excluir');
$app->options('/talonario-cheque[/{id}]', \ControllerBase::class . ':browserOptionsRetornarResponse');

// view-pessoa-colaborador
$app->get('/view-pessoa-colaborador[/]', \ViewPessoaColaboradorController::class . ':consultarLista');
$app->get('/view-pessoa-colaborador/{id}', \ViewPessoaColaboradorController::class . ':consultarObjeto');
$app->post('/view-pessoa-colaborador', \ViewPessoaColaboradorController::class . ':inserir');
$app->put('/view-pessoa-colaborador/{id}', \ViewPessoaColaboradorController::class . ':alterar');
$app->delete('/view-pessoa-colaborador/{id}', \ViewPessoaColaboradorController::class . ':excluir');
$app->options('/view-pessoa-colaborador[/{id}]', \ControllerBase::class . ':browserOptionsRetornarResponse');
