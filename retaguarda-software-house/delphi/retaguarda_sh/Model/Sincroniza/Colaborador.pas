{*******************************************************************************
Title: T2Ti ERP 3.0                                                                
Description: Model relacionado à tabela [COLABORADOR] 
                                                                                
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
unit Colaborador;

interface

uses
  MVCFramework.Serializer.Commons, ModelBase;

type

  [MVCNameCase(ncLowerCase)]
  TColaborador = class(TModelBase)
  private
    FId: Integer;
    FNome: string;
    FCpf: string;
    FTelefone: string;
    FCelular: string;
    FEmail: string;
    FComissaoVista: Extended;
    FComissaoPrazo: Extended;
    FNivelAutorizacao: string;
    FEntregadorVeiculo: string;

  public
//    procedure ValidarInsercao; override;
//    procedure ValidarAlteracao; override;
//    procedure ValidarExclusao; override;

    [MVCColumnAttribute('ID', True)]
		[MVCNameAsAttribute('id')]
		property Id: Integer read FId write FId;
    [MVCColumnAttribute('NOME')]
		[MVCNameAsAttribute('nome')]
		property Nome: string read FNome write FNome;
    [MVCColumnAttribute('CPF')]
		[MVCNameAsAttribute('cpf')]
		property Cpf: string read FCpf write FCpf;
    [MVCColumnAttribute('TELEFONE')]
		[MVCNameAsAttribute('telefone')]
		property Telefone: string read FTelefone write FTelefone;
    [MVCColumnAttribute('CELULAR')]
		[MVCNameAsAttribute('celular')]
		property Celular: string read FCelular write FCelular;
    [MVCColumnAttribute('EMAIL')]
		[MVCNameAsAttribute('email')]
		property Email: string read FEmail write FEmail;
    [MVCColumnAttribute('COMISSAO_VISTA')]
		[MVCNameAsAttribute('comissaoVista')]
		property ComissaoVista: Extended read FComissaoVista write FComissaoVista;
    [MVCColumnAttribute('COMISSAO_PRAZO')]
		[MVCNameAsAttribute('comissaoPrazo')]
		property ComissaoPrazo: Extended read FComissaoPrazo write FComissaoPrazo;
    [MVCColumnAttribute('NIVEL_AUTORIZACAO')]
		[MVCNameAsAttribute('nivelAutorizacao')]
		property NivelAutorizacao: string read FNivelAutorizacao write FNivelAutorizacao;
    [MVCColumnAttribute('ENTREGADOR_VEICULO')]
		[MVCNameAsAttribute('entregadorVeiculo')]
		property EntregadorVeiculo: string read FEntregadorVeiculo write FEntregadorVeiculo;
      
  end;

implementation

{ TColaborador }



end.