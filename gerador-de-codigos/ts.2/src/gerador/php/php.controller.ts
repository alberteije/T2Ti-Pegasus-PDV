import * as lodash from "lodash";
import { CamposModel } from '../../model/campos.model';
import { ComentarioDerJsonModel } from '../../model/comentario.der.json.model';
import { Biblioteca } from "../../util/biblioteca";

/// classe base que ajuda a gerar o controller do PHP usando o mustache
export class PHPController {

    table: string; // armazena o nome da tabela
    class: string; // armazena o nome da classe
    excluiFilhosString: string; // armazena a string para chamar o método de exclusão dos filhos, usado em tabelas mestre/detalhe

    filhosVinculadosObj = []; // relação de objetos para o método 'excluir filhos'
    filhosVinculadosList = []; // relação de listas para o método 'excluir filhos'

    mestresVinculadosInclusao = [] // armazena o código de configuração dos objetos mestre vinculados para o método inserir
    mestresVinculadosAlteracao = [] // armazena o código de configuração dos objetos mestre vinculados para o método alterar

    campoModel: CamposModel;

    constructor(tabela: string, dataPacket: CamposModel[], relacionamentos: ComentarioDerJsonModel[]) {
        // nome da classe
        this.class = lodash.camelCase(tabela);
        this.class = lodash.upperFirst(this.class);

        // nome da tabela
        this.table = tabela.toUpperCase();

        this.excluiFilhosString = '';

        // acha os relacionamentos PK que tenham campos locais para anexar os objetos no método inserir
        for (let i = 0; i < dataPacket.length; i++) {
            // pega o campo
            this.campoModel = dataPacket[i];

            // define os dados do campo
            this.campoModel.nomeCampo = this.campoModel.Field;
            this.campoModel.nomeCampoTabela = this.campoModel.nomeCampo.toUpperCase();

            if (this.campoModel.nomeCampoTabela.includes('ID_') && this.campoModel.Comment != '') {
                if (Biblioteca.isJsonString(tabela, this.campoModel.Comment)) {
                    let objeto = new ComentarioDerJsonModel('', this.campoModel.Comment);
                    if (objeto.side == 'Local') {
                        objeto.tabela = lodash.replace(this.campoModel.nomeCampoTabela, 'ID_', '');
                        let objetoMestre = lodash.camelCase(objeto.tabela);
                        let classeMestre = lodash.upperFirst(objetoMestre);
                        this.mestresVinculadosInclusao.push("$objEntidade->set" + classeMestre + "(" + classeMestre + "Service::consultarObjeto($objJson->" + objetoMestre + "->id));");
                        this.mestresVinculadosAlteracao.push("$objBanco->set" + classeMestre + "(" + classeMestre + "Service::consultarObjeto($objJson->" + objetoMestre + "->id));");
                    }
                }
            }
        }
        // relacionamentos agregados ao Mestre
        if (relacionamentos != null && relacionamentos.length > 0) {
            this.tratarRelacionamentos(relacionamentos);
        }
    }

    tratarRelacionamentos(relacionamentos: ComentarioDerJsonModel[]) {

        // chama o método excluir
        this.excluiFilhosString = this.class + "Service::excluirFilhos($objBanco);";

        for (let i = 0; i < relacionamentos.length; i++) {
            let relacionamento = relacionamentos[i];

            let nomeTabelaRelacionamento = relacionamento.tabela;
            let nomeCampoAtributo = lodash.camelCase(nomeTabelaRelacionamento);
            let nomeCampoGetSet = lodash.upperFirst(nomeCampoAtributo);

            // verifica a cardinalidade para definir o código
            if (relacionamento.cardinalidade == '@OneToOne') {
                // exclusao de objetos
                this.filhosVinculadosObj.push("$" + nomeCampoAtributo + " = $objEntidade->get" + nomeCampoGetSet + "();");
                this.filhosVinculadosObj.push("if ($" + nomeCampoAtributo + " != null) {");
                this.filhosVinculadosObj.push("\t$" + nomeCampoAtributo + "->set" + this.class + "($objBanco);");
                this.filhosVinculadosObj.push("\t$objBanco->set" + nomeCampoGetSet + "($" + nomeCampoAtributo + ");");
                this.filhosVinculadosObj.push("}\n");
            } else if (relacionamento.cardinalidade == '@OneToMany') {
                // exclusao de listas
                this.filhosVinculadosList.push("$lista" + nomeCampoGetSet + " = $objEntidade->getLista" + nomeCampoGetSet + "();");
                this.filhosVinculadosList.push("if ($lista" + nomeCampoGetSet + " != null) {");
                this.filhosVinculadosList.push("\t$objBanco->setLista" + nomeCampoGetSet + "($lista" + nomeCampoGetSet + ");");
                this.filhosVinculadosList.push("}\n");
            }
        }
    }

}