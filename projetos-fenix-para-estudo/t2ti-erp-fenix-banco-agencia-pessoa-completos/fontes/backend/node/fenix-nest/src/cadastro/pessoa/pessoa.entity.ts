import { Entity, Column, PrimaryGeneratedColumn, OneToMany, OneToOne, JoinColumn } from 'typeorm';
import { PessoaEndereco } from './pessoa-endereco.entity';
import { PessoaContato } from './pessoa-contato.entity';
import { PessoaTelefone } from './pessoa-telefone.entity';
import { PessoaFisica } from './pessoa-fisica.entity';
import { PessoaJuridica } from './pessoa-juridica.entity';

@Entity({ name: 'pessoa' })
export class Pessoa {

  @PrimaryGeneratedColumn()
  id: number;

  @Column({ name: 'NOME', type: 'varchar', length: 150 })
  nome: string;

  @Column({ name: 'TIPO', type: 'varchar', length: 1 })
  tipo: string;

  @Column({ name: 'SITE', type: 'varchar', length: 250 })
  site: string;

  @Column({ name: 'EMAIL', type: 'varchar', length: 250 })
  email: string;

  @Column({ name: 'CLIENTE', type: 'varchar', length: 1 })
  cliente: string;

  @Column({ name: 'FORNECEDOR', type: 'varchar', length: 1 })
  fornecedor: string;

  @Column({ name: 'TRANSPORTADORA', type: 'varchar', length: 1 })
  transportadora: string;

  @Column({ name: 'COLABORADOR', type: 'varchar', length: 1 })
  colaborador: string;

  @Column({ name: 'CONTADOR', type: 'varchar', length: 1 })
  contador: string;

  /**
   * Relations
   * https://typeorm.io/#/relations
   * https://github.com/typeorm/typeorm/blob/master/docs/relations.md
   */

  @OneToOne(() => PessoaFisica, pessoaFisica => pessoaFisica.pessoa, { cascade: true })
  pessoaFisica: PessoaFisica;

  @OneToOne(() => PessoaJuridica, pessoaJuridica => pessoaJuridica.pessoa, { cascade: true })
  pessoaJuridica: PessoaJuridica;

  @OneToMany(() => PessoaEndereco, pessoaEndereco => pessoaEndereco.pessoa, { cascade: true })
  listaPessoaEndereco: PessoaEndereco[];

  @OneToMany(() => PessoaContato, pessoaContato => pessoaContato.pessoa, { cascade: true })
  listaPessoaContato: PessoaContato[];

  @OneToMany(() => PessoaTelefone, pessoaTelefone => pessoaTelefone.pessoa, { cascade: true })
  listaPessoaTelefone: PessoaTelefone[];

  constructor(objetoJson: {}) {
    if (objetoJson != null) {
      this.id = objetoJson['id'];
      this.nome = objetoJson['nome'];
      this.tipo = objetoJson['tipo'];
      this.site = objetoJson['site'];
      this.email = objetoJson['email'];
      this.cliente = objetoJson['cliente'];
      this.fornecedor = objetoJson['fornecedor'];
      this.transportadora = objetoJson['transportadora'];
      this.colaborador = objetoJson['colaborador'];
      this.contador = objetoJson['contador'];

      // Pessoa Física
      if (objetoJson['pessoaFisica'] != null) {
        this.pessoaFisica = new PessoaFisica(objetoJson['pessoaFisica']);
      }

      // Pessoa Jurídica
      if (objetoJson['pessoaJuridica'] != null) {
        this.pessoaJuridica = new PessoaJuridica(objetoJson['pessoaJuridica']);
      }

      // Contatos
      this.listaPessoaContato = [];
      let listaPessoaContatoJson = objetoJson['listaPessoaContato'];
      if (listaPessoaContatoJson != null) {
        for (let i = 0; i < listaPessoaContatoJson.length; i++) {
          let contato = new PessoaContato(listaPessoaContatoJson[i]);
          this.listaPessoaContato.push(contato);
        }
      }

      // Telefones
      this.listaPessoaTelefone = [];
      let listaPessoaTelefoneJson = objetoJson['listaPessoaTelefone'];
      if (listaPessoaTelefoneJson != null) {
        for (let i = 0; i < listaPessoaTelefoneJson.length; i++) {
          let Telefone = new PessoaTelefone(listaPessoaTelefoneJson[i]);
          this.listaPessoaTelefone.push(Telefone);
        }
      }

      // Enderecos
      this.listaPessoaEndereco = [];
      let listaPessoaEnderecoJson = objetoJson['listaPessoaEndereco'];
      if (listaPessoaEnderecoJson != null) {
        for (let i = 0; i < listaPessoaEnderecoJson.length; i++) {
          let Endereco = new PessoaEndereco(listaPessoaEnderecoJson[i]);
          this.listaPessoaEndereco.push(Endereco);
        }
      }
    }
  }
}