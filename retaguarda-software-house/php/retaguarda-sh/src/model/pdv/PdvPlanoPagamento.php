<?php
/*******************************************************************************
Title: T2Ti ERP 3.0
Description: Model relacionado à tabela [PDV_PLANO_PAGAMENTO] 
                                                                                
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
declare(strict_types=1);

class PdvPlanoPagamento extends EloquentModel implements \JsonSerializable
{
    /**
     * The table associated with the model.
     *
     * @var string
     */
    protected $table = 'PDV_PLANO_PAGAMENTO';

    /**
     * Eager Loading - Relacionamentos que devem ser sempre carregados por padrão
     *
     * @var array
     */
	
    /**
     * Relations
     */
    public function getIdempresaAttribute()
    {
		return $this->attributes['ID_EMPRESA'];
    	// return $this->belongsTo(Empresa::class, 'ID_EMPRESA', 'ID');
    }

	public function setIdEmpresaAttribute($idEmpresa) 
	{
		$this->attributes['ID_EMPRESA'] = $idEmpresa;
	}

    public function getIdPdvTipoPlanoAttribute()
    {
		return $this->attributes['ID_PDV_TIPO_PLANO'];
    	// return $this->belongsTo(PdvTipoPlano::class, 'ID_PDV_TIPO_PLANO', 'ID');
    }

	public function setIdPdvTipoPlanoAttribute($idPdvTipoPlano) 
	{
		$this->attributes['ID_PDV_TIPO_PLANO'] = $idPdvTipoPlano;
	}	

    /**
     * Gets e Sets
     */
    public function getIdAttribute() 
	{
		return $this->attributes['ID'];
	}

	public function setIdAttribute($id) 
	{
		$this->attributes['ID'] = $id;
	}

    public function getDataSolicitacaoAttribute() 
	{
		return $this->attributes['DATA_SOLICITACAO'];
	}

	public function setDataSolicitacaoAttribute($dataSolicitacao) 
	{
		$this->attributes['DATA_SOLICITACAO'] = $dataSolicitacao;
	}

    public function getDataPagamentoAttribute() 
	{
		return $this->attributes['DATA_PAGAMENTO'];
	}

	public function setDataPagamentoAttribute($dataPagamento) 
	{
		$this->attributes['DATA_PAGAMENTO'] = $dataPagamento;
	}

    public function getPlanoAttribute() 
	{
		return $this->attributes['PLANO'];
	}

	public function setPlanoAttribute($plano) 
	{
		$this->attributes['PLANO'] = $plano;
	}

    public function getValorAttribute() 
	{
		return $this->attributes['VALOR'];
	}

	public function setValorAttribute($valor) 
	{
		$this->attributes['VALOR'] = $valor;
	}

    public function getStatusPagamentoAttribute() 
	{
		return $this->attributes['STATUS_PAGAMENTO'];
	}

	public function setStatusPagamentoAttribute($statusPagamento) 
	{
		$this->attributes['STATUS_PAGAMENTO'] = $statusPagamento;
	}

    public function getCodigoTransacaoAttribute() 
	{
		return $this->attributes['CODIGO_TRANSACAO'];
	}

	public function setCodigoTransacaoAttribute($codigoTransacao) 
	{
		$this->attributes['CODIGO_TRANSACAO'] = $codigoTransacao;
	}

    public function getMetodoPagamentoAttribute() 
	{
		return $this->attributes['METODO_PAGAMENTO'];
	}

	public function setMetodoPagamentoAttribute($metodoPagamento) 
	{
		$this->attributes['METODO_PAGAMENTO'] = $metodoPagamento;
	}

    public function getCodigoTipoPagamentoAttribute() 
	{
		return $this->attributes['CODIGO_TIPO_PAGAMENTO'];
	}

	public function setCodigoTipoPagamentoAttribute($codigoTipoPagamento) 
	{
		$this->attributes['CODIGO_TIPO_PAGAMENTO'] = $codigoTipoPagamento;
	}

    public function getDataPlanoExpiraAttribute() 
	{
		return $this->attributes['DATA_PLANO_EXPIRA'];
	}

	public function setDataPlanoExpiraAttribute($dataPlanoExpira) 
	{
		$this->attributes['DATA_PLANO_EXPIRA'] = $dataPlanoExpira;
	}

    public function getEmailPagamentoAttribute() 
	{
		return $this->attributes['EMAIL_PAGAMENTO'];
	}

	public function setEmailPagamentoAttribute($emailPagamento) 
	{
		$this->attributes['EMAIL_PAGAMENTO'] = $emailPagamento;
	}


    /**
     * Mapping
     */
    public function mapear($objeto)
    {
        if (isset($objeto)) {
            isset($objeto->id) ? $this->setIdAttribute($objeto->id) : $this->setIdAttribute(null);

			$this->setDataSolicitacaoAttribute($objeto->dataSolicitacao);
			$this->setDataPagamentoAttribute($objeto->dataPagamento);
			$this->setPlanoAttribute($objeto->plano);
			$this->setValorAttribute($objeto->valor);
			$this->setStatusPagamentoAttribute($objeto->statusPagamento);
			$this->setCodigoTransacaoAttribute($objeto->codigoTransacao);
			$this->setMetodoPagamentoAttribute($objeto->metodoPagamento);
			$this->setCodigoTipoPagamentoAttribute($objeto->codigoTipoPagamento);
			$this->setDataPlanoExpiraAttribute($objeto->dataPlanoExpira);
			$this->setEmailPagamentoAttribute($objeto->emailPagamento);

			// vincular objetos
        }
    }

    /**
     * Serialization
     * {@inheritdoc}
     */
    public function jsonSerialize()
    {
        return [
			'id' => $this->getIdAttribute(),
			'dataSolicitacao' => $this->getDataSolicitacaoAttribute(),
			'dataPagamento' => $this->getDataPagamentoAttribute(),
			'plano' => $this->getPlanoAttribute(),
			'valor' => $this->getValorAttribute(),
			'statusPagamento' => $this->getStatusPagamentoAttribute(),
			'codigoTransacao' => $this->getCodigoTransacaoAttribute(),
			'metodoPagamento' => $this->getMetodoPagamentoAttribute(),
			'codigoTipoPagamento' => $this->getCodigoTipoPagamentoAttribute(),
			'dataPlanoExpira' => $this->getDataPlanoExpiraAttribute(),
			'emailPagamento' => $this->getEmailPagamentoAttribute(),
        ];
    }
}