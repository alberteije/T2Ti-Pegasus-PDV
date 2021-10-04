<?php

declare(strict_types=1);

class ModelBase
{
    /**
     * Validation
     */
    public function validarObjeto($objJson, $id, $Classe)
    {
        if (!isset($objJson->id)) {
            $mensagemErro = "Objeto inválido [Alterar $Classe] - objeto não enviado.";
            return $mensagemErro;
        }
        if ($objJson->id == 0) {
            $mensagemErro = "Objeto inválido [Alterar $Classe] - ID zerado.";
            return $mensagemErro;
        }
        if ($id != $objJson->id) {
            $mensagemErro = "Objeto inválido [Alterar $Classe] - ID do objeto difere do ID da URL.";
            return $mensagemErro;
        }
    }
    
}