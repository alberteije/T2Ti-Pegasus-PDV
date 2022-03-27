{*******************************************************************************
Title: T2Ti ERP 3.0                                                                
Description: Controller relacionado à tabela [NFE_CONFIGURACAO] 
                                                                                
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
unit NfeConfiguracaoController;

interface

uses mvcframework, mvcframework.Commons,
  System.SysUtils, System.Classes,
  MVCFramework.SystemJSONUtils, MVCFramework.Serializer.Defaults;

type

  [MVCDoc('CRUD NfeConfiguracao')]
  [MVCPath('/nfe-configuracao')]
  TNfeConfiguracaoController = class(TMVCController)
  public
    [MVCDoc('Atualiza os dados')]
    [MVCPath('/atualiza-dados/')]
    [MVCHTTPMethod([httpPOST])]
    procedure AtualizarDados(Context: TWebContext);
  end;

implementation

{ TNfeConfiguracaoController }

uses NfeConfiguracaoService, NfeConfiguracao, Commons, Filtro, Constantes,
ObjetoPdvConfiguracao, Biblioteca;

procedure TNfeConfiguracaoController.AtualizarDados(Context: TWebContext);
var
  Cnpj, ObjetoJsonString: string;
  NfeConfiguracao: TNfeConfiguracao;
  PdvConfiguracao: TObjetoPdvConfiguracao;
begin
  try
    Cnpj := Biblioteca.DecifrarDCPCrypt(Context.Request.Headers['cnpj']);

    NfeConfiguracao := TNfeConfiguracao.Create;
    ObjetoJsonString := Biblioteca.DecifrarDCPCrypt(Context.Request.Body);
    GetDefaultSerializer.DeserializeObject(ObjetoJsonString, NfeConfiguracao);

    PdvConfiguracao := TObjetoPdvConfiguracao.Create;
    ObjetoJsonString := Biblioteca.DecifrarDCPCrypt(Context.Request.Headers['pdv-configuracao']);
    GetDefaultSerializer.DeserializeObject(ObjetoJsonString, PdvConfiguracao);
  except
    on E: EServiceException do
    begin
      raise EMVCException.Create('Objeto inválido [Atualizar NfeConfiguracao] - Exceção: ' +
        E.Message, E.StackTrace, 0, 400);
    end
    else
      raise;
  end;

  try
    NfeConfiguracao := TNfeConfiguracaoService.AtualizarDados(NfeConfiguracao, cnpj, PdvConfiguracao.DecimaisQuantidade, PdvConfiguracao.DecimaisValor);
    ObjetoJsonString := GetDefaultSerializer.SerializeObject(NfeConfiguracao);
    Render(Biblioteca.CifrarDCPCrypt(ObjetoJsonString));
  except
    on E: EServiceException do
    begin
      raise EMVCException.Create('Problemas na inserção [Atualizar NfeConfiguracao] - Exceção: ' +
        E.Message, E.StackTrace, 0, 400);
    end
    else
      raise;
  end;
end;

end.
