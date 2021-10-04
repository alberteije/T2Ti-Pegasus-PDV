import * as lodash from "lodash";
import { CamposModel } from '../../model/campos.model';
import { ComentarioDerJsonModel } from '../../model/comentario.der.json.model';

/// classe base que ajuda a gerar o extension do CSharp usando o mustache
export class CSharpExtension {

    table: string; // armazena o nome da tabela
    class: string; // armazena o nome da classe
    mapeamentoSimples = []; // armazena os Atributos da classe
    mapeamentoObjeto = []; // armazena os objetos - relacionamentos OneToOne
    mapeamentoLista = []; // armazena as listas - relacionamentos OneToMany

    constructor(tabela: string, dataPacket: CamposModel[], relacionamentos: ComentarioDerJsonModel[]) {
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
            nomeCampoAtributo = lodash.upperFirst(nomeCampoAtributo);

            // define o mapeamento dos dados entre os atributos simples
            if (!nomeCampoTabela.includes('ID')) { // não precisa gerar para o PK e FK
                let mapeamento = 'objBanco.' + nomeCampoAtributo + ' = ' + 'objJson.' + nomeCampoAtributo + ';';
                this.mapeamentoSimples.push(mapeamento);
            }
        }

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

            // verifica a cardinalidade para definir o nome do Field
            if (relacionamento.cardinalidade == '@OneToOne') {
                let mapeamento = 'objBanco.' + nomeCampoGetSet + ' = ' + 'objJson.' + nomeCampoGetSet + ';';
                this.mapeamentoObjeto.push(mapeamento);
            } else if (relacionamento.cardinalidade == '@OneToMany') {
                let mapeamento = 'objBanco.Lista' + nomeCampoGetSet + ' = ' + 'objJson.Lista' + nomeCampoGetSet + ';';
                this.mapeamentoLista.push(mapeamento);
            }
        }
    }

}