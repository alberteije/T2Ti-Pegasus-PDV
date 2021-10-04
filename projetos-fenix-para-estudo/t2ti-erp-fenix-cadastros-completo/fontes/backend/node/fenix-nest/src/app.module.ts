import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { AppController } from './app.controller';
import { AppService } from './app.service';
import { configMySQL } from './orm.config';
import { CadastrosModule } from './cadastros/cadastros.module';
import { FinanceiroModule } from './financeiro/financeiro.module';
import { ViewsDBModule } from './views-db/views-db.module';

@Module(
  {
    imports: [
      TypeOrmModule.forRoot(configMySQL),
      CadastrosModule,
	  FinanceiroModule,
	  ViewsDBModule,
    ],
    controllers: [AppController],
    providers: [AppService],
  }
)
export class AppModule { }