import { TypeOrmModuleOptions } from '@nestjs/typeorm';

export const configMySQL: TypeOrmModuleOptions = {
  type: 'mysql',
  host: 'localhost',
  port: 3306,
  username: 'root',
  password: 'root',
  database: 'retaguarda_sh',
  entities: ["dist/**/*.entity{.ts,.js}"],
  synchronize: false,
  bigNumberStrings: false,
  multipleStatements: true,
  logging: true
};
