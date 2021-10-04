import { Entity, Column, PrimaryGeneratedColumn, ManyToOne, RelationId, JoinColumn } from 'typeorm';
import { Pessoa } from './pessoa.entity';

@Entity({ name: 'pessoa_contato' })
export class PessoaContato {

	@PrimaryGeneratedColumn()
	id: number;

	@Column({ name: 'ID_PESSOA', type: 'int' })
	idPessoa: number;

	@Column({ name: 'NOME', type: 'varchar', length: 150 })
	nome: string;

	@Column({ name: 'EMAIL', type: 'varchar', length: 250 })
	email: string;

	@Column({ name: 'OBSERVACAO', type: 'varchar', length: 250 })
	observacao: string;

	/**
	 * Relations
	 */

	@ManyToOne(() => Pessoa, pessoa => pessoa.listaPessoaContato)
	@JoinColumn({ name: "ID_PESSOA" })
	pessoa: Pessoa;

	constructor(objetoJson: {}) {
		if (objetoJson != null) {
			this.nome = objetoJson['nome'];
			this.email = objetoJson['email'];
			this.observacao = objetoJson['observacao'];
		}
	}

}