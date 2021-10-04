import { Entity, Column, PrimaryGeneratedColumn, OneToOne, JoinColumn } from 'typeorm';
import { Pessoa } from './pessoa.entity';

@Entity({ name: 'pessoa_fisica' })
export class PessoaFisica {

	@PrimaryGeneratedColumn()
	id: number;

	@Column({ name: 'ID_PESSOA', type: 'int' })
	idPessoa: number;

	@Column({ name: 'CPF', type: 'varchar', length: 11 })
	cpf: string;

	@Column({ name: 'RG', type: 'varchar', length: 20 })
	rg: string;

	@Column({ name: 'ORGAO_RG', type: 'varchar', length: 20 })
	orgaoRg: string;

	@Column({ name: 'DATA_EMISSAO_RG', type: 'date' })
	dataEmissaoRg: Date;

	@Column({ name: 'DATA_NASCIMENTO', type: 'date' })
	dataNascimento: Date;

	@Column({ name: 'SEXO', type: 'varchar', length: 1 })
	sexo: string;

	@Column({ name: 'RACA', type: 'varchar', length: 1 })
	raca: string;

	@Column({ name: 'NACIONALIDADE', type: 'varchar', length: 100 })
	nacionalidade: string;

	@Column({ name: 'NATURALIDADE', type: 'varchar', length: 100 })
	naturalidade: string;

	@Column({ name: 'NOME_PAI', type: 'varchar', length: 200 })
	nomePai: string;

	@Column({ name: 'NOME_MAE', type: 'varchar', length: 200 })
	nomeMae: string;

	/**
	 * Relations
	 */

	@OneToOne(() => Pessoa, pessoa => pessoa.pessoaFisica)
	@JoinColumn({ name: "ID_PESSOA" })
	pessoa: Pessoa;

	constructor(objetoJson: {}) {
		if (objetoJson != null) {
			this.cpf = objetoJson['cpf'];
			this.rg = objetoJson['rg'];
			this.orgaoRg = objetoJson['orgaoRg'];
			this.dataEmissaoRg = objetoJson['dataEmissaoRg'];
			this.dataNascimento = objetoJson['dataNascimento'];
			this.sexo = objetoJson['sexo'];
			this.raca = objetoJson['raca'];
			this.nacionalidade = objetoJson['nacionalidade'];
			this.naturalidade = objetoJson['naturalidade'];
			this.nomePai = objetoJson['nomePai'];
			this.nomeMae = objetoJson['nomeMae'];
		}
	}
}