<?php
/*******************************************************************************
Title: T2Ti ERP 3.0
Description: Service relacionado à tabela [EMPRESA] 
                                                                                
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
use Illuminate\Database\Capsule\Manager as DB;

class EmpresaService extends ServiceBase
{
    public static function consultarLista()
    {
		return Empresa::select()->limit(QUANTIDADE_POR_PAGINA)->get();
    }

    public static function consultarListaFiltroValor($filtro)
    {
		return Empresa::whereRaw($filtro->where)->get();
    }

    public static function consultarObjeto($filtro)
    {
		return Empresa::whereRaw($filtro->where)->get();
    }

    public static function consultarObjetoFiltro(int $id)
    {
		$retorno = Empresa::find($id);
		if ($retorno->count() > 0) {
			return $retorno[0];
		} else {
			return null;
		}		
    }

	public static function inserir($objJson, $objEntidade)
	{
	    DB::transaction(function () use ($objJson, $objEntidade) {
	        $objEntidade->save();
	        EmpresaService::atualizarFilhos($objJson, $objEntidade);
	    });
	}

	public static function alterar($objJson, $objBanco)
	{
	    DB::transaction(function () use ($objJson, $objBanco) {
	        $objBanco->save();
	        EmpresaService::excluirFilhos($objBanco);
	        EmpresaService::atualizarFilhos($objJson, $objBanco);
	    });
	}
	
	public static function atualizarFilhos($objJson, $objPersistencia)
	{
		// atualizar listaNfeConfiguracao
		$listaNfeConfiguracaoJson = $objJson->listaNfeConfiguracao;
		if ($listaNfeConfiguracaoJson != null) {
		    for ($i = 0; $i < count($listaNfeConfiguracaoJson); $i++) {
		        $nfeConfiguracao = new NfeConfiguracao();
		        $nfeConfiguracao->mapear($listaNfeConfiguracaoJson[$i]);
		        $objPersistencia->listaNfeConfiguracao()->save($nfeConfiguracao);
		    }
		}

		// atualizar listaPdvPlanoPagamento
		$listaPdvPlanoPagamentoJson = $objJson->listaPdvPlanoPagamento;
		if ($listaPdvPlanoPagamentoJson != null) {
		    for ($i = 0; $i < count($listaPdvPlanoPagamentoJson); $i++) {
		        $pdvPlanoPagamento = new PdvPlanoPagamento();
		        $pdvPlanoPagamento->mapear($listaPdvPlanoPagamentoJson[$i]);
		        $objPersistencia->listaPdvPlanoPagamento()->save($pdvPlanoPagamento);
		    }
		}

	}
	
	public static function excluir($objeto)
	{
	    DB::transaction(function () use ($objeto) {
	        EmpresaService::excluirFilhos($objeto);
	        parent::excluir($objeto);
	    });
	}
		
	public static function excluirFilhos($objeto)
	{
		NfeConfiguracao::where('ID_EMPRESA', $objeto->getIdAttribute())->delete();
		PdvPlanoPagamento::where('ID_EMPRESA', $objeto->getIdAttribute())->delete();
	}

    public static function atualizar($objeto)
    {
		$filtro = 'CNPJ = "' . $objeto->cnpj . '"';
		$objBanco = EmpresaService::consultarObjetoFiltro($filtro);

		if ($objBanco == null) {
			$objEntidade = new Empresa();
			$objEntidade->mapear($objeto);
			$objEntidade->logotipo = '';
			return $objEntidade->save();
		} else {
			$objBanco->mapear($objeto);
			$objBanco->logotipo = '';
			return $objBanco->save();
		}
    }

    public static function registrar($objeto)
    {
		$filtro = 'CNPJ = "' . $objeto->cnpj . '"';
		$objBanco = EmpresaService::consultarObjetoFiltro($filtro);

		if ($objBanco == null) {
			if ($objBanco->registrado != 'P') {
				$objBanco->mapear($objeto);
				$objBanco->logotipo = '';
				$objBanco->registrado = 'P';
				EmpresaService::enviarEmailConfirmacao($objeto);
				return $objBanco->save();	
			}
		}
    }	

    public static function enviarEmailConfirmacao($objeto)
    {
		$codigo = md5($objeto->cnpj . CHAVE);
            
		$corpo = '';
		$corpo = $corpo + "<html>";
		$corpo = $corpo + "<body>";
		$corpo = $corpo + "<p>Olá " + $objeto->nomeFantasia + ", </p>";
		$corpo = $corpo + "<p>Parabéns pelo seu cadastro na aplicação T2Ti Pegasus PDV. Segue o código de confirmação para liberar o uso da aplicação.</p>";
		$corpo = $corpo + "<p>Informe o seguinte código na aplicação: " + $codigo + "</p>";
		$corpo = $corpo + "<p>Atenciosamente,</p>";
		$corpo = $corpo + "<p>Equipe T2Ti.COM</p>";
		$corpo = $corpo + "</body>";
		$corpo = $corpo + "</html>";

		Biblioteca::enviarEmail("T2Ti Pegasus PDV - Código de Confirmação", $objeto->email, $corpo);
	
		return $objeto;
    }	

    public static function conferirCodigoConfirmacao($objeto, $codigoConfirmacao)
    {
		$codigo = md5($objeto->cnpj . CHAVE);
		
		if ($codigo == $codigoConfirmacao)
		{
			$filtro = 'CNPJ = "' . $objeto->cnpj . '"';
			$objBanco = EmpresaService::consultarObjetoFiltro($filtro);
	
			if ($objBanco == null) {
				$objBanco->mapear($objeto);
				$objBanco->logotipo = '';
				$objBanco->registrado = 'S';
				$objBanco->dataRegistro = date("Y-m-d");
				$objBanco->horaRegistro = date("H:i:s");
				return $objBanco->save();	
			}
		}
    }	
	
}