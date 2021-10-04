/*
Title: T2Ti ERP 3.0
Description: Controller utilizado para a NFC-e
                                                                                
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
*******************************************************************************/
import 'dart:io';
import 'package:pegasus_pdv/src/database/database.dart';
import 'package:pegasus_pdv/src/database/database_classes.dart';
import 'package:pegasus_pdv/src/infra/infra.dart';
import 'package:ini/ini.dart';

class NfceController {

  static NfeCabecalhoMontado nfeCabecalhoMontado;
  static Config config; // para trabalhar com o conteúdo INI que retorna no ACBrMonitor
  static String _numeroMontado;
  static String _codigoNumericoMontado;
  static int _idNotaRecuperada;

  static Future<String> montarNfce() async{
    String nfceFormatoIni = '';
    nfceFormatoIni =  montarTagInfNFe() + 
                      montarTagIdentificacao() +
                      montarTagEmitente() +
                      montarTagDestinatario() +
                      montarTagProduto() +
                      montarTagTotal() +
                      montarTagTransportador() +
                      montarTagPagamento() +
                      montarTagResponsavelTecnico() + 
                      montarTagDadosAdicionais();
    return Future.value(nfceFormatoIni);
  }

  static Future<bool> gerarDadosNfceContingencia(String chaveAcesso) async {
    // atualizar a nota atual como off-line para posterior inutilização do número
    nfeCabecalhoMontado.nfeCabecalho = 
    nfeCabecalhoMontado.nfeCabecalho.copyWith(
      dataEntradaContingencia: DateTime.now(),
      justificativaContingencia: 'PROBLEMAS COM ACESSO AO WEBSERVICE',
    );
    await atualizarDadosNfce(chaveAcesso: chaveAcesso, statusNota: '9');

    // cria outra nota para emissão off-line
    Sessao.numeroNfce = await Sessao.db.nfeNumeroDao.consultarObjeto(1);
    final novoNumero = Sessao.numeroNfce.numero + 1;
    _numeroMontado = novoNumero.toString().padLeft(9, '0');
    _codigoNumericoMontado = '9' + novoNumero.toString().padLeft(7, '0');

    nfeCabecalhoMontado.nfeCabecalho = _clonarNfceCabecalho();

    Sessao.ultimoIniNfceEnviado = await montarNfce();

    final retorno = await _atualizarNota();
    return retorno;
  }

  static void instanciarNfceMontado() {
    nfeCabecalhoMontado = NfeCabecalhoMontado(
      nfeCabecalho: NfeCabecalho(id: null),
      nfeDestinatario: NfeDestinatario(id: null),
      listaNfeDetalheMontado: [],
      listaNfeInformacaoPagamento: [],
    );
  }

