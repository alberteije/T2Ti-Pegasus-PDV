{*******************************************************************************
Title: T2Ti ERP Fenix                                                                
Description: Controller relacionado a sincronização dos dados
                                                                                
The MIT License                                                                 
                                                                                
Copyright: Copyright (C) 2022 T2Ti.COM                                          
                                                                                
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
unit SincronizaController;

interface

uses mvcframework, mvcframework.Commons,
  MVCFramework.SystemJSONUtils, MVCFramework.Serializer.Defaults,
  MVCFramework.Serializer.Intf,
  System.SysUtils, System.Classes,
  System.Rtti, System.Generics.Collections;

type

  [MVCDoc('Sinconiza')]
  [MVCPath('/sincroniza')]
  TSincronizaController = class(TMVCController)
  public
    [MVCDoc('Armazena dados no servidor')]
    [MVCPath('/upload/')]
    [MVCHTTPMethod([httpPOST])]
    procedure SincronizarServidor(Context: TWebContext);

    [MVCDoc('Armazena dados do movimento no servidor')]
    [MVCPath('/upload-movimento/')]
    [MVCHTTPMethod([httpPOST])]
    procedure ArmazenarMovimento(Context: TWebContext);

    [MVCDoc('teste com o twilio')]
    [MVCPath('/twilio/')]
    [MVCHTTPMethod([httpPOST])]
    procedure TestarTwilio(Context: TWebContext);

    [MVCDoc('Desce os dados para o cliente')]
    [MVCPath('/download/')]
    [MVCHTTPMethod([httpGET])]
    procedure SincronizarCliente(Context: TWebContext);

  end;

implementation

{ TSincronizaController }

uses SincronizaService, Commons, Filtro, Biblioteca;

procedure TSincronizaController.SincronizarServidor(Context: TWebContext);
var
  BancoSQLite64: AnsiString;
  Cnpj: string;
begin
  try
    BancoSQLite64 := Biblioteca.DecifrarDCPCrypt(Context.Request.Body);
    Cnpj := Biblioteca.DecifrarDCPCrypt(Context.Request.Headers['cnpj']);
  except
    on E: EServiceException do
    begin
      raise EMVCException.Create('Conteúdo inválido [Sincronizar Servidor] - Exceção: ' +
        E.Message, E.StackTrace, 0, 400);
    end
    else
      raise;
  end;

  try
    TSincronizaService.SincronizarServidor(BancoSQLite64, Cnpj);
    Render(200, 'Servidor sincronizado com sucesso.')
  except
    on E: EServiceException do
    begin
      raise EMVCException.Create('Problemas na sincronização [Sincronizar Servidor] - Exceção: ' +
        E.Message, E.StackTrace, 0, 400);
    end
    else
      raise;
  end;
end;

procedure TSincronizaController.ArmazenarMovimento(Context: TWebContext);
var
  BancoSQLite64: AnsiString;
  Cnpj, IdMovimento, IdDispositivo: string;
begin
  try
    BancoSQLite64 := Biblioteca.DecifrarDCPCrypt(Context.Request.Body);
    Cnpj := Biblioteca.DecifrarDCPCrypt(Context.Request.Headers['cnpj']);
    IdMovimento := Biblioteca.DecifrarDCPCrypt(Context.Request.Headers['movimento']);
    IdDispositivo := Biblioteca.DecifrarDCPCrypt(Context.Request.Headers['dispositivo']);
    IdDispositivo := Trim(IdDispositivo);
    IdDispositivo := StringReplace(IdDispositivo,'-','',[rfReplaceAll]);
  except
    on E: EServiceException do
    begin
      raise EMVCException.Create('Conteúdo inválido [Armazenar Movimento] - Exceção: ' +
        E.Message, E.StackTrace, 0, 400);
    end
    else
      raise;
  end;

  try
    TSincronizaService.ArmazenarMovimento(BancoSQLite64, Cnpj, IdMovimento, Trim(IdDispositivo));
    Render(200, 'Movimento sincronizado com sucesso.')
  except
    on E: EServiceException do
    begin
      raise EMVCException.Create('Problemas na sincronização [Armazenar Movimento] - Exceção: ' +
        E.Message, E.StackTrace, 0, 400);
    end
    else
      raise;
  end;
end;

procedure TSincronizaController.SincronizarCliente(Context: TWebContext);
var
  Cnpj, Retorno: string;
begin
  try
    Cnpj := Biblioteca.DecifrarDCPCrypt(Context.Request.Headers['cnpj']);
  except
    on E: EServiceException do
    begin
      raise EMVCException.Create('Conteúdo inválido [Sincronizar Cliente] - Exceção: ' +
        E.Message, E.StackTrace, 0, 400);
    end
    else
      raise;
  end;

  try
    Retorno := TSincronizaService.SincronizarCliente(Cnpj);
    Render(Biblioteca.CifrarDCPCrypt(Retorno));
  except
    on E: EServiceException do
    begin
      raise EMVCException.Create('Problemas na sincronização [Sincronizar Cliente] - Exceção: ' +
        E.Message, E.StackTrace, 0, 400);
    end
    else
      raise;
  end;
end;


procedure TSincronizaController.TestarTwilio(Context: TWebContext);
var
  Corpo, Resposta: AnsiString;
begin
  try
    Corpo := Context.Request.Body;
  except
    on E: EServiceException do
    begin
      raise EMVCException.Create('Conteúdo inválido [Teste Twilio] - Exceção: ' +
        E.Message, E.StackTrace, 0, 400);
    end
    else
      raise;
  end;

  try
//    TSincronizaService.FazAlgumaCoisaNoServiceDoTwilio(Corpo);
    Resposta := Resposta + '<?xml version="1.0" encoding="UTF-8"?>';
    Resposta := Resposta + '<Response>';
    Resposta := Resposta + '<Message><Body>Mensagem vinda do Delphi.</Body></Message>';
    Resposta := Resposta + '</Response>';
    ContentType := 'text/html';
    Render(Resposta)
  except
    on E: EServiceException do
    begin
      raise EMVCException.Create('Problemas no Twilio [Teste Twilio] - Exceção: ' +
        E.Message, E.StackTrace, 0, 400);
    end
    else
      raise;
  end;
end;

end.
