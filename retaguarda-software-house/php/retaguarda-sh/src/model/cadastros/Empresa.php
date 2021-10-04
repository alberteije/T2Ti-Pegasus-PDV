<?php
/*******************************************************************************
Title: T2Ti ERP 3.0
Description: Model relacionado à tabela [EMPRESA] 
                                                                                
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

class Empresa extends EloquentModel implements \JsonSerializable
{
    /**
     * The table associated with the model.
     *
     * @var string
     */
    protected $table = 'EMPRESA';

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

    public function getRazaoSocialAttribute() 
	{
		return $this->attributes['RAZAO_SOCIAL'];
	}

	public function setRazaoSocialAttribute($razaoSocial) 
	{
		$this->attributes['RAZAO_SOCIAL'] = $razaoSocial;
	}

    public function getNomeFantasiaAttribute() 
	{
		return $this->attributes['NOME_FANTASIA'];
	}

	public function setNomeFantasiaAttribute($nomeFantasia) 
	{
		$this->attributes['NOME_FANTASIA'] = $nomeFantasia;
	}

    public function getCnpjAttribute() 
	{
		return $this->attributes['CNPJ'];
	}

	public function setCnpjAttribute($cnpj) 
	{
		$this->attributes['CNPJ'] = $cnpj;
	}

    public function getInscricaoEstadualAttribute() 
	{
		return $this->attributes['INSCRICAO_ESTADUAL'];
	}

	public function setInscricaoEstadualAttribute($inscricaoEstadual) 
	{
		$this->attributes['INSCRICAO_ESTADUAL'] = $inscricaoEstadual;
	}

    public function getInscricaoMunicipalAttribute() 
	{
		return $this->attributes['INSCRICAO_MUNICIPAL'];
	}

	public function setInscricaoMunicipalAttribute($inscricaoMunicipal) 
	{
		$this->attributes['INSCRICAO_MUNICIPAL'] = $inscricaoMunicipal;
	}

    public function getTipoRegimeAttribute() 
	{
		return $this->attributes['TIPO_REGIME'];
	}

	public function setTipoRegimeAttribute($tipoRegime) 
	{
		$this->attributes['TIPO_REGIME'] = $tipoRegime;
	}

    public function getCrtAttribute() 
	{
		return $this->attributes['CRT'];
	}

	public function setCrtAttribute($crt) 
	{
		$this->attributes['CRT'] = $crt;
	}

    public function getDataConstituicaoAttribute() 
	{
		return $this->attributes['DATA_CONSTITUICAO'];
	}

	public function setDataConstituicaoAttribute($dataConstituicao) 
	{
		$this->attributes['DATA_CONSTITUICAO'] = $dataConstituicao;
	}

    public function getTipoAttribute() 
	{
		return $this->attributes['TIPO'];
	}

	public function setTipoAttribute($tipo) 
	{
		$this->attributes['TIPO'] = $tipo;
	}

    public function getEmailAttribute() 
	{
		return $this->attributes['EMAIL'];
	}

	public function setEmailAttribute($email) 
	{
		$this->attributes['EMAIL'] = $email;
	}

    public function getAliquotaPisAttribute() 
	{
		return $this->attributes['ALIQUOTA_PIS'];
	}

	public function setAliquotaPisAttribute($aliquotaPis) 
	{
		$this->attributes['ALIQUOTA_PIS'] = $aliquotaPis;
	}

    public function getAliquotaCofinsAttribute() 
	{
		return $this->attributes['ALIQUOTA_COFINS'];
	}

	public function setAliquotaCofinsAttribute($aliquotaCofins) 
	{
		$this->attributes['ALIQUOTA_COFINS'] = $aliquotaCofins;
	}

    public function getLogradouroAttribute() 
	{
		return $this->attributes['LOGRADOURO'];
	}

	public function setLogradouroAttribute($logradouro) 
	{
		$this->attributes['LOGRADOURO'] = $logradouro;
	}

    public function getNumeroAttribute() 
	{
		return $this->attributes['NUMERO'];
	}

	public function setNumeroAttribute($numero) 
	{
		$this->attributes['NUMERO'] = $numero;
	}

    public function getComplementoAttribute() 
	{
		return $this->attributes['COMPLEMENTO'];
	}

	public function setComplementoAttribute($complemento) 
	{
		$this->attributes['COMPLEMENTO'] = $complemento;
	}

    public function getCepAttribute() 
	{
		return $this->attributes['CEP'];
	}

	public function setCepAttribute($cep) 
	{
		$this->attributes['CEP'] = $cep;
	}

    public function getBairroAttribute() 
	{
		return $this->attributes['BAIRRO'];
	}

	public function setBairroAttribute($bairro) 
	{
		$this->attributes['BAIRRO'] = $bairro;
	}

    public function getCidadeAttribute() 
	{
		return $this->attributes['CIDADE'];
	}

	public function setCidadeAttribute($cidade) 
	{
		$this->attributes['CIDADE'] = $cidade;
	}

    public function getUfAttribute() 
	{
		return $this->attributes['UF'];
	}

	public function setUfAttribute($uf) 
	{
		$this->attributes['UF'] = $uf;
	}

    public function getFoneAttribute() 
	{
		return $this->attributes['FONE'];
	}

	public function setFoneAttribute($fone) 
	{
		$this->attributes['FONE'] = $fone;
	}

    public function getContatoAttribute() 
	{
		return $this->attributes['CONTATO'];
	}

	public function setContatoAttribute($contato) 
	{
		$this->attributes['CONTATO'] = $contato;
	}

    public function getCodigoIbgeCidadeAttribute() 
	{
		return $this->attributes['CODIGO_IBGE_CIDADE'];
	}

	public function setCodigoIbgeCidadeAttribute($codigoIbgeCidade) 
	{
		$this->attributes['CODIGO_IBGE_CIDADE'] = $codigoIbgeCidade;
	}

    public function getCodigoIbgeUfAttribute() 
	{
		return $this->attributes['CODIGO_IBGE_UF'];
	}

	public function setCodigoIbgeUfAttribute($codigoIbgeUf) 
	{
		$this->attributes['CODIGO_IBGE_UF'] = $codigoIbgeUf;
	}

    public function getLogotipoAttribute() 
	{
		return $this->attributes['LOGOTIPO'];
	}

	public function setLogotipoAttribute($logotipo) 
	{
		$this->attributes['LOGOTIPO'] = $logotipo;
	}

    public function getRegistradoAttribute() 
	{
		return $this->attributes['REGISTRADO'];
	}

	public function setRegistradoAttribute($registrado) 
	{
		$this->attributes['REGISTRADO'] = $registrado;
	}

    public function getNaturezaJuridicaAttribute() 
	{
		return $this->attributes['NATUREZA_JURIDICA'];
	}

	public function setNaturezaJuridicaAttribute($naturezaJuridica) 
	{
		$this->attributes['NATUREZA_JURIDICA'] = $naturezaJuridica;
	}

    public function getSimeiAttribute() 
	{
		return $this->attributes['SIMEI'];
	}

	public function setSimeiAttribute($simei) 
	{
		$this->attributes['SIMEI'] = $simei;
	}

    public function getEmailPagamentoAttribute() 
	{
		return $this->attributes['EMAIL_PAGAMENTO'];
	}

	public function setEmailPagamentoAttribute($emailPagamento) 
	{
		$this->attributes['EMAIL_PAGAMENTO'] = $emailPagamento;
	}

    public function getDataRegistroAttribute() 
	{
		return $this->attributes['DATA_REGISTRO'];
	}

	public function setDataRegistroAttribute($dataRegistro) 
	{
		$this->attributes['DATA_REGISTRO'] = $dataRegistro;
	}

    public function getHoraRegistroAttribute() 
	{
		return $this->attributes['HORA_REGISTRO'];
	}

	public function setHoraRegistroAttribute($horaRegistro) 
	{
		$this->attributes['HORA_REGISTRO'] = $horaRegistro;
	}


    /**
     * Mapping
     */
    public function mapear($objeto)
    {
        if (isset($objeto)) {
            isset($objeto->id) ? $this->setIdAttribute($objeto->id) : $this->setIdAttribute(null);

			$this->setRazaoSocialAttribute($objeto->razaoSocial);
			$this->setNomeFantasiaAttribute($objeto->nomeFantasia);
			$this->setCnpjAttribute($objeto->cnpj);
			$this->setInscricaoEstadualAttribute($objeto->inscricaoEstadual);
			$this->setInscricaoMunicipalAttribute($objeto->inscricaoMunicipal);
			$this->setTipoRegimeAttribute($objeto->tipoRegime);
			$this->setCrtAttribute($objeto->crt);
			$this->setDataConstituicaoAttribute($objeto->dataConstituicao);
			$this->setTipoAttribute($objeto->tipo);
			$this->setEmailAttribute($objeto->email);
			$this->setAliquotaPisAttribute($objeto->aliquotaPis);
			$this->setAliquotaCofinsAttribute($objeto->aliquotaCofins);
			$this->setLogradouroAttribute($objeto->logradouro);
			$this->setNumeroAttribute($objeto->numero);
			$this->setComplementoAttribute($objeto->complemento);
			$this->setCepAttribute($objeto->cep);
			$this->setBairroAttribute($objeto->bairro);
			$this->setCidadeAttribute($objeto->cidade);
			$this->setUfAttribute($objeto->uf);
			$this->setFoneAttribute($objeto->fone);
			$this->setContatoAttribute($objeto->contato);
			$this->setCodigoIbgeCidadeAttribute($objeto->codigoIbgeCidade);
			$this->setCodigoIbgeUfAttribute($objeto->codigoIbgeUf);
			$this->setLogotipoAttribute($objeto->logotipo);
			$this->setRegistradoAttribute($objeto->registrado);
			$this->setNaturezaJuridicaAttribute($objeto->naturezaJuridica);
			$this->setSimeiAttribute($objeto->simei);
			$this->setEmailPagamentoAttribute($objeto->emailPagamento);
			$this->setDataRegistroAttribute($objeto->dataRegistro);
			$this->setHoraRegistroAttribute($objeto->horaRegistro);

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
			'razaoSocial' => $this->getRazaoSocialAttribute(),
			'nomeFantasia' => $this->getNomeFantasiaAttribute(),
			'cnpj' => $this->getCnpjAttribute(),
			'inscricaoEstadual' => $this->getInscricaoEstadualAttribute(),
			'inscricaoMunicipal' => $this->getInscricaoMunicipalAttribute(),
			'tipoRegime' => $this->getTipoRegimeAttribute(),
			'crt' => $this->getCrtAttribute(),
			'dataConstituicao' => $this->getDataConstituicaoAttribute(),
			'tipo' => $this->getTipoAttribute(),
			'email' => $this->getEmailAttribute(),
			'aliquotaPis' => $this->getAliquotaPisAttribute(),
			'aliquotaCofins' => $this->getAliquotaCofinsAttribute(),
			'logradouro' => $this->getLogradouroAttribute(),
			'numero' => $this->getNumeroAttribute(),
			'complemento' => $this->getComplementoAttribute(),
			'cep' => $this->getCepAttribute(),
			'bairro' => $this->getBairroAttribute(),
			'cidade' => $this->getCidadeAttribute(),
			'uf' => $this->getUfAttribute(),
			'fone' => $this->getFoneAttribute(),
			'contato' => $this->getContatoAttribute(),
			'codigoIbgeCidade' => $this->getCodigoIbgeCidadeAttribute(),
			'codigoIbgeUf' => $this->getCodigoIbgeUfAttribute(),
			'logotipo' => $this->getLogotipoAttribute(),
			'registrado' => $this->getRegistradoAttribute(),
			'naturezaJuridica' => $this->getNaturezaJuridicaAttribute(),
			'simei' => $this->getSimeiAttribute(),
			'emailPagamento' => $this->getEmailPagamentoAttribute(),
        ];
    }
}