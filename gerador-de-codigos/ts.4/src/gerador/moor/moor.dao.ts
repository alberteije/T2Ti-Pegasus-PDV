import * as lodash from "lodash";
import { ComentarioDerJsonModel } from '../../model/comentario.der.json.model';

/// classe base que ajuda a gerar o service do Eloquent usando o mustache
export class MoorDao {

    table: string; // armazena o nome da tabela
    class: string; // armazena o nome da classe
    objetoPrincipal: string; // armazena o nome do objeto principal, que costuma ser o nome da classe com a primeira letra em minúsculo
    nomeArquivo: string; // armazena o nome do arquivo que aparece no import

    listaTabelaFilha =  []; // a lista da tabela filha
    tabelas = []; // para armazenas as tabelas usadas pelo DAO

    inserirFilhos = []; // chama a inserção dos filhos
    excluirFilhos = []; // chama a exclusão dos filhos

    metodoExcluirFilhosAbre = []; // armazena o código para o método excluir filhos
    metodoExcluirFilhosFecha = []; // armazena o código para o método excluir filhos
    exclusaoFilho = []; // classes filhas que serão excluídas
    
    metodoInserirFilhosAbre = []; // armazena o código para o método inserir filhos
    metodoInserirFilhosFecha = []; // armazena o código para o método inserir filhos
    insereFilho = []; // classes filhas que serão incluídas
    

    constructor(tabela: string, relacionamentos: ComentarioDerJsonModel[]) {
        // nome da classe
        this.class = lodash.camelCase(tabela);5
        this.objetoPrincipal = this.class;
        this.class = lodash.upperFirst(this.class);

        // nome da tabela
        this.table = tabela.toUpperCase();

        // nomeArquivo
        this.nomeArquivo = tabela.toLowerCase();

        // adiciona a tabela principal ao DAO
        this.tabelas.push(this.class + "s,");

        // relacionamentos agregados ao Mestre
        if (relacionamentos != null && relacionamentos.length > 0) {
            this.tratarRelacionamentos(relacionamentos);
        }
    }

    tratarRelacionamentos(relacionamentos: ComentarioDerJsonModel[]) {

        for (let i = 0; i < relacionamentos.length; i++) {
            let relacionamento = relacionamentos[i];

            let nomeTabelaRelacionamento = relacionamento.tabela.toUpperCase();;
            let nomeCampoAtributo = lodash.camelCase(nomeTabelaRelacionamento);
            let nomeCampoGetSet = lodash.upperFirst(nomeCampoAtributo);
            
            // atualizar filhos
            if (relacionamento.cardinalidade == '@OneToOne') {
            } else if (relacionamento.cardinalidade == '@OneToMany') {
                this.tabelas.push(nomeCampoGetSet + "s,");
                this.listaTabelaFilha.push(", List<" + nomeCampoGetSet + "> lista" + nomeCampoGetSet);

                // inserir filhos
                this.inserirFilhos.push("inserirFilhos(pObjeto as " + this.class + ", lista" + nomeCampoGetSet + ");");
                this.insereFilho.push("for (var objeto in lista" + nomeCampoGetSet + ") {");
                this.insereFilho.push("  if (objeto.id == null) {");
                this.insereFilho.push("    objeto = objeto.copyWith(id" + this.class  + ": " + this.objetoPrincipal + ".id);");
                this.insereFilho.push("  }");
                this.insereFilho.push("  into(" + nomeCampoAtributo + "s).insert(objeto);  ");
                this.insereFilho.push("}");

                // excluir filhos
                this.excluirFilhos.push("excluirFilhos(pObjeto as " + this.class + ");");
                this.exclusaoFilho.push("(delete(" + nomeCampoAtributo + "s)..where((t) => t.id" + this.class + ".equals(" + this.objetoPrincipal + ".id))).go();");
            }
        }

        // método inserir filhos
        this.metodoInserirFilhosAbre.push("void inserirFilhos(" + this.class + " " + this.objetoPrincipal + this.listaTabelaFilha + ") {");
        this.metodoInserirFilhosFecha.push('}');
    
        // método excluir filhos
        this.metodoExcluirFilhosAbre.push("void excluirFilhos(" + this.class + " " + this.objetoPrincipal + ") {");
        this.metodoExcluirFilhosFecha.push('}');
    }

}