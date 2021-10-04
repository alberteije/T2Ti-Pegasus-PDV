import { Controller } from '@nestjs/common';
import { Crud, CrudController } from '@nestjsx/crud';
import { BancoAgenciaService } from './banco-agencia.service';
import { BancoAgencia } from './banco-agencia.entity';

@Crud({
  model: {
    type: BancoAgencia,
  },
  // https://github.com/nestjsx/crud/wiki/Controllers#query
  query: {
    join: {
      banco: {
        eager: true
      },
    },
  },  
})
@Controller('banco-agencia')
export class BancoAgenciaController implements CrudController<BancoAgencia> {
  constructor(public service: BancoAgenciaService) { }
}