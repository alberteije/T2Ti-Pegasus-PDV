<?php

use Doctrine\ORM\Mapping\Id;

/*******************************************************************************
Title: T2Ti ERP 3.0
Description: Service relacionado à tabela [PDV_PLANO_PAGAMENTO] 
                                                                                
The MIT License                                                                 
                                                                                
Copyright: Copyright (C) 2021 T2Ti.COM                                          
                                                                                
Permission is hereby granted, free of charge, to any person                     
obtaining a copy of this software and associated documentation                  
files (the "Software"), to deal in the Software without                         
restriction, including without limitation the rights to use,                    
copy, modify, merge, publish, distribute, sublicense, and/or sell               
copies of the Software, and to permit persons to whom the                       
Software is furnished to do so, subject to the following                        
conditions:                                                                     
                                                                                
The above copyright notice and this permission notice shall be                  
included in all copies or substantial portions of the Software.                 
                                                                                
THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,                 
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES                 
OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND                        
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT                     
HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,                    
WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING                    
FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR                   
OTHER DEALINGS IN THE SOFTWARE.                                                 
                                                                                
       The author may be contacted at:                                          
           t2ti.com@gmail.com                                                   
                                                                                
@author Albert Eije (alberteije@gmail.com)                    
@version 1.0.0
*******************************************************************************/

class PdvPlanoPagamentoService extends ServiceBase
{
    public static function consultarLista()
    {
  		return PdvPlanoPagamento::select()->limit(QUANTIDADE_POR_PAGINA)->get();
    }

    public static function consultarListaFiltroValor($filtro)
    {
	  	return PdvPlanoPagamento::whereRaw($filtro->where)->get();
    }

    public static function consultarObjeto(int $id)
    {
		  return PdvPlanoPagamento::find($id);
    }

    public static function consultarPlanoAtivo($cnpj)
    {
      $filtro = 'CNPJ = "' . $cnpj . '"';
      $empresaRetorno = Empresa::whereRaw($filtro)->get();
      if ($empresaRetorno->count() > 0) {
        $empresa = $empresaRetorno[0];
        $filtro = 'ID_EMPRESA = ' . $empresa->id->ToString() . ' AND DATA_PLANO_EXPIRA >= ' . date('yyyy-MM-dd');
        $plano = PdvPlanoPagamento::whereRaw($filtro)->get();
        if ($plano->count() > 0) {
          return $plano[0];
        } else {
          return null;
        }
      }  
    }

    public static function confirmarTransacao($codigoTransacao, $cnpj)
    {
      // remove qualquer hifen que tenha sido colocado pelo usuário
      $codigoTransacao = $codigoTransacao->replace("-", "");

      // primeiro verifica se existe o código da transação
      $filtro = "CODIGO_TRANSACAO = '" . $codigoTransacao . "'";
      $PdvPlanoPagamentoRetorno = PdvPlanoPagamento::whereRaw($filtro)->get();
      if ($PdvPlanoPagamentoRetorno->count() > 0) {
        $pdvPlanoPagamento = $PdvPlanoPagamentoRetorno[0];
        if ($pdvPlanoPagamento->empresa != null)
        {
            // achou o código da transação, mas o código já foi utilizado
            return 418;
        }
        else
        {
            // achou o código da transação e não está vinculado a nenhuma empresa
            // vamos vincular o id da empresa e o e-mail de pagamento
            // retorna 200
            $filtro = 'CNPJ = "' . $cnpj . '"';
            $empresaRetorno = Empresa::whereRaw($filtro)->get();
            if ($empresaRetorno->count() > 0) {
              $empresa = $empresaRetorno[0];
              $empresa->emailPagamento = $pdvPlanoPagamento->emailPagamento;
              $empresa->salvar();
            }

            $pdvPlanoPagamento->empresa = $empresa;
            $pdvPlanoPagamento->salvar(); 
            return 200;
        }
      }
      else
      {
          // não achou o código da transação, retorna 404
          return 404;
      }
    }

