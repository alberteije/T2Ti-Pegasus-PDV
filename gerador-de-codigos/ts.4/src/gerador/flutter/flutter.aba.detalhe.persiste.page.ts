import * as lodash from "lodash";
import { CamposModel } from '../../model/campos.model';
import { FlutterPersistePageBase } from "./flutter.persiste.page.base";

/// classe base que ajuda a gerar a PersistePage do Flutter usando o mustache
export class FlutterAbaDetalhePersistePage extends FlutterPersistePageBase {

    objetoMestre: string; // armazena o nome do objeto mestre - ex: PessoaEndereco fará referência ao objeto mestre 'pessoa'
    classeMestre: string; // armazena o nome da classe mestre - ex: PessoaEndereco fará referência à classe mestre 'Pessoa'

    constructor(tabela: string, tabelaMestre: string, dataPacket: CamposModel[]) {
        super(tabela);

        // objeto e classe mestre
        this.objetoMestre = lodash.camelCase(tabelaMestre);
        this.classeMestre = lodash.upperFirst(this.objetoMestre);

        super.montarPagina(dataPacket, true, true); 
    }
}