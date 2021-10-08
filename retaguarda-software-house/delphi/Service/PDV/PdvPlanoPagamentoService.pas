{*******************************************************************************
Title: T2Ti ERP 3.0
Description: Service relacionado à tabela [PDV_PLANO_PAGAMENTO] 
                                                                                
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
unit PdvPlanoPagamentoService;

interface

uses
  PdvPlanoPagamento, ObjetoPagSeguro, PdvTipoPlano, Empresa,
  PdvTipoPlanoService, EmpresaService,
  System.SysUtils, System.Generics.Collections, ServiceBase, StrUtils,
  MVCFramework.DataSet.Utils, Biblioteca;

type

  TPdvPlanoPagamentoService = class(TServiceBase)
  private
  public
    class function ConsultarLista: TObjectList<TPdvPlanoPagamento>;
    class function ConsultarListaFiltro(AWhere: string): TObjectList<TPdvPlanoPagamento>;
    class function ConsultarObjeto(AId: Integer): TPdvPlanoPagamento;
    class function ConsultarObjetoFiltro(AWhere: string): TPdvPlanoPagamento;
    class procedure Inserir(APdvPlanoPagamento: TPdvPlanoPagamento);
    class function Alterar(APdvPlanoPagamento: TPdvPlanoPagamento): Integer;
    class function Excluir(APdvPlanoPagamento: TPdvPlanoPagamento): Integer;
    class function Atualizar(AObjetoPagSeguroEnviado: TObjetoPagSeguro): TPdvPlanoPagamento;
    class function ConsultarPlanoAtivo(ACnpj: string): TPdvPlanoPagamento;
    class function ConfirmarTransacao(ACodigoTransacao: string; ACnpj: string): Integer;
  end;

var
  sql: string;


implementation

{ TPdvPlanoPagamentoService }


class function TPdvPlanoPagamentoService.ConsultarLista: TObjectList<TPdvPlanoPagamento>;
begin
  sql := 'SELECT * FROM PDV_PLANO_PAGAMENTO ORDER BY ID';
  try
    Result := GetQuery(sql).AsObjectList<TPdvPlanoPagamento>;

  finally
    Query.Close;
    Query.Free;
  end;
end;

class function TPdvPlanoPagamentoService.ConsultarListaFiltro(AWhere: string): TObjectList<TPdvPlanoPagamento>;
begin
  sql := 'SELECT * FROM PDV_PLANO_PAGAMENTO where ' + AWhere;
  try
    Result := GetQuery(sql).AsObjectList<TPdvPlanoPagamento>;

  finally
    Query.Close;
    Query.Free;
  end;
end;

class function TPdvPlanoPagamentoService.ConsultarObjeto(AId: Integer): TPdvPlanoPagamento;
begin
  sql := 'SELECT * FROM PDV_PLANO_PAGAMENTO WHERE ID = ' + IntToStr(AId);
  try
    GetQuery(sql);
    if not Query.Eof then
    begin
      Result := Query.AsObject<TPdvPlanoPagamento>;

    end
    else
      Result := nil;
  finally
    Query.Close;
    Query.Free;
  end;
end;

class function TPdvPlanoPagamentoService.ConsultarObjetoFiltro(AWhere: string): TPdvPlanoPagamento;
begin
  sql := 'SELECT * FROM PDV_PLANO_PAGAMENTO where ' + AWhere;
  try
    GetQuery(sql);
    if not Query.Eof then
    begin
      Result := Query.AsObject<TPdvPlanoPagamento>;

    end
    else
      Result := nil;
  finally
    Query.Close;
    Query.Free;
  end;
end;

class function TPdvPlanoPagamentoService.ConsultarPlanoAtivo(ACnpj: string): TPdvPlanoPagamento;
var
  Filtro: string;
  Empresa: TEmpresa;
begin
  Result := nil;
  Filtro := 'CNPJ = "' + ACnpj + '"';
  Empresa := TEmpresaService.ConsultarObjetoFiltro(Filtro);
  if Assigned(Empresa) then
  begin
    Filtro := 'ID_EMPRESA = ' + Empresa.Id.ToString + ' AND DATA_PLANO_EXPIRA >= ' + Biblioteca.DateToSQL(now);
    Result := ConsultarObjetoFiltro(Filtro);
  end;
end;

class function TPdvPlanoPagamentoService.ConfirmarTransacao(ACodigoTransacao: string; ACnpj: string): Integer;
var
  Filtro: string;
  Empresa: TEmpresa;
  PdvPlanoPagamento: TPdvPlanoPagamento;
begin
  // remove qualquer hifen que tenha sido colocado pelo usuário
  ACodigoTransacao := StringReplace(ACodigoTransacao, '-', '', [rfReplaceAll, rfIgnoreCase]);
  // primeiro verifica se existe o código da transação
  Filtro := 'CODIGO_TRANSACAO = "' + ACodigoTransacao + '"';
  PdvPlanoPagamento := ConsultarObjetoFiltro(filtro);
  if Assigned(PdvPlanoPagamento) then
  begin
    if PdvPlanoPagamento.IdEmpresa > 0 then
    begin
      // achou o código da transação, mas o código já foi utilizado
      Result := 418;
    end
    else
    begin
      // achou o código da transação e não está vinculado a nenhuma empresa
      // vamos verificar se ela já foi paga - statusPagamento = 3
      if PdvPlanoPagamento.StatusPagamento = '3' then
      begin
        // vamos vincular o id da empresa e o e-mail de pagamento
        // retorna 200
        Filtro := 'CNPJ = "' + ACnpj + '"';
        Empresa := TEmpresaService.ConsultarObjetoFiltro(Filtro);
        Empresa.EmailPagamento := PdvPlanoPagamento.EmailPagamento;
        AlterarBase(Empresa, 'EMPRESA');

        PdvPlanoPagamento.IdEmpresa := Empresa.Id;
        AlterarBase(PdvPlanoPagamento, 'PDV_PLANO_PAGAMENTO');

        Result := 200;
      end
      else
      begin
        Result := 202;
      end;


    end;
  end
  else
  begin
    // não achou o código da transação, retorna 404
    Result := 404;
  end;
end;

class procedure TPdvPlanoPagamentoService.Inserir(APdvPlanoPagamento: TPdvPlanoPagamento);
begin
  APdvPlanoPagamento.ValidarInsercao;
  APdvPlanoPagamento.Id := InserirBase(APdvPlanoPagamento, 'PDV_PLANO_PAGAMENTO');
end;

class function TPdvPlanoPagamentoService.Alterar(APdvPlanoPagamento: TPdvPlanoPagamento): Integer;
begin
  APdvPlanoPagamento.ValidarAlteracao;
  Result := AlterarBase(APdvPlanoPagamento, 'PDV_PLANO_PAGAMENTO');
end;

class function TPdvPlanoPagamentoService.Atualizar(AObjetoPagSeguroEnviado: TObjetoPagSeguro): TPdvPlanoPagamento;
var
  PdvPlanoPagamento, PdvPlanoPagamentoDB: TPdvPlanoPagamento;
  TipoPlano: TPdvTipoPlano;
  Empresa: TEmpresa;
  Filtro, PlanoContratado, ModuloFiscal: string;
begin
  // primeiro verifica se já existe um registro armazenado para a transação, pois neste caso iremos apenas atualizar o registro
  Filtro := 'CODIGO_TRANSACAO = "' + AObjetoPagSeguroEnviado.CodigoTransacao + '"';
  PdvPlanoPagamentoDB := TPdvPlanoPagamentoService.ConsultarObjetoFiltro(Filtro);
  if Assigned(PdvPlanoPagamentoDB) then
  begin
    // atualiza o status
    PdvPlanoPagamentoDB.StatusPagamento := AObjetoPagSeguroEnviado.CodigoStatusTransacao;

    // se o status for pago, então atualiza a data de pagamento e de expiração do plano
    if PdvPlanoPagamentoDB.StatusPagamento = '3' then
    begin
      PdvPlanoPagamentoDB.DataPagamento := now;
      case AnsiIndexStr(PdvPlanoPagamentoDB.Plano, ['M', 'S', 'A']) of
        0 : PdvPlanoPagamentoDB.DataPlanoExpira := now + 30;
        1 : PdvPlanoPagamentoDB.DataPlanoExpira := now + 180;
        2 : PdvPlanoPagamentoDB.DataPlanoExpira := now + 365;
      end;
    end
    else
    begin
      PdvPlanoPagamentoDB.DataPagamento := 0;
      PdvPlanoPagamentoDB.DataPlanoExpira := 0;
    end;

    AlterarBase(PdvPlanoPagamentoDB, 'PDV_PLANO_PAGAMENTO');
    result := PdvPlanoPagamentoDB;
  end
  else
  begin
    // a falta de registro no banco indica que devemos criar um novo registro no banco de dados
    // que só será inserido se tiver vindo um tipo de plano válido na requisição
    PlanoContratado := Biblioteca.PegarPlanoPdv(AObjetoPagSeguroEnviado.DescricaoProduto);
    ModuloFiscal := Biblioteca.PegarModuloFiscalPdv(AObjetoPagSeguroEnviado.DescricaoProduto);
    Filtro := 'PLANO = "' + PlanoContratado + '" AND MODULO_FISCAL = "' + ModuloFiscal + '"';
    TipoPlano := TPdvTipoPlanoService.ConsultarObjetoFiltro(Filtro);
    if Assigned(TipoPlano) then
    begin
      PdvPlanoPagamento := TPdvPlanoPagamento.Create;
      PdvPlanoPagamento.IdPdvTipoPlano := TipoPlano.Id;
      PdvPlanoPagamento.CodigoTransacao := AObjetoPagSeguroEnviado.CodigoTransacao;
      PdvPlanoPagamento.StatusPagamento := AObjetoPagSeguroEnviado.CodigoStatusTransacao;
      PdvPlanoPagamento.MetodoPagamento := AObjetoPagSeguroEnviado.MetodoPagamento;
      PdvPlanoPagamento.CodigoTipoPagamento := AObjetoPagSeguroEnviado.CodigoTipoPagamento;
      PdvPlanoPagamento.Valor := AObjetoPagSeguroEnviado.ValorUnitario;
      PdvPlanoPagamento.emailPagamento := AObjetoPagSeguroEnviado.EmailCliente;
      PdvPlanoPagamento.DataSolicitacao := now;
      PdvPlanoPagamento.Plano := PlanoContratado;

      // se o status for pago, então atualiza a data de pagamento e de expiração do plano
      if AObjetoPagSeguroEnviado.CodigoStatusTransacao = '3' then
      begin
        PdvPlanoPagamento.DataPagamento := now;
        case AnsiIndexStr(PlanoContratado, ['M', 'S', 'A']) of
        0 : PdvPlanoPagamento.DataPlanoExpira := now + 30;
        1 : PdvPlanoPagamento.DataPlanoExpira := now + 180;
        2 : PdvPlanoPagamento.DataPlanoExpira := now + 365;
        end;
      end;

      // tenta encontrar a empresa pelo e-mail - se não encontrar, o usuário terá
      // que informar o código da transação na App para reconhecer o seu pagamento
      Filtro := 'EMAIL = "' + AObjetoPagSeguroEnviado.EmailCliente + '"';
      Empresa := TEmpresaService.ConsultarObjetoFiltro(filtro);
      if Assigned(Empresa) then
      begin
        PdvPlanoPagamento.IdEmpresa := Empresa.Id;
      end;

      InserirBase(PdvPlanoPagamento, 'PDV_PLANO_PAGAMENTO');
      result := PdvPlanoPagamento;
    end
    else
    begin
      result := nil;
    end;
  end;
end;

class function TPdvPlanoPagamentoService.Excluir(APdvPlanoPagamento: TPdvPlanoPagamento): Integer;
begin
  APdvPlanoPagamento.ValidarExclusao;
  
  Result := ExcluirBase(APdvPlanoPagamento.Id, 'PDV_PLANO_PAGAMENTO');
end;


end.
