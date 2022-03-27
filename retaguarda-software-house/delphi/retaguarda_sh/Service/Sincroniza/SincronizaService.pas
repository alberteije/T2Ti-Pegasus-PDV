{*******************************************************************************
Title: T2Ti ERP Fenix
Description: Service relacionado a sincronização dos dados

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
unit SincronizaService;

interface

uses
  Empresa, ServiceBase,
  MVCFramework.Serializer.Defaults, MVCFramework.DataSet.Utils,
  System.Classes, System.SysUtils, System.Generics.Collections,
  StrUtils, TypInfo,
  FireDAC.Comp.Client, FireDAC.Phys.SQLite, FireDAC.Phys.MySQL,
  FireDAC.Comp.BatchMove, FireDAC.Comp.BatchMove.DataSet;

type
  TTabelaCentral = (
    TRIBUT_ICMS_CUSTOM_CAB,
    TRIBUT_ICMS_CUSTOM_DET,
    TRIBUT_OPERACAO_FISCAL,
    TRIBUT_GRUPO_TRIBUTARIO,
    TRIBUT_CONFIGURA_OF_GT,
    TRIBUT_COFINS,
    TRIBUT_ICMS_UF,
    TRIBUT_IPI,
    TRIBUT_ISS,
    TRIBUT_PIS,
    CLIENTE,
    COLABORADOR,
    FORNECEDOR,
    PRODUTO_GRUPO,
    PRODUTO_SUBGRUPO,
    PRODUTO_TIPO,
    PRODUTO_UNIDADE,
    PRODUTO,
    PRODUTO_FICHA_TECNICA,
    PRODUTO_IMAGEM,
    PDV_TIPO_PAGAMENTO,
    PRODUTO_PROMOCAO,
    COMPRA_PEDIDO_CABECALHO,
    COMPRA_PEDIDO_DETALHE,
    CONTAS_PAGAR,
    CONTAS_RECEBER
  );

  TTabelaLocal = (
    PDV_MOVIMENTO,
    PDV_FECHAMENTO,
    PDV_SANGRIA,
    PDV_SUPRIMENTO,
    PDV_VENDA_CABECALHO,
    PDV_VENDA_DETALHE,
    PDV_TOTAL_TIPO_PAGAMENTO,
    NFE_CABECALHO,
    NFE_DESTINATARIO,
    NFE_DETALHE,
    NFE_DETALHE_IMPOSTO_COFINS,
    NFE_DETALHE_IMPOSTO_ICMS,
    NFE_DETALHE_IMPOSTO_PIS,
    NFE_INFORMACAO_PAGAMENTO,
    NFE_NUMERO,
    NFE_NUMERO_INUTILIZADO
  );

  TSincronizaService = class(TServiceBase)
  private
  public
    class procedure SincronizarServidor(ABancoSQLite64: AnsiString; ACnpj: string);
    class procedure ArmazenarMovimento(ABancoSQLite64: AnsiString; ACnpj: string; AIdMovimento: string; AIdDispositivo: string);
    class function SincronizarCliente(ACnpj: string): string;
  end;

var
  CaminhoComCnpj: string;
  Empresa: TEmpresa;

implementation

{ TSincronizaService }

uses
  Biblioteca, Constantes, EmpresaService, ObjetoSincroniza,
  Cliente,
  Colaborador,
  CompraPedidoCabecalho,
  CompraPedidoDetalhe,
  ContasPagar,
  ContasReceber,
  Fornecedor,
  PdvTipoPagamento,
  Produto,
  ProdutoFichaTecnica,
  ProdutoGrupo,
  ProdutoImagem,
  ProdutoPromocao,
  ProdutoSubgrupo,
  ProdutoTipo,
  ProdutoUnidade,
  TributCofins,
  TributConfiguraOfGt,
  TributGrupoTributario,
  TributIcmsCustomCab,
  TributIcmsCustomDet,
  TributIcmsUf,
  TributIpi,
  TributIss,
  TributOperacaoFiscal,
  TributPis
  ;

class procedure TSincronizaService.SincronizarServidor(ABancoSQLite64: AnsiString; ACnpj: string);
var
  Filtro, CaminhoArquivoSQLite, NomeTabela: string;
  ConexaoSQLite, ConexaoMySQL: TFDConnection;
  QuerySQLite, QueryMySQL: TFDQuery;
  BatchMove: TFDBatchMove;
  Reader: TFDBatchMoveDataSetReader;
  Writer: TFDBatchMoveDataSetWriter;
  I: Integer;
begin
  Filtro := 'CNPJ = "' + ACnpj + '"';
  Empresa := TEmpresaService.ConsultarObjetoFiltro(filtro);
  if Assigned(Empresa) then
  begin
    // configura os caminhos
    CaminhoComCnpj := 'C:\ACBrMonitor\' + Empresa.Cnpj + '\';
    CaminhoArquivoSQLite := CaminhoComCnpj + 'sqlite\' + Empresa.Cnpj + '.sqlite';

    // salva o arquivo base64 em disco
    Biblioteca.DecodeFileBase64(ABancoSQLite64, CaminhoArquivoSQLite);

    // sincroniza dados
    ConexaoSQLite := TFDConnection.Create(nil);
    QuerySQLite := TFDQuery.Create(nil);
    QuerySQLite.Connection := ConexaoSQLite;

    ConexaoMySQL := TFDConnection.Create(nil);
    QueryMySQL := TFDQuery.Create(nil);
    QueryMySQL.Connection := ConexaoMySQL;

    BatchMove := TFDBatchMove.Create(nil);
    BatchMove.Mode := dmAppendUpdate;
    Reader := TFDBatchMoveDataSetReader.Create(nil);
    Writer := TFDBatchMoveDataSetWriter.Create(nil);

    try
      ConexaoSQLite.Connected := False;
      ConexaoSQLite.Params.Clear;
      ConexaoSQLite.Params.Add('DriverID=SQLite');
      ConexaoSQLite.Params.Add('Database=' + CaminhoArquivoSQLite);
      ConexaoSQLite.Connected := True;

      ConexaoMySQL.Connected := False;
      ConexaoMySQL.Params.Clear;
      ConexaoMySQL.Params.Add('DriverID=MySQL');
      ConexaoMySQL.Params.Add('Server=' + TConstantes.BD_SERVER);
      ConexaoMySQL.Params.Add('Port=3306');
      ConexaoMySQL.Params.Add('Database=pegasus_' + ACnpj);
      ConexaoMySQL.Params.Add('CharacterSet=utf8');
      ConexaoMySQL.Params.Add('User_Name=' + TConstantes.BD_USUARIO);
      ConexaoMySQL.Params.Add('Password=' + TConstantes.BD_SENHA);
      ConexaoMySQL.DriverName := 'MySQL';
      ConexaoMySQL.Connected := True;

      for I := Ord(Low(TTabelaCentral)) to Ord(High(TTabelaCentral)) do
      begin
        NomeTabela := GetEnumName(TypeInfo(TTabelaCentral), I);

        // atualiza os dados no banco MySQL usando BatchMove
        QuerySQLite.Close;
        QuerySQLite.SQL.Text := 'select * from ' + NomeTabela;
        QuerySQLite.Open;

        QueryMySQL.Close;
        QueryMySQL.SQL.Text := 'select * from ' + NomeTabela;
        QueryMySQL.Open;

        Reader.DataSet := QuerySQLite;
        Writer.DataSet := QueryMySQL;

        BatchMove.Reader := Reader;
        BatchMove.Writer := Writer;

        BatchMove.Execute;
      end;
    finally
      QuerySQLite.Free;
      ConexaoSQLite.Free;
      QueryMySQL.Free;
      ConexaoMySQL.Free;
      BatchMove.Free;
      Reader.Free;
      Writer.Free;
    end;

  end;
end;

class procedure TSincronizaService.ArmazenarMovimento(ABancoSQLite64: AnsiString; ACnpj: string; AIdMovimento: string; AIdDispositivo: string);
var
  Filtro, CaminhoArquivoSQLite, NomeTabela: string;
  ConexaoSQLite, ConexaoMySQL: TFDConnection;
  QuerySQLite, QueryMySQL: TFDQuery;
  I, J: Integer;
begin
  Filtro := 'CNPJ = "' + ACnpj + '"';
  Empresa := TEmpresaService.ConsultarObjetoFiltro(filtro);
  if Assigned(Empresa) then
  begin
    // configura os caminhos
    CaminhoComCnpj := 'C:\ACBrMonitor\' + Empresa.Cnpj + '\';
    CaminhoArquivoSQLite := CaminhoComCnpj + 'sqlite\' + AIdDispositivo + '.sqlite';

    // salva o arquivo base64 em disco
    Biblioteca.DecodeFileBase64(ABancoSQLite64, CaminhoArquivoSQLite);

    // sincroniza dados
    ConexaoSQLite := TFDConnection.Create(nil);
    QuerySQLite := TFDQuery.Create(nil);
    QuerySQLite.Connection := ConexaoSQLite;

    ConexaoMySQL := TFDConnection.Create(nil);
    QueryMySQL := TFDQuery.Create(nil);
    QueryMySQL.Connection := ConexaoMySQL;

    try
      ConexaoSQLite.Connected := False;
      ConexaoSQLite.Params.Clear;
      ConexaoSQLite.Params.Add('DriverID=SQLite');
      ConexaoSQLite.Params.Add('Database=' + CaminhoArquivoSQLite);
      ConexaoSQLite.Connected := True;

      ConexaoMySQL.Connected := False;
      ConexaoMySQL.Params.Clear;
      ConexaoMySQL.Params.Add('DriverID=MySQL');
      ConexaoMySQL.Params.Add('Server=' + TConstantes.BD_SERVER);
      ConexaoMySQL.Params.Add('Port=3306');
      ConexaoMySQL.Params.Add('Database=pegasus_' + ACnpj);
      ConexaoMySQL.Params.Add('CharacterSet=utf8');
      ConexaoMySQL.Params.Add('User_Name=' + TConstantes.BD_USUARIO);
      ConexaoMySQL.Params.Add('Password=' + TConstantes.BD_SENHA);
      ConexaoMySQL.DriverName := 'MySQL';
      ConexaoMySQL.Connected := True;
      ConexaoMySQL.UpdateOptions.CountUpdatedRecords := False;

      for I := Ord(Low(TTabelaLocal)) to Ord(High(TTabelaLocal)) do
      begin
        NomeTabela := GetEnumName(TypeInfo(TTabelaLocal), I);

        // apaga os dados daquele dispositivo
        QueryMySQL.Close;
        QueryMySQL.SQL.Text := 'delete from ' + NomeTabela + ' where ID_DISPOSITIVO = "' + AIdDispositivo + '"';
        QueryMySQL.ExecSQL;

        // abre a tabela do MySQL
        QueryMySQL.Close;
        QueryMySQL.SQL.Text := 'select * from ' + NomeTabela;
        QueryMySQL.Active := True;

        // atualiza os dados no banco MySQL
        QuerySQLite.Close;
        QuerySQLite.SQL.Text := 'select * from ' + NomeTabela;
        QuerySQLite.Active := True;
        QuerySQLite.First;
        while not QuerySQLite.Eof do
        begin
          QueryMySQL.Append;
          for J := 0 to QuerySQLite.FieldCount  - 1 do
          begin
            QueryMySQL.Fields[J].Value := QuerySQLite.Fields[J].Value;
          end;
          QueryMySQL.FieldByName('ID_GERADO_DISPOSITIVO').AsString := QuerySQLite.FieldByName('ID').AsString;
          QueryMySQL.FieldByName('ID_DISPOSITIVO').AsString := AIdDispositivo;
          QueryMySQL.Post;
          QuerySQLite.Next;
        end;
      end;
    finally
      QuerySQLite.Free;
      ConexaoSQLite.Free;
      QueryMySQL.Free;
      ConexaoMySQL.Free;
    end;

  end;
end;

class function TSincronizaService.SincronizarCliente(ACnpj: string): string;
var
  Filtro, NomeTabela, ListaJsonString: string;
  ConexaoMySQL: TFDConnection;
  QueryMySQL: TFDQuery;
  I: Integer;
  ListaRetorno: TObjectList<TObjetoSincroniza>;
  ObjSincroniza: TObjetoSincroniza;
begin
  Filtro := 'CNPJ = "' + ACnpj + '"';
  Empresa := TEmpresaService.ConsultarObjetoFiltro(filtro);
  if Assigned(Empresa) then
  begin
    // configura a conexão com o banco da empresa
    ConexaoMySQL := TFDConnection.Create(nil);
    QueryMySQL := TFDQuery.Create(nil);
    QueryMySQL.Connection := ConexaoMySQL;

    try
      ConexaoMySQL.Connected := False;
      ConexaoMySQL.Params.Clear;
      ConexaoMySQL.Params.Add('DriverID=MySQL');
      ConexaoMySQL.Params.Add('Server=' + TConstantes.BD_SERVER);
      ConexaoMySQL.Params.Add('Port=3306');
      ConexaoMySQL.Params.Add('Database=pegasus_' + ACnpj);
      ConexaoMySQL.Params.Add('CharacterSet=utf8');
      ConexaoMySQL.Params.Add('User_Name=' + TConstantes.BD_USUARIO);
      ConexaoMySQL.Params.Add('Password=' + TConstantes.BD_SENHA);
      ConexaoMySQL.DriverName := 'MySQL';
      ConexaoMySQL.Connected := True;

      ListaRetorno := TObjectList<TObjetoSincroniza>.Create();
      for I := Ord(Low(TTabelaCentral)) to Ord(High(TTabelaCentral)) do
      begin
        NomeTabela := GetEnumName(TypeInfo(TTabelaCentral), I);
        sql := 'select * from ' + NomeTabela;

        QueryMySQL.Open(sql);

        ObjSincroniza := TObjetoSincroniza.Create;
        ObjSincroniza.Tabela := NomeTabela;

        case AnsiIndexStr(NomeTabela, [
          'TRIBUT_ICMS_CUSTOM_CAB',
          'TRIBUT_ICMS_CUSTOM_DET',
          'TRIBUT_OPERACAO_FISCAL',
          'TRIBUT_GRUPO_TRIBUTARIO',
          'TRIBUT_CONFIGURA_OF_GT',
          'TRIBUT_COFINS',
          'TRIBUT_ICMS_UF',
          'TRIBUT_IPI',
          'TRIBUT_ISS',
          'TRIBUT_PIS',
          'CLIENTE',
          'COLABORADOR',
          'FORNECEDOR',
          'PRODUTO_GRUPO',
          'PRODUTO_SUBGRUPO',
          'PRODUTO_TIPO',
          'PRODUTO_UNIDADE',
          'PRODUTO',
          'PRODUTO_FICHA_TECNICA',
          'PRODUTO_IMAGEM',
          'PDV_TIPO_PAGAMENTO',
          'PRODUTO_PROMOCAO',
          'COMPRA_PEDIDO_CABECALHO',
          'COMPRA_PEDIDO_DETALHE',
          'CONTAS_PAGAR',
          'CONTAS_RECEBER']
          ) of
            0  : ObjSincroniza.Registros := GetDefaultSerializer.SerializeCollection( QueryMySQL.AsObjectList<TTributIcmsCustomCab> );
            1  : ObjSincroniza.Registros := GetDefaultSerializer.SerializeCollection( QueryMySQL.AsObjectList<TTributIcmsCustomDet> );
            2  : ObjSincroniza.Registros := GetDefaultSerializer.SerializeCollection( QueryMySQL.AsObjectList<TTributOperacaoFiscal> );
            3  : ObjSincroniza.Registros := GetDefaultSerializer.SerializeCollection( QueryMySQL.AsObjectList<TTributGrupoTributario> );
            4  : ObjSincroniza.Registros := GetDefaultSerializer.SerializeCollection( QueryMySQL.AsObjectList<TTributConfiguraOfGt> );
            5  : ObjSincroniza.Registros := GetDefaultSerializer.SerializeCollection( QueryMySQL.AsObjectList<TTributCofins> );
            6  : ObjSincroniza.Registros := GetDefaultSerializer.SerializeCollection( QueryMySQL.AsObjectList<TTributIcmsUf> );
            7  : ObjSincroniza.Registros := GetDefaultSerializer.SerializeCollection( QueryMySQL.AsObjectList<TTributIpi> );
            8  : ObjSincroniza.Registros := GetDefaultSerializer.SerializeCollection( QueryMySQL.AsObjectList<TTributIss> );
            9  : ObjSincroniza.Registros := GetDefaultSerializer.SerializeCollection( QueryMySQL.AsObjectList<TTributPis> );
            10 : ObjSincroniza.Registros := GetDefaultSerializer.SerializeCollection( QueryMySQL.AsObjectList<TCliente> );
            11 : ObjSincroniza.Registros := GetDefaultSerializer.SerializeCollection( QueryMySQL.AsObjectList<TColaborador> );
            12 : ObjSincroniza.Registros := GetDefaultSerializer.SerializeCollection( QueryMySQL.AsObjectList<TFornecedor> );
            13 : ObjSincroniza.Registros := GetDefaultSerializer.SerializeCollection( QueryMySQL.AsObjectList<TProdutoGrupo> );
            14 : ObjSincroniza.Registros := GetDefaultSerializer.SerializeCollection( QueryMySQL.AsObjectList<TProdutoSubgrupo> );
            15 : ObjSincroniza.Registros := GetDefaultSerializer.SerializeCollection( QueryMySQL.AsObjectList<TProdutoTipo> );
            16 : ObjSincroniza.Registros := GetDefaultSerializer.SerializeCollection( QueryMySQL.AsObjectList<TProdutoUnidade> );
            17 : ObjSincroniza.Registros := GetDefaultSerializer.SerializeCollection( QueryMySQL.AsObjectList<TProduto> );
            18 : ObjSincroniza.Registros := GetDefaultSerializer.SerializeCollection( QueryMySQL.AsObjectList<TProdutoFichaTecnica> );
            19 : ObjSincroniza.Registros := GetDefaultSerializer.SerializeCollection( QueryMySQL.AsObjectList<TProdutoImagem> );
            20 : ObjSincroniza.Registros := GetDefaultSerializer.SerializeCollection( QueryMySQL.AsObjectList<TPdvTipoPagamento> );
            21 : ObjSincroniza.Registros := GetDefaultSerializer.SerializeCollection( QueryMySQL.AsObjectList<TProdutoPromocao> );
            22 : ObjSincroniza.Registros := GetDefaultSerializer.SerializeCollection( QueryMySQL.AsObjectList<TCompraPedidoCabecalho> );
            23 : ObjSincroniza.Registros := GetDefaultSerializer.SerializeCollection( QueryMySQL.AsObjectList<TCompraPedidoDetalhe> );
            24 : ObjSincroniza.Registros := GetDefaultSerializer.SerializeCollection( QueryMySQL.AsObjectList<TContasPagar> );
            25 : ObjSincroniza.Registros := GetDefaultSerializer.SerializeCollection( QueryMySQL.AsObjectList<TContasReceber> );
        end;
        ListaRetorno.Add(ObjSincroniza);
      end;

      Result := GetDefaultSerializer.SerializeCollection(ListaRetorno);
    finally
      QueryMySQL.Free;
      ConexaoMySQL.Free;
    end;

  end;
end;

end.
