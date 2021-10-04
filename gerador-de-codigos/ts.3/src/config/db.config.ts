import { createConnection } from "typeorm";

export const connection = createConnection({
    type: "mysql",
    host: "localhost",
    port: 3306,
    username: "root",
    password: "root",
    database: "pegasus_pdv",
    entities: [],
    synchronize: false,
    logging: true
});