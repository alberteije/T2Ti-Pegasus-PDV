import { Controller } from '@nestjs/common';
import { Crud, CrudController, Override, ParsedRequest, ParsedBody, CrudRequest } from '@nestjsx/crud';
import { BancoService } from './banco.service';
import { Banco } from './banco.entity';

@Crud({
  model: {
    type: Banco,
  },
})
@Controller('banco')
export class BancoController implements CrudController<Banco> {
  constructor(public service: BancoService) { }

  get base(): CrudController<Banco> {
    return this;
  }

  @Override('replaceOneBase')
  alterar(
    @ParsedRequest() req: CrudRequest,
    @ParsedBody() dto: Banco,
  ) {
    return this.base.replaceOneBase(req, dto);
  }
}
/*
sem o package crud
@Controller('banco')
export class BancoController {
    constructor(private readonly bancoService: BancoService) {}

    @Get()
    findAll(): Promise<Banco[]> {
      return this.bancoService.findAll();
    }
}
*/