/*
Title: T2Ti ERP 3.0
Description: Controller utilizado para a sincronização de dados
                                                                                
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
import 'dart:convert';
import 'dart:io';

import 'package:pegasus_pdv/src/infra/infra.dart';
import 'package:pegasus_pdv/src/model/model.dart';
import 'package:pegasus_pdv/src/service/infra/sincroniza_service.dart';

class SincronizaController {

	static List<String> listaTabelaCentral = [
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
    'CONTAS_RECEBER'
  ]; 

  static Future<bool> subirTabelasCentrais() async {
    List<String> listaSincroniza = [];

    for (var i = 0; i < listaTabelaCentral.length; i++) {
      ObjetoSincroniza objetoSincroniza = ObjetoSincroniza(
        tabela: listaTabelaCentral[i],
      );
      
      switch (listaTabelaCentral[i]) {
        case 'TRIBUT_ICMS_CUSTOM_CAB' : 
          objetoSincroniza.registros = jsonEncode(await Sessao.db.tributIcmsCustomCabDao.consultarLista());          
          break;
        case 'TRIBUT_ICMS_CUSTOM_DET' : 
          objetoSincroniza.registros = jsonEncode(await Sessao.db.tributIcmsCustomCabDao.consultarListaDetalhe());          
          break;
        case 'TRIBUT_OPERACAO_FISCAL' : 
          objetoSincroniza.registros = jsonEncode(await Sessao.db.tributOperacaoFiscalDao.consultarLista());          
          break;
        case 'TRIBUT_GRUPO_TRIBUTARIO' : 
          objetoSincroniza.registros = jsonEncode(await Sessao.db.tributGrupoTributarioDao.consultarLista());          
          break;
        case 'TRIBUT_CONFIGURA_OF_GT' : 
          objetoSincroniza.registros = jsonEncode(await Sessao.db.tributConfiguraOfGtDao.consultarLista());          
          break;
        case 'TRIBUT_COFINS' : 
          objetoSincroniza.registros = jsonEncode(await Sessao.db.tributConfiguraOfGtDao.consultarListaCofins());          
          break;
        case 'TRIBUT_ICMS_UF' : 
          objetoSincroniza.registros = jsonEncode(await Sessao.db.tributConfiguraOfGtDao.consultarListaIcms());          
          break;
        case 'TRIBUT_IPI' : 
          objetoSincroniza.registros = jsonEncode(await Sessao.db.tributConfiguraOfGtDao.consultarListaIpi());          
          break;
        case 'TRIBUT_PIS' : 
          objetoSincroniza.registros = jsonEncode(await Sessao.db.tributConfiguraOfGtDao.consultarListaPis());          
          break;
        case 'CLIENTE' : 
          objetoSincroniza.registros = jsonEncode(await Sessao.db.clienteDao.consultarLista());          
          break;
        case 'COLABORADOR' : 
          objetoSincroniza.registros = jsonEncode(await Sessao.db.colaboradorDao.consultarLista());          
          break;
        case 'FORNECEDOR' : 
          objetoSincroniza.registros = jsonEncode(await Sessao.db.fornecedorDao.consultarLista());          
          break;
        case 'PRODUTO_GRUPO' : 
          objetoSincroniza.registros = jsonEncode(await Sessao.db.produtoGrupoDao.consultarLista());          
          break;
        case 'PRODUTO_SUBGRUPO' : 
          objetoSincroniza.registros = jsonEncode(await Sessao.db.produtoSubgrupoDao.consultarLista());          
          break;
        case 'PRODUTO_TIPO' : 
          objetoSincroniza.registros = jsonEncode(await Sessao.db.produtoTipoDao.consultarLista());          
          break;
        case 'PRODUTO_UNIDADE' : 
          objetoSincroniza.registros = jsonEncode(await Sessao.db.produtoUnidadeDao.consultarLista());          
          break;
        case 'PRODUTO' : 
          objetoSincroniza.registros = jsonEncode(await Sessao.db.produtoDao.consultarLista());          
          break;
        case 'PRODUTO_FICHA_TECNICA' : 
          objetoSincroniza.registros = jsonEncode(await Sessao.db.produtoFichaTecnicaDao.consultarLista());          
          break;
        case 'PRODUTO_IMAGEM' : 
          objetoSincroniza.registros = jsonEncode(await Sessao.db.produtoImagemDao.consultarLista());          
          break;
        case 'PDV_TIPO_PAGAMENTO' : 
          objetoSincroniza.registros = jsonEncode(await Sessao.db.pdvTipoPagamentoDao.consultarLista());          
          break;
        case 'PRODUTO_PROMOCAO' : 
          objetoSincroniza.registros = jsonEncode(await Sessao.db.produtoPromocaoDao.consultarLista());          
          break;
        case 'COMPRA_PEDIDO_CABECALHO' : 
          objetoSincroniza.registros = jsonEncode(await Sessao.db.compraPedidoCabecalhoDao.consultarLista());          
          break;
        case 'COMPRA_PEDIDO_DETALHE' : 
          objetoSincroniza.registros = jsonEncode(await Sessao.db.compraPedidoDetalheDao.consultarLista());          
          break;
        case 'CONTAS_PAGAR' : 
          objetoSincroniza.registros = jsonEncode(await Sessao.db.contasPagarDao.consultarLista());          
          break;
        case 'CONTAS_RECEBER' : 
          objetoSincroniza.registros = jsonEncode(await Sessao.db.contasReceberDao.consultarLista());          
          break;
        default:
      }
      
      listaSincroniza.add(objetoSincroniza.objetoEncodeJson());
    }

    SincronizaService sincronizaService = SincronizaService();
    final retorno = await sincronizaService.subirTabelasCentrais(listaSincroniza.toString());        
    return retorno;
  }

  static subirDadosMovimento() async {
    File file = File(Sessao.caminhoBancoDados);
    String arquivoBase64 = base64.encode(file.readAsBytesSync());
    SincronizaService sincronizaService = SincronizaService();
    await sincronizaService.subirDadosMovimento(arquivoBase64);        
  }

  static Future<bool> sincronizarDadosVindosDoServidor() async {
    SincronizaService sincronizaService = SincronizaService();
    final listaSincroniza = await sincronizaService.descerDadosServidor();          
    if (listaSincroniza != null) {
      for (var objSincroniza in listaSincroniza) {
        switch (objSincroniza.tabela) {
          case 'TRIBUT_ICMS_CUSTOM_DET' :
            Sessao.db.tributIcmsCustomCabDao.sincronizarDetalhe(objSincroniza);
            break;
          case 'TRIBUT_ICMS_CUSTOM_CAB' :
            Sessao.db.tributIcmsCustomCabDao.sincronizarCabecalho(objSincroniza);
            break;
          case 'TRIBUT_COFINS' :
            Sessao.db.tributConfiguraOfGtDao.sincronizarCofins(objSincroniza);
            break;
          case 'TRIBUT_ICMS_UF' :
            Sessao.db.tributConfiguraOfGtDao.sincronizarIcms(objSincroniza);
            break;
          case 'TRIBUT_IPI' :
            Sessao.db.tributConfiguraOfGtDao.sincronizarIpi(objSincroniza);
            break;
          case 'TRIBUT_PIS' :
            Sessao.db.tributConfiguraOfGtDao.sincronizarPis(objSincroniza);
            break;
          case 'TRIBUT_CONFIGURA_OF_GT' :
            Sessao.db.tributConfiguraOfGtDao.sincronizar(objSincroniza);
            break;
          case 'TRIBUT_OPERACAO_FISCAL' :
            Sessao.db.tributOperacaoFiscalDao.sincronizar(objSincroniza);
            break;
          case 'PRODUTO_IMAGEM' :
            Sessao.db.produtoImagemDao.sincronizar(objSincroniza);
            break;
          case 'PRODUTO_FICHA_TECNICA' :
            Sessao.db.produtoFichaTecnicaDao.sincronizar(objSincroniza);
            break;
          case 'PRODUTO_PROMOCAO' :
            Sessao.db.produtoPromocaoDao.sincronizar(objSincroniza);
            break;
          case 'PDV_TIPO_PAGAMENTO' :
            Sessao.db.pdvTipoPagamentoDao.sincronizar(objSincroniza);
            break;
          case 'COMPRA_PEDIDO_DETALHE' :
            Sessao.db.compraPedidoDetalheDao.sincronizar(objSincroniza);
            break;
          case 'COMPRA_PEDIDO_CABECALHO' :
            Sessao.db.compraPedidoCabecalhoDao.sincronizar(objSincroniza);
            break;
          case 'CONTAS_PAGAR' :
            Sessao.db.contasPagarDao.sincronizar(objSincroniza);
            break;
          case 'CONTAS_RECEBER' :
            Sessao.db.contasReceberDao.sincronizar(objSincroniza);
            break;
          case 'PRODUTO' :
            Sessao.db.produtoDao.sincronizar(objSincroniza);
            break;
          case 'TRIBUT_GRUPO_TRIBUTARIO' :
            Sessao.db.tributGrupoTributarioDao.sincronizar(objSincroniza);
            break;
          case 'PRODUTO_SUBGRUPO' :
            Sessao.db.produtoSubgrupoDao.sincronizar(objSincroniza);
            break;
          case 'PRODUTO_GRUPO' :
            Sessao.db.produtoGrupoDao.sincronizar(objSincroniza);
            break;
          case 'PRODUTO_TIPO' :
            Sessao.db.produtoTipoDao.sincronizar(objSincroniza);
            break;
          case 'PRODUTO_UNIDADE' :
            Sessao.db.produtoUnidadeDao.sincronizar(objSincroniza);
            break;
          case 'CLIENTE' :
            Sessao.db.clienteDao.sincronizar(objSincroniza);
            break;
          case 'COLABORADOR' :
            Sessao.db.colaboradorDao.sincronizar(objSincroniza);
            break;
          case 'FORNECEDOR' :
            Sessao.db.fornecedorDao.sincronizar(objSincroniza);
            break;
          default:
        }        
      }
      return true;
    } else {
      return false;
    }

  }
}