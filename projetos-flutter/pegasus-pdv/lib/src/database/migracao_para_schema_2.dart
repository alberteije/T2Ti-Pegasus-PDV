import 'package:moor/moor.dart';

import 'package:pegasus_pdv/src/database/database.dart';

class MigracaoParaSchema2 extends DatabaseAccessor<AppDatabase> {

  final AppDatabase db;
  MigracaoParaSchema2(this.db) : super(db);

  // pega referencia das tabelas existentes
  $PdvVendaCabecalhosTable get pdvVendaCabecalhos => attachedDatabase.pdvVendaCabecalhos;
  $ContasRecebersTable get contasRecebers => attachedDatabase.contasRecebers;
  $PdvConfiguracaosTable get pdvConfiguracaos => attachedDatabase.pdvConfiguracaos;

  // pega referencia das novas tabelas
  $NfeAcessoXmlsTable get	nfeAcessoXmls => attachedDatabase.nfeAcessoXmls;
  $NfeCabecalhosTable get nfeCabecalhos => attachedDatabase.nfeCabecalhos;
  $NfeCanasTable get nfeCanas => attachedDatabase.nfeCanas;
  $NfeCanaDeducoesSafrasTable get nfeCanaDeducoesSafras => attachedDatabase.nfeCanaDeducoesSafras; 
  $NfeCanaFornecimentoDiariosTable get nfeCanaFornecimentoDiarios => attachedDatabase.nfeCanaFornecimentoDiarios;
  $NfeConfiguracaosTable get nfeConfiguracaos => attachedDatabase.nfeConfiguracaos;
  $NfeCteReferenciadosTable get nfeCteReferenciados => attachedDatabase.nfeCteReferenciados;
  $NfeCupomFiscalReferenciadosTable get nfeCupomFiscalReferenciados => attachedDatabase.nfeCupomFiscalReferenciados; 
  $NfeDeclaracaoImportacaosTable get nfeDeclaracaoImportacaos => attachedDatabase.nfeDeclaracaoImportacaos;
  $NfeDestinatariosTable get nfeDestinatarios => attachedDatabase.nfeDestinatarios;
  $NfeDetEspecificoArmamentosTable get nfeDetEspecificoArmamentos => attachedDatabase.nfeDetEspecificoArmamentos;
  $NfeDetEspecificoCombustivelsTable get nfeDetEspecificoCombustivels => attachedDatabase.nfeDetEspecificoCombustivels;
  $NfeDetEspecificoMedicamentosTable get nfeDetEspecificoMedicamentos => attachedDatabase.nfeDetEspecificoMedicamentos;
  $NfeDetEspecificoVeiculosTable get nfeDetEspecificoVeiculos => attachedDatabase.nfeDetEspecificoVeiculos;
  $NfeDetalhesTable get nfeDetalhes => attachedDatabase.nfeDetalhes;
  $NfeDetalheImpostoCofinssTable get nfeDetalheImpostoCofinss => attachedDatabase.nfeDetalheImpostoCofinss; 
  $NfeDetalheImpostoCofinsStsTable get nfeDetalheImpostoCofinsSts => attachedDatabase.nfeDetalheImpostoCofinsSts;
  $NfeDetalheImpostoIcmssTable get nfeDetalheImpostoIcmss => attachedDatabase.nfeDetalheImpostoIcmss;
  $NfeDetalheImpostoIcmsUfdestsTable get nfeDetalheImpostoIcmsUfdests => attachedDatabase.nfeDetalheImpostoIcmsUfdests;
  $NfeDetalheImpostoIisTable get nfeDetalheImpostoIis => attachedDatabase.nfeDetalheImpostoIis; 
  $NfeDetalheImpostoIpisTable get nfeDetalheImpostoIpis => attachedDatabase.nfeDetalheImpostoIpis;
  $NfeDetalheImpostoIssqnsTable get nfeDetalheImpostoIssqns => attachedDatabase.nfeDetalheImpostoIssqns;
  $NfeDetalheImpostoPissTable get nfeDetalheImpostoPiss => attachedDatabase.nfeDetalheImpostoPiss;
  $NfeDetalheImpostoPisStsTable get nfeDetalheImpostoPisSts => attachedDatabase.nfeDetalheImpostoPisSts; 
  $NfeDuplicatasTable get nfeDuplicatas => attachedDatabase.nfeDuplicatas;
  $NfeEmitentesTable get nfeEmitentes => attachedDatabase.nfeEmitentes;
  $NfeExportacaosTable get nfeExportacaos => attachedDatabase.nfeExportacaos;
  $NfeFaturasTable get nfeFaturas => attachedDatabase.nfeFaturas; 
  $NfeImportacaoDetalhesTable get nfeImportacaoDetalhes => attachedDatabase.nfeImportacaoDetalhes;
  $NfeInformacaoPagamentosTable get nfeInformacaoPagamentos => attachedDatabase.nfeInformacaoPagamentos;
  $NfeItemRastreadosTable get nfeItemRastreados => attachedDatabase.nfeItemRastreados;
  $NfeLocalEntregasTable get nfeLocalEntregas => attachedDatabase.nfeLocalEntregas; 
  $NfeLocalRetiradasTable get nfeLocalRetiradas => attachedDatabase.nfeLocalRetiradas;
  $NfeNfReferenciadasTable get nfeNfReferenciadas => attachedDatabase.nfeNfReferenciadas;
  $NfeNumerosTable get nfeNumeros => attachedDatabase.nfeNumeros;
  $NfeNumeroInutilizadosTable get nfeNumeroInutilizados => attachedDatabase.nfeNumeroInutilizados; 
  $NfeProcessoReferenciadosTable get nfeProcessoReferenciados => attachedDatabase.nfeProcessoReferenciados;
  $NfeProdRuralReferenciadasTable get nfeProdRuralReferenciadas => attachedDatabase.nfeProdRuralReferenciadas;
  $NfeReferenciadasTable get nfeReferenciadas => attachedDatabase.nfeReferenciadas;
  $NfeResponsavelTecnicosTable get nfeResponsavelTecnicos => attachedDatabase.nfeResponsavelTecnicos; 
  $NfeTransportesTable get nfeTransportes => attachedDatabase.nfeTransportes;
  $NfeTransporteReboquesTable get nfeTransporteReboques => attachedDatabase.nfeTransporteReboques;
  $NfeTransporteVolumesTable get nfeTransporteVolumes => attachedDatabase.nfeTransporteVolumes;
  $NfeTransporteVolumeLacresTable get nfeTransporteVolumeLacres => attachedDatabase.nfeTransporteVolumeLacres; 
  $TributCofinssTable get tributCofinss => attachedDatabase.tributCofinss;
  $TributConfiguraOfGtsTable get tributConfiguraOfGts => attachedDatabase.tributConfiguraOfGts;
  $TributGrupoTributariosTable get tributGrupotributarios => attachedDatabase.tributGrupoTributarios;
  $TributIcmsCustomCabsTable get tributIcmsCustomCabs => attachedDatabase.tributIcmsCustomCabs; 
  $TributIcmsCustomDetsTable get tributIcmsCustomDets => attachedDatabase.tributIcmsCustomDets;
  $TributIcmsUfsTable get tributIcmsUfs => attachedDatabase.tributIcmsUfs;
  $TributIpisTable get tributIpis => attachedDatabase.tributIpis;
  $TributIsssTable get tributIsss => attachedDatabase.tributIsss; 
  $TributOperacaoFiscalsTable get tributOperacaoFiscals => attachedDatabase.tributOperacaoFiscals;
  $TributPissTable get tributPiss => attachedDatabase.tributPiss; 
  
