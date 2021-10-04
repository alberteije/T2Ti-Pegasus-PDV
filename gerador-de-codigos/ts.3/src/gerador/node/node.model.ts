import * as lodash from "lodash";
import { CamposModel } from '../../model/campos.model';
import { ComentarioDerJsonModel } from '../../model/comentario.der.json.model';
import { Biblioteca } from "../../util/biblioteca";

/// classe base que ajuda a gerar o model do Node usando o mustache
export class NodeModel {

    table: string; // armazena o nome da tabela
    class: string; // armazena o nome da classe
    objetoPrincipal: string; // armazena o nome do objeto principal, que costuma ser o nome da classe com a primeira letra em minúsculo
    stringImportTypeORM: string; // armazena outras classes que serão importadas para o TypeORM
    
    atribut = []; // armazena os Atributos da classe
    atributObj = []; // armazena os objetos - relacionamentos OneToOne
    atributList = []; // armazena as listas - relacionamentos OneToMany
    mapeamentoSimples = []; // mapeamento no construtor - atributos simples
    mapeamentoObj = []; // mapeamento no construtor - objetos
    mapeamentoList = []; // mapeamento no construtor - listas
    imports = []; // armazena os demais imports para a classe

    campoModel: CamposModel;
    relacionamentosDetalhe: ComentarioDerJsonModel[]; // armazena relacionamentos de uma tabela Detalhe que serão encontrado aqui no Model

    importOneToOne: boolean; // controla os imports OneToOne
    importManyToOne: boolean; // controla o import ManyToOne
    importOneToMany: boolean; // controla o import OneToMany
    importJoinColumn: boolean; // controla os imports JoinColumn

    constructor(tabela: string, dataPacket: CamposModel[], relacionamentos: ComentarioDerJsonModel[]) {
        // imports
        this.stringImportTypeORM = '';
        this.importOneToOne = false;
        this.importManyToOne = false;
        this.importOneToMany = false;
        this.importJoinColumn = false;
            
        // nome da classe
        this.class = lodash.camelCase(tabela);
        this.objetoPrincipal = this.class;
        this.class = lodash.upperFirst(this.class);

        // nome da tabela
        this.table = tabela.toUpperCase();

        // atributos e gettersSetters
        for (let i = 0; i < dataPacket.length; i++) {
            // pega o campo
            this.campoModel = dataPacket[i];

            // define os dados do campo
            this.campoModel.nomeCampo = this.campoModel.Field;
            this.campoModel.nomeCampoTabela = this.campoModel.nomeCampo.toUpperCase();
            this.campoModel.nomeCampoAtributo = lodash.camelCase(this.campoModel.nomeCampo);

            if (this.campoModel.nomeCampoTabela.includes('ID_') && this.campoModel.Comment != '') {
                if (Biblioteca.isJsonString(tabela, this.campoModel.Comment)) {
                    let objeto = new ComentarioDerJsonModel('', this.campoModel.Comment);
                    objeto.tabela = lodash.replace(this.campoModel.nomeCampoTabela, 'ID_', '');
                    if (this.relacionamentosDetalhe == null) {
                        this.relacionamentosDetalhe = new Array;
                    }
                    this.relacionamentosDetalhe.push(objeto);
                }
            } else { // não insere campos PK como atributos, eles serão tratados como objetos ou listass
                // pega o tipo de dado
                let tipoDado = this.getTipo(this.campoModel.Type);

                // define o atributo
                let atributo = '';
                if (this.campoModel.nomeCampoTabela != 'ID') {
                    atributo = atributo + "@Column({ name: '" + this.campoModel.nomeCampoTabela + "' })\n\t";

                    atributo = atributo + this.campoModel.nomeCampoAtributo + ': ' + tipoDado + ';\n';
                    this.atribut.push(atributo);

                    // define o mapeamento dos dados entre os atributos simples
                    let mapeamento = "this." + this.campoModel.nomeCampoAtributo + " = " + "objetoJson['" + this.campoModel.nomeCampoAtributo + "'];";
                    this.mapeamentoSimples.push(mapeamento);
                }
            }
        }

        // relacionamentos agregados ao Mestre
        if (relacionamentos != null) {
            this.tratarRelacionamentos(relacionamentos);
        }

        // relacionamentos agregados ao Detalhe
        if (this.relacionamentosDetalhe != null) {
            this.tratarRelacionamentos(this.relacionamentosDetalhe);
        }

        // arruma os imports
        if (this.importOneToMany) {
            this.stringImportTypeORM = this.stringImportTypeORM + ", OneToMany";
        }
        if (this.importOneToOne) {
            this.stringImportTypeORM = this.stringImportTypeORM + ", OneToOne";
        }
        if (this.importManyToOne) {
            this.stringImportTypeORM = this.stringImportTypeORM + ", ManyToOne";
        }
        if (this.importJoinColumn) {
            this.stringImportTypeORM = this.stringImportTypeORM + ", JoinColumn";
        }
    }

