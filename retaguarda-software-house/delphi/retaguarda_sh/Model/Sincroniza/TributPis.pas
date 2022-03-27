{*******************************************************************************
Title: T2Ti ERP 3.0                                                                
Description: Model relacionado à tabela [TRIBUT_PIS] 
                                                                                
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
unit TributPis;

interface

uses
  MVCFramework.Serializer.Commons, ModelBase;

type

  [MVCNameCase(ncLowerCase)]
  TTributPis = class(TModelBase)
  private
    FId: Integer;
    FIdTributConfiguraOfGt: Integer;
    FCstPis: string;
    FEfdTabela435: string;
    FModalidadeBaseCalculo: string;
    FPorcentoBaseCalculo: Extended;
    FAliquotaPorcento: Extended;
    FAliquotaUnidade: Extended;
    FValorPrecoMaximo: Extended;
    FValorPautaFiscal: Extended;

  public
//    procedure ValidarInsercao; override;
//    procedure ValidarAlteracao; override;
//    procedure ValidarExclusao; override;

    [MVCColumnAttribute('ID', True)]
		[MVCNameAsAttribute('id')]
		property Id: Integer read FId write FId;
    [MVCColumnAttribute('ID_TRIBUT_CONFIGURA_OF_GT')]
		[MVCNameAsAttribute('idTributConfiguraOfGt')]
		property IdTributConfiguraOfGt: Integer read FIdTributConfiguraOfGt write FIdTributConfiguraOfGt;
    [MVCColumnAttribute('CST_PIS')]
		[MVCNameAsAttribute('cstPis')]
		property CstPis: string read FCstPis write FCstPis;
    [MVCColumnAttribute('EFD_TABELA_435')]
		[MVCNameAsAttribute('efdTabela435')]
		property EfdTabela435: string read FEfdTabela435 write FEfdTabela435;
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
      
  end;

implementation

{ TTributPis }



end.