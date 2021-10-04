import * as lodash from "lodash";
import { ComentarioDerJsonModel } from '../../model/comentario.der.json.model';

/// classe base que ajuda a gerar o a página mestre das abas do Flutter usando o mustache
export class FlutterAbaMestrePage {

    table: string; // armazena o nome da tabela
    class: string; // armazena o nome da classe
    objetoPrincipal: string; // armazena o nome do objeto principal, que costuma ser o nome da classe com a primeira letra em minúsculo
    nomeArquivo: string; // armazena o nome do aruqivo que aparece no import

    imports = []; // armazena os demais imports para a classe
    keysOneToOne = []; // armazena as keys do scafold e do form para páginas OneToOne - Ex: PessoaFisica e PessoaJuridica
    abasOneToOne = []; // armazena as abas OneToOne
    abasOneToMany = []; // armazena as abas OneToMany
    salvarFormsOneToOne = []; // armazena o código de salvamento dos forms OneToOne

    objetoJsonComentario: ComentarioDerJsonModel;

    constructor(tabela: string, relacionamentos: ComentarioDerJsonModel[]) {
        // nome da classe
        this.class = lodash.camelCase(tabela);
        this.objetoPrincipal = this.class;
        this.class = lodash.upperFirst(this.class);

        // nome da tabela
        this.table = tabela.toUpperCase();

        // nomeArquivo
        this.nomeArquivo = tabela.toLowerCase();

        // relacionamentos agregados ao Mestre
        if (relacionamentos != null) {
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
                // import
                this.imports.push("import '" + nomeTabelaRelacionamento.toLowerCase() + "_persiste_page.dart';");

                // keysOneToOne
                this.keysOneToOne.push("final GlobalKey<FormState> _" + nomeCampoAtributo + "PersisteFormKey = GlobalKey<FormState>();");
                this.keysOneToOne.push("final GlobalKey<ScaffoldState> _" + nomeCampoAtributo + "PersisteScaffoldKey = GlobalKey<ScaffoldState>();");

                // abasOneToOne
                let titulo = lodash.startCase(nomeCampoAtributo);
                this.abasOneToOne.push("_todasAsAbas.add(Aba(");
                this.abasOneToOne.push("\ticon: Icons.person,"); // será preciso atualizar o ícone manualmente no código para um apropriado à aba
                this.abasOneToOne.push("\ttext: '" + titulo + "',");
                this.abasOneToOne.push("\tvisible: true,");
                this.abasOneToOne.push("\tpagina: " + nomeCampoGetSet + "PersistePage(");
                this.abasOneToOne.push("\t\tformKey: _" + nomeCampoAtributo + "PersisteFormKey,");
                this.abasOneToOne.push("\t\tscaffoldKey: _" + nomeCampoAtributo + "PersisteScaffoldKey,");
                this.abasOneToOne.push("\t\t" + this.objetoPrincipal + ": widget." + this.objetoPrincipal + ")));");

                // salvarFormsOneToOne
                this.salvarFormsOneToOne.push("FormState form" + nomeCampoGetSet + " = _" + nomeCampoAtributo + "PersisteFormKey.currentState;");
                this.salvarFormsOneToOne.push("if (form" + nomeCampoGetSet + " != null) {");
                this.salvarFormsOneToOne.push("\tif (!form" + nomeCampoGetSet + ".validate()) {");
                this.salvarFormsOneToOne.push("\t\t_abasController.animateTo(1);"); // talvez esse número precise ser atualizado dependendo da quantidade de abas OneToOne que o Form possua
                this.salvarFormsOneToOne.push("\t} else {");
                this.salvarFormsOneToOne.push("\t\t_" + nomeCampoAtributo + "PersisteFormKey.currentState?.save();");
                this.salvarFormsOneToOne.push("\t}");
                this.salvarFormsOneToOne.push("}");
            } else if (relacionamento.cardinalidade == '@OneToMany') {
                // import
                this.imports.push("import '" + nomeTabelaRelacionamento.toLowerCase() + "_lista_page.dart';");

                // abasOneToMany
                let titulo = lodash.startCase(nomeCampoAtributo);
                this.abasOneToMany.push("_todasAsAbas.add(Aba(");
                this.abasOneToMany.push("\ticon: Icons.group,"); // será preciso atualizar o ícone manualmente no código para um apropriado à aba
                this.abasOneToMany.push("\ttext: 'Relação - " + titulo + "',");
                this.abasOneToMany.push("\tvisible: true,");
                this.abasOneToMany.push("\tpagina: " + nomeCampoGetSet + "ListaPage(" + this.objetoPrincipal + ": widget." + this.objetoPrincipal + ")));");
            }
        }
    }


}