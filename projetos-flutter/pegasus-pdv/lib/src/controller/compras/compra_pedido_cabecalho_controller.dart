/*
Title: T2Ti ERP 3.0
Description: Controller utilizado para o Pedido de Compras
                                                                                
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

class CompraPedidoCabecalhoController {

  static CompraPedidoCabecalho compraPedidoCabecalho;
  static List<CompraDetalhe> listaCompraDetalhe = [];

  static Future<bool> gerarFinanceiro() async {
    // define o primeiroVencimento
    DateTime primeiroVencimento = compraPedidoCabecalho.diaPrimeiroVencimento;
    final diaFixoParcela = compraPedidoCabecalho.diaFixoParcela;
    final quantidadeParcelas = compraPedidoCabecalho.quantidadeParcelas;
    final intervaloEntreParcelas = compraPedidoCabecalho.intervaloEntreParcelas;
    // se tiver dia fixo, calcula as parcelas levando em conta apenas o mes
    if (diaFixoParcela != null && diaFixoParcela != '') {
      primeiroVencimento = DateTime.utc(primeiroVencimento.year, primeiroVencimento.month, int.parse(diaFixoParcela));        
    } 

    // gera as parcelas de acordo com critérios informados
    num somaParcelas = 0;
    num residuo = 0;
    List<ContasPagar> listaContasPagar = [];
    for (var i = 0; i < quantidadeParcelas; i++) {
      final parcelaPagar = 
        ContasPagar(
          id: null,
          idCompraPedidoCabecalho: compraPedidoCabecalho.id,
          idFornecedor: compraPedidoCabecalho.idFornecedor,
          dataLancamento: DateTime.now(),
          dataVencimento: (diaFixoParcela != null && diaFixoParcela != '') 
                          ? DateTime.utc(primeiroVencimento.year, primeiroVencimento.month + i, primeiroVencimento.day)
                          : primeiroVencimento.add(Duration(days: intervaloEntreParcelas * i)),
          valorAPagar: num.parse((compraPedidoCabecalho.valorTotal / quantidadeParcelas).toStringAsFixed(Constantes.decimaisValor)),
          statusPagamento: 'A',
          historico: 'Gerado pelo módulo compras. Parcela ' + (i+1).toString() + ' de ' + quantidadeParcelas.toString(),
        );
      listaContasPagar.add(parcelaPagar);
      somaParcelas = somaParcelas + parcelaPagar.valorAPagar;
    }
    // verifica se sobraram centavos no cálculo e lança na primeira parcela
    residuo = compraPedidoCabecalho.valorTotal - somaParcelas;
    if (residuo != 0) {
      var primeiraParcela = listaContasPagar[0];
      primeiraParcela = primeiraParcela.copyWith(
        valorAPagar: primeiraParcela.valorAPagar + residuo,
      );
    } 

    final inseriuParcelas = await Sessao.db.contasPagarDao.inserirParcelas(listaContasPagar);
    if (inseriuParcelas) {
      compraPedidoCabecalho = 
        compraPedidoCabecalho.copyWith(
          geraFinanceiro: 'S'
        );
      await Sessao.db.compraPedidoCabecalhoDao.atualizarCabecalho(compraPedidoCabecalho);
    } 
    return inseriuParcelas;
  }

  static Future<bool> atualizarEstoque() async {
    compraPedidoCabecalho = 
      compraPedidoCabecalho.copyWith(
        atualizouEstoque: 'S'
      );
    return await Sessao.db.compraPedidoCabecalhoDao.alterar(
      compraPedidoCabecalho, 
      listaCompraDetalhe,
      atualizaEstoque: true,
    );
  }

}