{*******************************************************************************
Title: T2Ti ERP 3.0
Description: Controller relacionado à tabela [PDV_PLANO_PAGAMENTO] 
                                                                                
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
unit PdvPlanoPagamentoController;

interface

uses mvcframework, mvcframework.Commons,
  System.SysUtils, System.Generics.Collections,
  MVCFramework.SystemJSONUtils, MVCFramework.Serializer.Defaults;

type

  [MVCDoc('CRUD PdvPlanoPagamento')]
  [MVCPath('/pdv-plano-pagamento')]
  TPdvPlanoPagamentoController = class(TMVCController)
  public
    [MVCDoc('Retorna um objeto')]
    [MVCPath('/consulta-plano/')]
    [MVCHTTPMethod([httpGET])]
    procedure ConsultarPlanoAtivo(Context: TWebContext);

    [MVCDoc('Insere um novo objeto')]
    [MVCPath('/insere-plano/')]
    [MVCHTTPMethod([httpPOST])]
    procedure InserirPlano(Context: TWebContext);

    [MVCDoc('Confirma a transação')]
    [MVCPath('/confirma-transacao/')]
    [MVCHTTPMethod([httpPOST])]
    procedure ConfirmarTransacao(Context: TWebContext);
  end;

implementation

{ TPdvPlanoPagamentoController }

uses PdvPlanoPagamentoService, PdvPlanoPagamento, Commons, Filtro, ObjetoPagSeguro,
  Biblioteca;

procedure TPdvPlanoPagamentoController.ConsultarPlanoAtivo(Context: TWebContext);
var
  PdvPlanoPagamento: TPdvPlanoPagamento;
  ObjetoJsonString, Cnpj: string;
begin
  try
    Cnpj := Biblioteca.DecifrarDCPCrypt(Context.Request.Headers['cnpj']);
    PdvPlanoPagamento := TPdvPlanoPagamentoService.ConsultarPlanoAtivo(Cnpj);

    if Assigned(PdvPlanoPagamento) then
    begin
      ObjetoJsonString := GetDefaultSerializer.SerializeObject(PdvPlanoPagamento);
      Render(Biblioteca.CifrarDCPCrypt(ObjetoJsonString));
    end
    else
    begin
      Render(404, Biblioteca.CifrarDCPCrypt('Plano inexistente ou expirado.'));
    end;
  except
    on E: EServiceException do
    begin
      raise EMVCException.Create
        ('Erro no Servidor [Consultar Objeto PdvPlanoPagamento] - Exceção: ' + E.Message,
        E.StackTrace, 0, 500);
    end
    else
      raise;
  end;
end;

procedure TPdvPlanoPagamentoController.InserirPlano(Context: TWebContext);
var
  ObjetoJsonString: string;
  ObjetoPagSeguroEnviado: TObjetoPagSeguro;
  PdvPlanoPagamento: TPdvPlanoPagamento;
begin
  try
//    ObjetoPagSeguroEnviado := Context.Request.BodyAs<TObjetoPagSeguro>;
    ObjetoPagSeguroEnviado := TObjetoPagSeguro.Create;
    ObjetoJsonString := Biblioteca.DecifrarDCPCrypt(Context.Request.Body);
    GetDefaultSerializer.DeserializeObject(ObjetoJsonString, ObjetoPagSeguroEnviado);
  except
    on E: EServiceException do
    begin
      raise EMVCException.Create('Objeto inválido [Atualizar PdvPlanoPagamento] - Exceção: ' +
        E.Message, E.StackTrace, 0, 400);
    end
    else
      raise;
  end;

  try
    PdvPlanoPagamento := TPdvPlanoPagamentoService.Atualizar(TObjetoPagSeguro(ObjetoPagSeguroEnviado));
    if Assigned(PdvPlanoPagamento) then
    begin
//      Render(PdvPlanoPagamento);
      ObjetoJsonString := GetDefaultSerializer.SerializeObject(PdvPlanoPagamento);
      Render(Biblioteca.CifrarDCPCrypt(ObjetoJsonString));
    end
    else
    begin
      Render(400, 'Objeto inválido [Não apresenta PLANO e/ou MODULO FISCAL na descrição].')
    end;

  except
    on E: EServiceException do
    begin
      raise EMVCException.Create('Problemas na atualização [Atualizar PdvPlanoPagamento] - Exceção: ' +
        E.Message, E.StackTrace, 0, 400);
    end
    else
      raise;
  end;
end;

procedure TPdvPlanoPagamentoController.ConfirmarTransacao(Context: TWebContext);
var
  Retorno: Integer;
  Cnpj, Codigo: string;
begin
  try
    Cnpj := Biblioteca.DecifrarDCPCrypt(Context.Request.Headers['cnpj']);
    Codigo := Biblioteca.DecifrarDCPCrypt(Context.Request.Headers['codigo']);
    (*
      Vamos usar os códigos HTTP para nossa conveniência:
      200 - achou a transação e vinculou o ID da empresa
      202 - a transação foi encontrada e está disponível, mas o pagamento não foi confirmado
      404 - não achou o código da transação no banco de dados
      418 - achou o código da transação, mas ele já foi utilizado
    *)
    Retorno := TPdvPlanoPagamentoService.ConfirmarTransacao(codigo, Cnpj);
    Render(Retorno, Retorno.ToString);
  except
    on E: EServiceException do
    begin
      raise EMVCException.Create('Problemas na confirmação da transação [Confirmar Transação Plano Pagamento] - Exceção: ' +
        E.Message, E.StackTrace, 0, 400);
    end
    else
      raise;
  end;
end;

end.