    public static function atualizar($objetoPagSeguroEnviado)
    {
      // primeiro verifica se já existe um registro armazenado para a transação, pois neste caso iremos apenas atualizar o registro
      $filtro = "CODIGO_TRANSACAO = '" . $objetoPagSeguroEnviado->codigoTransacao . "'";
      $pdvPlanoPagamentoDB = PdvPlanoPagamento::whereRaw($filtro)->get();
      if ($pdvPlanoPagamentoDB->count() > 0) {
        $pdvPlanoPagamentoDB = $pdvPlanoPagamentoDB[0];
        // atualiza o status
        $pdvPlanoPagamentoDB->statusPagamento = $objetoPagSeguroEnviado->codigoStatusTransacao;

        // se o status for pago, então atualiza a data de pagamento e de expiração do plano
        if ($pdvPlanoPagamentoDB->statusPagamento == "3")
        {
          $pdvPlanoPagamentoDB->dataPagamento = new DateTime();
          $pdvPlanoPagamentoDB->dataPlanoExpira = new DateTime();
          switch ($pdvPlanoPagamentoDB->plano) {
            case "M":
              $interval = new DateInterval('P30D');
              break;
            case "S":
              $interval = new DateInterval('P180D');
              break;
            case "A":
              $interval = new DateInterval('P365D');
              break;
            default:
              break;
          }
          $pdvPlanoPagamentoDB->dataPlanoExpira->add($interval);
        }
        $pdvPlanoPagamentoDB->save();
        return $pdvPlanoPagamentoDB;
      } else {
        // a falta de registro no banco indica que devemos criar um novo registro no banco de dados
        // que só será inserido se tiver vindo um tipo de plano válido na requisição
        $planoContratado = Biblioteca::pegarPlanoPdv($objetoPagSeguroEnviado->descricaoProduto);
        $moduloFiscal = Biblioteca::pegarModuloFiscalPdv($objetoPagSeguroEnviado->descricaoProduto);
        $filtro = "PLANO = '" . $planoContratado . "' AND MODULO_FISCAL = '" . $moduloFiscal . "'";
        $tipoPlano = PdvTipoPlano::whereRaw($filtro)->get();
        if ($tipoPlano->count() > 0) {
          $tipoPlano = $tipoPlano[0];
          $pdvPlanoPagamento = new PdvPlanoPagamento();
          $pdvPlanoPagamento->idPdvTipoPlano = $tipoPlano->id;
          $pdvPlanoPagamento->codigoTransacao = $objetoPagSeguroEnviado->codigoTransacao;
          $pdvPlanoPagamento->statusPagamento = $objetoPagSeguroEnviado->codigoStatusTransacao;
          $pdvPlanoPagamento->metodoPagamento = $objetoPagSeguroEnviado->metodoPagamento;
          $pdvPlanoPagamento->codigoTipoPagamento = $objetoPagSeguroEnviado->codigoTipoPagamento;
          $pdvPlanoPagamento->valor = $objetoPagSeguroEnviado->valorUnitario;
          $pdvPlanoPagamento->emailPagamento = $objetoPagSeguroEnviado->emailCliente;
          $pdvPlanoPagamento->dataSolicitacao = new DateTime();
          $pdvPlanoPagamento->plano = $planoContratado;

          // tenta encontrar a empresa pelo e-mail - se não encontrar, o usuário terá
          // que informar o código da transação na App para reconhecer o seu pagamento
          $filtro = "EMAIL = '" . $objetoPagSeguroEnviado->emailCliente . "'";
          $empresa = Empresa::whereRaw($filtro)->get();
          if ($empresa->count() > 0) {
            $pdvPlanoPagamento->empresa = $empresa[0];
          }

          $pdvPlanoPagamento->save();
          return $pdvPlanoPagamento;                    
        }
        else {
          return null;
        }
      }
    }		
	
}