  static Future<bool> gerarDadosNfce() async {
    instanciarNfceMontado();

    // verfifica se já existe nfce vinculada à venda
    final cabecalho = await Sessao.db.nfeCabecalhoDao.consultarNotaPorVenda(Sessao.vendaAtual.id);

    if (cabecalho == null) {
      Sessao.numeroNfce= await Sessao.db.nfeNumeroDao.consultarObjeto(1);
      final novoNumero = Sessao.numeroNfce.numero + 1;
      _numeroMontado = novoNumero.toString().padLeft(9, '0');
      _codigoNumericoMontado = '9' + novoNumero.toString().padLeft(7, '0');
    } else {
      _numeroMontado = cabecalho.numero;
      _codigoNumericoMontado = cabecalho.codigoNumerico;
      _idNotaRecuperada = cabecalho.id;
    }

    // IDENTIFICACAO    
    nfeCabecalhoMontado.nfeCabecalho = nfeCabecalhoMontado.nfeCabecalho.copyWith(
      idPdvVendaCabecalho: Sessao.vendaAtual.id,
      numero: _numeroMontado,                                                           // nNF - 
      codigoNumerico: _codigoNumericoMontado,                                           // cNF
      serie: Sessao.numeroNfce.serie,                                                   // serie - 
      naturezaOperacao: 'VENDA',                                                        // natOp - venda
      codigoModelo: '65',                                                               // mod=65 - NFC-e
      dataHoraEmissao: DateTime.now(),                                                  // dhEmi
      tipoOperacao: '1',                                                                // tpNF - 1=saída
      consumidorOperacao: '1',                                                          // indFinal - 1=consumidor final
      consumidorPresenca: '1',                                                          // indPres - 1=operação presencial 
      localDestino: '1',                                                                // idDest - 1=operação interna
      formatoImpressaoDanfe: Sessao.configuracaoNfce.formatoImpressaoDanfe.toString(),  // tpimp - 4=DANCE NFC-e 5=DANFE NFC-e em mensagem eletrônica 
      ambiente: Sessao.configuracaoNfce.webserviceAmbiente.toString(),                  // tpAmb - 1=produção 2=homologação
      valorTotal: Sessao.vendaAtual.valorFinal,                                         // vNF
      baseCalculoIcms: Sessao.empresa.crt.substring(0, 1) == '1' ? 0 : Sessao.vendaAtual.valorBaseIcms,                                 // vBC
      valorTotalProdutos: Sessao.vendaAtual.valorVenda,                                 // vProd
      valorDesconto: Sessao.vendaAtual.valorDesconto,                                   // vDesc                        
      valorPis: 0,                                                                      // vPIS 
      valorCofins: 0,                                                                   // vCOFINS  
      ufEmitente: Sessao.empresa.codigoIbgeUf,                                          // cUF 
      codigoMunicipio: Sessao.empresa.codigoIbgeCidade,                                 // cMunFG 
      statusNota: cabecalho == null ? '0' : cabecalho.statusNota,                       // "0-Em Edição"-"1-Salva"-"2-Validada"-"3-Assinada"-"4-Autorizada"-"5-Inutilizada"        
    );

    // EMITENTE - Não precisa preencher a tabela, pegamos tudo da EMPRESA

    // DESTINATARIO
    Cliente cliente;
    if (Sessao.vendaAtual.idCliente != null) {
      cliente = await Sessao.db.clienteDao.consultarObjeto(Sessao.vendaAtual.idCliente);
    }
    nfeCabecalhoMontado.nfeDestinatario = nfeCabecalhoMontado.nfeDestinatario.copyWith(
      cpf: (Sessao.vendaAtual.cpfCnpjCliente ?? ''),                                    // CNPJCPF
      nome: (Sessao.vendaAtual.nomeCliente ?? ''),                                      // xNome
      // inscricaoEstadual: (cliente?.inscricaoEstadual ?? ''),                            // ie
      email: (cliente?.email ?? ''),                                                    // email
      logradouro: (cliente?.logradouro ?? ''),                                          // xLgr
      numero: (cliente?.numero ?? ''),                                                  // nro
      complemento: (cliente?.complemento ?? ''),                                        // xCpl
      bairro: (cliente?.bairro ?? ''),                                                  // xBairro
      codigoMunicipio: (cliente?.codigoIbgeCidade ?? 0),                                // cMun
      nomeMunicipio: (cliente?.cidade ?? ''),                                           // xMun
      uf: (cliente?.uf ?? ''),                                                          // UF
      cep: (cliente?.cep ?? ''),                                                        // CEP
      telefone: (cliente?.telefone ?? ''),                                              // fone
      codigoPais: 1058,                                                                 // cPais
      nomePais: 'BRASIL',                                                               // xPais
    );
    
    // PRODUTO
    for (var vendaDetalhe in Sessao.listaVendaAtualDetalhe) {
      final produtoMontado = await Sessao.db.produtoDao.consultarObjetoMontado(vendaDetalhe.produto.id);
      final tributacao = await Sessao.db.tributConfiguraOfGtDao.consultarObjetoMontado(
        Sessao.configuracaoPdv.idTributOperacaoFiscalPadrao, produtoMontado.tributGrupoTributario.id
      ); 

      // DETALHE
      NfeDetalheMontado nfceDetalheMontado = NfeDetalheMontado();
      NfeDetalhe nfceDetalhe = NfeDetalhe(
        id: null,
        cfop: tributacao.tributIcmsUf.cfop,                                                                   // cfop
        codigoProduto: produtoMontado.produto.id.toString(),                                                  // cProd
        nomeProduto: produtoMontado.produto.nome,                                                             // xProd
        ncm: (produtoMontado.produto.codigoNcm ?? '00000000'),                                                // NCM
        gtin: produtoMontado.produto.gtin == null ? 'SEM GTIN' : produtoMontado.produto.gtin,                 // cEAN
        gtinUnidadeTributavel: produtoMontado.produto.gtin == null ? 'SEM GTIN' : produtoMontado.produto.gtin,// cEANTrib
        unidadeComercial: produtoMontado.produtoUnidade.sigla,                                                // uCom
        unidadeTributavel: produtoMontado.produtoUnidade.sigla,                                               // uTrib
        quantidadeComercial: vendaDetalhe.pdvVendaDetalhe.quantidade,                                         // qCom
        quantidadeTributavel: vendaDetalhe.pdvVendaDetalhe.quantidade,                                        // qTrib
        valorUnitarioComercial: vendaDetalhe.pdvVendaDetalhe.valorUnitario,                                   // vUnCom
        valorUnitarioTributavel: vendaDetalhe.pdvVendaDetalhe.valorUnitario,                                  // vUnTrib
        valorDesconto: vendaDetalhe.pdvVendaDetalhe.valorDesconto,                                            // vDesc
        valorSubtotal: Biblioteca.multiplicarMonetario(                                                          // 
          vendaDetalhe.pdvVendaDetalhe.valorUnitario, vendaDetalhe.pdvVendaDetalhe.quantidade),
        valorBrutoProduto: Biblioteca.multiplicarMonetario(
          vendaDetalhe.pdvVendaDetalhe.valorUnitario, vendaDetalhe.pdvVendaDetalhe.quantidade),
        valorTotal: Biblioteca.multiplicarMonetario(                                                          // 
          vendaDetalhe.pdvVendaDetalhe.valorUnitario, vendaDetalhe.pdvVendaDetalhe.quantidade) 
          - (vendaDetalhe.pdvVendaDetalhe.valorDesconto ?? 0),
        entraTotal: '1',                                                                                      // indTot
        valorTotalTributos: vendaDetalhe.pdvVendaDetalhe.valorImpostoMunicipal + 
                            vendaDetalhe.pdvVendaDetalhe.valorImpostoEstadual + 
                            vendaDetalhe.pdvVendaDetalhe.valorImpostoFederal,
      );
      nfceDetalheMontado.nfeDetalhe = nfceDetalhe;
      
      // ICMS
      NfeDetalheImpostoIcms nfceDetalheImpostoIcms = NfeDetalheImpostoIcms(
        id: null,
        csosn: tributacao.tributIcmsUf.csosn,                                                                   // CSOSN
        cstIcms: tributacao.tributIcmsUf.cst,                                                                   // CST
        origemMercadoria: tributacao.tributGrupoTributario.origemMercadoria,                                    // orig 
        modalidadeBcIcms: tributacao.tributIcmsUf.modalidadeBc,                                                 // modBC
        valorBcIcms: Sessao.empresa.crt.substring(0, 1) == '1' ? 0 : vendaDetalhe.pdvVendaDetalhe.valorTotal,   // vBC
        aliquotaIcms: tributacao.tributIcmsUf.aliquota,                                                         // pICMS
        valorIcms: Biblioteca.multiplicarMonetario(                                                             // vICMS
                  vendaDetalhe.pdvVendaDetalhe.valorTotal, 
                  (tributacao.tributIcmsUf.aliquota ?? 0) / 100
        ),
      );
      nfceDetalheMontado.nfeDetalheImpostoIcms = nfceDetalheImpostoIcms;

      // PIS
      NfeDetalheImpostoPis nfceDetalheImpostoPis = NfeDetalheImpostoPis(
        id: null,
        cstPis: tributacao.tributPis.cstPis,                                    // CST
        valorBaseCalculoPis: 0,                                                 // vBC
        aliquotaPisPercentual: 0,                                               // pPIS 
        valorPis: 0,                                                            // vPIS
      );
      nfceDetalheMontado.nfeDetalheImpostoPis = nfceDetalheImpostoPis;

      // COFINS
      NfeDetalheImpostoCofins nfceDetalheImpostoCofins = NfeDetalheImpostoCofins(
        id: null,
        cstCofins: tributacao.tributCofins.cstCofins,                              // CST
        baseCalculoCofins: 0,                                                      // vBC
        aliquotaCofinsPercentual: 0,                                               // pCOFINS 
        valorCofins: 0,                                                            // vCOFINS
      );
      nfceDetalheMontado.nfeDetalheImpostoCofins = nfceDetalheImpostoCofins;

      // atualiza o cabeçalho
      nfeCabecalhoMontado.nfeCabecalho = nfeCabecalhoMontado.nfeCabecalho.copyWith(
        valorIcms: (nfeCabecalhoMontado.nfeCabecalho.valorIcms ?? 0) + nfceDetalheImpostoIcms.valorIcms,     // vICMS
        idTributOperacaoFiscal: tributacao.tributOperacaoFiscal.id,
        valorTotalTributos: (nfeCabecalhoMontado.nfeCabecalho.valorTotalTributos ?? 0) + nfceDetalheMontado.nfeDetalhe.valorTotalTributos,
      );

      nfeCabecalhoMontado.listaNfeDetalheMontado.add(nfceDetalheMontado);
    }

    // PAGAMENTO
    for (var pagamento in Sessao.listaDadosPagamento) {      
      final tipoFiltrado = Sessao.listaTipoPagamento.where( ((tipo) => tipo.id == pagamento.idPdvTipoPagamento)).toList();  
      final codigoPagamentoNfce = (tipoFiltrado[0]?.codigoPagamentoNfce ?? '01');
      NfeInformacaoPagamento nfceInformacaoPagamento = NfeInformacaoPagamento(
        id: null,
        indicadorPagamento: Sessao.listaParcelamento.length > 0 ? '1' : '0',      // indPag - 0= Pagamento à Vista 1= Pagamento à Prazo      
        meioPagamento: codigoPagamentoNfce,                                       // tPag
        valor: pagamento.valor,                                                   // vPag
        troco: codigoPagamentoNfce == '01' ? Sessao.vendaAtual.valorTroco : 0,    // vTroco
      );
      nfeCabecalhoMontado.listaNfeInformacaoPagamento.add(nfceInformacaoPagamento);
    }

    final retorno = await _atualizarNota();
    return retorno;
  }

