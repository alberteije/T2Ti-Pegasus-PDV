import 'package:moor/moor.dart';

import 'package:pegasus_pdv/src/database/database.dart';

class MigracaoParaSchema4 extends DatabaseAccessor<AppDatabase> {

  final AppDatabase db;
  MigracaoParaSchema4(this.db) : super(db);

  // pega referencia das tabelas existentes
  $PdvConfiguracaosTable get pdvConfiguracaos => attachedDatabase.pdvConfiguracaos;
  $PdvTipoPagamentosTable get pdvTipoPagamentos => attachedDatabase.pdvTipoPagamentos;
  $NfeConfiguracaosTable get nfeConfiguracaos => attachedDatabase.nfeConfiguracaos;
  
  Future<void> migrarParaSchema4(Migrator m, int from, int to) async {
    // adicionando novas colunas em tabelas existentes
    await m.addColumn(pdvConfiguracaos, pdvConfiguracaos.moduloFiscalPrincipal);        
    await m.addColumn(pdvConfiguracaos, pdvConfiguracaos.moduloFiscalContingencia);        
    await m.addColumn(pdvTipoPagamentos, pdvTipoPagamentos.codigoPagamentoNfce);        
    await m.addColumn(nfeConfiguracaos, nfeConfiguracaos.respTecCnpj);        
    await m.addColumn(nfeConfiguracaos, nfeConfiguracaos.respTecContato);        
    await m.addColumn(nfeConfiguracaos, nfeConfiguracaos.respTecEmail);        
    await m.addColumn(nfeConfiguracaos, nfeConfiguracaos.respTecFone);        
    await m.addColumn(nfeConfiguracaos, nfeConfiguracaos.respTecIdCsrt);        
    await m.addColumn(nfeConfiguracaos, nfeConfiguracaos.respTecHashCsrt);        
  }
}