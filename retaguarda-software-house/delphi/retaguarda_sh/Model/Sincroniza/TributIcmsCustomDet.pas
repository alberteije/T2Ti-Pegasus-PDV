{*******************************************************************************
Title: T2Ti ERP 3.0                                                                
Description: Model relacionado à tabela [TRIBUT_ICMS_CUSTOM_DET] 
                                                                                
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
*******************************************************************************}
unit TributIcmsCustomDet;

interface

uses
  MVCFramework.Serializer.Commons, ModelBase;

type

  [MVCNameCase(ncLowerCase)]
  TTributIcmsCustomDet = class(TModelBase)
  private
    FId: Integer;
    FIdTributIcmsCustomCab: Integer;
    FUfDestino: string;
    FCfop: Integer;
    FCsosn: string;
    FCst: string;
    FModalidadeBc: string;
    FAliquota: Extended;
    FValorPauta: Extended;
    FValorPrecoMaximo: Extended;
    FMva: Extended;
    FPorcentoBc: Extended;
    FModalidadeBcSt: string;
    FAliquotaInternaSt: Extended;
    FAliquotaInterestadualSt: Extended;
    FPorcentoBcSt: Extended;
    FAliquotaIcmsSt: Extended;
    FValorPautaSt: Extended;
    FValorPrecoMaximoSt: Extended;

  public
//    procedure ValidarInsercao; override;
//    procedure ValidarAlteracao; override;
//    procedure ValidarExclusao; override;

    [MVCColumnAttribute('ID', True)]
		[MVCNameAsAttribute('id')]
		property Id: Integer read FId write FId;
    [MVCColumnAttribute('ID_TRIBUT_ICMS_CUSTOM_CAB')]
		[MVCNameAsAttribute('idTributIcmsCustomCab')]
		property IdTributIcmsCustomCab: Integer read FIdTributIcmsCustomCab write FIdTributIcmsCustomCab;
    [MVCColumnAttribute('UF_DESTINO')]
		[MVCNameAsAttribute('ufDestino')]
		property UfDestino: string read FUfDestino write FUfDestino;
    [MVCColumnAttribute('CFOP')]
		[MVCNameAsAttribute('cfop')]
		property Cfop: Integer read FCfop write FCfop;
    [MVCColumnAttribute('CSOSN')]
		[MVCNameAsAttribute('csosn')]
		property Csosn: string read FCsosn write FCsosn;
    [MVCColumnAttribute('CST')]
		[MVCNameAsAttribute('cst')]
		property Cst: string read FCst write FCst;
    [MVCColumnAttribute('MODALIDADE_BC')]
		[MVCNameAsAttribute('modalidadeBc')]
		property ModalidadeBc: string read FModalidadeBc write FModalidadeBc;
    [MVCColumnAttribute('ALIQUOTA')]
		[MVCNameAsAttribute('aliquota')]
		property Aliquota: Extended read FAliquota write FAliquota;
    [MVCColumnAttribute('VALOR_PAUTA')]
		[MVCNameAsAttribute('valorPauta')]
		property ValorPauta: Extended read FValorPauta write FValorPauta;
    [MVCColumnAttribute('VALOR_PRECO_MAXIMO')]
		[MVCNameAsAttribute('valorPrecoMaximo')]
		property ValorPrecoMaximo: Extended read FValorPrecoMaximo write FValorPrecoMaximo;
    [MVCColumnAttribute('MVA')]
		[MVCNameAsAttribute('mva')]
		property Mva: Extended read FMva write FMva;
    [MVCColumnAttribute('PORCENTO_BC')]
		[MVCNameAsAttribute('porcentoBc')]
		property PorcentoBc: Extended read FPorcentoBc write FPorcentoBc;
    [MVCColumnAttribute('MODALIDADE_BC_ST')]
		[MVCNameAsAttribute('modalidadeBcSt')]
		property ModalidadeBcSt: string read FModalidadeBcSt write FModalidadeBcSt;
    [MVCColumnAttribute('ALIQUOTA_INTERNA_ST')]
		[MVCNameAsAttribute('aliquotaInternaSt')]
		property AliquotaInternaSt: Extended read FAliquotaInternaSt write FAliquotaInternaSt;
    [MVCColumnAttribute('ALIQUOTA_INTERESTADUAL_ST')]
		[MVCNameAsAttribute('aliquotaInterestadualSt')]
		property AliquotaInterestadualSt: Extended read FAliquotaInterestadualSt write FAliquotaInterestadualSt;
    [MVCColumnAttribute('PORCENTO_BC_ST')]
		[MVCNameAsAttribute('porcentoBcSt')]
		property PorcentoBcSt: Extended read FPorcentoBcSt write FPorcentoBcSt;
    [MVCColumnAttribute('ALIQUOTA_ICMS_ST')]
		[MVCNameAsAttribute('aliquotaIcmsSt')]
		property AliquotaIcmsSt: Extended read FAliquotaIcmsSt write FAliquotaIcmsSt;
    [MVCColumnAttribute('VALOR_PAUTA_ST')]
		[MVCNameAsAttribute('valorPautaSt')]
		property ValorPautaSt: Extended read FValorPautaSt write FValorPautaSt;
    [MVCColumnAttribute('VALOR_PRECO_MAXIMO_ST')]
		[MVCNameAsAttribute('valorPrecoMaximoSt')]
		property ValorPrecoMaximoSt: Extended read FValorPrecoMaximoSt write FValorPrecoMaximoSt;
      
  end;

implementation

{ TTributIcmsCustomDet }



end.