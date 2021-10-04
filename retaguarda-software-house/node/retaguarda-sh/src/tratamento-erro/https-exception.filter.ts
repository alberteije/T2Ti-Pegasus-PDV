import { ExceptionFilter, Catch, ArgumentsHost, UnauthorizedException } from '@nestjs/common';
import { HttpException, InternalServerErrorException } from '@nestjs/common';
import { RetornoJsonErro } from './retorno.json.erro';

/**
   * Referência
   * https://github.com/nestjsx/crud/tree/master/integration/shared
   */

@Catch()
export class HttpExceptionFilter implements ExceptionFilter {
  catch(exception: HttpException, host: ArgumentsHost) {
    const ctx = host.switchToHttp();
    const response = ctx.getResponse();
    const { status, json } = this.prepareException(exception);

    response.status(status).send(json);
  }

  prepareException(exc: any): { status: number; json: object } {
    if (exc instanceof UnauthorizedException) {
	  const status = exc.getStatus();
      let json = new RetornoJsonErro({ codigo: exc.getStatus, mensagem: exc.getResponse(), erro: exc });
      return { status, json};
    } else {
      const error = exc instanceof HttpException ? exc : new InternalServerErrorException(exc.message);
      const status = error.getStatus();
      //const response = error.getResponse();
      //const json = typeof response === 'string' ? { error: response } : response;
      const json = new RetornoJsonErro({ codigo: 500, mensagem: "Erro no Servidor", erro: exc });
  
      return { status, json };
    }
  }
}