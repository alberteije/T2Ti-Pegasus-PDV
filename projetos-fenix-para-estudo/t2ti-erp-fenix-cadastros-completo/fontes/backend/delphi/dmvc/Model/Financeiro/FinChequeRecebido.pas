{*******************************************************************************
Title: T2Ti ERP Fenix                                                                
Description: Model relacionado à tabela [FIN_CHEQUE_RECEBIDO] 
                                                                                
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
unit FinChequeRecebido;

interface

uses
  Generics.Collections, System.SysUtils,
  Pessoa, 
  MVCFramework.Serializer.Commons, ModelBase;

type

  [MVCNameCase(ncLowerCase)]
  TFinChequeRecebido = class(TModelBase)
  private
    FId: Integer;
    FIdPessoa: Integer;
    FCpf: string;
    FCnpj: string;
    FNome: string;
    FCodigoBanco: string;
    FCodigoAgencia: string;
    FConta: string;
    FNumero: Integer;
    FDataEmissao: TDateTime;
    FBomPara: TDateTime;
    FDataCompensacao: TDateTime;
    FValor: Extended;
    FCustodiaData: TDateTime;
    FCustodiaTarifa: Extended;
    FCustodiaComissao: Extended;
    FDescontoData: TDateTime;
    FDescontoTarifa: Extended;
    FDescontoComissao: Extended;
    FValorRecebido: Extended;
      
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
    [MVCColumnAttribute('CPF')]
	[MVCNameAsAttribute('cpf')]
	property Cpf: string read FCpf write FCpf;
    [MVCColumnAttribute('CNPJ')]
	[MVCNameAsAttribute('cnpj')]
	property Cnpj: string read FCnpj write FCnpj;
    [MVCColumnAttribute('NOME')]
	[MVCNameAsAttribute('nome')]
	property Nome: string read FNome write FNome;
    [MVCColumnAttribute('CODIGO_BANCO')]
	[MVCNameAsAttribute('codigoBanco')]
	property CodigoBanco: string read FCodigoBanco write FCodigoBanco;
    [MVCColumnAttribute('CODIGO_AGENCIA')]
	[MVCNameAsAttribute('codigoAgencia')]
	property CodigoAgencia: string read FCodigoAgencia write FCodigoAgencia;
    [MVCColumnAttribute('CONTA')]
	[MVCNameAsAttribute('conta')]
	property Conta: string read FConta write FConta;
    [MVCColumnAttribute('NUMERO')]
	[MVCNameAsAttribute('numero')]
	property Numero: Integer read FNumero write FNumero;
    [MVCColumnAttribute('DATA_EMISSAO')]
	[MVCNameAsAttribute('dataEmissao')]
	property DataEmissao: TDateTime read FDataEmissao write FDataEmissao;
    [MVCColumnAttribute('BOM_PARA')]
	[MVCNameAsAttribute('bomPara')]
	property BomPara: TDateTime read FBomPara write FBomPara;
    [MVCColumnAttribute('DATA_COMPENSACAO')]
	[MVCNameAsAttribute('dataCompensacao')]
	property DataCompensacao: TDateTime read FDataCompensacao write FDataCompensacao;
    [MVCColumnAttribute('VALOR')]
	[MVCNameAsAttribute('valor')]
	property Valor: Extended read FValor write FValor;
    [MVCColumnAttribute('CUSTODIA_DATA')]
	[MVCNameAsAttribute('custodiaData')]
	property CustodiaData: TDateTime read FCustodiaData write FCustodiaData;
    [MVCColumnAttribute('CUSTODIA_TARIFA')]
	[MVCNameAsAttribute('custodiaTarifa')]
	property CustodiaTarifa: Extended read FCustodiaTarifa write FCustodiaTarifa;
    [MVCColumnAttribute('CUSTODIA_COMISSAO')]
	[MVCNameAsAttribute('custodiaComissao')]
	property CustodiaComissao: Extended read FCustodiaComissao write FCustodiaComissao;
    [MVCColumnAttribute('DESCONTO_DATA')]
	[MVCNameAsAttribute('descontoData')]
	property DescontoData: TDateTime read FDescontoData write FDescontoData;
    [MVCColumnAttribute('DESCONTO_TARIFA')]
	[MVCNameAsAttribute('descontoTarifa')]
	property DescontoTarifa: Extended read FDescontoTarifa write FDescontoTarifa;
    [MVCColumnAttribute('DESCONTO_COMISSAO')]
	[MVCNameAsAttribute('descontoComissao')]
	property DescontoComissao: Extended read FDescontoComissao write FDescontoComissao;
    [MVCColumnAttribute('VALOR_RECEBIDO')]
	[MVCNameAsAttribute('valorRecebido')]
	property ValorRecebido: Extended read FValorRecebido write FValorRecebido;
      
    [MVCNameAsAttribute('pessoa')]
	property Pessoa: TPessoa read FPessoa write FPessoa;
  end;

implementation

{ TFinChequeRecebido }

constructor TFinChequeRecebido.Create;
begin
  FPessoa := TPessoa.Create;
end;

destructor TFinChequeRecebido.Destroy;
begin
  FreeAndNil(FPessoa);
  inherited;
end;

procedure TFinChequeRecebido.ValidarInsercao;
begin
  inherited;

end;

procedure TFinChequeRecebido.ValidarAlteracao;
begin
  inherited;

end;

procedure TFinChequeRecebido.ValidarExclusao;
begin
  inherited;

end;

end.