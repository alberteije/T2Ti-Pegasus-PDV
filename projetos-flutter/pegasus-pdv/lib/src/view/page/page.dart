/*
Title: T2Ti ERP 3.0                                                                
Description: Arquivo que exporta os todas as páginas
                                                                                
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

// PDV
export 'package:pegasus_pdv/src/view/page/pdv/caixa_page.dart';
export 'package:pegasus_pdv/src/view/page/pdv/efetua_pagamento_page.dart';
export 'package:pegasus_pdv/src/view/page/pdv/informa_valor_page.dart';
export 'package:pegasus_pdv/src/view/page/pdv/parcelamento_receitas_page.dart';
export 'package:pegasus_pdv/src/view/page/pdv/produto_detalhe_page.dart';
export 'package:pegasus_pdv/src/view/page/pdv/identifica_cliente_page.dart';

// Movimento
export 'package:pegasus_pdv/src/view/page/movimento/movimento_encerra_page.dart';
export 'package:pegasus_pdv/src/view/page/movimento/movimento_inicia_page.dart';
export 'package:pegasus_pdv/src/view/page/movimento/movimento_lista_page.dart';

// Cadastros
export 'package:pegasus_pdv/src/view/page/cadastros/cliente/cliente_lista_page.dart';
export 'package:pegasus_pdv/src/view/page/cadastros/cliente/cliente_persiste_page.dart';
export 'package:pegasus_pdv/src/view/page/cadastros/cliente/cliente_fiado_lista_page.dart';

export 'package:pegasus_pdv/src/view/page/cadastros/fornecedor/fornecedor_lista_page.dart';
export 'package:pegasus_pdv/src/view/page/cadastros/fornecedor/fornecedor_persiste_page.dart';

export 'package:pegasus_pdv/src/view/page/cadastros/colaborador/colaborador_lista_page.dart';
export 'package:pegasus_pdv/src/view/page/cadastros/colaborador/colaborador_persiste_page.dart';

export 'package:pegasus_pdv/src/view/page/cadastros/empresa/empresa_lista_page.dart';
export 'package:pegasus_pdv/src/view/page/cadastros/empresa/empresa_persiste_page.dart';

export 'package:pegasus_pdv/src/view/page/cadastros/pdv_tipo_pagamento/pdv_tipo_pagamento_lista_page.dart';
export 'package:pegasus_pdv/src/view/page/cadastros/pdv_tipo_pagamento/pdv_tipo_pagamento_persiste_page.dart';

export 'package:pegasus_pdv/src/view/page/cadastros/produto_unidade/produto_unidade_lista_page.dart';
export 'package:pegasus_pdv/src/view/page/cadastros/produto_unidade/produto_unidade_persiste_page.dart';

export 'package:pegasus_pdv/src/view/page/cadastros/produto_tipo/produto_tipo_lista_page.dart';
export 'package:pegasus_pdv/src/view/page/cadastros/produto_tipo/produto_tipo_persiste_page.dart';

export 'package:pegasus_pdv/src/view/page/cadastros/produto/produto_page.dart';
export 'package:pegasus_pdv/src/view/page/cadastros/produto/produto_lista_page.dart';
export 'package:pegasus_pdv/src/view/page/cadastros/produto/produto_persiste_page.dart';
export 'package:pegasus_pdv/src/view/page/cadastros/produto/produto_ficha_tecnica_lista_page.dart';
export 'package:pegasus_pdv/src/view/page/cadastros/produto/produto_ficha_tecnica_persiste_page.dart';

export 'package:pegasus_pdv/src/view/page/cadastros/produto_grupo/produto_grupo_lista_page.dart';
export 'package:pegasus_pdv/src/view/page/cadastros/produto_grupo/produto_grupo_persiste_page.dart';

export 'package:pegasus_pdv/src/view/page/cadastros/produto_subgrupo/produto_subgrupo_lista_page.dart';
export 'package:pegasus_pdv/src/view/page/cadastros/produto_subgrupo/produto_subgrupo_persiste_page.dart';


// Compras
export 'package:pegasus_pdv/src/view/page/compras/pedido/compra_pedido_cabecalho_lista_page.dart';
export 'package:pegasus_pdv/src/view/page/compras/pedido/compra_pedido_cabecalho_persiste_page.dart';


// Financeiro
export 'package:pegasus_pdv/src/view/page/financeiro/contas_pagar/contas_pagar_lista_page.dart';
export 'package:pegasus_pdv/src/view/page/financeiro/contas_pagar/contas_pagar_persiste_page.dart';

export 'package:pegasus_pdv/src/view/page/financeiro/contas_receber/contas_receber_lista_page.dart';
export 'package:pegasus_pdv/src/view/page/financeiro/contas_receber/contas_receber_persiste_page.dart';

// Estoque
export 'package:pegasus_pdv/src/view/page/estoque/estoque_lista_page.dart';

// dashboard
export 'package:pegasus_pdv/src/view/page/dashboard/dashboard_page.dart';

// relatórios
export 'package:pegasus_pdv/src/view/page/relatorios/encerra_movimento_relatorio.dart';
export 'package:pegasus_pdv/src/view/page/relatorios/recibo_relatorio_a4.dart';
export 'package:pegasus_pdv/src/view/page/relatorios/recibo_relatorio_80.dart';
export 'package:pegasus_pdv/src/view/page/relatorios/recibo_relatorio_57.dart';
export 'package:pegasus_pdv/src/view/page/relatorios/comanda_relatorio_80.dart';


// vendas
export 'package:pegasus_pdv/src/view/page/vendas/vendas_lista_page.dart';

// configurações
export 'package:pegasus_pdv/src/view/page/configuracoes/configuracao_page.dart';
export 'package:pegasus_pdv/src/view/page/configuracoes/configuracao_aba_cadastro.dart';
export 'package:pegasus_pdv/src/view/page/configuracoes/configuracao_aba_geral.dart';
export 'package:pegasus_pdv/src/view/page/configuracoes/configuracao_aba_nfce.dart';

// tributação
export 'package:pegasus_pdv/src/view/page/tributacao/tribut_configura_of_gt/tribut_configura_of_gt_lista_page.dart';
export 'package:pegasus_pdv/src/view/page/tributacao/tribut_configura_of_gt/tribut_configura_of_gt_persiste_page.dart';

export 'package:pegasus_pdv/src/view/page/tributacao/tribut_grupo_tributario/tribut_grupo_tributario_lista_page.dart';
export 'package:pegasus_pdv/src/view/page/tributacao/tribut_grupo_tributario/tribut_grupo_tributario_persiste_page.dart';

export 'package:pegasus_pdv/src/view/page/tributacao/tribut_operacao_fiscal/tribut_operacao_fiscal_lista_page.dart';
export 'package:pegasus_pdv/src/view/page/tributacao/tribut_operacao_fiscal/tribut_operacao_fiscal_persiste_page.dart';

// nfc-e
export 'package:pegasus_pdv/src/view/page/nfce/nfe_cabecalho_page.dart';
export 'package:pegasus_pdv/src/view/page/nfce/nfe_cabecalho_lista_page.dart';
export 'package:pegasus_pdv/src/view/page/nfce/nfe_cabecalho_persiste_page.dart';
export 'package:pegasus_pdv/src/view/page/nfce/nfe_detalhe_lista_page.dart';
export 'package:pegasus_pdv/src/view/page/nfce/nfce_inutiliza_numero_page.dart';
export 'package:pegasus_pdv/src/view/page/nfce/nfce_contrata_page.dart';
export 'package:pegasus_pdv/src/view/page/nfce/nfe_devolucao_page.dart';
export 'package:pegasus_pdv/src/view/page/nfce/nfe_devolucao_persiste_page.dart';

// food
export 'package:pegasus_pdv/src/view/page/food/cozinha/cozinha_lista_page.dart';
export 'package:pegasus_pdv/src/view/page/food/cozinha/cozinha_persiste_page.dart';
export 'package:pegasus_pdv/src/view/page/food/mesa/mesa_page.dart';
export 'package:pegasus_pdv/src/view/page/food/mesa/mesa_cadastro_page.dart';
export 'package:pegasus_pdv/src/view/page/food/reserva/reserva_lista_page.dart';
export 'package:pegasus_pdv/src/view/page/food/reserva/reserva_persiste_page.dart';
export 'package:pegasus_pdv/src/view/page/food/comanda/comanda_page.dart';
export 'package:pegasus_pdv/src/view/page/food/comanda/comanda_cadastro_page.dart';
export 'package:pegasus_pdv/src/view/page/food/comanda/comanda_lista_page.dart';
export 'package:pegasus_pdv/src/view/page/food/comanda/comanda_detalhe_page.dart';
export 'package:pegasus_pdv/src/view/page/food/comanda/comanda_tile_detalhe_page.dart';
export 'package:pegasus_pdv/src/view/page/food/comanda/comanda_observacao_padrao_lista_page.dart';
export 'package:pegasus_pdv/src/view/page/food/comanda/comanda_observacao_padrao_persiste_page.dart';
export 'package:pegasus_pdv/src/view/page/food/comanda/comanda_observacao_padrao_lookup_page.dart';
export 'package:pegasus_pdv/src/view/page/food/comanda/comanda_cardapio_pergunta_lookup_page.dart';
export 'package:pegasus_pdv/src/view/page/food/cardapio_digital/cardapio_page.dart';
export 'package:pegasus_pdv/src/view/page/food/cardapio_digital/cardapio_detalhe_page.dart';

// delivery
export 'package:pegasus_pdv/src/view/page/delivery/taxa_entrega/taxa_entrega_lista_page.dart';
export 'package:pegasus_pdv/src/view/page/delivery/taxa_entrega/taxa_entrega_persiste_page.dart';
export 'package:pegasus_pdv/src/view/page/delivery/delivery_lista_page.dart';
export 'package:pegasus_pdv/src/view/page/delivery/delivery_persiste_page.dart';
export 'package:pegasus_pdv/src/view/page/delivery/delivery_acerto_persiste_page.dart';
