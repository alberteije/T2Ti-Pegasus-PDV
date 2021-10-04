<?php

declare(strict_types=1);

class Biblioteca
{

    public static function camelCase($string)
    {
        $stringRetorno = ucwords(strtolower($string), "_");
        $stringRetorno = str_replace("_", "", $stringRetorno);
        $stringRetorno = lcfirst($stringRetorno);
        return $stringRetorno;
    }


}