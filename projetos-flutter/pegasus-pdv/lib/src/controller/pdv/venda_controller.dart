/*
Title: T2Ti ERP 3.0
Description: Controller utilizado para a Venda
                                                                                
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
import 'package:pegasus_pdv/src/database/database_classes.dart';
import 'package:pegasus_pdv/src/infra/infra.dart';

class VendaController {

  // busca as taxas no arquivo do IBTP e calcula o imposto do item, armazenando ainda o imposto total da nota
  static void calcularImpostosTransparencia(VendaDetalhe vendaDetalhe) async {
    bool produtoImportado = false;
    final produtoMontado = await Sessao.db.produtoDao.consultarObjetoMontado(vendaDetalhe.produto.id);

    switch (produtoMontado.tributGrupoTributario?.origemMercadoria ?? 0) {
      case '0' : produtoImportado = false; break;             // 0 - Nacional, exceto as indicadas nos códigos 3, 4, 5 e 8
      case '1' : produtoImportado = true; break;              // 1 - Estrangeira - Importação direta, exceto a indicada no código 6
      case '2' : produtoImportado = true; break;              // 2 - Estrangeira - Adquirida no mercado interno, exceto a indicada no código 7
      case '3' : produtoImportado = false; break;             // 3 - Nacional, mercadoria ou bem com Conteúdo de Importação superior a 40% (quarenta por cento) e inferior ou igual a 70% (setenta por cento)
      case '4' : produtoImportado = false; break;             // 4 - Nacional, cuja produção tenha sido feita em conformidade com os processos produtivos básicos de que tratam o Decreto-Lei no 288/67, e as Leis nos 8.248/91, 8.387/91, 10.176/01 e 11.484/07
      case '5' : produtoImportado = false; break;             // 5 - Nacional, mercadoria ou bem com Conteúdo de Importação inferior ou igual a 40% (quarenta por cento)
      case '6' : produtoImportado = true; break;              // 6 - Estrangeira - Importação direta, sem similar nacional, constante em lista de Resolução CAMEX e gás natural
      case '7' : produtoImportado = true; break;              // 7 - Estrangeira - Adquirida no mercado interno, sem similar nacional, constante em lista de Resolução CAMEX e gás natural 
      case '8' : produtoImportado = false; break;             // 8 - Nacional, mercadoria ou bem com Conteúdo de Importação superior a 70% (setenta por cento) 
      default:
    }
    double valorTributoFederal = 0;
    double valorTributoEstadual = 0;
    double valorTributoMunicipal = 0;
    for (var i = 0; i < Sessao.tabelaIbpt.length; i++) {
      if (Sessao.tabelaIbpt[i][0] == int.tryParse(vendaDetalhe.produto.codigoNcm)) {
        if(produtoImportado) {
          valorTributoFederal = Biblioteca.multiplicarMonetario((Sessao.tabelaIbpt[i][5] / 100), vendaDetalhe.pdvVendaDetalhe.valorTotal); 
        } else {
          valorTributoFederal = Biblioteca.multiplicarMonetario((Sessao.tabelaIbpt[i][4] / 100), vendaDetalhe.pdvVendaDetalhe.valorTotal); 
        }
        valorTributoEstadual = Biblioteca.multiplicarMonetario((Sessao.tabelaIbpt[i][6] / 100), vendaDetalhe.pdvVendaDetalhe.valorTotal); 
        valorTributoMunicipal = Biblioteca.multiplicarMonetario((Sessao.tabelaIbpt[i][7] / 100), vendaDetalhe.pdvVendaDetalhe.valorTotal); 
      }
    }        
    vendaDetalhe.pdvVendaDetalhe = 
      vendaDetalhe.pdvVendaDetalhe.copyWith(
        valorImpostoMunicipal: valorTributoMunicipal,
        valorImpostoEstadual: valorTributoEstadual,
        valorImpostoFederal: valorTributoFederal,
      );
  }


}