  static Future<bool> _atualizarNota() async {
    var idNfceCabecalho;
    if (nfeCabecalhoMontado.nfeCabecalho.statusNota == '0') {
      idNfceCabecalho = await Sessao.db.nfeCabecalhoDao.inserir(nfeCabecalhoMontado); // só insere a nota se o seu status for '0'
    } else {
      idNfceCabecalho = _idNotaRecuperada; // venda está sendo recuperada e já existe uma nota armazenada no banco
    }
    if (idNfceCabecalho != null) { // inseriu ou está recuperando uma venda
      nfeCabecalhoMontado.nfeCabecalho = nfeCabecalhoMontado.nfeCabecalho.copyWith(
        id: idNfceCabecalho,
        statusNota: '1', // nota salva
      );
      await Sessao.db.nfeCabecalhoDao.alterar(nfeCabecalhoMontado, atualizaFilhos: true);
      return Future.value(true);
    } else {
      return Future.value(false);
    }
  }

  static String montarTagInfNFe() {
    return 
      ' [infNFe]\n'
      ' versao=4.00\n'
      ' \n';
  }

  static String montarTagIdentificacao() {
    return 
      ' [Identificacao]\n'
      ' nNF=' + nfeCabecalhoMontado.nfeCabecalho.numero + '\n'
      ' cNF=' + nfeCabecalhoMontado.nfeCabecalho.codigoNumerico + '\n'
      ' serie='+ nfeCabecalhoMontado.nfeCabecalho.serie +'\n'
      ' natOp=' + nfeCabecalhoMontado.nfeCabecalho.naturezaOperacao + '\n'
      ' mod=' + nfeCabecalhoMontado.nfeCabecalho.codigoModelo + '\n'
      ' dhEmi=' + Biblioteca.formatarDataHora(nfeCabecalhoMontado.nfeCabecalho.dataHoraEmissao) + '\n'
      ' tpNF=' + nfeCabecalhoMontado.nfeCabecalho.tipoOperacao + '\n'
      ' indFinal=' + nfeCabecalhoMontado.nfeCabecalho.consumidorOperacao + '\n'
      ' indPres=' + nfeCabecalhoMontado.nfeCabecalho.consumidorPresenca + '\n'
      ' idDest=' + nfeCabecalhoMontado.nfeCabecalho.localDestino + '\n'
      ' tpimp=' + nfeCabecalhoMontado.nfeCabecalho.formatoImpressaoDanfe + '\n'
      ' tpAmb=' + nfeCabecalhoMontado.nfeCabecalho.ambiente + '\n'
      ' dhCont=' + 
        (nfeCabecalhoMontado.nfeCabecalho.dataEntradaContingencia == null 
        ? '' 
        : Biblioteca.formatarDataHora(nfeCabecalhoMontado.nfeCabecalho.dataEntradaContingencia)) + '\n'
      ' xJust=' + 
        (nfeCabecalhoMontado.nfeCabecalho.justificativaContingencia == null
        ? ''
        : nfeCabecalhoMontado.nfeCabecalho.justificativaContingencia) + '\n'
      ' \n';
  }

  static String montarTagEmitente() {
    return 
      ' [Emitente]\n'
      ' CNPJCPF=' + Sessao.empresa.cnpj + '\n'                                      
      ' xNome='+ Sessao.empresa.razaoSocial +'\n'                                   
      ' xFant='+ (Sessao.empresa.nomeFantasia ?? '') +'\n'
      ' IE='+ Sessao.empresa.inscricaoEstadual +'\n'                                
      ' CRT='+ Sessao.empresa.crt.substring(0, 1) +'\n'                             
      ' xLgr='+ Sessao.empresa.logradouro +'\n'                                     
      ' nro='+ Sessao.empresa.numero +'\n'                                          
      ' xCpl='+ (Sessao.empresa.complemento ?? '') +'\n'
      ' xBairro='+ Sessao.empresa.bairro +'\n'                                      
      ' cMun='+ Sessao.empresa.codigoIbgeCidade.toString() +'\n'                    
      ' xMun='+ Sessao.empresa.cidade +'\n'                                         
      ' UF='+ Sessao.empresa.uf +'\n'                                               
      ' CEP='+ Sessao.empresa.cep +'\n'                                             
      ' cUF='+ Sessao.empresa.codigoIbgeUf.toString() +'\n'                         
      ' cMunFG=\n'
      ' cPais=1058\n'
      ' xPais=BRASIL\n'
      ' \n';
  }

