{*******************************************************************************
Title: T2Ti ERP 3.0
Description: Model relacionado à tabela [TRIBUT_ISS] 
                                                                                
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
unit TributIss;

interface

uses
  Generics.Collections, System.SysUtils,
  TributOperacaoFiscal, 
  MVCFramework.Serializer.Commons, ModelBase;

type

  [MVCNameCase(ncLowerCase)]
  TTributIss = class(TModelBase)
  private
    FId: Integer;
    FIdTributOperacaoFiscal: Integer;
    FModalidadeBaseCalculo: string;
    FPorcentoBaseCalculo: Extended;
    FAliquotaPorcento: Extended;
    FAliquotaUnidade: Extended;
    FValorPrecoMaximo: Extended;
    FValorPautaFiscal: Extended;
    FItemListaServico: Integer;
    FCodigoTributacao: string;

    FTributOperacaoFiscal: TTributOperacaoFiscal;
  public
//    procedure ValidarInsercao; override;
//    procedure ValidarAlteracao; override;
//    procedure ValidarExclusao; override;

    constructor Create; virtual;
    destructor Destroy; override;

    [MVCColumnAttribute('ID', True)]
		[MVCNameAsAttribute('id')]
		property Id: Integer read FId write FId;
    [MVCColumnAttribute('ID_TRIBUT_OPERACAO_FISCAL')]
		[MVCNameAsAttribute('idTributOperacaoFiscal')]
		property IdTributOperacaoFiscal: Integer read FIdTributOperacaoFiscal write FIdTributOperacaoFiscal;
    [MVCColumnAttribute('MODALIDADE_BASE_CALCULO')]
		[MVCNameAsAttribute('modalidadeBaseCalculo')]
		property ModalidadeBaseCalculo: string read FModalidadeBaseCalculo write FModalidadeBaseCalculo;
    [MVCColumnAttribute('PORCENTO_BASE_CALCULO')]
		[MVCNameAsAttribute('porcentoBaseCalculo')]
		property PorcentoBaseCalculo: Extended read FPorcentoBaseCalculo write FPorcentoBaseCalculo;
    [MVCColumnAttribute('ALIQUOTA_PORCENTO')]
		[MVCNameAsAttribute('aliquotaPorcento')]
		property AliquotaPorcento: Extended read FAliquotaPorcento write FAliquotaPorcento;
    [MVCColumnAttribute('ALIQUOTA_UNIDADE')]
		[MVCNameAsAttribute('aliquotaUnidade')]
		property AliquotaUnidade: Extended read FAliquotaUnidade write FAliquotaUnidade;
    [MVCColumnAttribute('VALOR_PRECO_MAXIMO')]
		[MVCNameAsAttribute('valorPrecoMaximo')]
		property ValorPrecoMaximo: Extended read FValorPrecoMaximo write FValorPrecoMaximo;
    [MVCColumnAttribute('VALOR_PAUTA_FISCAL')]
		[MVCNameAsAttribute('valorPautaFiscal')]
		property ValorPautaFiscal: Extended read FValorPautaFiscal write FValorPautaFiscal;
    [MVCColumnAttribute('ITEM_LISTA_SERVICO')]
		[MVCNameAsAttribute('itemListaServico')]
		property ItemListaServico: Integer read FItemListaServico write FItemListaServico;
    [MVCColumnAttribute('CODIGO_TRIBUTACAO')]
		[MVCNameAsAttribute('codigoTributacao')]
		property CodigoTributacao: string read FCodigoTributacao write FCodigoTributacao;
      
    [MVCNameAsAttribute('tributOperacaoFiscal')]
		property TributOperacaoFiscal: TTributOperacaoFiscal read FTributOperacaoFiscal write FTributOperacaoFiscal;
  end;

implementation

{ TTributIss }

constructor TTributIss.Create;
begin
  inherited;
  FTributOperacaoFiscal := TTributOperacaoFiscal.Create;
end;

destructor TTributIss.Destroy;
begin
  FreeAndNil(FTributOperacaoFiscal);
  inherited;
end;

end.