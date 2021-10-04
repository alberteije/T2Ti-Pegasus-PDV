import { Entity, Column, PrimaryGeneratedColumn, ManyToOne, JoinColumn } from 'typeorm';
import { Pessoa } from './pessoa.entity';

@Entity({ name: 'pessoa_endereco' })
export class PessoaEndereco {

	@PrimaryGeneratedColumn()
	id: number;

	@Column({ name: 'ID_PESSOA', type: 'int' })
	idPessoa: number;

	@Column({ name: 'LOGRADOURO', type: 'varchar', length: 100 })
	logradouro: string;

	@Column({ name: 'NUMERO', type: 'varchar', length: 10 })
	numero: string;

	@Column({ name: 'BAIRRO', type: 'varchar', length: 100 })
	bairro: string;

	@Column({ name: 'MUNICIPIO_IBGE', type: 'int' })
	municipioIbge: number;

	@Column({ name: 'COMPLEMENTO', type: 'varchar', length: 100 })
	complemento: string;

	@Column({ name: 'PRINCIPAL', type: 'varchar', length: 1 })
	principal: string;

	@Column({ name: 'ENTREGA', type: 'varchar', length: 1 })
	entrega: string;

	@Column({ name: 'COBRANCA', type: 'varchar', length: 1 })
	cobranca: string;

	@Column({ name: 'CORRESPONDENCIA', type: 'varchar', length: 1 })
	correspondencia: string;

	@Column({ name: 'UF', type: 'varchar', length: 2 })
	uf: string;

	@Column({ name: 'CEP', type: 'varchar', length: 8 })
	cep: string;

	@Column({ name: 'CIDADE', type: 'varchar', length: 100 })
	cidade: string;

	/**
	 * Relations
	 */

	@ManyToOne(() => Pessoa, pessoa => pessoa.listaPessoaEndereco)
	@JoinColumn({ name: "ID_PESSOA" })
	pessoa: Pessoa;

	constructor(objetoJson: {}) {
		if (objetoJson != null) {
			this.logradouro = objetoJson['logradouro'];
			this.numero = objetoJson['numero'];
			this.bairro = objetoJson['bairro'];
			this.municipioIbge = objetoJson['municipioIbge'];
			this.complemento = objetoJson['complemento'];
			this.principal = objetoJson['principal'];
			this.entrega = objetoJson['entrega'];
			this.cobranca = objetoJson['cobranca'];
			this.correspondencia = objetoJson['correspondencia'];
			this.uf = objetoJson['uf'];
			this.cep = objetoJson['cep'];
			this.cidade = objetoJson['cidade'];
		}
	}
}