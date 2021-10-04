/*******************************************************************************
Title: T2Ti ERP Fenix                                                                
Description: Module relacionado ao módulo Cadastros Base
                                                                                
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
import { BancoModule } from '../cadastros/banco/banco.module';
import { BancoAgenciaModule } from '../cadastros/banco-agencia/banco-agencia.module';
import { BancoContaCaixaModule } from '../cadastros/banco-conta-caixa/banco-conta-caixa.module';
import { PessoaModule } from '../cadastros/pessoa/pessoa.module';
import { ProdutoModule } from '../cadastros/produto/produto.module';
import { ProdutoGrupoModule } from '../cadastros/produto-grupo/produto-grupo.module';
import { ProdutoSubgrupoModule } from '../cadastros/produto-subgrupo/produto-subgrupo.module';
import { ProdutoMarcaModule } from '../cadastros/produto-marca/produto-marca.module';
import { ProdutoUnidadeModule } from '../cadastros/produto-unidade/produto-unidade.module';
import { EstadoCivilModule } from '../cadastros/estado-civil/estado-civil.module';
import { NivelFormacaoModule } from '../cadastros/nivel-formacao/nivel-formacao.module';
import { CargoModule } from '../cadastros/cargo/cargo.module';
import { CepModule } from '../cadastros/cep/cep.module';
import { CfopModule } from '../cadastros/cfop/cfop.module';
import { ClienteModule } from '../cadastros/cliente/cliente.module';
import { CnaeModule } from '../cadastros/cnae/cnae.module';
import { ColaboradorModule } from '../cadastros/colaborador/colaborador.module';
import { SetorModule } from '../cadastros/setor/setor.module';
import { PapelModule } from '../cadastros/papel/papel.module';
import { ContadorModule } from '../cadastros/contador/contador.module';
import { CsosnModule } from '../cadastros/csosn/csosn.module';
import { CstCofinsModule } from '../cadastros/cst-cofins/cst-cofins.module';
import { CstIcmsModule } from '../cadastros/cst-icms/cst-icms.module';
import { CstIpiModule } from '../cadastros/cst-ipi/cst-ipi.module';
import { CstPisModule } from '../cadastros/cst-pis/cst-pis.module';
import { FornecedorModule } from '../cadastros/fornecedor/fornecedor.module';
import { MunicipioModule } from '../cadastros/municipio/municipio.module';
import { NcmModule } from '../cadastros/ncm/ncm.module';
import { TransportadoraModule } from '../cadastros/transportadora/transportadora.module';
import { UfModule } from '../cadastros/uf/uf.module';
import { VendedorModule } from '../cadastros/vendedor/vendedor.module';

@Module({
    imports: [
        BancoModule,
        BancoAgenciaModule,
		BancoContaCaixaModule,
        PessoaModule,
        ProdutoModule,
        ProdutoGrupoModule,
        ProdutoSubgrupoModule,
        ProdutoUnidadeModule,
        ProdutoMarcaModule,
        EstadoCivilModule,
        NivelFormacaoModule,
		CargoModule,
		CepModule,
		CfopModule,
		ClienteModule,
		CnaeModule,
		ColaboradorModule,
		SetorModule,
		PapelModule,
		ContadorModule,
		CsosnModule,
		CstCofinsModule,
		CstIcmsModule,
		CstIpiModule,
		CstPisModule,
		FornecedorModule,
		MunicipioModule,
		NcmModule,
		TransportadoraModule,
		UfModule,
		VendedorModule,
    ],
})
export class CadastrosModule { }
