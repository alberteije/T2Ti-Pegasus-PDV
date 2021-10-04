/*******************************************************************************
Title: T2Ti ERP 3.0                                                                
Description: Controller relacionado à tabela [EMPRESA] 
                                                                                
The MIT License                                                                 
                                                                                
Copyright: Copyright (C) 2021 T2Ti.COM                                          
                                                                                
Permission is hereby granted, free of charge, to any person                     
obtaining a copy of this software and associated documentation                  
files (the "Software"), to deal in the Software without                         
restriction, including without limitation the rights to use,                    
copy, modify, merge, publish, distribute, sublicense, and/or sell               
copies of the Software, and to permit persons to whom the                       
Software is furnished to do so, subject to the following                        
conditions:                                                                     
                                                                                
The above copyright notice and this permission notice shall be                  
included in all copies or substantial portions of the Software.                 
                                                                                
THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,                 
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES                 
OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND                        
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT                     
HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,                    
WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING                    
FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR                   
OTHER DEALINGS IN THE SOFTWARE.                                                 
                                                                                
       The author may be contacted at:                                          
           t2ti.com@gmail.com                                                   
                                                                                
@author Albert Eije (alberteije@gmail.com)                    
@version 1.0.0
*******************************************************************************/
import { Controller, Param, Post, Req, Res } from '@nestjs/common';
import { Crud, CrudController } from '@nestjsx/crud';
import { Request, Response } from 'express';
import { EmpresaService } from './empresa.service';
import { Empresa } from './empresa.entity';

@Crud({
  model: {
    type: Empresa,
  },
  query: {
    join: {
    },
  },
})
@Controller('empresa')
export class EmpresaController implements CrudController<Empresa> {
  constructor(public service: EmpresaService) { }

	@Post()
	async atualizar(@Req() request: Request) {
		let objetoJson = request.body;
		let empresa = new Empresa(objetoJson);
		const retorno = await this.service.atualizar(empresa);
		return retorno;
	}

	@Post(':cnpj')
	async registrar(
    @Req() request: Request,
    @Res() response: Response,
    @Param('cnpj') cnpj: string, 
  ) {
		let objetoJson = request.body;
		let empresa = new Empresa(objetoJson);
    
    let operacao = request.headers['operacao'];
    let codigoConfirmacao = request.headers['codigo-confirmacao'] as string;

    switch (operacao) {
      case "registrar":
        empresa = await this.service.registrar(empresa);
      case "reenviar-email":
        empresa = await this.service.enviarEmailConfirmacao(empresa);
      case "confirmar-codigo":
        empresa = await this.service.conferirCodigoConfirmacao(empresa, codigoConfirmacao);
    }

    response.status(200);
		response.send(empresa);
	}   
}