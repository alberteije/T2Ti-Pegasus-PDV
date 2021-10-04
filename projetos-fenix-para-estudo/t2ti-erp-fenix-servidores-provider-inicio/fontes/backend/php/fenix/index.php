<?php
// variáveis para o resquest e o response
use Psr\Http\Message\ResponseInterface as Response;
use Psr\Http\Message\ServerRequestInterface as Request;
// para instanciar o Slim
use Slim\Factory\AppFactory;

require './vendor/autoload.php';

// inserir a conexão com o banco de dados
require './src/config/db.php';

// instancia o Slim
$app = AppFactory::create();

// usa o projeto como Sub-Directory sem precisar de Virtual Host
$app->setBasePath('/fenix');

// rotal inicial padrão para testes
$app->get('/', function (Request $request, Response $response, $args) {
    $response->getBody()->write("Servidor T2Ti ERP Fenix funcionando!");
    return $response;
});

// inserir os controllers
require './src/controller/BancoController.php';
require './src/controller/PessoaController.php';

// adicionar as novas rotas - banco
$app->get('/banco[/]', \BancoController::class . ':consultarLista');
// $app->get('/banco/{campo}/{valor}', \BancoController::class . ':consultarListaFiltroValor');
$app->get('/banco/{id}', \BancoController::class . ':consultarObjeto');
$app->post('/banco', \BancoController::class . ':inserir');
$app->put('/banco/{id}', \BancoController::class . ':alterar');
$app->delete('/banco/{id}', \BancoController::class . ':excluir');

// adicionar as novas rotas - pessoa
$app->get('/pessoa', \PessoaController::class . ':consultarLista');
$app->get('/pessoa/{id}', \PessoaController::class . ':consultarObjeto');
$app->post('/pessoa', \PessoaController::class . ':inserir');
$app->put('/pessoa', \PessoaController::class . ':alterar');
$app->delete('/pessoa/{id}', \PessoaController::class . ':excluir');

// para executar a aplicação - sem isso as rotas não vão funcionar
$app->run();
