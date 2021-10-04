<?php

///////////////////////////////
// LOGIN
///////////////////////////////
// Authentication Manager middleware
//$auth = new LoginController();
//$app->post('/login[/]', \LoginController::class . ":login");
//$app->options('/login[/]', \ControllerBase::class . BROWSER_OPTION_RETORNAR_RESPONSE);

///////////////////////////////
// CADASTROS
///////////////////////////////

// empresa
$app->get('/empresa[/]', \EmpresaController::class . CONSULTAR_LISTA);
$app->get('/empresa/{id}', \EmpresaController::class . CONSULTAR_OBJETO);
$app->post('/empresa', \EmpresaController::class . ':atualizar');
$app->put('/empresa/{id}', \EmpresaController::class . ALTERAR);
$app->delete('/empresa/{id}', \EmpresaController::class . EXCLUIR);
$app->options('/empresa[/{id}]', \ControllerBase::class . BROWSER_OPTION_RETORNAR_RESPONSE);

///////////////////////////////
// PDV
///////////////////////////////

// pdv-tipo-plano
$app->get('/pdv-tipo-plano[/]', \PdvTipoPlanoController::class . CONSULTAR_LISTA);
$app->get('/pdv-tipo-plano/{id}', \PdvTipoPlanoController::class . CONSULTAR_OBJETO);
$app->post('/pdv-tipo-plano', \PdvTipoPlanoController::class . INSERIR);
$app->put('/pdv-tipo-plano/{id}', \PdvTipoPlanoController::class . ALTERAR);
$app->delete('/pdv-tipo-plano/{id}', \PdvTipoPlanoController::class . EXCLUIR);
$app->options('/pdv-tipo-plano[/{id}]', \ControllerBase::class . BROWSER_OPTION_RETORNAR_RESPONSE);

// plano pagamento
$app->get('/pdv-plano-pagamento[/]', \PdvPlanoPagamentoController::class . CONSULTAR_LISTA);
$app->get('/pdv-plano-pagamento/{cnpj}', \PdvPlanoPagamentoController::class . CONSULTAR_OBJETO);
$app->post('/pdv-plano-pagamento', \PdvPlanoPagamentoController::class . INSERIR);
$app->post('/pdv-plano-pagamento/{codigo}', \PdvPlanoPagamentoController::class . ':confirmarTransacao');
$app->put('/pdv-plano-pagamento/{id}', \PdvPlanoPagamentoController::class . ALTERAR);
$app->delete('/pdv-plano-pagamento/{id}', \PdvPlanoPagamentoController::class . EXCLUIR);
$app->options('/pdv-plano-pagamento[/{id}]', \ControllerBase::class . BROWSER_OPTION_RETORNAR_RESPONSE);

///////////////////////////////
// NF-e
///////////////////////////////

// nfe-configuracao
//$app->get('/nfe-configuracao/', \NfeConfiguracaoController::class . CONSULTAR_LISTA);
$app->get('/nfe-configuracao/{id}', \NfeConfiguracaoController::class . CONSULTAR_OBJETO);
$app->get('/nfe-configuracao', \NfeConfiguracaoController::class . ':retornarArquivosXmlPeriodo');
$app->post('/nfe-configuracao/{/cnpj}', \NfeConfiguracaoController::class . ':atualizar');
$app->post('/nfe-configuracao[/]', \NfeConfiguracaoController::class . ':atualizarCertificado');
$app->put('/nfe-configuracao/{id}', \NfeConfiguracaoController::class . ALTERAR);
$app->delete('/nfe-configuracao/{id}', \NfeConfiguracaoController::class . EXCLUIR);
$app->options('/nfe-configuracao[/{id}]', \ControllerBase::class . BROWSER_OPTION_RETORNAR_RESPONSE);