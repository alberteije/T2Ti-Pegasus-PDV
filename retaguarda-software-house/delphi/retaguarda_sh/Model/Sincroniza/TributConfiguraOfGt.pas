{*******************************************************************************
Title: T2Ti ERP 3.0                                                                
Description: Model relacionado à tabela [TRIBUT_CONFIGURA_OF_GT] 
                                                                                
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
unit TributConfiguraOfGt;

interface

uses
  Generics.Collections, System.SysUtils,
  TributGrupoTributario, TributOperacaoFiscal, 
  MVCFramework.Serializer.Commons, ModelBase;

type

  [MVCNameCase(ncLowerCase)]
  TTributConfiguraOfGt = class(TModelBase)
  private
    FId: Integer;
    FIdTributGrupoTributario: Integer;
    FIdTributOperacaoFiscal: Integer;

    FTributGrupoTributario: TTributGrupoTributario;
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
    [MVCColumnAttribute('ID_TRIBUT_GRUPO_TRIBUTARIO')]
		[MVCNameAsAttribute('idTributGrupoTributario')]
		property IdTributGrupoTributario: Integer read FIdTributGrupoTributario write FIdTributGrupoTributario;
    [MVCColumnAttribute('ID_TRIBUT_OPERACAO_FISCAL')]
		[MVCNameAsAttribute('idTributOperacaoFiscal')]
		property IdTributOperacaoFiscal: Integer read FIdTributOperacaoFiscal write FIdTributOperacaoFiscal;
      
    [MVCNameAsAttribute('tributGrupoTributario')]
		property TributGrupoTributario: TTributGrupoTributario read FTributGrupoTributario write FTributGrupoTributario;
    [MVCNameAsAttribute('tributOperacaoFiscal')]
		property TributOperacaoFiscal: TTributOperacaoFiscal read FTributOperacaoFiscal write FTributOperacaoFiscal;
  end;

implementation

{ TTributConfiguraOfGt }

constructor TTributConfiguraOfGt.Create;
begin
  inherited;
  FTributGrupoTributario := TTributGrupoTributario.Create;
  FTributOperacaoFiscal := TTributOperacaoFiscal.Create;
end;

destructor TTributConfiguraOfGt.Destroy;
begin
  FreeAndNil(FTributGrupoTributario);
  FreeAndNil(FTributOperacaoFiscal);
  inherited;
end;

end.