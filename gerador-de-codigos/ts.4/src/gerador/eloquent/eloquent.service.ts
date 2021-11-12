import * as lodash from "lodash";
import { ComentarioDerJsonModel } from '../../model/comentario.der.json.model';

/// classe base que ajuda a gerar o service do Eloquent usando o mustache
export class EloquentService {

    table: string; // armazena o nome da tabela
    class: string; // armazena o nome da classe

    metodoInserir = []; // para montar o método inserir, se for o caso
    metodoAlterar = []; // para montar o método alterar, se for o caso
    metodoExcluir = []; // para montar o método excluir, se for o caso

    metodoExcluirFilhosAbre = []; // armazena o código para o método excluir filhos
    metodoExcluirFilhosFecha = []; // armazena o código para o método excluir filhos
    exclusaoFilho = []; // classes filhas que serão excluídas
    
    metodoAtualizarFilhosAbre = []; // armazena o código para o método atualizar filhos
    metodoAtualizarFilhosFecha = []; // armazena o código para o método atualizar filhos
    atualizaObj = []; // relação de objetos para o método 'atualizar filhos'
    atualizaList = []; // relação de listas para o método 'atualizar filhos'
    
    imports = []; // armazena os demais imports para a classe

    constructor(tabela: string, relacionamentos: ComentarioDerJsonModel[]) {
        // nome da classe
        this.class = lodash.camelCase(tabela);
        this.class = lodash.upperFirst(this.class);

        // nome da tabela
        this.table = tabela.toUpperCase();

        // relacionamentos agregados ao Mestre
        if (relacionamentos != null && relacionamentos.length > 0) {
            this.imports.push("use Illuminate\\Database\\Capsule\\Manager as DB;");
            this.tratarRelacionamentos(relacionamentos);
        }
    }

    tratarRelacionamentos(relacionamentos: ComentarioDerJsonModel[]) {

        for (let i = 0; i < relacionamentos.length; i++) {
            let relacionamento = relacionamentos[i];

            let nomeTabelaRelacionamento = relacionamento.tabela.toUpperCase();;
            let nomeCampoAtributo = lodash.camelCase(nomeTabelaRelacionamento);
            let nomeCampoGetSet = lodash.upperFirst(nomeCampoAtributo);

            // excluir filhos
            this.exclusaoFilho.push(nomeCampoGetSet + "::where('ID_" + this.table + "', $objeto->getIdAttribute())->delete();");
            
            // atualizar filhos
            if (relacionamento.cardinalidade == '@OneToOne') {
                this.atualizaObj.push("// atualizar " + nomeCampoAtributo);
                this.atualizaObj.push("if (isset($objJson->" + nomeCampoAtributo + ")) {");
                this.atualizaObj.push("    $" + nomeCampoAtributo + " = new " + nomeCampoGetSet + "();");
                this.atualizaObj.push("    $" + nomeCampoAtributo + "->mapear($objJson->" + nomeCampoAtributo + ");");
                this.atualizaObj.push("    $objPersistencia->" + nomeCampoAtributo + "()->save($" + nomeCampoAtributo + ");");
                this.atualizaObj.push("}\n");
            } else if (relacionamento.cardinalidade == '@OneToMany') {
                this.atualizaList.push("// atualizar lista" + nomeCampoGetSet);
                this.atualizaList.push("$lista" + nomeCampoGetSet + "Json = $objJson->lista" + nomeCampoGetSet + ";");
                this.atualizaList.push("if ($lista" + nomeCampoGetSet + "Json != null) {");
                this.atualizaList.push("    for ($i = 0; $i < count($lista" + nomeCampoGetSet + "Json); $i++) {");
                this.atualizaList.push("        $" + nomeCampoAtributo + " = new " + nomeCampoGetSet + "();");
                this.atualizaList.push("        $" + nomeCampoAtributo + "->mapear($lista" + nomeCampoGetSet + "Json[$i]);");
                this.atualizaList.push("        $objPersistencia->lista" + nomeCampoGetSet + "()->save($" + nomeCampoAtributo + ");");
                this.atualizaList.push("    }");
                this.atualizaList.push("}\n");        
            }
        }

        // método inserir
        this.metodoInserir.push("public static function inserir($objJson, $objEntidade)");
        this.metodoInserir.push("{");
        this.metodoInserir.push("    DB::transaction(function () use ($objJson, $objEntidade) {");
        this.metodoInserir.push("        $objEntidade->save();");
        this.metodoInserir.push("        " + this.class + "Service::atualizarFilhos($objJson, $objEntidade);");
        this.metodoInserir.push("    });");
        this.metodoInserir.push("}");
    
        // método alterar
        this.metodoAlterar.push("public static function alterar($objJson, $objBanco)");
        this.metodoAlterar.push("{");
        this.metodoAlterar.push("    DB::transaction(function () use ($objJson, $objBanco) {");
        this.metodoAlterar.push("        $objBanco->save();");
        this.metodoAlterar.push("        " + this.class + "Service::excluirFilhos($objBanco);");
        this.metodoAlterar.push("        " + this.class + "Service::atualizarFilhos($objJson, $objBanco);");
        this.metodoAlterar.push("    });");
        this.metodoAlterar.push("}");
    
        // método atualizar filhos
        this.metodoAtualizarFilhosAbre.push('public static function atualizarFilhos($objJson, $objPersistencia)');
        this.metodoAtualizarFilhosAbre.push('{');
        this.metodoAtualizarFilhosFecha.push('}');

        // método excluir
        this.metodoExcluir.push("public static function excluir($objeto)");
        this.metodoExcluir.push("{");
        this.metodoExcluir.push("    DB::transaction(function () use ($objeto) {");
        this.metodoExcluir.push("        " + this.class + "Service::excluirFilhos($objeto);");
        this.metodoExcluir.push("        parent::excluir($objeto);");
        this.metodoExcluir.push("    });");
        this.metodoExcluir.push("}");
    
        // método excluir filhos
        this.metodoExcluirFilhosAbre.push('public static function excluirFilhos($objeto)');
        this.metodoExcluirFilhosAbre.push('{');
        this.metodoExcluirFilhosFecha.push('}');
    }

}