    tratarRelacionamentos(relacionamentos: ComentarioDerJsonModel[]) {
        for (let i = 0; i < relacionamentos.length; i++) {
            let relacionamento = relacionamentos[i];

            let nomeTabelaRelacionamento = relacionamento.tabela;
            let nomeCampoAtributo = lodash.camelCase(nomeTabelaRelacionamento);
            let nomeCampoGetSet = lodash.upperFirst(nomeCampoAtributo);

            // import
            this.imports.push("import { " + nomeCampoGetSet + " } from '../../entities-export';")

            // verifica a cardinalidade para definir o nome do Field
            if (relacionamento.cardinalidade == '@OneToOne') {
                // import
                this.importOneToOne = true;
                // define o atributo - objeto
                let atributo = '';
                if (relacionamento.side == 'Local') {
                    // import
                    this.importJoinColumn = true;

                    this.atributObj.push('@OneToOne(() => ' + nomeCampoGetSet + ')');
                    this.atributObj.push('@JoinColumn({ name: "ID_' + nomeTabelaRelacionamento + '" })');
                    atributo = nomeCampoAtributo + ': ' + nomeCampoGetSet + ';\n';

                    // mapeamento para objetos
                    this.mapeamentoObj.push("if (objetoJson['" + nomeCampoAtributo + "'] != null) {");
                    this.mapeamentoObj.push("\tthis." + nomeCampoAtributo + " = new " + nomeCampoGetSet + "(objetoJson['" + nomeCampoAtributo + "']);");
                    this.mapeamentoObj.push("}\n");

                } else if (relacionamento.side == 'Inverse') {
                    if (relacionamento.classeMestre == "") {//se for vazio, o relacionamento foi encontrado na classe de detalhe e deve ser mapeado como tal
                        // import
                        this.importJoinColumn = true;

                        this.atributObj.push('@OneToOne(() => ' + nomeCampoGetSet + ', ' + nomeCampoAtributo + ' => ' + nomeCampoAtributo + '.' + this.objetoPrincipal + ')');
                        this.atributObj.push('@JoinColumn({ name: "ID_' + nomeTabelaRelacionamento + '" })');
                        atributo = nomeCampoAtributo + ': ' + nomeCampoGetSet + ';\n';
                    } else {
                        this.atributObj.push('@OneToOne(() => ' + nomeCampoGetSet + ', ' + nomeCampoAtributo + ' => ' + nomeCampoAtributo + '.' + this.objetoPrincipal + ', { cascade: ' + relacionamento.cascade + ' })');
                        atributo = nomeCampoAtributo + ': ' + nomeCampoGetSet + ';\n';

                        // mapeamento para objetos
                        this.mapeamentoObj.push("if (objetoJson['" + nomeCampoAtributo + "'] != null) {");
                        this.mapeamentoObj.push("\tthis." + nomeCampoAtributo + " = new " + nomeCampoGetSet + "(objetoJson['" + nomeCampoAtributo + "']);");
                        this.mapeamentoObj.push("}\n");
                    }
                }
                this.atributObj.push(atributo);
            } else if (relacionamento.cardinalidade == '@OneToMany') {
                // define o atributo - lista
                let atributo = '';
                if (relacionamento.classeMestre == "") {//se for vazio, o relacionamento foi encontrado na classe de detalhe e deve ser mapeado como tal
                    // import
                    this.importManyToOne = true;
                    this.importJoinColumn = true;
                    
                    this.atributList.push('@ManyToOne(() => ' + nomeCampoGetSet + ', ' + nomeCampoAtributo + ' => ' + nomeCampoAtributo + '.lista' + this.class + ')');
                    this.atributList.push('@JoinColumn({ name: "ID_' + nomeTabelaRelacionamento + '" })');
                    atributo = nomeCampoAtributo + ': ' + nomeCampoGetSet + ';\n';
                } else {
                    // import
                    this.importOneToMany = true;
                    
                    this.atributList.push('@OneToMany(() => ' + nomeCampoGetSet + ', ' + nomeCampoAtributo + ' => ' + nomeCampoAtributo + '.' + this.objetoPrincipal + ', { cascade: ' + relacionamento.cascade + ' })');
                    atributo = 'lista' + nomeCampoGetSet + ': ' + nomeCampoGetSet + '[];\n';

                    // mapeamento para listas
                    this.mapeamentoList.push("this.lista" + nomeCampoGetSet + " = [];");
                    this.mapeamentoList.push("let lista" + nomeCampoGetSet + "Json = objetoJson['lista" + nomeCampoGetSet + "'];");
                    this.mapeamentoList.push("if (lista" + nomeCampoGetSet + "Json != null) {");
                    this.mapeamentoList.push("\tfor (let i = 0; i < lista" + nomeCampoGetSet + "Json.length; i++) {");
                    this.mapeamentoList.push("\t\tlet objeto = new " + nomeCampoGetSet + "(lista" + nomeCampoGetSet + "Json[i]);");
                    this.mapeamentoList.push("\t\tthis.lista" + nomeCampoGetSet + ".push(objeto);");
                    this.mapeamentoList.push("\t}");
                    this.mapeamentoList.push("}\n");              
                }
                this.atributList.push(atributo);
            }
        }
    }

    // define o tipo de dado
    getTipo(pType: any): string {
        if (pType.includes('int')) {
            return 'number';
        } else if (pType.includes('varchar')) {
            return 'string';
        } else if (pType.includes('decimal')) {
            return 'number';
        } else if (pType.includes('char')) {
            return 'string';
        } else if (pType.includes('text')) {
            return 'string';
        } else if (pType.includes('date')) {
            return 'Date';
        } else if (pType.includes('timestamp')) {
            return 'Date';
        }
    }

}