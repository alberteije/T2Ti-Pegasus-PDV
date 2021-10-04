import { CamposModel } from '../../model/campos.model';
import { FlutterPersistePageBase } from "./flutter.persiste.page.base";

/// classe base que ajuda a gerar a PersistePage do Flutter usando o mustache
export class FlutterAbaMestrePersistePage extends FlutterPersistePageBase {

    constructor(tabela: string, dataPacket: CamposModel[]) {
        super(tabela);
        super.montarPagina(dataPacket, true, false);
    }
}