import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { PessoaController } from './pessoa.controller';
import { PessoaService } from './pessoa.service';
import { Pessoa } from './pessoa.entity';

@Module({
    imports: [TypeOrmModule.forFeature([Pessoa])],
    controllers: [PessoaController],
    providers: [PessoaService],
})
export class PessoaModule { }
