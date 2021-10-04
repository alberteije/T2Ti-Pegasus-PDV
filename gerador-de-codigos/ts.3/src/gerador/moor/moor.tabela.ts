import * as lodash from "lodash";
import { CamposModel } from '../../model/campos.model';
import { ComentarioDerJsonModel } from '../../model/comentario.der.json.model';
import { Biblioteca } from "../../util/biblioteca";

/// classe base que ajuda a gerar o model do Eloquent usando o mustache
export class MoorTabela {

    table: string; // armazena o nome da tabela
    class: string; // armazena o nome da classe

    campos = []; // armazena os campos da tabela

    campoModel: CamposModel;

    constructor(tabela: string, dataPacket: CamposModel[], relacionamentos: ComentarioDerJsonModel[]) {
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

            if (this.campoModel.nomeCampoTabela != 'ID') {

                // pega o tipo de dado
                let tipoDado = this.getTipo(this.campoModel.Type);
                let tipoColuna = this.getColuna(this.campoModel.Type);

                // tamanho do campo
                this.campoModel.tipoCampo = this.campoModel.Type;
                let posicaoAbreParentese = this.campoModel.tipoCampo.indexOf("(");
                let posicaoFechaParentese = this.campoModel.tipoCampo.indexOf(")");
                this.campoModel.tamanhoCampo = 0;
                if (this.campoModel.tipoCampo == "text") {
                    this.campoModel.tamanhoCampo = 250;
                }
                else {
                    this.campoModel.tamanhoCampo = parseInt(this.campoModel.tipoCampo.substring(posicaoAbreParentese + 1, posicaoFechaParentese));
                }        

                if (this.campoModel.nomeCampoTabela.includes('ID_') && this.campoModel.Comment != '') {
                    let tabelaRelacionada = lodash.replace(this.campoModel.nomeCampoTabela, 'ID_', '');
                    let objetoTabelaRelacionada = lodash.camelCase(tabelaRelacionada);
                    let classeTabelaRelacionada = lodash.upperFirst(objetoTabelaRelacionada);  

                    this.campos.push("IntColumn get id" + classeTabelaRelacionada + " => integer().named('" + this.campoModel.nomeCampoTabela + "').nullable().customConstraint('NULLABLE REFERENCES " + tabelaRelacionada + "(ID)')();");
                } else {

                    if (tipoColuna == 'TextColumn') {
                        this.campos.push("TextColumn get " + this.campoModel.nomeCampoAtributo + " => text().named('" + this.campoModel.nomeCampoTabela + "').withLength(min: 0, max: " + this.campoModel.tamanhoCampo + ").nullable()();");
                    } else {
                        this.campos.push(tipoColuna + " get " + this.campoModel.nomeCampoAtributo + " => " + tipoDado + ".named('" + this.campoModel.nomeCampoTabela + "').nullable()();");
                    }
                }

            }
        }

    }

    // define o tipo de dado
    getTipo(pType: any): string {
        if (pType.includes('int')) {
            return 'integer()';
        } else if (pType.includes('varchar')) {
            return 'text()';
        } else if (pType.includes('decimal')) {
            return 'real()';
        } else if (pType.includes('char')) {
            return 'text()';
        } else if (pType.includes('text')) {
            return 'text()';
        } else if (pType.includes('date')) {
            return 'dateTime()';
        } else if (pType.includes('timestamp')) {
            return 'dateTime()';
        }
    }

    // define o tipo de dado
    getColuna(pType: any): string {
        if (pType.includes('int')) {
            return 'IntColumn';
        } else if (pType.includes('varchar')) {
            return 'TextColumn';
        } else if (pType.includes('decimal')) {
            return 'RealColumn';
        } else if (pType.includes('char')) {
            return 'TextColumn';
        } else if (pType.includes('text')) {
            return 'TextColumn';
        } else if (pType.includes('date')) {
            return 'DateTimeColumn';
        } else if (pType.includes('timestamp')) {
            return 'DateTimeColumn';
        }
    }

}