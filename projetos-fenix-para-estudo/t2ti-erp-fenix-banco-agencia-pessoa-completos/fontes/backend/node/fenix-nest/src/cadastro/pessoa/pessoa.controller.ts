import { Controller, Delete, Param, Post, Body, Put, Req } from '@nestjs/common';
import {
  Crud,
  CrudController,
} from '@nestjsx/crud';
import { PessoaService } from './pessoa.service';
import { Pessoa } from './pessoa.entity';
import { Request } from 'express';

@Crud({
  model: {
    type: Pessoa,
  },
  // https://github.com/nestjsx/crud/wiki/Controllers#query
  query: {
    join: {
      pessoaFisica: {
        eager: true
      },
      pessoaJuridica: {
        eager: true
      },
      listaPessoaEndereco: {
        eager: true
      },
      listaPessoaContato: {
        eager: true
      },
      listaPessoaTelefone: {
        eager: true
      },
    },
  },
})
@Controller('pessoa')
export class PessoaController implements CrudController<Pessoa> {
  constructor(public service: PessoaService) { }

  @Post()
  async inserir(@Req() request: Request) {
    var objetoJson = request.body;
    var pessoa = new Pessoa(objetoJson);
    const retorno = await this.service.inserir(pessoa);
    return retorno;
  }

  @Put(':id')
  async alterar(@Param('id') id: number, @Req() request: Request) {
    var objetoJson = request.body;
    var pessoa = new Pessoa(objetoJson);
    const retorno = await this.service.alterar(pessoa);
    return retorno;
  }

  @Delete(':id')
  async excluir(@Param('id') id: number) {
    return this.service.excluirMestreDetalhe(id);
  }

}