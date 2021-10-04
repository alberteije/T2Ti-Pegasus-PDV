{*******************************************************************************
Title: T2Ti ERP Fenix                                                                
Description: Model relacionado à tabela [FIN_CONFIGURACAO_BOLETO] 
                                                                                
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
unit FinConfiguracaoBoleto;

interface

uses
  Generics.Collections, System.SysUtils,
  BancoContaCaixa, 
  MVCFramework.Serializer.Commons, ModelBase;

type

  [MVCNameCase(ncLowerCase)]
  TFinConfiguracaoBoleto = class(TModelBase)
  private
    FId: Integer;
    FIdBancoContaCaixa: Integer;
    FInstrucao01: string;
    FInstrucao02: string;
    FCaminhoArquivoRemessa: string;
    FCaminhoArquivoRetorno: string;
    FCaminhoArquivoLogotipo: string;
    FCaminhoArquivoPdf: string;
    FMensagem: string;
    FLocalPagamento: string;
    FLayoutRemessa: string;
    FAceite: string;
    FEspecie: string;
    FCarteira: string;
    FCodigoConvenio: string;
    FCodigoCedente: string;
    FTaxaMulta: Extended;
    FTaxaJuro: Extended;
    FDiasProtesto: Integer;
    FNossoNumeroAnterior: string;
      
    FBancoContaCaixa: TBancoContaCaixa;
  public
    procedure ValidarInsercao; override;
    procedure ValidarAlteracao; override;
    procedure ValidarExclusao; override;

    constructor Create; virtual;
    destructor Destroy; override;

    [MVCColumnAttribute('ID', True)]
	[MVCNameAsAttribute('id')]
	property Id: Integer read FId write FId;
    [MVCColumnAttribute('ID_BANCO_CONTA_CAIXA')]
	[MVCNameAsAttribute('idBancoContaCaixa')]
	property IdBancoContaCaixa: Integer read FIdBancoContaCaixa write FIdBancoContaCaixa;
    [MVCColumnAttribute('INSTRUCAO01')]
	[MVCNameAsAttribute('instrucao01')]
	property Instrucao01: string read FInstrucao01 write FInstrucao01;
    [MVCColumnAttribute('INSTRUCAO02')]
	[MVCNameAsAttribute('instrucao02')]
	property Instrucao02: string read FInstrucao02 write FInstrucao02;
    [MVCColumnAttribute('CAMINHO_ARQUIVO_REMESSA')]
	[MVCNameAsAttribute('caminhoArquivoRemessa')]
	property CaminhoArquivoRemessa: string read FCaminhoArquivoRemessa write FCaminhoArquivoRemessa;
    [MVCColumnAttribute('CAMINHO_ARQUIVO_RETORNO')]
	[MVCNameAsAttribute('caminhoArquivoRetorno')]
	property CaminhoArquivoRetorno: string read FCaminhoArquivoRetorno write FCaminhoArquivoRetorno;
    [MVCColumnAttribute('CAMINHO_ARQUIVO_LOGOTIPO')]
	[MVCNameAsAttribute('caminhoArquivoLogotipo')]
	property CaminhoArquivoLogotipo: string read FCaminhoArquivoLogotipo write FCaminhoArquivoLogotipo;
    [MVCColumnAttribute('CAMINHO_ARQUIVO_PDF')]
	[MVCNameAsAttribute('caminhoArquivoPdf')]
	property CaminhoArquivoPdf: string read FCaminhoArquivoPdf write FCaminhoArquivoPdf;
    [MVCColumnAttribute('MENSAGEM')]
	[MVCNameAsAttribute('mensagem')]
	property Mensagem: string read FMensagem write FMensagem;
    [MVCColumnAttribute('LOCAL_PAGAMENTO')]
	[MVCNameAsAttribute('localPagamento')]
	property LocalPagamento: string read FLocalPagamento write FLocalPagamento;
    [MVCColumnAttribute('LAYOUT_REMESSA')]
	[MVCNameAsAttribute('layoutRemessa')]
	property LayoutRemessa: string read FLayoutRemessa write FLayoutRemessa;
    [MVCColumnAttribute('ACEITE')]
	[MVCNameAsAttribute('aceite')]
	property Aceite: string read FAceite write FAceite;
    [MVCColumnAttribute('ESPECIE')]
	[MVCNameAsAttribute('especie')]
	property Especie: string read FEspecie write FEspecie;
    [MVCColumnAttribute('CARTEIRA')]
	[MVCNameAsAttribute('carteira')]
	property Carteira: string read FCarteira write FCarteira;
    [MVCColumnAttribute('CODIGO_CONVENIO')]
	[MVCNameAsAttribute('codigoConvenio')]
	property CodigoConvenio: string read FCodigoConvenio write FCodigoConvenio;
    [MVCColumnAttribute('CODIGO_CEDENTE')]
	[MVCNameAsAttribute('codigoCedente')]
	property CodigoCedente: string read FCodigoCedente write FCodigoCedente;
    [MVCColumnAttribute('TAXA_MULTA')]
	[MVCNameAsAttribute('taxaMulta')]
	property TaxaMulta: Extended read FTaxaMulta write FTaxaMulta;
    [MVCColumnAttribute('TAXA_JURO')]
	[MVCNameAsAttribute('taxaJuro')]
	property TaxaJuro: Extended read FTaxaJuro write FTaxaJuro;
    [MVCColumnAttribute('DIAS_PROTESTO')]
	[MVCNameAsAttribute('diasProtesto')]
	property DiasProtesto: Integer read FDiasProtesto write FDiasProtesto;
    [MVCColumnAttribute('NOSSO_NUMERO_ANTERIOR')]
	[MVCNameAsAttribute('nossoNumeroAnterior')]
	property NossoNumeroAnterior: string read FNossoNumeroAnterior write FNossoNumeroAnterior;
      
    [MVCNameAsAttribute('bancoContaCaixa')]
	property BancoContaCaixa: TBancoContaCaixa read FBancoContaCaixa write FBancoContaCaixa;
  end;

implementation

{ TFinConfiguracaoBoleto }

constructor TFinConfiguracaoBoleto.Create;
begin
  FBancoContaCaixa := TBancoContaCaixa.Create;
end;

destructor TFinConfiguracaoBoleto.Destroy;
begin
  FreeAndNil(FBancoContaCaixa);
  inherited;
end;

procedure TFinConfiguracaoBoleto.ValidarInsercao;
begin
  inherited;

end;

procedure TFinConfiguracaoBoleto.ValidarAlteracao;
begin
  inherited;

end;

procedure TFinConfiguracaoBoleto.ValidarExclusao;
begin
  inherited;

end;

end.