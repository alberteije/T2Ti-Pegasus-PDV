{*******************************************************************************
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
*******************************************************************************}
unit PdvPlanoPagamento;

interface

uses
  MVCFramework.Serializer.Commons, ModelBase;

type

  [MVCNameCase(ncLowerCase)]
  TPdvPlanoPagamento = class(TModelBase)
  private
    FId: Integer;
    FIdEmpresa: Integer;
    FIdPdvTipoPlano: Integer;
    FDataSolicitacao: TDateTime;
    FDataPagamento: TDateTime;
    FDataPlanoExpira: TDateTime;
    FPlano: string;
    FValor: Extended;
    FStatusPagamento: string;
    FCodigoTransacao: string;
    FMetodoPagamento: string;
    FCodigoTipoPagamento: string;
    FEmailPagamento: string;

  public
//    procedure ValidarInsercao; override;
//    procedure ValidarAlteracao; override;
//    procedure ValidarExclusao; override;

    [MVCColumnAttribute('ID', True)]
		[MVCNameAsAttribute('id')]
		property Id: Integer read FId write FId;
    [MVCColumnAttribute('ID_EMPRESA')]
		[MVCNameAsAttribute('idEmpresa')]
		property IdEmpresa: Integer read FIdEmpresa write FIdEmpresa;
    [MVCColumnAttribute('ID_PDV_TIPO_PLANO')]
		[MVCNameAsAttribute('idPdvTipoPlano')]
		property IdPdvTipoPlano: Integer read FIdPdvTipoPlano write FIdPdvTipoPlano;
    [MVCColumnAttribute('DATA_SOLICITACAO')]
		[MVCNameAsAttribute('dataSolicitacao')]
		property DataSolicitacao: TDateTime read FDataSolicitacao write FDataSolicitacao;
    [MVCColumnAttribute('DATA_PAGAMENTO')]
		[MVCNameAsAttribute('dataPagamento')]
		property DataPagamento: TDateTime read FDataPagamento write FDataPagamento;
    [MVCColumnAttribute('PLANO')]
		[MVCNameAsAttribute('plano')]
		property Plano: string read FPlano write FPlano;
    [MVCColumnAttribute('VALOR')]
		[MVCNameAsAttribute('valor')]
		property Valor: Extended read FValor write FValor;
    [MVCColumnAttribute('STATUS_PAGAMENTO')]
		[MVCNameAsAttribute('statusPagamento')]
		property StatusPagamento: string read FStatusPagamento write FStatusPagamento;
    [MVCColumnAttribute('CODIGO_TRANSACAO')]
		[MVCNameAsAttribute('codigoTransacao')]
		property CodigoTransacao: string read FCodigoTransacao write FCodigoTransacao;
    [MVCColumnAttribute('METODO_PAGAMENTO')]
		[MVCNameAsAttribute('metodoPagamento')]
		property MetodoPagamento: string read FMetodoPagamento write FMetodoPagamento;
    [MVCColumnAttribute('CODIGO_TIPO_PAGAMENTO')]
		[MVCNameAsAttribute('codigoTipoPagamento')]
		property CodigoTipoPagamento: string read FCodigoTipoPagamento write FCodigoTipoPagamento;
    [MVCColumnAttribute('DATA_PLANO_EXPIRA')]
		[MVCNameAsAttribute('dataPlanoExpira')]
		property DataPlanoExpira: TDateTime read FDataPlanoExpira write FDataPlanoExpira;
    [MVCColumnAttribute('EMAIL_PAGAMENTO')]
		[MVCNameAsAttribute('emailPagamento')]
		property EmailPagamento: string read FEmailPagamento write FEmailPagamento;

  end;

implementation

{ TPdvPlanoPagamento }



end.