  static String montarTagDestinatario() {
    if (nfeCabecalhoMontado.nfeDestinatario != null) {
      return 
        ' [Destinatario]\n'
        ' CNPJCPF=' + (nfeCabecalhoMontado.nfeDestinatario.cpf ?? '') + '\n'
        ' xNome=' + (nfeCabecalhoMontado.nfeDestinatario.nome ?? '') + '\n'
        ' indIEDest=9\n'
        ' email=' + (nfeCabecalhoMontado.nfeDestinatario.email ?? '') + '\n'
        ' xLgr=' + (nfeCabecalhoMontado.nfeDestinatario.logradouro ?? '') + '\n'
        ' nro=' + (nfeCabecalhoMontado.nfeDestinatario.numero ?? '') + '\n'
        ' xCpl=' + (nfeCabecalhoMontado.nfeDestinatario.complemento ?? '') + '\n'
        ' xBairro=' + (nfeCabecalhoMontado.nfeDestinatario.bairro ?? '') + '\n'
        ' cMun=' + (nfeCabecalhoMontado.nfeDestinatario.codigoMunicipio.toString() ?? '') + '\n'
        ' xMun=' + (nfeCabecalhoMontado.nfeDestinatario.nomeMunicipio ?? '') + '\n'
        ' UF=' + (nfeCabecalhoMontado.nfeDestinatario.uf ?? '') + '\n'
        ' CEP=' + (nfeCabecalhoMontado.nfeDestinatario.cep ?? '') + '\n'
        ' cPais=' + (nfeCabecalhoMontado.nfeDestinatario.codigoPais?.toString() ?? '') + '\n'
        ' xPais=' + (nfeCabecalhoMontado.nfeDestinatario.nomePais ?? '') + '\n'
        ' Fone=' + (nfeCabecalhoMontado.nfeDestinatario.telefone ?? '') + '\n'
        ' \n';
    } else {
      return '';
    }
  }

  static String montarTagProduto() {
    String tagProduto = '';
    int contador = 0;
    for (var detalhe in nfeCabecalhoMontado.listaNfeDetalheMontado) {      
      tagProduto = tagProduto + '\n'
        ' [Produto' + (++contador).toString().padLeft(3, '0') + ']\n'
        ' CFOP=' + detalhe.nfeDetalhe.cfop.toString() + '\n'
        ' cProd=' + detalhe.nfeDetalhe.codigoProduto + '\n'
        ' cEAN=' + detalhe.nfeDetalhe.gtin + '\n'
        ' cEANTrib=' + detalhe.nfeDetalhe.gtinUnidadeTributavel + '\n'
        ' xProd=' + detalhe.nfeDetalhe.nomeProduto + '\n'
        ' ncm=' + detalhe.nfeDetalhe.ncm + '\n'                                             
        ' uCom=' + detalhe.nfeDetalhe.unidadeComercial + '\n'
        ' uTrib=' + detalhe.nfeDetalhe.unidadeTributavel + '\n'
        ' qCom=' + detalhe.nfeDetalhe.quantidadeComercial.toString() + '\n'
        ' qTrib=' + detalhe.nfeDetalhe.quantidadeTributavel.toString() + '\n'
        ' vUnCom=' + detalhe.nfeDetalhe.valorUnitarioComercial.toString() + '\n'
        ' vUnTrib=' + detalhe.nfeDetalhe.valorUnitarioTributavel.toString() + '\n'
        ' vProd=' + detalhe.nfeDetalhe.valorSubtotal.toString() + '\n'
        ' vDesc=' + (detalhe.nfeDetalhe.valorDesconto?.toString() ?? '0') + '\n'
        ' indTot=' + detalhe.nfeDetalhe.entraTotal + '\n'
        ' vTotTrib=' + (detalhe.nfeDetalhe.valorTotalTributos.toString() ?? '0') + '\n'
        ' \n'
        ' [ICMS' + (contador).toString().padLeft(3, '0') + ']\n' + 
        (Sessao.empresa.crt.substring(0, 1) == '1' ? ' CSOSN=' + detalhe.nfeDetalheImpostoIcms.csosn + '\n' : ' CST=' + detalhe.nfeDetalheImpostoIcms.cstIcms + '\n' ) +
        ' orig=' + detalhe.nfeDetalheImpostoIcms.origemMercadoria+ '\n'
        ' modBC=' + (detalhe.nfeDetalheImpostoIcms.modalidadeBcIcms ?? '') + '\n'
        ' vBC=' + (detalhe.nfeDetalheImpostoIcms.valorBcIcms?.toString() ?? '0') + '\n'
        ' pICMS=' + (detalhe.nfeDetalheImpostoIcms.aliquotaIcms?.toString() ?? '0') + '\n'
        ' vICMS=' + (detalhe.nfeDetalheImpostoIcms.valorIcms?.toString() ?? '0') + '\n'
        ' \n'
        ' [PIS' + (contador).toString().padLeft(3, '0') + ']\n'
        ' CST=' + detalhe.nfeDetalheImpostoPis.cstPis + '\n'
        ' vBC=' + detalhe.nfeDetalheImpostoPis.valorBaseCalculoPis.toString() + '\n'
        ' pPIS=' + detalhe.nfeDetalheImpostoPis.aliquotaPisPercentual.toString() + '\n'
        ' vPIS=' + detalhe.nfeDetalheImpostoPis.valorPis.toString() + '\n'
        ' \n'
        ' [COFINS' + (contador).toString().padLeft(3, '0') + ']\n'
        ' CST=' + detalhe.nfeDetalheImpostoCofins.cstCofins + '\n'
        ' vBC=' + detalhe.nfeDetalheImpostoCofins.baseCalculoCofins.toString() + '\n'
        ' pCOFINS=' + detalhe.nfeDetalheImpostoCofins.aliquotaCofinsPercentual.toString() + '\n'
        ' vCOFINS=' + detalhe.nfeDetalheImpostoCofins.valorCofins.toString() + '\n'
        ' \n';
    }
    
    return tagProduto;
  }

