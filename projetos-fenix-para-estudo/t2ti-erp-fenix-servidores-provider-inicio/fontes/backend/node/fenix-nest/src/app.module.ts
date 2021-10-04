import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { AppController } from './app.controller';
import { AppService } from './app.service';
import { BancoModule } from './cadastro/banco/banco.module';

@Module(
  {
    imports: [
      TypeOrmModule.forRoot(
        {
          type: 'mysql',
          host: 'localhost',
          port: 3306,
          username: 'root',
          password: 'root',
          database: 'fenix',
          entities: ["dist/**/*.entity{.ts,.js}"],
          synchronize: false,
          logging: true
        }
      ),
      BancoModule
    ],
    controllers: [AppController],
    providers: [AppService],
  }
)
export class AppModule { }
