{*******************************************************************************
Title: T2Ti ERP Fenix                                                                
Description: Model relacionado à tabela [CLIENTE] 
                                                                                
The MIT License                                                                 
                                                                                
Copyright: Copyright (C) 2020 T2Ti.COM                                          
                                                                                
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
unit Cliente;

interface

uses
  Generics.Collections, System.SysUtils,
  Pessoa, 
  MVCFramework.Serializer.Commons, ModelBase;

type

  [MVCNameCase(ncLowerCase)]
  TCliente = class(TModelBase)
  private
    FId: Integer;
    FIdPessoa: Integer;
    FDesde: TDateTime;
    FDataCadastro: TDateTime;
    FTaxaDesconto: Extended;
    FLimiteCredito: Extended;
    FObservacao: string;
      
    FPessoa: TPessoa;
  public
    procedure ValidarInsercao; override;
    procedure ValidarAlteracao; override;
    procedure ValidarExclusao; override;

    constructor Create; virtual;
    destructor Destroy; override;

    [MVCColumnAttribute('ID', True)]
	[MVCNameAsAttribute('id')]
	property Id: Integer read FId write FId;
    [MVCColumnAttribute('ID_PESSOA')]
	[MVCNameAsAttribute('idPessoa')]
	property IdPessoa: Integer read FIdPessoa write FIdPessoa;
    [MVCColumnAttribute('DESDE')]
	[MVCNameAsAttribute('desde')]
	property Desde: TDateTime read FDesde write FDesde;
    [MVCColumnAttribute('DATA_CADASTRO')]
	[MVCNameAsAttribute('dataCadastro')]
	property DataCadastro: TDateTime read FDataCadastro write FDataCadastro;
    [MVCColumnAttribute('TAXA_DESCONTO')]
	[MVCNameAsAttribute('taxaDesconto')]
	property TaxaDesconto: Extended read FTaxaDesconto write FTaxaDesconto;
    [MVCColumnAttribute('LIMITE_CREDITO')]
	[MVCNameAsAttribute('limiteCredito')]
	property LimiteCredito: Extended read FLimiteCredito write FLimiteCredito;
    [MVCColumnAttribute('OBSERVACAO')]
	[MVCNameAsAttribute('observacao')]
	property Observacao: string read FObservacao write FObservacao;
      
    [MVCNameAsAttribute('pessoa')]
	property Pessoa: TPessoa read FPessoa write FPessoa;
  end;

implementation

{ TCliente }

constructor TCliente.Create;
begin
  FPessoa := TPessoa.Create;
end;

destructor TCliente.Destroy;
begin
  FreeAndNil(FPessoa);
  inherited;
end;

procedure TCliente.ValidarInsercao;
begin
  inherited;

end;

procedure TCliente.ValidarAlteracao;
begin
  inherited;

end;

procedure TCliente.ValidarExclusao;
begin
  inherited;

end;

end.