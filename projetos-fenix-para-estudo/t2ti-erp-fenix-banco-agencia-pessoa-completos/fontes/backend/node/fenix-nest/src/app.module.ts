import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { AppController } from './app.controller';
import { AppService } from './app.service';
import { BancoModule } from './cadastro/banco/banco.module';
import { BancoAgenciaModule } from './cadastro/banco-agencia/banco-agencia.module';
import { configMySQL } from './orm.config';
import { PessoaModule } from './cadastro/pessoa/pessoa.module';

@Module(
  {
    imports: [
      TypeOrmModule.forRoot(configMySQL),
      BancoModule,
      BancoAgenciaModule,
      PessoaModule,
    ],
    controllers: [AppController],
    providers: [AppService],
  }
)
export class AppModule { }