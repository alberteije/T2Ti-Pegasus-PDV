/*
Title: T2Ti ERP Fenix                                                                
Description: DetalhePage relacionada à tabela [FIN_CONFIGURACAO_BOLETO] 
                                                                                
The MIT License                                                                 
                                                                                
Copyright: Copyright (C) 2020 T2Ti.COM                                          
                                                                                
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
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:fenix/src/model/model.dart';
import 'package:fenix/src/view_model/view_model.dart';
import 'package:fenix/src/view/shared/erro_page.dart';
import 'package:fenix/src/view/shared/view_util_lib.dart';
import 'package:fenix/src/infra/constantes.dart';
import 'fin_configuracao_boleto_persiste_page.dart';

class FinConfiguracaoBoletoDetalhePage extends StatelessWidget {
  final FinConfiguracaoBoleto finConfiguracaoBoleto;

  const FinConfiguracaoBoletoDetalhePage({Key key, this.finConfiguracaoBoleto}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var finConfiguracaoBoletoProvider = Provider.of<FinConfiguracaoBoletoViewModel>(context);

    if (finConfiguracaoBoletoProvider.objetoJsonErro != null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Configuracao Boleto'),
          actions: <Widget>[],
        ),
        body: ErroPage(
            objetoJsonErro:
                Provider.of<FinConfiguracaoBoletoViewModel>(context).objetoJsonErro),
      );
    } else {
      return Theme(
          data: ViewUtilLib.getThemeDataDetalhePage(context),
          child: Scaffold(
            appBar: AppBar(title: Text('Configuracao Boleto'), actions: <Widget>[
              IconButton(
                icon: ViewUtilLib.getIconBotaoExcluir(),
                onPressed: () {
                  return ViewUtilLib.gerarDialogBoxExclusao(context, () {
                    finConfiguracaoBoletoProvider.excluir(finConfiguracaoBoleto.id);
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                  });
                },
              ),
              IconButton(
                icon: ViewUtilLib.getIconBotaoAlterar(),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => FinConfiguracaoBoletoPersistePage(
                          finConfiguracaoBoleto: finConfiguracaoBoleto,
                          title: 'Configuracao Boleto - Editando',
                          operacao: 'A')));
                },
              ),
            ]),
            body: SingleChildScrollView(
              child: Theme(
                data: ThemeData(fontFamily: 'Raleway'),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    ViewUtilLib.getPaddingDetalhePage('Detalhes de Configuracao Boleto'),
                    Card(
                      color: Colors.white,
                      elevation: 2.0,
                      child: Column(
                        children: <Widget>[
                        ViewUtilLib.getListTileDataDetalhePageId(
                            finConfiguracaoBoleto.id?.toString() ?? '', 'Id'),
						ViewUtilLib.getListTileDataDetalhePage(
							finConfiguracaoBoleto.idBancoContaCaixa?.toString() ?? '', 'Conta Caixa'),
						ViewUtilLib.getListTileDataDetalhePage(
							finConfiguracaoBoleto.instrucao01 ?? '', 'Instrução 01'),
						ViewUtilLib.getListTileDataDetalhePage(
							finConfiguracaoBoleto.instrucao02 ?? '', 'Instrução 02'),
						ViewUtilLib.getListTileDataDetalhePage(
							finConfiguracaoBoleto.caminhoArquivoRemessa ?? '', 'Caminho Arquivo Remessa'),
						ViewUtilLib.getListTileDataDetalhePage(
							finConfiguracaoBoleto.caminhoArquivoRetorno ?? '', 'Caminho Arquivo Retorno'),
						ViewUtilLib.getListTileDataDetalhePage(
							finConfiguracaoBoleto.caminhoArquivoLogotipo ?? '', 'Caminho Arquivo Logotipo'),
						ViewUtilLib.getListTileDataDetalhePage(
							finConfiguracaoBoleto.caminhoArquivoPdf ?? '', 'Caminho Arquivo PDF'),
						ViewUtilLib.getListTileDataDetalhePage(
							finConfiguracaoBoleto.mensagem ?? '', 'Mensagem'),
						ViewUtilLib.getListTileDataDetalhePage(
							finConfiguracaoBoleto.localPagamento ?? '', 'Local Pagamento'),
						ViewUtilLib.getListTileDataDetalhePage(
							finConfiguracaoBoleto.layoutRemessa ?? '', 'Layout Remessa'),
						ViewUtilLib.getListTileDataDetalhePage(
							finConfiguracaoBoleto.aceite ?? '', 'Aceite'),
						ViewUtilLib.getListTileDataDetalhePage(
							finConfiguracaoBoleto.especie ?? '', 'Espécie'),
						ViewUtilLib.getListTileDataDetalhePage(
							finConfiguracaoBoleto.carteira ?? '', 'Carteira'),
						ViewUtilLib.getListTileDataDetalhePage(
							finConfiguracaoBoleto.codigoConvenio ?? '', 'Código Convênio'),
						ViewUtilLib.getListTileDataDetalhePage(
							finConfiguracaoBoleto.codigoCedente ?? '', 'Código Cedente'),
						ViewUtilLib.getListTileDataDetalhePage(
							finConfiguracaoBoleto.taxaMulta != null ? Constantes.formatoDecimalTaxa.format(finConfiguracaoBoleto.taxaMulta) : 0.toStringAsFixed(Constantes.decimaisTaxa), 'Taxa Multa'),
						ViewUtilLib.getListTileDataDetalhePage(
							finConfiguracaoBoleto.taxaJuro != null ? Constantes.formatoDecimalTaxa.format(finConfiguracaoBoleto.taxaJuro) : 0.toStringAsFixed(Constantes.decimaisTaxa), 'Taxa Juros'),
						ViewUtilLib.getListTileDataDetalhePage(
							finConfiguracaoBoleto.diasProtesto?.toString() ?? '', 'Dias Protesto'),
						ViewUtilLib.getListTileDataDetalhePage(
							finConfiguracaoBoleto.nossoNumeroAnterior ?? '', 'Nosso Número Anterior'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ));
    }
  }
}