<?php
// variáveis para o resquest e o response
use Psr\Http\Message\ResponseInterface as Response;
use Psr\Http\Message\ServerRequestInterface as Request;
use Psr\Http\Server\RequestHandlerInterface;
// para instanciar o Slim
use Slim\Factory\AppFactory;
// controle de rotas
use Slim\Routing\RouteContext;

require './vendor/autoload.php';

// inserir a conexão com o banco de dados
require './src/config/db.php';

// instancia o Slim
$app = AppFactory::create();

#region CORS
// fonte: http://www.slimframework.com/docs/v4/cookbook/enable-cors.html
$app->addBodyParsingMiddleware();

// This middleware will append the response header Access-Control-Allow-Methods with all allowed methods
$app->add(function (Request $request, RequestHandlerInterface $handler): Response {
    $routeContext = RouteContext::fromRequest($request);
    $routingResults = $routeContext->getRoutingResults();
    $methods = $routingResults->getAllowedMethods();
    $requestHeaders = $request->getHeaderLine('Access-Control-Request-Headers');

    $response = $handler->handle($request);

    $response = $response->withHeader('Access-Control-Allow-Origin', '*');
    // $response = $response->withHeader('Access-Control-Allow-Methods', 'GET, POST, PUT, DELETE, PATCH, OPTIONS');
    $response = $response->withHeader('Access-Control-Allow-Methods', implode(',', $methods));
    $response = $response->withHeader('Access-Control-Allow-Headers', $requestHeaders);

    // Optional: Allow Ajax CORS requests with Authorization header
    // $response = $response->withHeader('Access-Control-Allow-Credentials', 'true');

    return $response;
});

// The RoutingMiddleware should be added after our CORS middleware so routing is performed first
$app->addRoutingMiddleware();
#endregion CORS

// usa o projeto como Sub-Directory sem precisar de Virtual Host
$app->setBasePath('/fenix');

// rotal inicial padrão para testes
$app->get('/', function (Request $request, Response $response, $args) {
    $response->getBody()->write("Servidor T2Ti ERP Fenix funcionando!");
    return $response;
});

// require once
require_once('./src/config/Biblioteca.php');
require_once('./src/config/doctrine.php');
require_once('./src/model/transiente/RetornoJsonErro.php');
require_once('./src/model/transiente/Filtro.php');
require_once('./src/controller/Controllers.php');
require_once('./src/service/Services.php');
require_once('./src/model/Models.php');
require_once('./rotas.php');

// para executar a aplicação - sem isso as rotas não vão funcionar
$app->run();
