import * as lodash from "lodash";
import { CamposModel } from '../../model/campos.model';
import { ComentarioDerJsonModel } from '../../model/comentario.der.json.model';
import { Biblioteca } from "../../util/biblioteca";

/// classe base que ajuda a gerar o repositório do CSharp usando o mustache
export class CSharpRepository {

    table: string; // armazena o nome da tabela
    class: string; // armazena o nome da classe
    objetoPrincipal: string; //armazena o nome do objeto principal, que costuma ser o nome da classe com a primeira letra em minúsculo
    includes = []; // armazena os includes
    notIncludes = []; // armazena os notIncludes - objetos que não devem persistir junto com o mestre

    campoModel: CamposModel;
    relacionamentosDetalhe: ComentarioDerJsonModel[]; // armazena relacionamentos PK para inserir nos includes

    constructor(tabela: string, dataPacket: CamposModel[], relacionamentos: ComentarioDerJsonModel[]) {
        // nome da classe
        this.class = lodash.camelCase(tabela);
        this.objetoPrincipal = this.class;
        this.class = lodash.upperFirst(this.class);

        // nome da tabela
        this.table = tabela.toUpperCase();

        for (let i = 0; i < dataPacket.length; i++) {
            // pega o campo
            this.campoModel = dataPacket[i];

            // define os dados do campo
            this.campoModel.nomeCampo = this.campoModel.Field;
            this.campoModel.nomeCampoTabela = this.campoModel.nomeCampo.toUpperCase();

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
        }

        // relacionamentos agregados ao Mestre
        if (relacionamentos != null) {
            this.tratarRelacionamentos(relacionamentos);
        }

        // relacionamentos FK encontrados na tabela
        if (this.relacionamentosDetalhe != null) {
            this.tratarRelacionamentos(this.relacionamentosDetalhe);
        }

    }

    tratarRelacionamentos(relacionamentos: ComentarioDerJsonModel[]) {
        for (let i = 0; i < relacionamentos.length; i++) {

            let relacionamento = relacionamentos[i];

            let nomeTabelaRelacionamento = relacionamento.tabela;
            let nomeCampoAtributo = lodash.camelCase(nomeTabelaRelacionamento);
            nomeCampoAtributo = lodash.upperFirst(nomeCampoAtributo);

            let inc = '';
            if (relacionamento.cardinalidade == '@OneToOne') {
                inc = '.Include(' + this.objetoPrincipal + ' => ' + this.objetoPrincipal + '.' + nomeCampoAtributo + ')';
            } else if (relacionamento.cardinalidade == '@OneToMany') {
                inc = '.Include(' + this.objetoPrincipal + ' => ' + this.objetoPrincipal + '.Lista' + nomeCampoAtributo + ')';
            }
            this.includes.push(inc);

            // verifica se o objeto deve ser persistido
            if (!relacionamento.create) {
                this.notIncludes.push("if (objeto." + nomeCampoAtributo + " != null)");
                this.notIncludes.push("{");
                this.notIncludes.push("\tRepositoryContext.Entry(objeto." + nomeCampoAtributo + ").State = EntityState.Unchanged; //não queremos inserir o objeto vinculado");
                this.notIncludes.push("} else");
                this.notIncludes.push("{");
                this.notIncludes.push("\tobjeto.Id" + nomeCampoAtributo + " = null;");
                this.notIncludes.push("}");
            }
        }
    }

}