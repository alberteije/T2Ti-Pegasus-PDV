import * as lodash from "lodash";
import { CamposModel } from '../../model/campos.model';
import { ComentarioDerJsonModel } from '../../model/comentario.der.json.model';

/// classe base que ajuda a gerar o controller do Eloquent usando o mustache
export class EloquentController {

    table: string; // armazena o nome da tabela
    class: string; // armazena o nome da classe
    salvarOuInserir: string; // decide entre o método salvar ou inserir dependendo da classe
    salvarOuAlterar: string; // decide entre o método salvar ou alterar dependendo da classe

    constructor(tabela: string, dataPacket: CamposModel[], relacionamentos: ComentarioDerJsonModel[]) {
        // nome da classe
        this.class = lodash.camelCase(tabela);
        this.class = lodash.upperFirst(this.class);

        // nome da tabela
        this.table = tabela.toUpperCase();

        // Tabelas sem relacionamentos chamam o método salvar. As demais chamam os métodos inserir e alterar.
        if (relacionamentos != null && relacionamentos.length > 0) {
            this.salvarOuInserir = this.class + "Service::inserir($objJson, $objEntidade);";
            this.salvarOuAlterar = this.class + "Service::alterar($objJson, $objBanco);";
        } else {
            this.salvarOuInserir = this.class + "Service::salvar($objEntidade);";
            this.salvarOuAlterar = this.class + "Service::salvar($objBanco);";    
        }
    }

}