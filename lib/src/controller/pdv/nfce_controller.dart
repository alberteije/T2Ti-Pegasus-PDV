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
import 'package:pegasus_pdv/src/database/database.dart';
import 'package:pegasus_pdv/src/database/database_classes.dart';
import 'package:pegasus_pdv/src/infra/infra.dart';

class NfceController {

  // TODO: Assista aos seguintes vídeos para melhor compreensão:
  // http://t2ti.com/erp3/videos/flutter-pdv.php#44
  // http://t2ti.com/erp3/videos/flutter-pdv.php#45

  static NfeCabecalhoMontado nfeCabecalhoMontado;

  static String montarNfce() {
    String nfceFormatoIni = '';
    nfceFormatoIni =  montarTagInfNFe() + 
                      montarTagIdentificacao() +
                      montarTagEmitente() +
                      montarTagDestinatario() +
                      montarTagProduto() +
                      montarTagTotal() +
                      montarTagTransportador() +
                      montarTagPagamento() +
                      montarTagResponsavelTecnico();
    return nfceFormatoIni;
  }

  static Future<bool> gerarDadosNfce() async {
    nfeCabecalhoMontado = NfeCabecalhoMontado(
      nfeCabecalho: NfeCabecalho(id: null),
      nfeDestinatario: NfeDestinatario(id: null),
      listaNfeDetalheMontado: [],
      listaNfeInformacaoPagamento: [],
    );

    // IDENTIFICACAO
    final nfceNumero = await Sessao.db.nfeNumeroDao.consultarObjeto(1);
    final novoNumero = nfceNumero.numero + 1;
    final numeroMontado = novoNumero.toString().padLeft(9, '0');
    final codigoNumericoMontado = '9' + novoNumero.toString().padLeft(7, '0');
    
    nfeCabecalhoMontado.nfeCabecalho = nfeCabecalhoMontado.nfeCabecalho.copyWith(
      numero: numeroMontado,                                                            // nNF - TODO: permitir que o usuário informe o primeiro número da sequencia nas configurações
      codigoNumerico: codigoNumericoMontado,                                            // cNF
      serie: nfceNumero.serie,                                                          // serie - TODO: permitir que o usuário informe a série nas configurações
      naturezaOperacao: 'VENDA',                                                        // natOp - venda
      codigoModelo: '65',                                                               // mod=65 - NFC-e
      dataHoraEmissao: DateTime.now(),                                                  // dhEmi
      tipoOperacao: '1',                                                                // tpNF - 1=saída
      consumidorOperacao: '1',                                                          // indFinal - 1=consumidor final
      consumidorPresenca: '1',                                                          // indPres - 1=operação presencial TODO: pode haver fora do estabelecimento?
      localDestino: '1',                                                                // idDest - 1=operação interna
      formatoImpressaoDanfe: Sessao.configuracaoNfce.formatoImpressaoDanfe.toString(),  // tpimp - 4=DANCE NFC-e 5=DANFE NFC-e em mensagem eletrônica TODO: colocar nas configurações
      ambiente: Sessao.configuracaoNfce.webserviceAmbiente.toString(),                  // tpAmb - 1=produção 2=homologação TODO: colocar nas configurações
      valorTotal: Sessao.vendaAtual.valorFinal,                                         // vNF
      baseCalculoIcms: Sessao.empresa.crt.substring(0, 1) == '1' ? 0 : Sessao.vendaAtual.valorBaseIcms,                                 // vBC
      valorTotalProdutos: Sessao.vendaAtual.valorFinal,                                 // vProd
      valorDesconto: Sessao.vendaAtual.valorDesconto,                                   // vDesc
      valorPis: 0,                                                                      // vPIS 
      valorCofins: 0,                                                                   // vCOFINS  
      ufEmitente: Sessao.empresa.codigoIbgeUf,                                          // cUF TODO: obrigar o cadastro na empresa
      codigoMunicipio: Sessao.empresa.codigoIbgeCidade,                                 // cMunFG TODO: obrigar o cadastro na empresa
      statusNota: '0',                                                                  // TODO: comentar com os possíveis status
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
      inscricaoEstadual: (cliente?.inscricaoEstadual ?? ''),                            // indIEDest
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
      final tributacao = await Sessao.db.tributConfiguraOfGtDao.consultarObjetoMontado(2, 2); //TODO: pegar o grupo tributario do produto e a operacao fiscal padrão da configuração

      // DETALHE
      NfeDetalheMontado nfceDetalheMontado = NfeDetalheMontado();
      NfeDetalhe nfceDetalhe = NfeDetalhe(
        id: null,
        cfop: tributacao.tributIcmsUf.cfop,                                                                   // cfop
        codigoProduto: produtoMontado.produto.id.toString(),                                                  // cProd
        nomeProduto: produtoMontado.produto.descricao,                                                        // xProd
        ncm: produtoMontado.produto.codigoNcm,                                                                // NCM
        gtin: produtoMontado.produto.gtin == null ? 'SEM GTIN' : produtoMontado.produto.gtin,                 // cEAN
        gtinUnidadeTributavel: produtoMontado.produto.gtin == null ? 'SEM GTIN' : produtoMontado.produto.gtin,// cEANTrib
        unidadeComercial: produtoMontado.produtoUnidade.sigla,                                                // uCom
        unidadeTributavel: produtoMontado.produtoUnidade.sigla,                                               // uTrib
        quantidadeComercial: vendaDetalhe.pdvVendaDetalhe.quantidade,                                         // qCom
        quantidadeTributavel: vendaDetalhe.pdvVendaDetalhe.quantidade,                                        // qTrib
        valorUnitarioComercial: vendaDetalhe.pdvVendaDetalhe.valorUnitario,                                   // vUnCom
        valorUnitarioTributavel: vendaDetalhe.pdvVendaDetalhe.valorUnitario,                                  // vUnTrib
        valorDesconto: vendaDetalhe.pdvVendaDetalhe.valorDesconto,                                            // vDesc
        valorTotal: Biblioteca.multiplicarMonetario(                                                          // 
            vendaDetalhe.pdvVendaDetalhe.valorUnitario, vendaDetalhe.pdvVendaDetalhe.quantidade
          ) - (vendaDetalhe.pdvVendaDetalhe.valorDesconto ?? 0),
        entraTotal: '1',                                                                                      // indTot
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
        meioPagamento: codigoPagamentoNfce,                                       // tPag - TODO: obrigar o cadastro do tipo de pagamento da NFC-e
        valor: pagamento.valor,                                                   // vPag
        troco: codigoPagamentoNfce == '01' ? Sessao.vendaAtual.valorTroco : 0,    // vTroco
      );
      nfeCabecalhoMontado.listaNfeInformacaoPagamento.add(nfceInformacaoPagamento);
    }

    final retorno = await Sessao.db.nfeCabecalhoDao.inserir(nfeCabecalhoMontado);
    return retorno > 1; // TODO: analisar como melhorar esse retorno
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
      ' \n';
  }

