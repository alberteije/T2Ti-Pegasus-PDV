/*******************************************************************************
Title: T2Ti ERP Fenix                                                                
Description: Modules relacionados ao bloco Financeiro
                                                                                
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
import { Module } from '@nestjs/common';
import { FinChequeEmitidoModule } from '../financeiro/fin-cheque-emitido/fin-cheque-emitido.module';
import { FinChequeRecebidoModule } from '../financeiro/fin-cheque-recebido/fin-cheque-recebido.module';
import { FinConfiguracaoBoletoModule } from '../financeiro/fin-configuracao-boleto/fin-configuracao-boleto.module';
import { FinDocumentoOrigemModule } from '../financeiro/fin-documento-origem/fin-documento-origem.module';
import { FinExtratoContaBancoModule } from '../financeiro/fin-extrato-conta-banco/fin-extrato-conta-banco.module';
import { FinFechamentoCaixaBancoModule } from '../financeiro/fin-fechamento-caixa-banco/fin-fechamento-caixa-banco.module';
import { FinLancamentoPagarModule } from '../financeiro/fin-lancamento-pagar/fin-lancamento-pagar.module';
import { FinLancamentoReceberModule } from '../financeiro/fin-lancamento-receber/fin-lancamento-receber.module';
import { FinNaturezaFinanceiraModule } from '../financeiro/fin-natureza-financeira/fin-natureza-financeira.module';
import { FinStatusParcelaModule } from '../financeiro/fin-status-parcela/fin-status-parcela.module';
import { FinTipoPagamentoModule } from '../financeiro/fin-tipo-pagamento/fin-tipo-pagamento.module';
import { FinTipoRecebimentoModule } from '../financeiro/fin-tipo-recebimento/fin-tipo-recebimento.module';
import { TalonarioChequeModule } from '../financeiro/talonario-cheque/talonario-cheque.module';

@Module({
    imports: [
		FinChequeEmitidoModule,
		FinChequeRecebidoModule,
		FinConfiguracaoBoletoModule,
		FinDocumentoOrigemModule,
		FinExtratoContaBancoModule,
		FinFechamentoCaixaBancoModule,
		FinLancamentoPagarModule,
		FinLancamentoReceberModule,
		FinNaturezaFinanceiraModule,
		FinStatusParcelaModule,
		FinTipoPagamentoModule,
		FinTipoRecebimentoModule,
		TalonarioChequeModule,
    ],
})
export class FinanceiroModule { }
