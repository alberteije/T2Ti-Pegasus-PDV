import { Entity, Column, PrimaryGeneratedColumn, OneToMany } from 'typeorm';

@Entity({name: 'banco'})
export class Banco {
  
  @PrimaryGeneratedColumn()
  id: number;

  @Column({ name: 'CODIGO', type: 'varchar', length: 10 })
  codigo: string;

  @Column({ name: 'NOME', type: 'varchar', length: 100 })
  nome: string;

  @Column({ name: 'URL', type: 'varchar', length: 250 })
  url: string;
}