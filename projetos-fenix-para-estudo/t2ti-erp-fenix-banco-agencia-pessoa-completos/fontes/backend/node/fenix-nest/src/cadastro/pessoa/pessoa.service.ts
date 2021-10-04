import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { TypeOrmCrudService } from '@nestjsx/crud-typeorm';
import { getConnection, QueryRunner } from "typeorm";
import { Pessoa } from './pessoa.entity';

@Injectable()
export class PessoaService extends TypeOrmCrudService<Pessoa> {

  constructor(
    @InjectRepository(Pessoa) repository) {
    super(repository);
  }

  async inserir(pessoa: Pessoa): Promise<Pessoa> {
    let objetoInserido: Pessoa;

    const connection = getConnection();
    const queryRunner = connection.createQueryRunner();

    await queryRunner.connect();
    await queryRunner.startTransaction();
    try {
      objetoInserido = await queryRunner.manager.save(pessoa);
      await queryRunner.commitTransaction();
    } catch (erro) {
      await queryRunner.rollbackTransaction();
      throw (erro);
    } finally {
      await queryRunner.release();
    }
    return objetoInserido;
  }

  async alterar(pessoa: Pessoa): Promise<Pessoa> {
    let objetoAlterado: Pessoa;

    const connection = getConnection();
    const queryRunner = connection.createQueryRunner();

    await queryRunner.connect();
    await queryRunner.startTransaction();
    try {
      this.excluirFilhos(queryRunner, pessoa.id);
      objetoAlterado = await queryRunner.manager.save(pessoa);
      await queryRunner.commitTransaction();
    } catch (erro) {
      await queryRunner.rollbackTransaction();
      throw (erro);
    } finally {
      await queryRunner.release();
    }
    return objetoAlterado;
  }

  async excluirMestreDetalhe(id: number) {
    const connection = getConnection();
    const queryRunner = connection.createQueryRunner();

    await queryRunner.connect();
    await queryRunner.startTransaction();
    try {
      await this.excluirFilhos(queryRunner, id);
      await queryRunner.query('delete from pessoa where id=' + id);
      await queryRunner.commitTransaction();
    } catch (erro) {
      await queryRunner.rollbackTransaction();
      throw (erro);
    } finally {
      await queryRunner.release();
    }
  }

  async excluirFilhos(queryRunner: QueryRunner, id: number) {
    await queryRunner.query('delete from pessoa_endereco where id_pessoa=' + id);
    await queryRunner.query('delete from pessoa_contato where id_pessoa=' + id);
    await queryRunner.query('delete from pessoa_telefone where id_pessoa=' + id);
    await queryRunner.query('delete from pessoa_fisica where id_pessoa=' + id);
    await queryRunner.query('delete from pessoa_juridica where id_pessoa=' + id);
  }

}