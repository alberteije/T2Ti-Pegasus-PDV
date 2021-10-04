import { Controller } from '@nestjs/common';
import { Crud, CrudController } from '@nestjsx/crud';
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
}