  Future<void> migrarParaSchema2(Migrator m, int from, int to) async {
    // adicionando novas colunas em tabelas existentes
    await m.addColumn(pdvVendaCabecalhos, pdvVendaCabecalhos.tipoOperacao);        
    await m.addColumn(pdvConfiguracaos, pdvConfiguracaos.modulo);        
    await m.addColumn(pdvConfiguracaos, pdvConfiguracaos.plano);        
    await m.addColumn(pdvConfiguracaos, pdvConfiguracaos.planoValor);        
    await m.addColumn(pdvConfiguracaos, pdvConfiguracaos.planoSituacao);        
    await m.addColumn(pdvConfiguracaos, pdvConfiguracaos.reciboFormatoPagina);        
    await m.addColumn(pdvConfiguracaos, pdvConfiguracaos.reciboLarguraPagina);        
    await m.addColumn(pdvConfiguracaos, pdvConfiguracaos.reciboMargemPagina);        
    await m.addColumn(pdvConfiguracaos, pdvConfiguracaos.encerraMovimentoAuto);        
    await m.addColumn(pdvConfiguracaos, pdvConfiguracaos.permiteEstoqueNegativo);        
    await m.addColumn(contasRecebers, contasRecebers.idPdvVendaCabecalho);        
    
    // criando novas tabelas
    await m.createTable(nfeAcessoXmls);
    await m.createTable(nfeCabecalhos);
    await m.createTable(nfeCanas);
    await m.createTable(nfeCanaDeducoesSafras);
    await m.createTable(nfeCanaFornecimentoDiarios);
    await m.createTable(nfeConfiguracaos);
    await m.createTable(nfeCteReferenciados);
    await m.createTable(nfeCupomFiscalReferenciados);
    await m.createTable(nfeDeclaracaoImportacaos);
    await m.createTable(nfeDestinatarios);
    await m.createTable(nfeDetEspecificoArmamentos);
    await m.createTable(nfeDetEspecificoCombustivels);
    await m.createTable(nfeDetEspecificoMedicamentos);
    await m.createTable(nfeDetEspecificoVeiculos);
    await m.createTable(nfeDetalhes);
    await m.createTable(nfeDetalheImpostoCofinss);
    await m.createTable(nfeDetalheImpostoCofinsSts);
    await m.createTable(nfeDetalheImpostoIcmss);
    await m.createTable(nfeDetalheImpostoIcmsUfdests);
    await m.createTable(nfeDetalheImpostoIis);
    await m.createTable(nfeDetalheImpostoIpis);
    await m.createTable(nfeDetalheImpostoIssqns);
    await m.createTable(nfeDetalheImpostoPiss);
    await m.createTable(nfeDetalheImpostoPisSts);
    await m.createTable(nfeDuplicatas);
    await m.createTable(nfeEmitentes);
    await m.createTable(nfeExportacaos);
    await m.createTable(nfeFaturas);
    await m.createTable(nfeImportacaoDetalhes);
    await m.createTable(nfeInformacaoPagamentos);
    await m.createTable(nfeItemRastreados);
    await m.createTable(nfeLocalEntregas);
    await m.createTable(nfeLocalRetiradas);
    await m.createTable(nfeNfReferenciadas);
    await m.createTable(nfeNumeros);
    await m.createTable(nfeNumeroInutilizados);
    await m.createTable(nfeProcessoReferenciados);
    await m.createTable(nfeProdRuralReferenciadas);
    await m.createTable(nfeReferenciadas);
    await m.createTable(nfeResponsavelTecnicos);
    await m.createTable(nfeTransportes);
    await m.createTable(nfeTransporteReboques);
    await m.createTable(nfeTransporteVolumes);
    await m.createTable(nfeTransporteVolumeLacres);
    await m.createTable(tributCofinss);
    await m.createTable(tributConfiguraOfGts);
    await m.createTable(tributGrupotributarios);
    await m.createTable(tributIcmsCustomCabs);
    await m.createTable(tributIcmsCustomDets);
    await m.createTable(tributIcmsUfs);
    await m.createTable(tributIpis);
    await m.createTable(tributIsss);
    await m.createTable(tributOperacaoFiscals);
    await m.createTable(tributPiss);
  }
}