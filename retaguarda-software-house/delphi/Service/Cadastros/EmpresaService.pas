{*******************************************************************************
Title: T2Ti ERP 3.0                                                                
Description: Service relacionado à tabela [EMPRESA] 
                                                                                
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
unit EmpresaService;

interface

uses
  Empresa,
  System.Classes, System.SysUtils, System.Generics.Collections, ServiceBase,
  MVCFramework.DataSet.Utils, MVCFramework.Logger;

type

  TEmpresaService = class(TServiceBase)
  private
  public
    class function ConsultarLista: TObjectList<TEmpresa>;
    class function ConsultarListaFiltro(AWhere: string): TObjectList<TEmpresa>;
    class function ConsultarObjeto(AId: Integer): TEmpresa;
    class function ConsultarObjetoFiltro(AWhere: string): TEmpresa;
    class procedure Inserir(AEmpresa: TEmpresa);
    class procedure Atualizar(AEmpresa: TEmpresa);
    class procedure Registrar(AEmpresa: TEmpresa);
    class procedure EnviarEmailConfirmacao(AEmpresa: TEmpresa);
    class procedure ConferirCodigoConfirmacao(AEmpresa: TEmpresa; CodigoConfirmacao: string);
    class function Alterar(AEmpresa: TEmpresa): Integer;
    class function Excluir(AEmpresa: TEmpresa): Integer;
  end;

var
  sql: string;


implementation

uses
  Biblioteca, Constantes;
{ TEmpresaService }



class function TEmpresaService.ConsultarLista: TObjectList<TEmpresa>;
begin
  Log('== TEmpresaService.ConsultarLista [BEGIN]');
  sql := 'SELECT * FROM EMPRESA ORDER BY ID';
  try
    Result := GetQuery(sql).AsObjectList<TEmpresa>;

  finally
    Query.Close;
    Query.Free;
  end;
  Log('== TEmpresaService.ConsultarLista [END]');
end;

class function TEmpresaService.ConsultarListaFiltro(AWhere: string): TObjectList<TEmpresa>;
begin
  Log('== TEmpresaService.ConsultarListaFiltro [BEGIN]');
  sql := 'SELECT * FROM EMPRESA where ' + AWhere;
  try
    Result := GetQuery(sql).AsObjectList<TEmpresa>;

  finally
    Query.Close;
    Query.Free;
  end;
  Log('== TEmpresaService.ConsultarListaFiltro [END]');
end;

class function TEmpresaService.ConsultarObjeto(AId: Integer): TEmpresa;
begin
  Log('== TEmpresaService.ConsultarObjeto [BEGIN]');
  sql := 'SELECT * FROM EMPRESA WHERE ID = ' + IntToStr(AId);
  try
    GetQuery(sql);
    if not Query.Eof then
    begin
      Result := Query.AsObject<TEmpresa>;

    end
    else
      Result := nil;
  finally
    Query.Close;
    Query.Free;
  end;
  Log('== TEmpresaService.ConsultarObjeto [END]');
end;

class function TEmpresaService.ConsultarObjetoFiltro(AWhere: string): TEmpresa;
begin
  Log('== TEmpresaService.ConsultarObjetoFiltro [BEGIN]');
  sql := 'SELECT * FROM EMPRESA where ' + AWhere;
  try
    GetQuery(sql);
    if not Query.Eof then
    begin
      Result := Query.AsObject<TEmpresa>;

    end
    else
      Result := nil;
  finally
    Query.Close;
    Query.Free;
  end;
  Log('== TEmpresaService.ConsultarObjetoFiltro [END]');
end;

class procedure TEmpresaService.Inserir(AEmpresa: TEmpresa);
begin
  Log('== TEmpresaService.Inserir [BEGIN]');
  AEmpresa.ValidarInsercao;
  AEmpresa.Id := InserirBase(AEmpresa, 'EMPRESA');
  Log('== TEmpresaService.Inserir [END]');
end;

class function TEmpresaService.Alterar(AEmpresa: TEmpresa): Integer;
begin
  Log('== TEmpresaService.Alterar [BEGIN]');
  AEmpresa.ValidarAlteracao;
  Result := AlterarBase(AEmpresa, 'EMPRESA');
  Log('== TEmpresaService.Alterar [END]');
end;


class procedure TEmpresaService.Atualizar(AEmpresa: TEmpresa);
var
  Empresa: TEmpresa;
  Filtro: string;
begin
  Log('== TEmpresaService.Atualizar [BEGIN]');
  // TODO: salva a imagem em disco
  AEmpresa.Logotipo := '';

  Filtro := 'CNPJ = "' + AEmpresa.Cnpj + '"';
  Empresa := ConsultarObjetoFiltro(filtro);
  if Assigned(Empresa) then
  begin
    AEmpresa.Id := Empresa.Id;
    AlterarBase(AEmpresa, 'EMPRESA');
  end
  else
  begin
    AEmpresa.Id := InserirBase(AEmpresa, 'EMPRESA');
  end;
  Log('== TEmpresaService.Atualizar [END]');
end;

class procedure TEmpresaService.Registrar(AEmpresa: TEmpresa);
var
  Empresa: TEmpresa;
  Filtro: string;
begin
  Log('== TEmpresaService.Registrar [BEGIN]');
  AEmpresa.Logotipo := '';

  Filtro := 'CNPJ = "' + AEmpresa.Cnpj + '"';
  Empresa := ConsultarObjetoFiltro(filtro);
  if Assigned(Empresa) then
  begin
    // só altera a empresa se ela já não estiver pendente
    if Empresa.Registrado <> 'P' then
    begin
      AEmpresa.Id := Empresa.Id;
      AEmpresa.Registrado := 'P';
      AlterarBase(AEmpresa, 'EMPRESA');
      EnviarEmailConfirmacao(AEmpresa);
    end;
  end;
  Log('== TEmpresaService.Registrar [END]');
end;

class procedure TEmpresaService.EnviarEmailConfirmacao(AEmpresa: TEmpresa);
var
  Corpo: TStringList;
  Codigo: string;
begin
  Log('== TEmpresaService.EnviarEmailConfirmacao [BEGIN]');
  Codigo := Biblioteca.MD5String(AEmpresa.Cnpj + TConstantes.CHAVE);
  try
    Corpo := TStringList.Create;
    Corpo.Add('<html>');
    Corpo.Add('<body>');
    Corpo.Add('<p>Olá ' + AEmpresa.NomeFantasia+', </p>');
    Corpo.Add('<p>Parabéns pelo seu cadastro na aplicação T2Ti Pegasus PDV. Segue o código de confirmação para liberar o uso da aplicação.</p>');
    Corpo.Add('<p>Informe o seguinte código na aplicação: ' + Codigo+'</p>');
    Corpo.Add('<p>Atenciosamente,</p>');
    Corpo.Add('<p>Equipe T2Ti.COM</p>');
    Corpo.Add('</body>');
    Corpo.Add('</html>');

    Biblioteca.EnviarEmail('T2Ti Pegasus PDV - Código de Confirmação', AEmpresa.Email, Corpo.Text);
  finally
    FreeAndNil(Corpo);
  end;
  Log('== TEmpresaService.EnviarEmailConfirmacao [END]');
end;

class procedure TEmpresaService.ConferirCodigoConfirmacao(AEmpresa: TEmpresa; CodigoConfirmacao: string);
var
  Empresa: TEmpresa;
  Codigo, Filtro: string;
begin
  Log('== TEmpresaService.ConferirCodigoConfirmacao [BEGIN]');
  Codigo := Biblioteca.MD5String(AEmpresa.Cnpj + TConstantes.CHAVE);
  Log('CNPJ = ' + AEmpresa.Cnpj);
  Log('Codigo Gerado = ' + Codigo);
  Log('Codigo Enviado = ' + CodigoConfirmacao);
  if Codigo = CodigoConfirmacao then
  begin
    Log('O código bateu, vamos procurar a empresa');
    Filtro := 'CNPJ = "' + AEmpresa.Cnpj + '"';
    Empresa := ConsultarObjetoFiltro(filtro);
    if Assigned(Empresa) then
    begin
      Log('Encontrou a empresa, vamos registrar');
      AEmpresa.Id := Empresa.Id;
      AEmpresa.Logotipo := '';
      AEmpresa.DataRegistro := now;
      AEmpresa.HoraRegistro := FormatDateTime('hh:mm:ss', now);
      AEmpresa.Registrado := 'S';
      AlterarBase(AEmpresa, 'EMPRESA');
      Log('Alterou os dados da empresa');
    end;
  end;
  Log('== TEmpresaService.ConferirCodigoConfirmacao [END]');
end;

class function TEmpresaService.Excluir(AEmpresa: TEmpresa): Integer;
begin
  Log('== TEmpresaService.Excluir [BEGIN]');
  AEmpresa.ValidarExclusao;

  Result := ExcluirBase(AEmpresa.Id, 'EMPRESA');
  Log('== TEmpresaService.Excluir [END]');
end;


end.
