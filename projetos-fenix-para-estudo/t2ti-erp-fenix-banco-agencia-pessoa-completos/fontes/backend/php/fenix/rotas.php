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

// pessoa
$app->get('/pessoa[/]', \PessoaController::class . ':consultarLista');
$app->get('/pessoa/{id}', \PessoaController::class . ':consultarObjeto');
$app->post('/pessoa', \PessoaController::class . ':inserir');
$app->put('/pessoa/{id}', \PessoaController::class . ':alterar');
$app->delete('/pessoa/{id}', \PessoaController::class . ':excluir');
