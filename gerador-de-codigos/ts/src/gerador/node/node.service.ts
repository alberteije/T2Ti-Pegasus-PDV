import * as lodash from "lodash";
import { ComentarioDerJsonModel } from '../../model/comentario.der.json.model';

/// classe base que ajuda a gerar o service do Node usando o mustache
export class NodeService {

    table: string; // armazena o nome da tabela
    class: string; // armazena o nome da classe
    path: string; // armazena o caminho para a API REST
    objetoPrincipal: string; //armazena o nome do objeto principal, que costuma ser o nome da classe com a primeira letra em minúsculo
    classFile: string; // armazena o nome do arquivo da classe

    metodoPersistir = []; // armazena o código para o método persistir
    metodoExcluirMestre = []; // armazena o código para o método excluir mestre
    metodoExcluirDetalhe = []; // armazena o código para o método excluir detalhe
    imports = []; // armazena os demais imports para a classe

    usarQueryRunner: boolean;

    constructor(tabela: string, relacionamentos: ComentarioDerJsonModel[]) {
        this.usarQueryRunner = false;

        // nome da classe
        this.classFile = lodash.camelCase(tabela);
        this.class = lodash.camelCase(tabela);
        this.objetoPrincipal = this.class;
        this.class = lodash.upperFirst(this.classFile);

        // nome da tabela
        this.table = tabela.toUpperCase();

        // path
        this.path = lodash.replace(tabela.toLowerCase(), new RegExp("_", "g"), "-");

        // relacionamentos agregados ao Mestre
        if (relacionamentos != null && relacionamentos.length > 0) {
            this.usarQueryRunner = true;
            this.tratarRelacionamentos(relacionamentos);
        }

    }

    tratarRelacionamentos(relacionamentos: ComentarioDerJsonModel[]) {

        let corpoMetodoExcluir = '\t';
        for (let i = 0; i < relacionamentos.length; i++) {
            let relacionamento = relacionamentos[i];
            corpoMetodoExcluir = corpoMetodoExcluir +  "await queryRunner.query('delete from " + relacionamento.tabela.toUpperCase() + " where ID_" + relacionamento.tabelaMestre + "=' + id);\n\t\t"
        }

        // insere o import e define os métodos CUD
        if (this.usarQueryRunner) {
            // import
            this.imports.push("import { getConnection, QueryRunner } from 'typeorm';")

            // método persistir
            this.metodoPersistir.push("async persistir(" + this.objetoPrincipal + ": " + this.class + ", operacao: String): Promise<" + this.class + "> {");
            this.metodoPersistir.push("  let objetoRetorno: " + this.class + ";");
            this.metodoPersistir.push("");
            this.metodoPersistir.push("  const connection = getConnection();");
            this.metodoPersistir.push("  const queryRunner = connection.createQueryRunner();");
            this.metodoPersistir.push("");
            this.metodoPersistir.push("  await queryRunner.connect();");
            this.metodoPersistir.push("  await queryRunner.startTransaction();");
            this.metodoPersistir.push("  try {");
            this.metodoPersistir.push("    if (operacao == 'A') {");
            this.metodoPersistir.push("      await this.excluirFilhos(queryRunner, " + this.objetoPrincipal + ".id);");
            this.metodoPersistir.push("    }");
            this.metodoPersistir.push("    objetoRetorno = await queryRunner.manager.save(" + this.objetoPrincipal + ");");
            this.metodoPersistir.push("    await queryRunner.commitTransaction();");
            this.metodoPersistir.push("  } catch (erro) {");
            this.metodoPersistir.push("    await queryRunner.rollbackTransaction();");
            this.metodoPersistir.push("    throw (erro);");
            this.metodoPersistir.push("  } finally {");
            this.metodoPersistir.push("    await queryRunner.release();");
            this.metodoPersistir.push("  }");
            this.metodoPersistir.push("  return objetoRetorno;");
            this.metodoPersistir.push("}");

            // método excluirMestreDetalhe
            this.metodoExcluirMestre.push("async excluirMestreDetalhe(id: number) {");
            this.metodoExcluirMestre.push("  const connection = getConnection();");
            this.metodoExcluirMestre.push("  const queryRunner = connection.createQueryRunner();");
            this.metodoExcluirMestre.push("");
            this.metodoExcluirMestre.push("  await queryRunner.connect();");
            this.metodoExcluirMestre.push("  await queryRunner.startTransaction();");
            this.metodoExcluirMestre.push("  try {");
            this.metodoExcluirMestre.push("    await this.excluirFilhos(queryRunner, id);");
            this.metodoExcluirMestre.push("    await queryRunner.query('delete from " + this.objetoPrincipal + " where id=' + id);");
            this.metodoExcluirMestre.push("    await queryRunner.commitTransaction();");
            this.metodoExcluirMestre.push("  } catch (erro) {");
            this.metodoExcluirMestre.push("    await queryRunner.rollbackTransaction();");
            this.metodoExcluirMestre.push("    throw (erro);");
            this.metodoExcluirMestre.push("  } finally {");
            this.metodoExcluirMestre.push("    await queryRunner.release();");
            this.metodoExcluirMestre.push("  }");
            this.metodoExcluirMestre.push("}");
            
            // método excluir
            this.metodoExcluirDetalhe.push('async excluirFilhos(queryRunner: QueryRunner, id: number) {');
            this.metodoExcluirDetalhe.push(corpoMetodoExcluir);
            this.metodoExcluirDetalhe.push('}');
        }

    }

}