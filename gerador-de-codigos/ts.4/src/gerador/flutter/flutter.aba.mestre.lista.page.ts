import { CamposModel } from '../../model/campos.model';
import { FlutterListaPageBase } from './flutter.lista.page.base';

/// classe base que ajuda a gerar a ListaPage do Flutter usando o mustache
export class FlutterAbaMestreListaPage extends FlutterListaPageBase {

    constructor(tabela: string, dataPacket: CamposModel[]) {
        super(tabela);
        super.montarPagina(dataPacket);
    }

}