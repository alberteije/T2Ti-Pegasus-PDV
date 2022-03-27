import * as rawbody from 'raw-body';
import { Injectable, NestMiddleware } from '@nestjs/common';
import { Request, Response, NextFunction } from 'express';

@Injectable()
export class HandleBodyMiddleware implements NestMiddleware {
  async use(request: Request, response: Response, next: NextFunction) {

    // trata o corpo da requisição que está vindo cifrada em base64
    if (request.method == 'POST' || request.method == 'PUT') {
      if (request.readable) {
        const raw = await rawbody(request);
        const text = raw.toString().trim();
        request.body = text;
      }  
    }
    next();
  }
}
