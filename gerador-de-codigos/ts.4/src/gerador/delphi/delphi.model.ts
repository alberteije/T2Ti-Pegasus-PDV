import * as lodash from "lodash";
import { CamposModel } from '../../model/campos.model';
import { ComentarioDerJsonModel } from '../../model/comentario.der.json.model';
import { Biblioteca } from "../../util/biblioteca";

/// classe base que ajuda a gerar o model do Delphi usando o mustache
export class DelphiModel {

    uses: string; // armazena as uses que serão inseridas no início da unit
    table: string; // armazena o nome da tabela
    class: string; // armazena o nome da classe
    fields = []; // armazena os Fields que são gerados na unit
    properties = []; // armazena as property que são geradas na unit
    fieldsObj = []; // armazena os objetos - relacionamentos OneToOne
    fieldsList = []; // armazena as listas - relacionamentos OneToMany
    constDestInterface = []; // armazena as declaração do construtor e destrutor
    propertiesObj = []; // armazena as property do tipo OneToOne
    propertiesList = []; // armazena as property do tipo OneToMany
    constImplementation = []; // armazena a implementação do contrutor
    destImplementation = []; // armazena a implementação do destrutor

    campoModel: CamposModel;
    relacionamentosDetalhe: ComentarioDerJsonModel[]; // armazena relacionamentos de uma tabela Detalhe que serão encontrado aqui no Model

    constructor(tabela: string, dataPacket: CamposModel[], relacionamentos: ComentarioDerJsonModel[]) {
        // nome da classe
        this.class = lodash.camelCase(tabela);
        this.class = lodash.upperFirst(this.class);

        // nome da tabela
        this.table = tabela.toUpperCase();

        // fields e properties
        for (let i = 0; i < dataPacket.length; i++) {
            // pega o campo
            this.campoModel = dataPacket[i];

            // define o nome do campo
            let nomeCampo = this.campoModel.Field;

            let nomeCampoTabela = nomeCampo.toUpperCase();
            let nomeCampoJson = lodash.camelCase(nomeCampo);
            let nomeCampoFieldProperty = lodash.upperFirst(nomeCampoJson);

            // se houver um campo PK e o Side for 'Local' adiciona o objeto da classe Pai no array relacionamentosDetalhe
            if (nomeCampoTabela.includes('ID_') && this.campoModel.Comment != '') {
                if (Biblioteca.isJsonString(tabela, this.campoModel.Comment)) {
                    let objeto = new ComentarioDerJsonModel('', this.campoModel.Comment);
                    if (objeto.side == 'Local') {
                        objeto.tabela = lodash.replace(nomeCampoTabela, 'ID_', '');
                        if (this.relacionamentosDetalhe == null) {
                            this.relacionamentosDetalhe = new Array;
                        }
                        this.relacionamentosDetalhe.push(objeto);
                    }    
                }
            }

            // pega o tipo de dado
            let tipoDado = this.getTipo(this.campoModel.Type);

            // define o field
            let field = 'F' + nomeCampoFieldProperty + ': ' + tipoDado + ';';
            this.fields.push(field);

            // define a property
            let atributoNomeCampo = "[MVCColumnAttribute('" + nomeCampoTabela;
            if (nomeCampoTabela == 'ID') {
                atributoNomeCampo = atributoNomeCampo + "', True)]";
            } else {
                atributoNomeCampo = atributoNomeCampo + "')]";
            }
            let atributoNomeJson = "[MVCNameAsAttribute('" + nomeCampoJson + "')]";
            let property = 'property ' + nomeCampoFieldProperty + ': ' + tipoDado + ' read F' + nomeCampoFieldProperty + ' write F' + nomeCampoFieldProperty + ';';

            let atributosComPropriedade = atributoNomeCampo + '\n\t\t' + atributoNomeJson + '\n\t\t' + property;

            this.properties.push(atributosComPropriedade);
        }

        // imports iniciais
        if (relacionamentos != null || this.relacionamentosDetalhe != null) {
            this.uses = 'Generics.Collections, System.SysUtils,\n  ';
        }

        // relacionamentos agregados ao Mestre
        if (relacionamentos != null) {
            this.abrirConstrutorDestrutor();
            this.tratarRelacionamentos(relacionamentos);
        }

        // relacionamentos agregados ao Detalhe
        if (this.relacionamentosDetalhe != null) {
            this.abrirConstrutorDestrutor();
            this.tratarRelacionamentos(this.relacionamentosDetalhe);
        }

        // fecha construtor e destrutor, se necessario
        if (relacionamentos != null || this.relacionamentosDetalhe != null) {
            this.fecharConstrutorDestrutor();
        }

    }

