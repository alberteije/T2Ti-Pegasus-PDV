import { CamposModel } from '../../model/campos.model';
import { FlutterDetalhePageBase } from './flutter.detalhe.page.base';

/// classe base que ajuda a gerar a DetalhePage do Flutter usando o mustache
export class FlutterAbaMestreDetalhePage extends FlutterDetalhePageBase {

    constructor(tabela: string, dataPacket: CamposModel[]) {
        super(tabela);
        super.montarPagina(dataPacket);
   }

}