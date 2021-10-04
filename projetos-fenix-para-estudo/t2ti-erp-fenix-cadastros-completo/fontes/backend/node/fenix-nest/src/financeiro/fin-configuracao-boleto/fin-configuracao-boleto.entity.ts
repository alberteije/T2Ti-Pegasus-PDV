/*******************************************************************************
Title: T2Ti ERP Fenix                                                                
Description: Model relacionado à tabela [FIN_CONFIGURACAO_BOLETO] 
                                                                                
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
import { Entity, Column, PrimaryGeneratedColumn, OneToOne, JoinColumn } from 'typeorm';
import { BancoContaCaixa } from '../../entities-export';

@Entity({ name: 'FIN_CONFIGURACAO_BOLETO' })
export class FinConfiguracaoBoleto { 

	@PrimaryGeneratedColumn()
	id: number;

	@Column({ name: 'INSTRUCAO01' })
	instrucao01: string;

	@Column({ name: 'INSTRUCAO02' })
	instrucao02: string;

	@Column({ name: 'CAMINHO_ARQUIVO_REMESSA' })
	caminhoArquivoRemessa: string;

	@Column({ name: 'CAMINHO_ARQUIVO_RETORNO' })
	caminhoArquivoRetorno: string;

	@Column({ name: 'CAMINHO_ARQUIVO_LOGOTIPO' })
	caminhoArquivoLogotipo: string;

	@Column({ name: 'CAMINHO_ARQUIVO_PDF' })
	caminhoArquivoPdf: string;

	@Column({ name: 'MENSAGEM' })
	mensagem: string;

	@Column({ name: 'LOCAL_PAGAMENTO' })
	localPagamento: string;

	@Column({ name: 'LAYOUT_REMESSA' })
	layoutRemessa: string;

	@Column({ name: 'ACEITE' })
	aceite: string;

	@Column({ name: 'ESPECIE' })
	especie: string;

	@Column({ name: 'CARTEIRA' })
	carteira: string;

	@Column({ name: 'CODIGO_CONVENIO' })
	codigoConvenio: string;

	@Column({ name: 'CODIGO_CEDENTE' })
	codigoCedente: string;

	@Column({ name: 'TAXA_MULTA' })
	taxaMulta: number;

	@Column({ name: 'TAXA_JURO' })
	taxaJuro: number;

	@Column({ name: 'DIAS_PROTESTO' })
	diasProtesto: number;

	@Column({ name: 'NOSSO_NUMERO_ANTERIOR' })
	nossoNumeroAnterior: string;


	/**
	* Relations
	*/
    @OneToOne(() => BancoContaCaixa)
    @JoinColumn({ name: "ID_BANCO_CONTA_CAIXA" })
    bancoContaCaixa: BancoContaCaixa;


	/**
	* Constructor
	*/
	constructor(objetoJson: {}) {
		if (objetoJson != null) {
			this.id = objetoJson['id'];
			this.instrucao01 = objetoJson['instrucao01'];
			this.instrucao02 = objetoJson['instrucao02'];
			this.caminhoArquivoRemessa = objetoJson['caminhoArquivoRemessa'];
			this.caminhoArquivoRetorno = objetoJson['caminhoArquivoRetorno'];
			this.caminhoArquivoLogotipo = objetoJson['caminhoArquivoLogotipo'];
			this.caminhoArquivoPdf = objetoJson['caminhoArquivoPdf'];
			this.mensagem = objetoJson['mensagem'];
			this.localPagamento = objetoJson['localPagamento'];
			this.layoutRemessa = objetoJson['layoutRemessa'];
			this.aceite = objetoJson['aceite'];
			this.especie = objetoJson['especie'];
			this.carteira = objetoJson['carteira'];
			this.codigoConvenio = objetoJson['codigoConvenio'];
			this.codigoCedente = objetoJson['codigoCedente'];
			this.taxaMulta = objetoJson['taxaMulta'];
			this.taxaJuro = objetoJson['taxaJuro'];
			this.diasProtesto = objetoJson['diasProtesto'];
			this.nossoNumeroAnterior = objetoJson['nossoNumeroAnterior'];
			
			if (objetoJson['bancoContaCaixa'] != null) {
				this.bancoContaCaixa = new BancoContaCaixa(objetoJson['bancoContaCaixa']);
			}

			
		}
	}
}