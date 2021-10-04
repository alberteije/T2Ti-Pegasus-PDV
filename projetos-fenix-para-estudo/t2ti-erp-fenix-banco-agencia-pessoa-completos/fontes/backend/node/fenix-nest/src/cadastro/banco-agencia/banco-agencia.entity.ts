import { Entity, Column, PrimaryGeneratedColumn, ManyToOne, JoinColumn } from 'typeorm';
import { Banco } from '../banco/banco.entity';

@Entity({ name: 'banco_agencia' })
export class BancoAgencia {

  @PrimaryGeneratedColumn()
  id: number;

  @Column({ name: 'NUMERO', type: 'varchar', length: 20 })
  numero: string;

  @Column({ name: 'DIGITO', type: 'varchar', length: 1 })
  digito: string;

  @Column({ name: 'NOME', type: 'varchar', length: 100 })
  nome: string;

  @Column({ name: 'TELEFONE', type: 'varchar', length: 15 })
  telefone: string;

  @Column({ name: 'CONTATO', type: 'varchar', length: 100 })
  contato: string;

  @Column({ name: 'OBSERVACAO', type: 'varchar', length: 250 })
  observacao: string;

  @Column({ name: 'GERENTE', type: 'varchar', length: 100 })
  gerente: string;

  /**
   * Relations
   * https://github.com/typeorm/typeorm/blob/master/docs/relations.md
   */

  @ManyToOne(() => Banco)
  @JoinColumn({ name: "ID_BANCO" })
  banco: Banco;

}