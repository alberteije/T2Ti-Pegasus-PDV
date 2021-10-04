import { Entity, Column, PrimaryGeneratedColumn, ManyToOne, RelationId, JoinColumn, OneToOne } from 'typeorm';
import { Pessoa } from './pessoa.entity';

@Entity({ name: 'pessoa_juridica' })
export class PessoaJuridica {

	@PrimaryGeneratedColumn()
	id: number;

	@Column({ name: 'ID_PESSOA', type: 'int' })
	idPessoa: number;

	@Column({ name: 'CNPJ', type: 'varchar', length: 14 })
	cnpj: string;
	
	@Column({ name: 'NOME_FANTASIA', type: 'varchar', length: 100 })
	nomeFantasia: string;

	@Column({ name: 'INSCRICAO_ESTADUAL', type: 'varchar', length: 45 })
	inscricaoEstadual: string;

	@Column({ name: 'INSCRICAO_MUNICIPAL', type: 'varchar', length: 45 })
	inscricaoMunicipal: string;
	
	@Column({ name: 'DATA_CONSTITUICAO', type: 'date' })
	dataConstituicao: Date;

	@Column({ name: 'TIPO_REGIME', type: 'varchar', length: 1 })
	tipoRegime: string;

	@Column({ name: 'CRT', type: 'varchar', length: 1 })
	crt: string;

	/**
	 * Relations
	 */

	@OneToOne(() => Pessoa, pessoa => pessoa.pessoaJuridica)
	@JoinColumn({ name: "ID_PESSOA" })
	pessoa: Pessoa;

	constructor(objetoJson: {}) {
		if (objetoJson != null) {
            this.cnpj = objetoJson['cnpj'];
            this.nomeFantasia = objetoJson['nomeFantasia'];
            this.dataConstituicao = objetoJson['dataConstituicao'];
            this.inscricaoEstadual = objetoJson['inscricaoEstadual'];
            this.inscricaoMunicipal = objetoJson['inscricaoMunicipal'];
            this.tipoRegime = objetoJson['tipoRegime'];
            this.crt = objetoJson['crt'];
		}
	}

}