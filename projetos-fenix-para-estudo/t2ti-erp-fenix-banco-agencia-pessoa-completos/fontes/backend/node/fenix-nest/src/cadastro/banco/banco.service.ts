import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { TypeOrmCrudService } from '@nestjsx/crud-typeorm';
import { Banco } from './banco.entity';

@Injectable()
export class BancoService extends TypeOrmCrudService<Banco> {

  constructor(
    @InjectRepository(Banco) bancoRepository) { super(bancoRepository); }
}