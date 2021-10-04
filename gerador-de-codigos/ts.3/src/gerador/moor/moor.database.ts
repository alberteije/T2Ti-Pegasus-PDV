import * as lodash from "lodash";
import { CamposModel } from '../../model/campos.model';
import { ComentarioDerJsonModel } from '../../model/comentario.der.json.model';
import { Biblioteca } from "../../util/biblioteca";

/// classe base que ajuda a gerar o model do Eloquent usando o mustache
export class MoorDatabase {

    tabelasDatabase = []; // tabelasDatabase
    exportTable = []; // exportTable
    daosDatabase = []; // daosDatabase

    constructor(modulo: string, listaTabelas: string[]) {
        let nomeTabela = "";
        let nomeObjeto = "";
        let nomeClasse = "";

        for (let i = 0; i < listaTabelas.length; i++) {
            nomeTabela = listaTabelas[i];
            nomeObjeto = lodash.camelCase(nomeTabela);
            nomeClasse = lodash.upperFirst(nomeObjeto);

            // exportTable
            this.exportTable.push("export 'package:pegasus_pdv/src/database/tabela/" + nomeTabela + ".dart';");
            this.exportTable.push("export 'package:pegasus_pdv/src/database/dao/" + nomeTabela + "_dao.dart';");

            // tabelasDatabase
            this.tabelasDatabase.push(nomeClasse + "s,");

            // daosDatabase
            this.daosDatabase.push(nomeClasse + "Dao,");
        }

    }

}