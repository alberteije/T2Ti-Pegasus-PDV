import 'package:moor/moor.dart';

import 'package:pegasus_pdv/src/database/database.dart';

class MigracaoParaSchema4 extends DatabaseAccessor<AppDatabase> {

  final AppDatabase db;
  MigracaoParaSchema4(this.db) : super(db);

  // pega referencia das tabelas existentes
  $PdvConfiguracaosTable get pdvConfiguracaos => attachedDatabase.pdvConfiguracaos;
  $PdvTipoPagamentosTable get pdvTipoPagamentos => attachedDatabase.pdvTipoPagamentos;
  $NfeConfiguracaosTable get nfeConfiguracaos => attachedDatabase.nfeConfiguracaos;
  $NfeCabecalhosTable get nfeCabecalhos => attachedDatabase.nfeCabecalhos;
  $EmpresasTable get empresas => attachedDatabase.empresas;
  
  // pega referencia das novas tabelas
  $NfcePlanoPagamentosTable get	nfcePlanoPagamentos => attachedDatabase.nfcePlanoPagamentos;

  Future<void> migrarParaSchema4(Migrator m, int from, int to) async {
    // adicionando novas colunas em tabelas existentes
    await m.addColumn(pdvConfiguracaos, pdvConfiguracaos.moduloFiscalPrincipal);        
    await m.addColumn(pdvConfiguracaos, pdvConfiguracaos.moduloFiscalContingencia);        
    await m.addColumn(pdvConfiguracaos, pdvConfiguracaos.acbrMonitorEndereco);        
    await m.addColumn(pdvConfiguracaos, pdvConfiguracaos.acbrMonitorPorta);        
    await m.addColumn(pdvTipoPagamentos, pdvTipoPagamentos.codigoPagamentoNfce);        
    await m.addColumn(nfeConfiguracaos, nfeConfiguracaos.respTecCnpj);        
    await m.addColumn(nfeConfiguracaos, nfeConfiguracaos.respTecContato);        
    await m.addColumn(nfeConfiguracaos, nfeConfiguracaos.respTecEmail);        
    await m.addColumn(nfeConfiguracaos, nfeConfiguracaos.respTecFone);        
    await m.addColumn(nfeConfiguracaos, nfeConfiguracaos.respTecIdCsrt);        
    await m.addColumn(nfeConfiguracaos, nfeConfiguracaos.respTecHashCsrt);        
    await m.addColumn(nfeConfiguracaos, nfeConfiguracaos.nfceResolucaoImpressao);        
    await m.addColumn(nfeConfiguracaos, nfeConfiguracaos.nfceTamanhoFonteItem);        
    await m.addColumn(nfeCabecalhos, nfeCabecalhos.idPdvVendaCabecalho);    
    await m.addColumn(empresas, empresas.naturezaJuridica); 
    await m.addColumn(empresas, empresas.emailPagamento); 
    await m.addColumn(empresas, empresas.simei); 
    await m.addColumn(empresas, empresas.dataRegistro); 
    await m.addColumn(empresas, empresas.horaRegistro); 

    // criando novas tabelas
    await m.createTable(nfcePlanoPagamentos);        
  }
}