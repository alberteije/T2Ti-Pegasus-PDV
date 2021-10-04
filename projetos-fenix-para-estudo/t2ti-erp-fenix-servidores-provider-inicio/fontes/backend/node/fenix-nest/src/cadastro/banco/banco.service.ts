import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { TypeOrmCrudService } from '@nestjsx/crud-typeorm';
// import { Repository } from 'typeorm';
import { Banco } from './banco.entity';

@Injectable()
export class BancoService extends TypeOrmCrudService<Banco> {

  constructor(
    @InjectRepository(Banco) bancoRepository) { super(bancoRepository); }
}

/*
sem o package crud
@Injectable()
export class BancoService {

  constructor(
    @InjectRepository(Banco)
    private readonly bancoRepository: Repository<Banco>,
  ) { }

  findAll(): Promise<Banco[]> {
    return this.bancoRepository.find();
  }
}
*/