  static String montarTagTotal() {
    return 
      ' [Total]\n'
      ' vNF=' + nfeCabecalhoMontado.nfeCabecalho.valorTotal.toString() + '\n'
      ' vBC=' + nfeCabecalhoMontado.nfeCabecalho.baseCalculoIcms.toString() + '\n'
      ' vICMS=' + nfeCabecalhoMontado.nfeCabecalho.valorIcms.toString() + '\n'
      ' vProd=' + nfeCabecalhoMontado.nfeCabecalho.valorTotalProdutos.toString() + '\n'
      ' vDesc=' + nfeCabecalhoMontado.nfeCabecalho.valorDesconto.toString() + '\n'
      ' vPIS=' + nfeCabecalhoMontado.nfeCabecalho.valorPis.toString() + '\n'
      ' vCOFINS=' + nfeCabecalhoMontado.nfeCabecalho.valorCofins.toString() + '\n'
      ' vTotTrib=' + (nfeCabecalhoMontado.nfeCabecalho.valorTotalTributos?.toString() ?? 0) + '\n'
      ' \n';
  }

  static String montarTagTransportador() {
    return 
      ' [Transportador]\n'
      ' modFrete=9\n'
      ' \n';
  }

  static String montarTagPagamento() {
    String tagPagamento = '';
    int contador = 0;
    for (var pagamento in nfeCabecalhoMontado.listaNfeInformacaoPagamento) {      
      tagPagamento = tagPagamento + '\n'
      ' [PAG' + (++contador).toString().padLeft(3, '0') + ']\n'
      ' tpag=' + pagamento.meioPagamento + '\n'                         
      ' vPag=' + pagamento.valor.toString() + '\n'
      ' indPag=' + pagamento.indicadorPagamento + '\n'
      ' vTroco=' + pagamento.troco.toString() + '\n'
      ' \n';
    }
    return tagPagamento;
  }

  static String montarTagResponsavelTecnico() {
    return 
      ' [INFRESPTEC]\n'                                                   
      ' CNPJ='+ (Sessao.configuracaoNfce.respTecCnpj ?? '') + '\n'
      ' xContato='+ (Sessao.configuracaoNfce.respTecContato ?? '') + '\n'
      ' email='+ (Sessao.configuracaoNfce.respTecEmail ?? '') + '\n'
      ' fone='+ (Sessao.configuracaoNfce.respTecFone ?? '') + '\n'
      ' idcsrt='+ (Sessao.configuracaoNfce.respTecIdCsrt ?? '') + '\n'
      ' csrt='+ (Sessao.configuracaoNfce.respTecHashCsrt ?? '') + '\n'
      '\n';
  }

  static String montarTagDadosAdicionais() {
    return 
      ' [DadosAdicionais]\n'
      ' infCpl=NUMERO DA VENDA: ' + Sessao.vendaAtual.id.toString() + '\n'
      ' \n';
  }

  static Future<String> verificarSeAptoParaEmitirNfce() async {
    String retorno = '';

    // verifica se a operação fiscal padrão foi informada
    if (Sessao.configuracaoPdv == null 
    || Sessao.configuracaoPdv.idTributOperacaoFiscalPadrao == null) {
      retorno = 'Por favor, informe a operação fiscal padrão na tela de Configurações do PDV.';
    }

    // verifica se o tipo de impressão do danfe foi cadastrado nas configurações
    if (Sessao.configuracaoNfce == null 
    || Sessao.configuracaoNfce.caminhoSalvarPdf == null 
    || Sessao.configuracaoNfce.caminhoSalvarXml == null 
    || Sessao.configuracaoNfce.formatoImpressaoDanfe == null 
    || Sessao.configuracaoNfce.webserviceAmbiente == null) {
      retorno = 'Por favor, cadastre os dados necessários na tela de Configurações da NFC-e.';
    }
    // verifica se a numeração e série foram cadastradas pelo usuário
    else if (Sessao.numeroNfce == null 
    || Sessao.numeroNfce.numero == null 
    || Sessao.numeroNfce.serie == null) {
      retorno = 'Por favor, informe os dados de numeração e série da NFC-e na tela de Configurações da NFC-e.';
    }

    // conferir todos os campos obrigatórios cadastrados para a empresa
    else if (Sessao.empresa.codigoIbgeCidade == null 
    || Sessao.empresa.codigoIbgeUf == null 
    || (Sessao.empresa.razaoSocial == null || Sessao.empresa.razaoSocial == '')
    || (Sessao.empresa.inscricaoEstadual == null || Sessao.empresa.inscricaoEstadual == '')
    || (Sessao.empresa.crt == null || Sessao.empresa.crt == '')
    || (Sessao.empresa.logradouro == null || Sessao.empresa.logradouro == '')
    || (Sessao.empresa.numero == null || Sessao.empresa.numero == '')
    || (Sessao.empresa.bairro == null || Sessao.empresa.bairro == '')
    || (Sessao.empresa.cidade == null || Sessao.empresa.cidade == '')
    || (Sessao.empresa.uf == null || Sessao.empresa.uf == '')
    || (Sessao.empresa.cep == null || Sessao.empresa.cep == '')
    || (Sessao.empresa.cnpj == null || Sessao.empresa.cnpj == '')
    ) {
      retorno = 'Por favor, informe todos os dados obrigatórios no cadastro da Empresa para a emissão da NFC-e.';
    }

    // verifica se tem produto sem grupo tributario
    final listaProduto = await Sessao.db.produtoDao.consultarProdutoSemGrupoTributario();
    if (listaProduto.length > 0) {
      retorno = 'Por favor, vincule os grupos tributários aos produtos.';
    }

    return retorno;
  }

  static Future<bool> atualizarDadosNfce({String chaveAcesso, String statusNota, String motivoCancelamento}) async {
    nfeCabecalhoMontado.nfeCabecalho = 
      NfceController.nfeCabecalhoMontado.nfeCabecalho.copyWith(
        chaveAcesso: chaveAcesso,
        statusNota: statusNota,
        informacoesAddContribuinte: motivoCancelamento,
      );
    final retorno = await Sessao.db.nfeCabecalhoDao.alterar(NfceController.nfeCabecalhoMontado, atualizaFilhos: false);
    return retorno;
  }

  static String retornarChaveDoIni(String conteudoIni) {
    conteudoIni = removerPrimeiraLinhaDoIni(conteudoIni);
    config = Config.fromString(conteudoIni);
    final chaveNota = 'NFe' + int.tryParse(NfceController.nfeCabecalhoMontado.nfeCabecalho.numero).toString(); // faz o parse para tirar os zeros a esquerda do número que foi armazenado no banco de dados como String
    return config.get(chaveNota, 'chDFe');
  }

