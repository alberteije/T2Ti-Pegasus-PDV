import * as lodash from "lodash";
import { CamposModel } from '../../model/campos.model';
import { ComentarioDerJsonModel } from '../../model/comentario.der.json.model';
import { Biblioteca } from "../../util/biblioteca";

/// classe base que ajuda a gerar o model do Eloquent usando o mustache
export class EloquentModel {

    table: string; // armazena o nome da tabela
    class: string; // armazena o nome da classe
    objetosEager: string;
    objetoPrincipal: string; // armazena o nome do objeto principal, que costuma ser o nome da classe com a primeira letra em minúsculo

    atributObj = []; // armazena os objetos - relacionamentos OneToOne
    gettersSetters = []; // armazena os Getters e os Setters
    mapeamentoSimples = []; // mapeamento no construtor - atributos simples
    mapeamentoObj = []; // mapeamento no construtor - objetos
    serializeSimples = []; // serialize JSON - atributos simples
    serializeObj = []; // serialize JSON - objetos
    serializeList = []; // serialize JSON - listas
    eagerLoad = []; // // armazena os objetos que devem ser carregados junto com o objeto principal

    geraWith: boolean; // controla se deve gerar o with com os objetos que devem ser carregados imediatamente com o objeto principal - Eager Loading

    campoModel: CamposModel;
    relacionamentosDetalhe: ComentarioDerJsonModel[]; // armazena relacionamentos de uma tabela Detalhe que serão encontrado aqui no Model

    constructor(tabela: string, dataPacket: CamposModel[], relacionamentos: ComentarioDerJsonModel[]) {
        // Eager Loading
        this.geraWith = false;
        this.objetosEager = "";

        // nome da classe
        this.class = lodash.camelCase(tabela);
        this.objetoPrincipal = this.class;
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

            if (this.campoModel.nomeCampoTabela.includes('ID_') && this.campoModel.Comment != '') {
                if (Biblioteca.isJsonString(tabela, this.campoModel.Comment)) {
                    let objeto = new ComentarioDerJsonModel('', this.campoModel.Comment);
                    objeto.tabela = lodash.replace(this.campoModel.nomeCampoTabela, 'ID_', '');
                    if (this.relacionamentosDetalhe == null) {
                        this.relacionamentosDetalhe = new Array;
                    }
                    this.relacionamentosDetalhe.push(objeto);
                }
            } else { // não insere campos PK como atributos, eles serão tratados como objetos ou listass
                // define o atributo
                // --- não existe para o Eloquent

                // define os Getters e Setters - atributos normais
                // GET
                let get = 'public function get' + this.campoModel.nomeCampoGetSet + 'Attribute() \n\t{\n\t\t';
                get = get + "return $this->attributes['" + this.campoModel.nomeCampoTabela + "'];\n\t}\n\n\t";
                // SET
                let set = 'public function set' + this.campoModel.nomeCampoGetSet + 'Attribute($' + this.campoModel.nomeCampoAtributo + ') \n\t{\n\t\t';
                set = set + "$this->attributes['" + this.campoModel.nomeCampoTabela + "'] = $" + this.campoModel.nomeCampoAtributo + ";\n\t}\n";

                let getSet = get + set;

                this.gettersSetters.push(getSet);

                // define o mapeamento dos dados entre os atributos simples
                if (this.campoModel.nomeCampoTabela != 'ID') {
                    let mapeamento = "$this->set" + this.campoModel.nomeCampoGetSet + "Attribute($objeto->" + this.campoModel.nomeCampoAtributo + ");";
                    this.mapeamentoSimples.push(mapeamento);
                }

                // serializa os atributos para JSON
                let serial = "'" + this.campoModel.nomeCampoAtributo + "' => $this->get" + this.campoModel.nomeCampoGetSet + "Attribute(),";
                this.serializeSimples.push(serial);
            }
        }

        this.mapeamentoObj.push("// vincular objetos");

        // relacionamentos agregados ao Mestre
        if (relacionamentos != null) {
            this.tratarRelacionamentos(relacionamentos);
        }

        // relacionamentos agregados ao Detalhe
        if (this.relacionamentosDetalhe != null) {
            this.tratarRelacionamentos(this.relacionamentosDetalhe);
        }

