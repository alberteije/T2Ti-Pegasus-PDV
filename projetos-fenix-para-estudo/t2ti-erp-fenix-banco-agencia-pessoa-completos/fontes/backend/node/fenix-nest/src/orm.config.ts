import { TypeOrmModuleOptions } from '@nestjs/typeorm';

export const configMySQL: TypeOrmModuleOptions = {
  type: 'mysql',
  host: 'localhost',
  port: 3306,
  username: 'root',
  password: 'root',
  database: 'fenix',
  entities: ["dist/**/*.entity{.ts,.js}"],
  synchronize: false,
  logging: true
};
