/*******************************************************************************
Title: T2Ti ERP 3.0                                                                
Description: Service relacionado à tabela [PDV_PLANO_PAGAMENTO] 
                                                                                
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
import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { TypeOrmCrudService } from '@nestjsx/crud-typeorm';
import { PdvPlanoPagamento } from './pdv-plano-pagamento.entity';
import { getConnection, QueryRunner } from 'typeorm';
import { Biblioteca } from '../../util/biblioteca';
import { ObjetoPagSeguro } from '../../util/objeto.pagseguro';
import { PdvTipoPlano, Empresa } from '../../entities-export';

@Injectable()
export class PdvPlanoPagamentoService extends TypeOrmCrudService<PdvPlanoPagamento> {

  constructor(
    @InjectRepository(PdvPlanoPagamento) repository) { super(repository); }


	async atualizar(objetoPagSeguroEnviado: ObjetoPagSeguro): Promise<PdvPlanoPagamento> {
		let objetoRetorno: PdvPlanoPagamento;
		const connection = getConnection();
		const queryRunner = connection.createQueryRunner();

		await queryRunner.connect();
		await queryRunner.startTransaction();

		// primeiro verifica se já existe um registro armazenado para a transação, pois neste caso iremos apenas atualizar o registro
		let pdvPlanoPagamentoDB = await connection.manager.findOne(PdvPlanoPagamento, { where: { codigoTransacao: objetoPagSeguroEnviado.codigoTransacao }} );
		if (pdvPlanoPagamentoDB != null) {
			// atualiza o status
			pdvPlanoPagamentoDB.statusPagamento = objetoPagSeguroEnviado.codigoStatusTransacao;

			// se o status for pago, então atualiza a data de pagamento e de expiração do plano
			if (pdvPlanoPagamentoDB.statusPagamento == "3") {
				pdvPlanoPagamentoDB.dataPagamento = new Date();
				pdvPlanoPagamentoDB.dataPlanoExpira = new Date();
				switch (pdvPlanoPagamentoDB.plano) {
					case "M":
						pdvPlanoPagamentoDB.dataPlanoExpira.setMonth(pdvPlanoPagamentoDB.dataPagamento.getMonth() + 1);
						break;
					case "S":
						pdvPlanoPagamentoDB.dataPlanoExpira.setMonth(pdvPlanoPagamentoDB.dataPagamento.getMonth() + 6);
						break;
					case "A":
						pdvPlanoPagamentoDB.dataPlanoExpira.setMonth(pdvPlanoPagamentoDB.dataPagamento.getMonth() + 12);
						break;
					default:
						break;
				}
			}
			objetoRetorno = await queryRunner.manager.save(pdvPlanoPagamentoDB);
			await queryRunner.commitTransaction();
			return objetoRetorno;
		} else {
			// a falta de registro no banco indica que devemos criar um novo registro no banco de dados
			// que só será inserido se tiver vindo um tipo de plano válido na requisição
			let planoContratado = Biblioteca.pegarPlanoPdv(objetoPagSeguroEnviado.descricaoProduto);
			let moduloFiscal = Biblioteca.pegarModuloFiscalPdv(objetoPagSeguroEnviado.descricaoProduto);
			let tipoPlano = await connection.manager.findOne(PdvTipoPlano, { where: { plano: planoContratado, moduloFiscal: moduloFiscal }} );
			if (tipoPlano != null) {
				let pdvPlanoPagamento = new PdvPlanoPagamento({});
				pdvPlanoPagamento.pdvTipoPlano = tipoPlano;
				pdvPlanoPagamento.codigoTransacao = objetoPagSeguroEnviado.codigoTransacao;
				pdvPlanoPagamento.statusPagamento = objetoPagSeguroEnviado.codigoStatusTransacao;
				pdvPlanoPagamento.metodoPagamento = objetoPagSeguroEnviado.metodoPagamento;
				pdvPlanoPagamento.codigoTipoPagamento = objetoPagSeguroEnviado.codigoTipoPagamento;
				pdvPlanoPagamento.valor = objetoPagSeguroEnviado.valorUnitario;
				pdvPlanoPagamento.emailPagamento = objetoPagSeguroEnviado.emailCliente;
				pdvPlanoPagamento.dataSolicitacao = new Date();
				pdvPlanoPagamento.plano = planoContratado;

				// tenta encontrar a empresa pelo e-mail - se não encontrar, o usuário terá
				// que informar o código da transação na App para reconhecer o seu pagamento
				let empresa = await connection.manager.findOne(Empresa, { where: { email: objetoPagSeguroEnviado.emailCliente }} );
				if (empresa != null) {
					pdvPlanoPagamento.empresa = empresa;
				}

				objetoRetorno = await queryRunner.manager.save(pdvPlanoPagamento);
				await queryRunner.commitTransaction();
				return objetoRetorno;
			} else {
				return null;
			}
		}
	}
 
	async consultarPlanoAtivo(cnpj: string): Promise<PdvPlanoPagamento> {
        const connection = getConnection();
        const queryRunner = connection.createQueryRunner();  
        await queryRunner.connect();
        await queryRunner.startTransaction();

        let empresa = await connection.manager.findOne(Empresa, { where: { cnpj: cnpj }} );
        if (empresa != null) {
			let plano = await connection.manager.findOne(PdvPlanoPagamento, { where: { empresa: empresa, dataPlanoExpira: Date.now }} );
			return plano;
		} else {
			return null;
		}
	}	

	async confirmarTransacao(codigoTransacao: string, cnpj: string): Promise<number> {
        const connection = getConnection();
        const queryRunner = connection.createQueryRunner();  
        await queryRunner.connect();
        await queryRunner.startTransaction();

		// remove qualquer hifen que tenha sido colocado pelo usuário
		codigoTransacao = codigoTransacao.replace("-", "");  

		// primeiro verifica se existe o código da transação
		let pdvPlanoPagamento = await connection.manager.findOne(PdvPlanoPagamento, { where: { codigoTransacao: codigoTransacao }} );
		if (pdvPlanoPagamento != null)
		{
			if (pdvPlanoPagamento.empresa != null)
			{
				// achou o código da transação, mas o código já foi utilizado
				return 418;
			}
			else
			{
				// achou o código da transação e não está vinculado a nenhuma empresa
				// vamos vincular o id da empresa e o e-mail de pagamento
				// retorna 200
				let empresa = await connection.manager.findOne(Empresa, { where: { cnpj: cnpj }} );
				empresa.emailPagamento = pdvPlanoPagamento.emailPagamento;
				await queryRunner.manager.save(empresa);
				pdvPlanoPagamento.empresa = empresa;
				await queryRunner.manager.save(pdvPlanoPagamento);
				await queryRunner.commitTransaction();					
				return 200;
			}
		}
		else
		{
			// não achou o código da transação, retorna 404
			return 404;
		}
	}
}