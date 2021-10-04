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
                this.abasOneToOne.push("  icon: Icons.person,"); // será preciso atualizar o ícone manualmente no código para um apropriado à aba
                this.abasOneToOne.push("  text: '" + titulo + "',");
                this.abasOneToOne.push("  visible: true,");
                this.abasOneToOne.push("  pagina: " + nomeCampoGetSet + "PersistePage(");
                this.abasOneToOne.push("    formKey: _" + nomeCampoAtributo + "PersisteFormKey,");
                this.abasOneToOne.push("    scaffoldKey: _" + nomeCampoAtributo + "PersisteScaffoldKey,");
                this.abasOneToOne.push("    " + this.objetoPrincipal + ": widget." + this.objetoPrincipal + ",");
                this.abasOneToOne.push("    foco: myFocusNode,");
                this.abasOneToOne.push("    salvar" + this.class + "CallBack: _salvar" + this.class + ",");                
                this.abasOneToOne.push(")));");

                // salvarFormsOneToOne
                this.salvarFormsOneToOne.push("FormState form" + nomeCampoGetSet + " = _" + nomeCampoAtributo + "PersisteFormKey.currentState;");
                this.salvarFormsOneToOne.push("if (form" + nomeCampoGetSet + " != null) {");
                this.salvarFormsOneToOne.push("  if (!form" + nomeCampoGetSet + ".validate()) {");
                this.salvarFormsOneToOne.push("    _abasController.animateTo(1);"); // talvez esse número precise ser atualizado dependendo da quantidade de abas OneToOne que o Form possua
                this.salvarFormsOneToOne.push("    return false;");
                this.salvarFormsOneToOne.push("  } else {");
                this.salvarFormsOneToOne.push("    _" + nomeCampoAtributo + "PersisteFormKey.currentState?.save();");
                this.salvarFormsOneToOne.push("    return true;");
                this.salvarFormsOneToOne.push("  }");
                this.salvarFormsOneToOne.push("}");
            } else if (relacionamento.cardinalidade == '@OneToMany') {
                // import
                this.imports.push("import '" + nomeTabelaRelacionamento.toLowerCase() + "_lista_page.dart';");

                // abasOneToMany
                let titulo = lodash.startCase(nomeCampoAtributo);
                this.abasOneToMany.push("_todasAsAbas.add(Aba(");
                this.abasOneToMany.push("  icon: Icons.group,"); // será preciso atualizar o ícone manualmente no código para um apropriado à aba
                this.abasOneToMany.push("  text: 'Relação - " + titulo + "',");
                this.abasOneToMany.push("  visible: true,");
                this.abasOneToMany.push("  pagina: " + nomeCampoGetSet + "ListaPage(");
                this.abasOneToMany.push("    " + this.objetoPrincipal + ": widget." + this.objetoPrincipal + ",");
                this.abasOneToMany.push("    foco: myFocusNode,");
                this.abasOneToMany.push("    salvar" + this.class + "CallBack: _salvar" + this.class + ",");                
                this.abasOneToMany.push(")));");
            }
        }
    }


}