    abrirConstrutorDestrutor() {
        if (this.constDestInterface.length == 0) {
            // contrutor e destrutor na interface
            this.constDestInterface.push('constructor Create; virtual;');
            this.constDestInterface.push('destructor Destroy; override;\n');

            // contrutor na implementation - abre
            this.constImplementation.push('constructor T' + this.class + '.Create;');
            this.constImplementation.push('begin');
            this.constImplementation.push('  inherited;');

            // destrutor na implementation - abre
            this.destImplementation.push('destructor T' + this.class + '.Destroy;');
            this.destImplementation.push('begin');
        }
    }

    fecharConstrutorDestrutor() {
        // se ocorrer de não haver objetos ou listas, limpa o contrutor o destrutor e as uses.
        if (this.propertiesObj.length == 0 && this.propertiesList.length == 0) {
            this.uses = '';
            this.constDestInterface.length = 0;
            this.constImplementation.length = 0;
            this.destImplementation.length = 0;
        } else {
            if (this.constDestInterface.length > 0) {
                // contrutor na implementation - fecha
                this.constImplementation.push('end;');

                // destrutor na implementation - abre
                this.destImplementation.push('  inherited;');
                this.destImplementation.push('end;');
            }
        }
    }

    tratarRelacionamentos(relacionamentos: ComentarioDerJsonModel[]) {
        for (let i = 0; i < relacionamentos.length; i++) {

            let relacionamento = relacionamentos[i];

            let nomeCampo = relacionamento.tabela;
            let nomeCampoJson = lodash.camelCase(nomeCampo);
            let nomeCampoFieldProperty = lodash.upperFirst(nomeCampoJson);

            // uses
            this.uses = this.uses + nomeCampoFieldProperty + ', ';

            // verifica a cardinalidade para definir o nome do Field
            if (relacionamento.cardinalidade == '@OneToOne') {
                // define o field - objeto
                let field = 'F' + nomeCampoFieldProperty + ': T' + nomeCampoFieldProperty + ';';
                this.fieldsObj.push(field);
                // define a property
                let atributoNomeJson = "[MVCNameAsAttribute('" + nomeCampoJson + "')]";
                let property = 'property ' + nomeCampoFieldProperty + ': T' + nomeCampoFieldProperty + ' read F' + nomeCampoFieldProperty + ' write F' + nomeCampoFieldProperty + ';';
                let atributosComPropriedade = atributoNomeJson + '\n\t\t' + property;
                this.propertiesObj.push(atributosComPropriedade);
                // construtor
                let createField = '  F' + nomeCampoFieldProperty + ' := ' + 'T' + nomeCampoFieldProperty + '.Create;';
                this.constImplementation.push(createField);
                // destrutor
                let releaseField = '  FreeAndNil(F' + nomeCampoFieldProperty + ');';
                this.destImplementation.push(releaseField);
            } else if (relacionamento.cardinalidade == '@OneToMany') {
                // define o field - lista
                let field = 'FLista' + nomeCampoFieldProperty + ': TObjectList<T' + nomeCampoFieldProperty + '>;';
                this.fieldsList.push(field);
                // define a property
                let atributoMapperList = "[MapperListOf(T" + nomeCampoFieldProperty + ")]";
                let atributoNomeJson = "[MVCNameAsAttribute('lista" + nomeCampoFieldProperty + "')]";
                let property = 'property Lista' + nomeCampoFieldProperty + ': TObjectList<T' + nomeCampoFieldProperty + '> read FLista' + nomeCampoFieldProperty + ' write FLista' + nomeCampoFieldProperty + ';';
                let atributosComPropriedade = atributoMapperList + '\n\t\t' + atributoNomeJson + '\n\t\t' + property;
                this.propertiesList.push(atributosComPropriedade);
                // construtor
                let createField = '  FLista' + nomeCampoFieldProperty + ' := ' + 'TObjectList<T' + nomeCampoFieldProperty + '>.Create;';
                this.constImplementation.push(createField);
                // destrutor
                let releaseField = '  FreeAndNil(FLista' + nomeCampoFieldProperty + ');';
                this.destImplementation.push(releaseField);
            }
        }

    }

    // define o tipo de dado
    getTipo(pType: any): string {
        if (pType.includes('int')) {
            return 'Integer';
        } else if (pType.includes('varchar')) {
            return 'string';
        } else if (pType.includes('decimal')) {
            return 'Extended';
        } else if (pType.includes('char')) {
            return 'string';
        } else if (pType.includes('text')) {
            return 'string';
        } else if (pType.includes('date')) {
            return 'TDateTime';
        } else if (pType.includes('timestamp')) {
            return 'TDateTime';
        }
    }

}