        if (this.geraWith)
        {
            this.eagerLoad.push("protected $with = [" + this.objetosEager + "];");
        }

    }

    tratarRelacionamentos(relacionamentos: ComentarioDerJsonModel[]) {
        for (let i = 0; i < relacionamentos.length; i++) {
            let relacionamento = relacionamentos[i];

            let nomeTabelaRelacionamento = lodash.toUpper(relacionamento.tabela);
            let nomeCampoAtributo = lodash.camelCase(nomeTabelaRelacionamento);
            let nomeCampoGetSet = lodash.upperFirst(nomeCampoAtributo);

            // verifica a cardinalidade para definir o nome do Field
            if (relacionamento.cardinalidade == '@OneToOne') {
                if (relacionamento.side == 'Local') {
                    this.geraWith = true;
                    this.objetosEager = this.objetosEager + "'" + nomeCampoAtributo + "', ";

                    this.atributObj.push('public function ' + nomeCampoAtributo + '()');
                    this.atributObj.push('{');
                    this.atributObj.push("\treturn $this->belongsTo(" + nomeCampoGetSet + "::class, 'ID_" + nomeTabelaRelacionamento + "', 'ID');");
                    this.atributObj.push('}\n');

                    // mapeamento para objetos vinculados
                    this.mapeamentoObj.push("$" + nomeCampoAtributo + " = new " + nomeCampoGetSet + "();");
                    this.mapeamentoObj.push("$" + nomeCampoAtributo + "->mapear($objeto->" + nomeCampoAtributo + ");");
                    this.mapeamentoObj.push("$this->" + nomeCampoAtributo + "()->associate($" + nomeCampoAtributo + ");\n");

                    // serializa objeto
                    let serial = "'" + nomeCampoAtributo + "' => $this->" + nomeCampoAtributo + ",";
                    this.serializeObj.push(serial);
                } else if (relacionamento.side == 'Inverse') {
                    if (relacionamento.classeMestre == "") {//se for vazio, o relacionamento foi encontrado na classe de detalhe e deve ser mapeado como tal
                        this.atributObj.push('public function ' + nomeCampoAtributo + '()');
                        this.atributObj.push('{');
                        this.atributObj.push("\treturn $this->belongsTo(" + nomeCampoGetSet + "::class, 'ID_" + nomeTabelaRelacionamento + "', 'ID');");
                        this.atributObj.push('}\n');    
                    } else {
                        this.geraWith = true;
                        this.objetosEager = this.objetosEager + "'" + nomeCampoAtributo + "', ";

                        this.atributObj.push('public function ' + nomeCampoAtributo + '()');
                        this.atributObj.push('{');
                        this.atributObj.push("\treturn $this->hasOne(" + nomeCampoGetSet + "::class, 'ID_" + this.table + "', 'ID');");
                        this.atributObj.push('}\n');    

                        // serializa objeto
                        let serial = "'" + nomeCampoAtributo + "' => $this->" + nomeCampoAtributo + ",";
                        this.serializeObj.push(serial);
                    }
                }
            } else if (relacionamento.cardinalidade == '@OneToMany') {
                if (relacionamento.classeMestre == "") {//se for vazio, o relacionamento foi encontrado na classe de detalhe e deve ser mapeado como tal
                    this.atributObj.push('public function ' + nomeCampoAtributo + '()');
                    this.atributObj.push('{');
                    this.atributObj.push("\treturn $this->belongsTo(" + nomeCampoGetSet + "::class, 'ID_" + nomeTabelaRelacionamento + "', 'ID');");
                    this.atributObj.push('}\n');    
                } else {
                    this.geraWith = true;
                    this.objetosEager = this.objetosEager + "'lista" + nomeCampoGetSet + "', ";

                    this.atributObj.push('public function lista' + nomeCampoGetSet + '()');
                    this.atributObj.push('{');
                    this.atributObj.push("\treturn $this->hasMany(" + nomeCampoGetSet + "::class, 'ID_" + this.table + "', 'ID');");
                    this.atributObj.push('}\n');    
    
                    // serializa lista
                    let serial = "'lista" + nomeCampoGetSet + "' => $this->lista" + nomeCampoGetSet + ",";
                    this.serializeList.push(serial);
                }
            }
        }
    }


}