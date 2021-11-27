import { CamposModel } from '../../model/campos.model';
import { ComentarioDerJsonModel } from '../../model/comentario.der.json.model';
import { FlutterListaPageBase } from "../flutter/flutter.lista.page.base";
import { Biblioteca } from "../../util/biblioteca";

/// classe base que ajuda a gerar a ListaPage do Flutter usando o mustache
export class MoorListaPage extends FlutterListaPageBase {

    constructor(tabela: string, dataPacket: CamposModel[]) {
        super(tabela);
        super.montarPagina(dataPacket, true);
    }

}