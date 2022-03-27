import { MiddlewareConsumer, Module, NestModule, RequestMethod } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { AppController } from './app.controller';
import { AppService } from './app.service';
import { configMySQL } from './orm.config';
import { CadastrosModule } from './cadastros/cadastros.module';
import { NfeModule } from './nfe/nfe.module';
import { PdvModule } from './pdv/pdv.module';
import { AcbrModule } from './acbr/acbr.module';
import { SincronizaModule } from './sincroniza/sincroniza.module';
import { HandleBodyMiddleware } from './handle-body-middleware';

@Module(
  {
    imports: [
      TypeOrmModule.forRoot(configMySQL),
      CadastrosModule,
      NfeModule,
      PdvModule,
      AcbrModule,
	  SincronizaModule,
    ],
    controllers: [AppController],
    providers: [AppService],//, {
    //   provide: APP_INTERCEPTOR,
    //   useClass: AppInterceptor,
    // }],
  }
)
export class AppModule implements NestModule {
  configure(consumer: MiddlewareConsumer) {
    consumer
      .apply(HandleBodyMiddleware)
      .forRoutes({ path: '*', method: RequestMethod.ALL });     
  }
}