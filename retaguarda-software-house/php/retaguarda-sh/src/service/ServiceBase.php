<?php

declare(strict_types=1);

class ServiceBase
{

    public static function salvar($objeto)
    {
        $objeto->save();
    }

    public static function excluir($objeto)
    {
        $objeto->delete();
    }

}