  static String retornarMotivoRejeicao(String conteudoIni) {
    String retorno = '';
     if (conteudoIni.indexOf("[") < 0) { // desceu conteúdo que não está no formato INI - a rejeição voltou em texto puro
      retorno = conteudoIni;
     } else {
      conteudoIni = removerPrimeiraLinhaDoIni(conteudoIni);
      config = Config.fromString(conteudoIni);
      if (conteudoIni.contains('Envio')) {
        retorno = config.get('Envio', 'Msg');
      } else if (conteudoIni.contains('Cancelamento')) {
        if (conteudoIni.contains('XMotivo')) {
          retorno = config.get('Cancelamento', 'XMotivo');
        } else if (conteudoIni.contains('xMotivo')) {
          retorno = config.get('Cancelamento', 'xMotivo');
        }
      } else {
        retorno = 'Rejeição não identificada';
      }
    }
    return retorno;
  }

  static String removerPrimeiraLinhaDoIni(String conteudoIni) {
    return conteudoIni.substring(conteudoIni.indexOf("["), conteudoIni.length);
  }

  static String retornarChaveDoCaminhoXml(String caminhoXml) {
    final posicaoFinal = caminhoXml.indexOf('-');
    final posicaoInicial = posicaoFinal - 44; //44 é o tamanho da chave da NF-e
    final chaveNota = caminhoXml.substring(posicaoInicial, posicaoFinal);
    return chaveNota;
  }

  static void enviarComandoInutilizacaoNumero(
    {Socket socket, String cnpj, String justificativa, String ano, String modelo, String serie, 
    String numeroInicial, String numeroFinal}
  ) {
    socket.write('NFE.InutilizarNFe('
        +cnpj +', '
        +justificativa+', '
        +ano+', '
        +modelo+', '
        +serie+', '
        +numeroInicial+', '
        +numeroFinal+
      ')\r\n.\r\n');
  }

  static bool ufPermiteContingenciaOffLine(String uf) {
    switch (uf) {
      case 'AC' : return true; break;  // http://www.legis.ac.gov.br/detalhar/4285
      case 'AL' : return true; break;  // http://www.sefaz.al.gov.br/nfce/nfce-documentacao
      case 'AP' : return true; break;  // https://www.legisweb.com.br/legislacao/?id=279851
      case 'AM' : return true; break;  // https://online.sefaz.am.gov.br/silt/Normas/Legisla%C3%A7%C3%A3o%20Estadual/Decreto%20Estadual/Ano%202014/Arquivo/DE%2034459_14.htm
      case 'BA' : return true; break;  // https://www.sefaz.ba.gov.br/scripts/default/nfiscalconsumidor.asp / https://www.sefaz.ba.gov.br/especiais/_perguntas_respostas_NFCe.pdf
      case 'CE' : return false; break; // https://www.legisweb.com.br/legislacao/?id=320010
      case 'DF' : return true; break;  // http://www.fazenda.df.gov.br/aplicacoes/legislacao/legislacao/TelaSaidaDocumento.cfm?txtNumero=387&txtAno=2019&txtTipo=7&txtParte=.
      case 'ES' : return true; break;  // https://internet.sefaz.es.gov.br/faleconosco/index.php?carregar=421
      case 'GO' : return true; break;  // https://www.economia.go.gov.br/acesso-a-informacao/241-documentos-fiscais/nfc-e/5377-perguntas-e-respostas.html
      case 'MA' : return true; break;  // https://sistemas1.sefaz.ma.gov.br/portalsefaz/files?codigo=9313
      case 'MT' : return true; break;  // http://app1.sefaz.mt.gov.br/0325677500623408/07FA81BED2760C6B84256710004D3940/F3C3E6446030BC2E84257B3300641650
      case 'MS' : return true; break;  // http://www.nfce.ms.gov.br/wp-content/uploads/2018/06/Cartilha-NFC-e_v2.0_06_2018_publicada.pdf
      case 'MG' : return true; break;  // http://www.sped.fazenda.mg.gov.br/spedmg/nfce/Perguntas-Frequentes/respostas_iii/index.html
      case 'PA' : return true; break;  // https://www.legisweb.com.br/legislacao/?id=272878
      case 'PB' : return true; break;  // https://www.sefaz.pb.gov.br/info/documentos-fiscais/nfc-e
      case 'PR' : return true; break;  // http://www.sped.fazenda.pr.gov.br/modules/conteudo/conteudo.php?conteudo=99
      case 'PE' : return true; break;  // https://www.sefaz.pe.gov.br/Servicos/Nota-Fiscal-de-Consumidor-Eletronica/Paginas/contingencia.aspx
      case 'PI' : return true; break;  // https://portal.sefaz.pi.gov.br/documentoseletronicos/portal/nfce/faq.php
      case 'RJ' : return true; break;  // http://www.fazenda.rj.gov.br/sefaz/content/conn/UCMServer/path/Contribution%20Folders/site_fazenda/informacao/sistemaseletronicos/dfe/manuais/DF-e_NFC-e.pdf?lve
      case 'RN' : return true; break;  // http://www.set.rn.gov.br/contentProducao/aplicacao/set_v2/nfce/gerados/contingencia.asp
      case 'RS' : return true; break;  // https://www.sefaz.rs.gov.br/Site/MontaDuvidas.aspx?al=l_nfe_faq_nfce
      case 'RO' : return true; break;  // http://www.informanet.com.br/Prodinfo/boletim/2019/ro/icms_ro_17_2019.html
      case 'RR' : return true; break;  // https://www.legisweb.com.br/legislacao/?id=265212
      case 'SC' : return true; break;  // https://blog.tecnospeed.com.br/nfc-e-santa-catarina/
      case 'SP' : return false; break; // http://www.nfce.fazenda.sp.gov.br/NFCePortal/Paginas/DuvidasFrequentes.aspx
      case 'SE' : return true; break;  // https://www.legisweb.com.br/legislacao/?id=336177
      case 'TO' : return true; break;  // https://www.to.gov.br/sefaz/nfc-e/2jj2gm7nnuog
      default: return false;
    }
  }

