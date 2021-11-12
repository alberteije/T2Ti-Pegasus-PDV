import * as lodash from "lodash";
import { ComentarioDerJsonModel } from '../../model/comentario.der.json.model';

/// classe base que ajuda a gerar o service do PHP usando o mustache
export class PHPService {

    table: string; // armazena o nome da tabela
    class: string; // armazena o nome da classe

    exclusaoObj = []; // relação de objetos para o método 'excluir filhos'
    exclusaoList = []; // relação de listas para o método 'excluir filhos'

    metodoExcluirCorpo = []; // armazena o código do corpo do método excluir
    metodoExcluirFilhosAbre = []; // armazena o código para o método excluir filhos
    metodoExcluirFilhosFecha = []; // armazena o código para o método excluir filhos

    constructor(tabela: string, relacionamentos: ComentarioDerJsonModel[]) {

        // nome da classe
        this.class = lodash.camelCase(tabela);
        this.class = lodash.upperFirst(this.class);

        // nome da tabela
        this.table = tabela.toUpperCase();

        // corpo do método excluir padrão
        this.metodoExcluirCorpo.push("parent::excluirBase($objeto);");

        // relacionamentos agregados ao Mestre
        if (relacionamentos != null && relacionamentos.length > 0) {
            this.tratarRelacionamentos(relacionamentos);
        }
    }

    tratarRelacionamentos(relacionamentos: ComentarioDerJsonModel[]) {
        for (let i = 0; i < relacionamentos.length; i++) {
            let relacionamento = relacionamentos[i];

            let nomeTabelaRelacionamento = relacionamento.tabela;
            let nomeCampoAtributo = lodash.camelCase(nomeTabelaRelacionamento);
            let nomeCampoGetSet = lodash.upperFirst(nomeCampoAtributo);

            // verifica a cardinalidade para definir o código
            if (relacionamento.cardinalidade == '@OneToOne') {
                // exclusao de objetos
                this.exclusaoObj.push("$" + nomeCampoAtributo + " = $objeto->get" + nomeCampoGetSet + "();");
                this.exclusaoObj.push("if ($" + nomeCampoAtributo + " != null) {");
                this.exclusaoObj.push("\t$objeto->set" + nomeCampoGetSet + "(null);");
                this.exclusaoObj.push("\t$gerenteConexao->entityManager->remove($" + nomeCampoAtributo + ");");
                this.exclusaoObj.push("}\n");
            } else if (relacionamento.cardinalidade == '@OneToMany') {
                // exclusao de listas
                this.exclusaoList.push("$lista" + nomeCampoGetSet + " = $objeto->getLista" + nomeCampoGetSet + "();");
                this.exclusaoList.push("if ($lista" + nomeCampoGetSet + " != null) {");
                this.exclusaoList.push("\tfor ($i = 0; $i < count($lista" + nomeCampoGetSet + "); $i++) {");
                this.exclusaoList.push("\t\t$" + nomeCampoAtributo + " = $lista" + nomeCampoGetSet + "[$i];");
                this.exclusaoList.push("\t\t$gerenteConexao->entityManager->remove($" + nomeCampoAtributo + ");");
                this.exclusaoList.push("\t}\n");
                this.exclusaoList.push("}\n");
            }
        }

        // corpo do método excluir - redefinido
        this.metodoExcluirCorpo.length = 0;
        this.metodoExcluirCorpo.push(this.class + "Service::excluirFilhos($objeto);")
        this.metodoExcluirCorpo.push("parent::excluirBase($objeto);");

        // método excluir filhos
        this.metodoExcluirFilhosAbre.push('public static function excluirFilhos($objeto)');
        this.metodoExcluirFilhosAbre.push('{');
        this.metodoExcluirFilhosAbre.push('\t$gerenteConexao = GerenteConexao::getInstance();');
        this.metodoExcluirFilhosAbre.push('');
        this.metodoExcluirFilhosFecha.push('}');
    }

}