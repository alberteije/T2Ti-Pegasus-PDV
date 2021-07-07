import 'package:moor/moor.dart';

import 'package:pegasus_pdv/src/database/database.dart';

class MigracaoParaSchema3 extends DatabaseAccessor<AppDatabase> {

  final AppDatabase db;
  MigracaoParaSchema3(this.db) : super(db);

  // pega referencia das tabelas existentes
  $ProdutosTable get produtoss => attachedDatabase.produtos;
  $PdvConfiguracaosTable get pdvConfiguracaos => attachedDatabase.pdvConfiguracaos;
  
  Future<void> migrarParaSchema3(Migrator m, int from, int to) async {
    // adicionando novas colunas em tabelas existentes
    await m.addColumn(produtoss, produtoss.idTributGrupoTributario);    
    await m.addColumn(pdvConfiguracaos, pdvConfiguracaos.idTributOperacaoFiscalPadrao);        
  }
}