  static String montarTagEmitente() {
    return 
      ' [Emitente]\n'
      ' CNPJCPF=' + Sessao.empresa.cnpj + '\n'                                      //TODO: obrigar o cadastramento do CNPJ
      ' xNome='+ Sessao.empresa.razaoSocial +'\n'                                   //TODO: obrigar o cadastramento da razão social  
      ' xFant='+ (Sessao.empresa.nomeFantasia ?? '') +'\n'
      ' IE='+ Sessao.empresa.inscricaoEstadual +'\n'                                //TODO: obrigar o cadastramento da inscriçãoe estadual
      // ' IEST=\n'
      // ' IM=\n'
      // ' CNAE=8599604\n'
      ' CRT='+ Sessao.empresa.crt.substring(0, 1) +'\n'                                             //TODO: obrigar o cadastramento do CRT
      ' xLgr='+ Sessao.empresa.logradouro +'\n'                                     //TODO: obrigar o cadastramento do logradouro
      ' nro='+ Sessao.empresa.numero +'\n'                                          //TODO: obrigar o cadastramento do número
      ' xCpl='+ (Sessao.empresa.complemento ?? '') +'\n'
      ' xBairro='+ Sessao.empresa.bairro +'\n'                                      //TODO: obrigar o cadastramento do bairro
      ' cMun='+ Sessao.empresa.codigoIbgeCidade.toString() +'\n'                    //TODO: obrigar o cadastramento do código do município
      ' xMun='+ Sessao.empresa.cidade +'\n'                                         //TODO: obrigar o cadastramento do nome do município
      ' UF='+ Sessao.empresa.uf +'\n'                                               //TODO: obrigar o cadastramento da UF
      ' CEP='+ Sessao.empresa.cep +'\n'                                             //TODO: obrigar o cadastramento do CEP
      ' cUF='+ Sessao.empresa.codigoIbgeUf.toString() +'\n'                         //TODO: obrigar o cadastramento do código da UF
      ' cMunFG=\n'
      ' cPais=1058\n'
      ' xPais=BRASIL\n'
      // ' Fone=\n'
      ' \n';
  }

