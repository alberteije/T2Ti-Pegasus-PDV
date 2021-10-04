<?php
require './vendor/autoload.php';
use Illuminate\Database\Capsule\Manager as Capsule;

$capsule = new Capsule;

$capsule->addConnection([
	'driver'    => 'mysql',
	'host'      => 'localhost',
	'database'  => 'retaguarda_sh',
	'username'  => 'root',
	'password'  => 'root',
	'charset'   => 'utf8',
	'collation' => 'utf8_unicode_ci',
	'prefix'    => '',
]);

$capsule->setAsGlobal();
$capsule->bootEloquent();

abstract class EloquentModel extends \Illuminate\Database\Eloquent\Model {
    /**
     * Indicates if the model should be timestamped.
	 * Para não permitir que o Eloquent crie os campos created_at e updated_at no banco de dados
     *
     * @var bool
     */
	public $timestamps = false;
}