import { Controller, Get } from '@nestjs/common';
import { AppService } from './app.service';

@Controller('t2ti')
export class AppController {
  constructor(private readonly appService: AppService) {}

  @Get('consulta')
  getHello(): string {
    return this.appService.getHello();
  }

  @Get('teste')
  getTeste(): string {
    return 'testando outra rota';//this.appService.getHello();
  }

}
