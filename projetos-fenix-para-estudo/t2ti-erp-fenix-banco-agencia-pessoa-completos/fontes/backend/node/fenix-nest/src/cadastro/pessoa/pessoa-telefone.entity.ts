import { Entity, Column, PrimaryGeneratedColumn, ManyToOne, RelationId, JoinColumn } from 'typeorm';
import { Pessoa } from './pessoa.entity';

@Entity({ name: 'pessoa_telefone' })
export class PessoaTelefone {

	@PrimaryGeneratedColumn()
	id: number;

	@Column({ name: 'ID_PESSOA', type: 'int' })
	idPessoa: number;

	@Column({ name: 'TIPO', type: 'varchar', length: 1 })
	tipo: string;

	@Column({ name: 'NUMERO', type: 'varchar', length: 15 })
	numero: string;

	/**
	 * Relations
	 */

	@ManyToOne(() => Pessoa, pessoa => pessoa.listaPessoaTelefone)
	@JoinColumn({ name: "ID_PESSOA" })
	pessoa: Pessoa;

	constructor(objetoJson: {}) {
		if (objetoJson != null) {
			this.tipo = objetoJson['tipo'];
			this.numero = objetoJson['numero'];
		}
	}

}