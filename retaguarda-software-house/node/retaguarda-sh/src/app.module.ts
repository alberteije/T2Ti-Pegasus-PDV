import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { AppController } from './app.controller';
import { AppService } from './app.service';
import { configMySQL } from './orm.config';
import { CadastrosModule } from './cadastros/cadastros.module';
import { NfeModule } from './nfe/nfe.module';
import { PdvModule } from './pdv/pdv.module';

@Module(
  {
    imports: [
      TypeOrmModule.forRoot(configMySQL),
      CadastrosModule,
      NfeModule,
      PdvModule,
    ],
    controllers: [AppController],
    providers: [AppService],//, {
    //   provide: APP_INTERCEPTOR,
    //   useClass: AppInterceptor,
    // }],
  }
)
export class AppModule { }