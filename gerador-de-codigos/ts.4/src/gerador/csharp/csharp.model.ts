import * as lodash from "lodash";
import { CamposModel } from '../../model/campos.model';
import { ComentarioDerJsonModel } from '../../model/comentario.der.json.model';
import { Biblioteca } from "../../util/biblioteca";

/// classe base que ajuda a gerar o model do CSharp usando o mustache
export class CSharpModel {

    table: string; // armazena o nome da tabela
    class: string; // armazena o nome da classe
    atribut = []; // armazena os Atributos da classe
    atributObj = []; // armazena os objetos - relacionamentos OneToOne
    atributList = []; // armazena as listas - relacionamentos OneToMany
    imports = []; // armazena os demais imports para a classe

    campoModel: CamposModel;
    relacionamentosDetalhe: ComentarioDerJsonModel[]; // armazena relacionamentos de uma tabela Detalhe que serão encontrado aqui no Model

    importGeneric: boolean; // controla o import para Generics quando usarmos listas

    constructor(tabela: string, dataPacket: CamposModel[], relacionamentos: ComentarioDerJsonModel[]) {
        // imports diversos
        this.importGeneric = false;

        // nome da classe
        this.class = lodash.camelCase(tabela);
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
            this.campoModel.nomeCampoGetSet = lodash.upperFirst(this.campoModel.nomeCampoAtributo);  

            if (this.campoModel.nomeCampoTabela.includes('ID_') && this.campoModel.Comment != '') {
                if (Biblioteca.isJsonString(tabela, this.campoModel.Comment)) {
                    let objeto = new ComentarioDerJsonModel('', this.campoModel.Comment);
                    objeto.tabela = lodash.replace(this.campoModel.nomeCampoTabela, 'ID_', '');
                    if (this.relacionamentosDetalhe == null) {
                        this.relacionamentosDetalhe = new Array;
                    }
                    this.relacionamentosDetalhe.push(objeto);
                }
            }

            // pega o tipo de dado
            let tipoDado = this.getTipo(this.campoModel.Type);

            // define o atributo
            let atributo = '';
            if (this.campoModel.nomeCampoTabela == 'ID') {
                tipoDado = 'int';
                atributo = '[Key]\n\t\t';
            } 
            
            atributo = atributo + '[Column("' + this.campoModel.nomeCampoTabela + '")]\n\t\t';
            atributo = atributo + 'public ' + tipoDado + ' ' + this.campoModel.nomeCampoGetSet + ' { get; set; }\n';
            this.atribut.push(atributo);
        }

        // relacionamentos agregados ao Mestre
        if (relacionamentos != null) {
            this.tratarRelacionamentos(relacionamentos);
        }

        // relacionamentos agregados ao Detalhe
        if (this.relacionamentosDetalhe != null) {
            this.tratarRelacionamentos(this.relacionamentosDetalhe);
        }

        // arruma imports
        if (this.importGeneric) {
            this.imports.push('using System.Collections.Generic;')
        }
    }

    tratarRelacionamentos(relacionamentos: ComentarioDerJsonModel[]) {
        for (let i = 0; i < relacionamentos.length; i++) {

            let relacionamento = relacionamentos[i];

            let nomeTabelaRelacionamento = relacionamento.tabela;
            let nomeCampoAtributo = lodash.camelCase(nomeTabelaRelacionamento);
            let nomeCampoGetSet = lodash.upperFirst(nomeCampoAtributo);
            let classeMestreGetSet = lodash.upperFirst(relacionamento.classeMestre);

            // verifica a cardinalidade para definir o nome do Field
            if (relacionamento.cardinalidade == '@OneToOne') {
                // define o atributo - objeto
                if (relacionamento.classeMestre == "") {//se for vazio, o relacionamento foi encontrado na classe de detalhe e deve ser mapeado como tal
                    this.atributObj.push('[ForeignKey("Id' + nomeCampoGetSet + '")]');
                } else {
                    this.atributObj.push('[InverseProperty("' + classeMestreGetSet + '")]');
                }
                let atributo = 'public ' + nomeCampoGetSet + ' ' + nomeCampoGetSet + ' { get; set; }\n';
                this.atributObj.push(atributo);
            } else if (relacionamento.cardinalidade == '@OneToMany') {
                // define o atributo - lista
                let atributo = '';
                if (relacionamento.classeMestre == "") {//se for vazio, o relacionamento foi encontrado na classe de detalhe e deve ser mapeado como tal
                    this.atributList.push('[ForeignKey("Id' + nomeCampoGetSet + '")]');
                    atributo = 'public ' + nomeCampoGetSet + ' ' + nomeCampoGetSet + ' { get; set; }\n';
                } else {
                    this.importGeneric = true;
                    this.atributList.push('[InverseProperty("' + classeMestreGetSet + '")]');
                    atributo = 'public IList<' + nomeCampoGetSet + '> Lista' + nomeCampoGetSet + ' { get; set; }\n';
                }
                this.atributList.push(atributo);
            }
        }
    }

    // define o tipo de dado
    getTipo(pType: any): string {
        if (pType.includes('int')) {
            return 'int?';
        } else if (pType.includes('varchar')) {
            return 'string';
        } else if (pType.includes('decimal')) {
            return 'System.Nullable<System.Decimal>';
        } else if (pType.includes('char')) {
            return 'string';
        } else if (pType.includes('text')) {
            return 'string';
        } else if (pType.includes('date')) {
            return 'System.Nullable<System.DateTime>';
        } else if (pType.includes('timestamp')) {
            return 'System.Nullable<System.DateTime>';
        }
    }

}