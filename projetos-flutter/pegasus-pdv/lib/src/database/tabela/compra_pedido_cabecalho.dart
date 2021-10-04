/*
Title: T2Ti ERP Pegasus                                                                
Description: Table Moor relacionada à tabela [COMPRA_PEDIDO_CABECALHO] 
                                                                                
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
import 'package:moor/moor.dart';

import '../database.dart';

@DataClassName("CompraPedidoCabecalho")
class CompraPedidoCabecalhos extends Table {
  String get tableName => 'COMPRA_PEDIDO_CABECALHO';

  IntColumn get id => integer().named('ID').autoIncrement()();
  IntColumn get idColaborador => integer().named('ID_COLABORADOR').nullable().customConstraint('NULLABLE REFERENCES COLABORADOR(ID)')();
  IntColumn get idFornecedor => integer().named('ID_FORNECEDOR').nullable().customConstraint('NULLABLE REFERENCES FORNECEDOR(ID)')();
  DateTimeColumn get dataPedido => dateTime().named('DATA_PEDIDO').nullable()();
  DateTimeColumn get dataPrevisaoEntrega => dateTime().named('DATA_PREVISAO_ENTREGA').nullable()();
  DateTimeColumn get dataPrevisaoPagamento => dateTime().named('DATA_PREVISAO_PAGAMENTO').nullable()();
  TextColumn get localEntrega => text().named('LOCAL_ENTREGA').withLength(min: 0, max: 100).nullable()();
  TextColumn get localCobranca => text().named('LOCAL_COBRANCA').withLength(min: 0, max: 100).nullable()();
  TextColumn get contato => text().named('CONTATO').withLength(min: 0, max: 50).nullable()();
  RealColumn get valorSubtotal => real().named('VALOR_SUBTOTAL').nullable()();
  RealColumn get taxaDesconto => real().named('TAXA_DESCONTO').nullable()();
  RealColumn get valorDesconto => real().named('VALOR_DESCONTO').nullable()();
  RealColumn get valorTotal => real().named('VALOR_TOTAL').nullable()();
  TextColumn get formaPagamento => text().named('FORMA_PAGAMENTO').withLength(min: 0, max: 10).nullable()();
  TextColumn get geraFinanceiro => text().named('GERA_FINANCEIRO').withLength(min: 0, max: 1).nullable()();
  IntColumn get quantidadeParcelas => integer().named('QUANTIDADE_PARCELAS').nullable()();
  DateTimeColumn get diaPrimeiroVencimento => dateTime().named('DIA_PRIMEIRO_VENCIMENTO').nullable()();
  IntColumn get intervaloEntreParcelas => integer().named('INTERVALO_ENTRE_PARCELAS').nullable()();
  TextColumn get diaFixoParcela => text().named('DIA_FIXO_PARCELA').withLength(min: 0, max: 2).nullable()();
  DateTimeColumn get dataRecebimentoItens => dateTime().named('DATA_RECEBIMENTO_ITENS').nullable()();
  TextColumn get horaRecebimentoItens => text().named('HORA_RECEBIMENTO_ITENS').withLength(min: 0, max: 8).nullable()();
  TextColumn get atualizouEstoque => text().named('ATUALIZOU_ESTOQUE').withLength(min: 0, max: 1).nullable()();
  TextColumn get numeroDocumentoEntrada => text().named('NUMERO_DOCUMENTO_ENTRADA').withLength(min: 0, max: 50).nullable()();
}

class CompraPedidoCabecalhoMontado {
  CompraPedidoCabecalho compraPedidoCabecalho;
  Colaborador colaborador;
  Fornecedor fornecedor;

  CompraPedidoCabecalhoMontado({
    this.compraPedidoCabecalho,
    this.colaborador,
    this.fornecedor,
  });
}