  static String montarTagDestinatario() {
    if (nfeCabecalhoMontado.nfeDestinatario != null) {
      return 
        ' [Destinatario]\n'
        ' CNPJCPF=' + (nfeCabecalhoMontado.nfeDestinatario.cpf ?? '') + '\n'
        ' xNome=' + (nfeCabecalhoMontado.nfeDestinatario.nome ?? '') + '\n'
        ' indIEDest=' + (nfeCabecalhoMontado.nfeDestinatario.inscricaoEstadual ?? '') + '\n'
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
        ' ncm=' + detalhe.nfeDetalhe.ncm + '\n'                                             //TODO: obrigar o cadastro do NCM - analisar se existe a possibilidade de cadastrar o ncm de forma automática para todos os produtos
        ' uCom=' + detalhe.nfeDetalhe.unidadeComercial + '\n'
        ' uTrib=' + detalhe.nfeDetalhe.unidadeTributavel + '\n'
        ' qCom=' + detalhe.nfeDetalhe.quantidadeComercial.toString() + '\n'
        ' qTrib=' + detalhe.nfeDetalhe.quantidadeTributavel.toString() + '\n'
        ' vUnCom=' + detalhe.nfeDetalhe.valorUnitarioComercial.toString() + '\n'
        ' vUnTrib=' + detalhe.nfeDetalhe.valorUnitarioTributavel.toString() + '\n'
        ' vProd=' + detalhe.nfeDetalhe.valorTotal.toString() + '\n'
        // ' vFrete=' + detalhe.nfeDetalhe.ncm + '\n'
        // ' vSeg=' + detalhe.nfeDetalhe.ncm + '\n'
        ' vDesc=' + (detalhe.nfeDetalhe.valorDesconto?.toString() ?? '0') + '\n'
        // ' vOutro=' + detalhe.nfeDetalhe.ncm + '\n'
        ' indTot=' + detalhe.nfeDetalhe.entraTotal + '\n'
        ' \n'
        ' [ICMS' + (contador).toString().padLeft(3, '0') + ']\n' + 
        (Sessao.empresa.crt.substring(0, 1) == '1' ? ' CSOSN=' + detalhe.nfeDetalheImpostoIcms.csosn + '\n' : ' CST=' + detalhe.nfeDetalheImpostoIcms.cstIcms + '\n' ) +
        ' orig=' + detalhe.nfeDetalheImpostoIcms.origemMercadoria+ '\n'
        ' modBC=' + (detalhe.nfeDetalheImpostoIcms.modalidadeBcIcms ?? '') + '\n'
        ' vBC=' + (detalhe.nfeDetalheImpostoIcms.valorBcIcms?.toString() ?? '0') + '\n'
        ' pICMS=' + (detalhe.nfeDetalheImpostoIcms.aliquotaIcms?.toString() ?? '0') + '\n'
        ' vICMS=' + (detalhe.nfeDetalheImpostoIcms.valorIcms?.toString() ?? '0') + '\n'
        ' \n'
        // ' [IPI001]\n'
        // ' CST=99\n'
        // ' vBC=0\n'
        // ' pIPI=0\n'
        // ' vIPI=0\n'
        // ' \n'
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
      // ' vBCST=0\n'
      // ' vST=0\n'
      ' vProd=' + nfeCabecalhoMontado.nfeCabecalho.valorTotalProdutos.toString() + '\n'
      // ' vFrete=0\n'
      // ' vSeg=0\n'
      ' vDesc=' + nfeCabecalhoMontado.nfeCabecalho.valorDesconto.toString() + '\n'
      // ' vII=0\n'
      // ' vIPI=0\n'
      ' vPIS=' + nfeCabecalhoMontado.nfeCabecalho.valorPis.toString() + '\n'
      ' vCOFINS=' + nfeCabecalhoMontado.nfeCabecalho.valorCofins.toString() + '\n'
      // ' vOutro=0\n'
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
      ' [INFRESPTEC]\n'                                                   // TODO: obrigar o cadastro do responsável técnico nas configurações?
      ' CNPJ='+ (Sessao.configuracaoNfce.respTecCnpj ?? '') + '\n'
      ' xContato='+ (Sessao.configuracaoNfce.respTecContato ?? '') + '\n'
      ' email='+ (Sessao.configuracaoNfce.respTecEmail ?? '') + '\n'
      ' fone='+ (Sessao.configuracaoNfce.respTecFone ?? '') + '\n'
      ' idcsrt='+ (Sessao.configuracaoNfce.respTecIdCsrt ?? '') + '\n'
      ' csrt='+ (Sessao.configuracaoNfce.respTecHashCsrt ?? '') + '\n'
      '\n';
  }

}