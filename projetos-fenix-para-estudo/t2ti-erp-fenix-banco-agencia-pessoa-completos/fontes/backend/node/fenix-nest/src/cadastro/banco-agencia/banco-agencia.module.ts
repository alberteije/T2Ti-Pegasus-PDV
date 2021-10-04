import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { BancoAgenciaController } from './banco-agencia.controller';
import { BancoAgenciaService } from './banco-agencia.service';
import { BancoAgencia } from './banco-agencia.entity';

@Module({
    imports: [TypeOrmModule.forFeature([BancoAgencia])],
    controllers: [BancoAgenciaController],
    providers: [BancoAgenciaService],
})
export class BancoAgenciaModule {}