  static bool ufPermiteSistemaNfce(String uf) {
    switch (uf) {
      case 'AC' : return true; break;  // http://sefaznet.ac.gov.br/nfce/projetonfce.xhtml
      case 'AL' : return true; break;  // http://www.sefaz.al.gov.br/nfce
      case 'AP' : return true; break;  // https://www.sefaz.ap.gov.br/detalhes/9
      case 'AM' : return true; break;  // http://portalnfce.sefaz.am.gov.br/empresario/como-aderir-a-nfc-e/
      case 'BA' : return true; break;  // https://www.sefaz.ba.gov.br/especiais/como_se_tornar_emissor_nfce.html
      case 'CE' : return false; break; // necessário realizar cadastro da SH [tem que usar um software integrador fiscal] - https://www.projetoacbr.com.br/forum/topic/58762-passos-para-cadastramento-de-software-house-e-configura%C3%A7%C3%B5es-sefaz-cear%C3%A1/
      case 'DF' : return true; break;  // https://www.receita.fazenda.df.gov.br/aplicacoes/CartaServicos/servico.cfm?codTipoPessoa=7&codServico=770&codSubCategoria=216
      case 'ES' : return false; break; // necessário realizar credenciamento da SH - https://internet.sefaz.es.gov.br/informacoes/nfcEletronica/desenvolvedores.php
      case 'GO' : return true; break;  // https://www.economia.go.gov.br/receita-estadual/documentos-fiscais/nfce.html
      case 'MA' : return true; break;  // https://sistemas1.sefaz.ma.gov.br/portalsefaz/jsp/pagina/pagina.jsf?codigo=1693
      case 'MT' : return true; break;  // https://www.sefaz.mt.gov.br/portal/nfce/
      case 'MS' : return true; break;  // http://www.faleconosco.ms.gov.br/faq/#/detalhamentoAssunto/7/318
      case 'MG' : return true; break;  // http://www.sped.fazenda.mg.gov.br/spedmg/nfce/Perguntas-Frequentes/respostas_vi/index.html#f10
      case 'PA' : return false; break; // necessário realizar cadastro do sofware - http://nfce.sefa.pa.gov.br/
      case 'PB' : return true; break;  // https://www.sefaz.pb.gov.br/info/documentos-fiscais/nfc-e#credenciamento
      case 'PR' : return false; break; // necessário realizar credenciamento da SH - http://www.sped.fazenda.pr.gov.br/modules/conteudo/conteudo.php?conteudo=98
      case 'PE' : return true; break;  // https://www.sefaz.pe.gov.br/Servicos/Nota-Fiscal-de-Consumidor-Eletronica/Paginas/Credenciamento-de-Contribuintes.aspx
      case 'PI' : return true; break;  // https://portal.sefaz.pi.gov.br/documentoseletronicos/portal/nfce/faq.php
      case 'RJ' : return true; break;  // http://www.fazenda.rj.gov.br/sefaz/content/conn/UCMServer/path/Contribution%20Folders/site_fazenda/informacao/sistemaseletronicos/dfe/manuais/DF-e_NFC-e.pdf
      case 'RN' : return true; break;  // https://www.set.rn.gov.br/contentProducao/aplicacao/set_v2/nfce/gerados/credenciamentos.asp
      case 'RS' : return true; break;  // https://www.sefaz.rs.gov.br/Site/MontaDuvidas.aspx?al=l_nfe_faq_nfce
      case 'RO' : return true; break;  // http://www.informanet.com.br/Prodinfo/boletim/2019/ro/icms_ro_17_2019.html
      case 'RR' : return true; break;  // https://www.sefaz.rr.gov.br/nfc-e
      case 'SC' : return false; break; // MONSTRO: PAF-NFC-e - https://www.sef.sc.gov.br/servicos/servico/136/NFC-e_-_Nota_Fiscal_de_Consumidor_Eletr%C3%B4nica
      case 'SP' : return true; break;  // http://www.nfce.fazenda.sp.gov.br/NFCePortal/Paginas/DuvidasFrequentes.aspx
      case 'SE' : return true; break;  // http://www.nfce.se.gov.br/portal/portalNoticias.jsp?jsp=barra-menu/conhecaNFCe/perguntasFrequentes.htm
      case 'TO' : return true; break;  // http://www.sefaz.to.gov.br/nfce/
      default: return false;
    }
  }

