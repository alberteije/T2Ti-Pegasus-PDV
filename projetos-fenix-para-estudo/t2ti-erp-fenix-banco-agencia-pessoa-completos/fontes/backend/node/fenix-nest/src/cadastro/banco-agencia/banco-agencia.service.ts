import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { TypeOrmCrudService } from '@nestjsx/crud-typeorm';
import { BancoAgencia } from './banco-agencia.entity';

@Injectable()
export class BancoAgenciaService extends TypeOrmCrudService<BancoAgencia> {

  constructor(
    @InjectRepository(BancoAgencia) repository) { super(repository); }
}