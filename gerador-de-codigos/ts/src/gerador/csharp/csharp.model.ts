import * as lodash from "lodash";
import { CamposModel } from '../../model/campos.model';
import { ComentarioDerJsonModel } from '../../model/comentario.der.json.model';

/// classe base que ajuda a gerar o model do CSharp usando o mustache
export class CSharpModel {

    table: string; // armazena o nome da tabela
    class: string; // armazena o nome da classe
    atribut = []; // armazena os Atributos da classe
    atributObj = []; // armazena os objetos - relacionamentos OneToOne
    atributList = []; // armazena as listas - relacionamentos OneToMany
    imports = []; // armazena os demais imports para a classe

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
            // define o nome do campo
            let nomeCampo = dataPacket[i].Field;

            let nomeCampoTabela = nomeCampo.toUpperCase();
            let nomeCampoAtributo = lodash.camelCase(nomeCampo);
            let nomeCampoGetSet = lodash.upperFirst(nomeCampoAtributo);

            if (nomeCampoTabela.includes('ID_') && dataPacket[i].Comment != '') {
                let objeto = new ComentarioDerJsonModel('', dataPacket[i].Comment);
                objeto.tabela = lodash.replace(nomeCampoTabela, 'ID_', '');
                if (this.relacionamentosDetalhe == null) {
                    this.relacionamentosDetalhe = new Array;
                }
                this.relacionamentosDetalhe.push(objeto);
            }

            // pega o tipo de dado
            let tipoDado = this.getTipo(dataPacket[i].Type);

            // define o atributo
            let atributo = '';
            if (nomeCampoTabela == 'ID') {
                tipoDado = 'int';
                atributo = '[Key]\n\t\t';
            } 
            
            atributo = atributo + '[Column("' + nomeCampoTabela + '")]\n\t\t';
            atributo = atributo + 'public ' + tipoDado + ' ' + nomeCampoGetSet + ' { get; set; }\n';
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
        }
    }

}