  static NfeCabecalho _clonarNfceCabecalho() {
    NfeCabecalho retorno = NfeCabecalho(id: null); 
    retorno = retorno.copyWith(
      idTributOperacaoFiscal: nfeCabecalhoMontado.nfeCabecalho.idTributOperacaoFiscal,
      idPdvVendaCabecalho: nfeCabecalhoMontado.nfeCabecalho.idPdvVendaCabecalho,
      ufEmitente: nfeCabecalhoMontado.nfeCabecalho.ufEmitente,
      codigoNumerico: _codigoNumericoMontado,
      naturezaOperacao: nfeCabecalhoMontado.nfeCabecalho.naturezaOperacao,
      codigoModelo: nfeCabecalhoMontado.nfeCabecalho.codigoModelo,
      serie: nfeCabecalhoMontado.nfeCabecalho.serie,
      numero: _numeroMontado,
      dataHoraEmissao: nfeCabecalhoMontado.nfeCabecalho.dataHoraEmissao,
      dataHoraEntradaSaida: nfeCabecalhoMontado.nfeCabecalho.dataHoraEntradaSaida,
      tipoOperacao: nfeCabecalhoMontado.nfeCabecalho.tipoOperacao,
      localDestino: nfeCabecalhoMontado.nfeCabecalho.localDestino,
      codigoMunicipio: nfeCabecalhoMontado.nfeCabecalho.codigoMunicipio,
      formatoImpressaoDanfe: nfeCabecalhoMontado.nfeCabecalho.formatoImpressaoDanfe,
      tipoEmissao: nfeCabecalhoMontado.nfeCabecalho.tipoEmissao,
      chaveAcesso: nfeCabecalhoMontado.nfeCabecalho.chaveAcesso,
      digitoChaveAcesso: nfeCabecalhoMontado.nfeCabecalho.digitoChaveAcesso,
      ambiente: nfeCabecalhoMontado.nfeCabecalho.ambiente,
      finalidadeEmissao: nfeCabecalhoMontado.nfeCabecalho.finalidadeEmissao,
      consumidorOperacao: nfeCabecalhoMontado.nfeCabecalho.consumidorOperacao,
      consumidorPresenca: nfeCabecalhoMontado.nfeCabecalho.consumidorPresenca,
      processoEmissao: nfeCabecalhoMontado.nfeCabecalho.processoEmissao,
      versaoProcessoEmissao: nfeCabecalhoMontado.nfeCabecalho.versaoProcessoEmissao,
      dataEntradaContingencia: nfeCabecalhoMontado.nfeCabecalho.dataEntradaContingencia,
      justificativaContingencia: nfeCabecalhoMontado.nfeCabecalho.justificativaContingencia,
      baseCalculoIcms: nfeCabecalhoMontado.nfeCabecalho.baseCalculoIcms,
      valorIcms: nfeCabecalhoMontado.nfeCabecalho.valorIcms,
      valorIcmsDesonerado: nfeCabecalhoMontado.nfeCabecalho.valorIcmsDesonerado,
      totalIcmsFcpUfDestino: nfeCabecalhoMontado.nfeCabecalho.totalIcmsFcpUfDestino,
      totalIcmsInterestadualUfDestino: nfeCabecalhoMontado.nfeCabecalho.totalIcmsInterestadualUfDestino,
      totalIcmsInterestadualUfRemetente: nfeCabecalhoMontado.nfeCabecalho.totalIcmsInterestadualUfRemetente,
      valorTotalFcp: nfeCabecalhoMontado.nfeCabecalho.valorTotalFcp,
      baseCalculoIcmsSt: nfeCabecalhoMontado.nfeCabecalho.baseCalculoIcmsSt,
      valorIcmsSt: nfeCabecalhoMontado.nfeCabecalho.valorIcmsSt,
      valorTotalFcpSt: nfeCabecalhoMontado.nfeCabecalho.valorTotalFcpSt,
      valorTotalFcpStRetido: nfeCabecalhoMontado.nfeCabecalho.valorTotalFcpStRetido,
      valorTotalProdutos: nfeCabecalhoMontado.nfeCabecalho.valorTotalProdutos,
      valorFrete: nfeCabecalhoMontado.nfeCabecalho.valorFrete,
      valorSeguro: nfeCabecalhoMontado.nfeCabecalho.valorSeguro,
      valorDesconto: nfeCabecalhoMontado.nfeCabecalho.valorDesconto,
      valorImpostoImportacao: nfeCabecalhoMontado.nfeCabecalho.valorImpostoImportacao,
      valorIpi: nfeCabecalhoMontado.nfeCabecalho.valorIpi,
      valorIpiDevolvido: nfeCabecalhoMontado.nfeCabecalho.valorIpiDevolvido,
      valorPis: nfeCabecalhoMontado.nfeCabecalho.valorPis,
      valorCofins: nfeCabecalhoMontado.nfeCabecalho.valorCofins,
      valorDespesasAcessorias: nfeCabecalhoMontado.nfeCabecalho.valorDespesasAcessorias,
      valorTotal: nfeCabecalhoMontado.nfeCabecalho.valorTotal,
      valorTotalTributos: nfeCabecalhoMontado.nfeCabecalho.valorTotalTributos,
      valorServicos: nfeCabecalhoMontado.nfeCabecalho.valorServicos,
      baseCalculoIssqn: nfeCabecalhoMontado.nfeCabecalho.baseCalculoIssqn,
      valorIssqn: nfeCabecalhoMontado.nfeCabecalho.valorIssqn,
      valorPisIssqn: nfeCabecalhoMontado.nfeCabecalho.valorPisIssqn,
      valorCofinsIssqn: nfeCabecalhoMontado.nfeCabecalho.valorCofinsIssqn,
      dataPrestacaoServico: nfeCabecalhoMontado.nfeCabecalho.dataPrestacaoServico,
      valorDeducaoIssqn: nfeCabecalhoMontado.nfeCabecalho.valorDeducaoIssqn,
      outrasRetencoesIssqn: nfeCabecalhoMontado.nfeCabecalho.outrasRetencoesIssqn,
      descontoIncondicionadoIssqn: nfeCabecalhoMontado.nfeCabecalho.descontoIncondicionadoIssqn,
      descontoCondicionadoIssqn: nfeCabecalhoMontado.nfeCabecalho.descontoCondicionadoIssqn,
      totalRetencaoIssqn: nfeCabecalhoMontado.nfeCabecalho.totalRetencaoIssqn,
      regimeEspecialTributacao: nfeCabecalhoMontado.nfeCabecalho.regimeEspecialTributacao,
      valorRetidoPis: nfeCabecalhoMontado.nfeCabecalho.valorRetidoPis,
      valorRetidoCofins: nfeCabecalhoMontado.nfeCabecalho.valorRetidoCofins,
      valorRetidoCsll: nfeCabecalhoMontado.nfeCabecalho.valorRetidoCsll,
      baseCalculoIrrf: nfeCabecalhoMontado.nfeCabecalho.baseCalculoIrrf,
      valorRetidoIrrf: nfeCabecalhoMontado.nfeCabecalho.valorRetidoIrrf,
      baseCalculoPrevidencia: nfeCabecalhoMontado.nfeCabecalho.baseCalculoPrevidencia,
      valorRetidoPrevidencia: nfeCabecalhoMontado.nfeCabecalho.valorRetidoPrevidencia,
      informacoesAddFisco: nfeCabecalhoMontado.nfeCabecalho.informacoesAddFisco,
      informacoesAddContribuinte: nfeCabecalhoMontado.nfeCabecalho.informacoesAddContribuinte,
      comexUfEmbarque: nfeCabecalhoMontado.nfeCabecalho.comexUfEmbarque,
      comexLocalEmbarque: nfeCabecalhoMontado.nfeCabecalho.comexLocalEmbarque,
      comexLocalDespacho: nfeCabecalhoMontado.nfeCabecalho.comexLocalDespacho,
      compraNotaEmpenho: nfeCabecalhoMontado.nfeCabecalho.compraNotaEmpenho,
      compraPedido: nfeCabecalhoMontado.nfeCabecalho.compraPedido,
      compraContrato: nfeCabecalhoMontado.nfeCabecalho.compraContrato,
      qrcode: nfeCabecalhoMontado.nfeCabecalho.qrcode,
      urlChave: nfeCabecalhoMontado.nfeCabecalho.urlChave,
      statusNota: '0',
    );
    return retorno;
  }

}