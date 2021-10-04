import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { BancoController } from './banco.controller';
import { BancoService } from './banco.service';
import { Banco } from './banco.entity';

@Module({
    imports: [TypeOrmModule.forFeature([Banco])],
    controllers: [BancoController],
    providers: [BancoService],
})
export class BancoModule {}
