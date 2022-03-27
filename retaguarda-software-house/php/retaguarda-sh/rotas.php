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
$app->post('/empresa', \EmpresaController::class . ':atualizar');
$app->post('/empresa/registra-empresa', \EmpresaController::class . ':registrar');
$app->post('/empresa/envia-email-confirmacao', \EmpresaController::class . ':enviarEmailConfirmacao');
$app->post('/empresa/confere-codigo-confirmacao', \EmpresaController::class . ':conferirCodigoConfirmacao');
$app->options('/empresa[/{id}]', \ControllerBase::class . BROWSER_OPTION_RETORNAR_RESPONSE);
// $app->get('/empresa[/]', \EmpresaController::class . CONSULTAR_LISTA);
// $app->get('/empresa/{id}', \EmpresaController::class . CONSULTAR_OBJETO);
// $app->put('/empresa/{id}', \EmpresaController::class . ALTERAR);
// $app->delete('/empresa/{id}', \EmpresaController::class . EXCLUIR);

///////////////////////////////
// PDV
///////////////////////////////

// pdv-tipo-plano
$app->get('/pdv-tipo-plano[/]', \PdvTipoPlanoController::class . CONSULTAR_LISTA);
$app->options('/pdv-tipo-plano[/{id}]', \ControllerBase::class . BROWSER_OPTION_RETORNAR_RESPONSE);
// $app->get('/pdv-tipo-plano/{id}', \PdvTipoPlanoController::class . CONSULTAR_OBJETO);
// $app->post('/pdv-tipo-plano', \PdvTipoPlanoController::class . INSERIR);
// $app->put('/pdv-tipo-plano/{id}', \PdvTipoPlanoController::class . ALTERAR);
// $app->delete('/pdv-tipo-plano/{id}', \PdvTipoPlanoController::class . EXCLUIR);

// plano pagamento
$app->get('/pdv-plano-pagamento/consulta-plano[/]', \PdvPlanoPagamentoController::class . CONSULTAR_OBJETO);
$app->post('/pdv-plano-pagamento[/]', \PdvPlanoPagamentoController::class . INSERIR);
$app->post('/pdv-plano-pagamento/confirma-transacao[/]', \PdvPlanoPagamentoController::class . ':confirmarTransacao');
$app->options('/pdv-plano-pagamento[/{id}]', \ControllerBase::class . BROWSER_OPTION_RETORNAR_RESPONSE);
// $app->get('/pdv-plano-pagamento[/]', \PdvPlanoPagamentoController::class . CONSULTAR_LISTA);
// $app->put('/pdv-plano-pagamento/{id}', \PdvPlanoPagamentoController::class . ALTERAR);
// $app->delete('/pdv-plano-pagamento/{id}', \PdvPlanoPagamentoController::class . EXCLUIR);

///////////////////////////////
// NF-e
///////////////////////////////

// nfe-configuracao
//$app->get('/nfe-configuracao/', \NfeConfiguracaoController::class . CONSULTAR_LISTA);
$app->get('/nfe-configuracao/{id}', \NfeConfiguracaoController::class . CONSULTAR_OBJETO);
$app->post('/nfe-configuracao/{/cnpj}', \NfeConfiguracaoController::class . ':atualizar');
$app->put('/nfe-configuracao/{id}', \NfeConfiguracaoController::class . ALTERAR);
$app->delete('/nfe-configuracao/{id}', \NfeConfiguracaoController::class . EXCLUIR);
$app->options('/nfe-configuracao[/{id}]', \ControllerBase::class . BROWSER_OPTION_RETORNAR_RESPONSE);

///////////////////////////////
// ACBr
///////////////////////////////

// acbr-monitor
$app->get('/acbr-monitor/download-xml-periodo[/]', \AcbrMonitorController::class . ':retornarArquivosXmlPeriodo');
$app->post('/acbr-monitor/atualiza-certificado[/]', \AcbrMonitorController::class . ':atualizarCertificado');
$app->post('/acbr-monitor/emite-nfce[/]', \AcbrMonitorController::class . ':emitirNfce');
$app->post('/acbr-monitor/emite-nfce-contingencia[/]', \AcbrMonitorController::class . ':emitirNfceContingencia');
$app->post('/acbr-monitor/transmite-nfce-contingenciada[/]', \AcbrMonitorController::class . ':transmitirNfceContingenciada');
$app->post('/acbr-monitor/trata-nota-anterior-contingencia[/]', \AcbrMonitorController::class . ':tratarNotaAnteriorContingencia');
$app->post('/acbr-monitor/inutiliza-numero-nota[/]', \AcbrMonitorController::class . ':inutilizarNumeroNota');
$app->post('/acbr-monitor/cancela-nfce[/]', \AcbrMonitorController::class . ':cancelarNfce');
$app->post('/acbr-monitor/gera-pdf-danfe-nfce[/]', \AcbrMonitorController::class . ':gerarPdfDanfeNfce');
$app->options('/acbr-monitor[/{id}]', \ControllerBase::class . BROWSER_OPTION_RETORNAR_RESPONSE);

///////////////////////////////
// Sincroniza
///////////////////////////////

// sincroniza
$app->get('/sincroniza/download[/]', \SincronizaController::class . ':sincronizarCliente');
$app->post('/sincroniza/upload[/]', \SincronizaController::class . ':sincronizarServidor');
$app->post('/sincroniza/twilio[/]', \SincronizaController::class . ':testarTwilio');
$app->post('/sincroniza/upload-movimento[/]', \SincronizaController::class . ':armazenarMovimento');
$app->options('/sincroniza[/{id}]', \ControllerBase::class . BROWSER_OPTION_RETORNAR_RESPONSE);