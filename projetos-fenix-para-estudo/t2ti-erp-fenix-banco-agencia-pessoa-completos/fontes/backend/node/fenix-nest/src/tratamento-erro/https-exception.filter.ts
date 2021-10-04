import { ExceptionFilter, Catch, ArgumentsHost } from '@nestjs/common';
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
    const error = exc instanceof HttpException ? exc : new InternalServerErrorException(exc.message);
    const status = error.getStatus();
    const response = error.getResponse();
    //const json = typeof response === 'string' ? { error: response } : response;
    const json = new RetornoJsonErro({ codigo: 500, mensagem: "Erro no Servidor", erro: exc });

    return { status, json };
  }
}