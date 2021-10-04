import * as lodash from "lodash";
import { CamposModel } from '../../model/campos.model';
import { ComentarioDerJsonModel } from '../../model/comentario.der.json.model';

/// classe base que ajuda a gerar o model do PHP usando o mustache
export class PHPModel {

    table: string; // armazena o nome da tabela
    class: string; // armazena o nome da classe
    objetoPrincipal: string; // armazena o nome do objeto principal, que costuma ser o nome da classe com a primeira letra em minúsculo

    atribut = []; // armazena os Atributos da classe
    atributObj = []; // armazena os objetos - relacionamentos OneToOne
    atributList = []; // armazena as listas - relacionamentos OneToMany
    gettersSetters = []; // armazena os Getters e os Setters
    gettersSettersObj = []; // armazena Getters e os Setters do tipo OneToOne
    gettersSettersList = []; // armazena Getters e os Setters do tipo OneToMany
    mapeamentoSimples = []; // mapeamento no construtor - atributos simples
    mapeamentoObj = []; // mapeamento no construtor - objetos
    mapeamentoList = []; // mapeamento no construtor - listas
    serializeSimples = []; // serialize JSON - atributos simples
    serializeObj = []; // serialize JSON - objetos
    serializeList = []; // serialize JSON - listas
    imports = []; // armazena os demais imports para a classe

    relacionamentosDetalhe: ComentarioDerJsonModel[]; // armazena relacionamentos de uma tabela Detalhe que serão encontrado aqui no Model

    importArrayCollection: boolean; // controla os imports ArrayCollection

    constructor(tabela: string, dataPacket: CamposModel[], relacionamentos: ComentarioDerJsonModel[]) {
        // imports
        this.importArrayCollection = false;

        // nome da classe
        this.class = lodash.camelCase(tabela);
        this.objetoPrincipal = this.class;
        this.class = lodash.upperFirst(this.class);

        // nome da tabela
        this.table = tabela.toUpperCase();

        // atributos e gettersSetters
        for (let i = 0; i < dataPacket.length; i++) {
            // define o nome do campo
            let nomeCampo = dataPacket[i].Field;

            let nomeCampoTabela = nomeCampo.toUpperCase();
            let nomeCampoAtributo = lodash.camelCase(nomeCampo);
            let nomeCampoGetSet = lodash.upperFirst(nomeCampoAtributo);

            if (nomeCampoTabela.includes('ID_') && dataPacket[i].Comment != '') {
                let objeto = new ComentarioDerJsonModel('', dataPacket[i].Comment);
                objeto.tabela = lodash.replace(nomeCampoTabela, 'ID_', '');
                if (this.relacionamentosDetalhe == null) {
                    this.relacionamentosDetalhe = new Array;
                }
                this.relacionamentosDetalhe.push(objeto);
            } else { // não insere campos PK como atributos, eles serão tratados como objetos ou listass
                // pega o tipo de dado
                let tipoDado = this.getTipo(dataPacket[i].Type);

                // define o atributo
                let atributo = '';
                if (nomeCampoTabela == 'ID') {
                    atributo = atributo + '/**\n\t';
                    atributo = atributo + ' * @ORM\\Id\n\t';
                    atributo = atributo + ' * @ORM\\Column(type="integer")\n\t';
                    atributo = atributo + ' * @ORM\\GeneratedValue(strategy="AUTO")\n\t';
                    atributo = atributo + ' */\n\t';
                    atributo = atributo + 'private $' + nomeCampoAtributo + ';\n';
                } else {
                    atributo = atributo + '/**\n\t';
                    atributo = atributo + ' * @ORM\\Column(type="' + tipoDado + '", name="' + nomeCampoTabela + '")\n\t';
                    atributo = atributo + ' */\n\t';
                    atributo = atributo + 'private $' + nomeCampoAtributo + ';\n';
                }
                this.atribut.push(atributo);

                // define os Getters e Setters - atributos normais
                let get = 'public function get' + nomeCampoGetSet + '() \n\t{\n\t\t';
                if (tipoDado == 'date') {
                    get = get + "if ($this->" + nomeCampoAtributo + " != null) {\n\t\t\t";
                    get = get + "return $this->" + nomeCampoAtributo + "->format('Y-m-d');\n\t\t";
                    get = get + "} else {\n\t\t\t";
                    get = get + "return null;\n\t\t}\n\t}\n\t";
                } else {
                    get = get + 'return $this->' + nomeCampoAtributo + ';\n\t}\n\n\t';
                }

                let set = 'public function set' + nomeCampoGetSet + '($' + nomeCampoAtributo + ') \n\t{\n\t\t';
                if (tipoDado == 'date') {
                    set = set + '$this->' + nomeCampoAtributo + ' = $' + nomeCampoAtributo + ' != null ? new \\DateTime($' + nomeCampoAtributo + ') : null;\n\t}\n';
                } else {
                    set = set + '$this->' + nomeCampoAtributo + ' = $' + nomeCampoAtributo + ';\n\t}\n';
                }

                let getSet = get + set;

                this.gettersSetters.push(getSet);

                // define o mapeamento dos dados entre os atributos simples
                if (nomeCampoTabela != 'ID') {
                    let mapeamento = "$this->set" + nomeCampoGetSet + "($objeto->" + nomeCampoAtributo + ");";
                    this.mapeamentoSimples.push(mapeamento);
                }

                // serializa os atributos para JSON
                let serial = "'" + nomeCampoAtributo + "' => $this->get" + nomeCampoGetSet + "(),";
                this.serializeSimples.push(serial);
            }
        }

        // relacionamentos agregados ao Mestre
        if (relacionamentos != null) {
            this.tratarRelacionamentos(relacionamentos);
        }

        // relacionamentos agregados ao Detalhe
        if (this.relacionamentosDetalhe != null) {
            this.tratarRelacionamentos(this.relacionamentosDetalhe);
        }

        // arruma os imports
        if (this.importArrayCollection) {
            this.imports.push('use Doctrine\\Common\\Collections\\ArrayCollection;');
        }
    }

    tratarRelacionamentos(relacionamentos: ComentarioDerJsonModel[]) {
        for (let i = 0; i < relacionamentos.length; i++) {
            let relacionamento = relacionamentos[i];

            let nomeTabelaRelacionamento = relacionamento.tabela;
            let nomeCampoAtributo = lodash.camelCase(nomeTabelaRelacionamento);
            let nomeCampoGetSet = lodash.upperFirst(nomeCampoAtributo);
            let classeMestreGetSet = lodash.upperFirst(relacionamento.classeMestre);

            // verifica a cardinalidade para definir o nome do Field
            if (relacionamento.cardinalidade == '@OneToOne') {
                // define o atributo - objeto
                let atributo = '';
                if (relacionamento.side == 'Local') {
                    this.atributObj.push('/**');
                    this.atributObj.push(' * @ORM\\OneToOne(targetEntity="' + nomeCampoGetSet + '", fetch="EAGER")');
                    this.atributObj.push(' * @ORM\\JoinColumn(name="ID_' + nomeTabelaRelacionamento + '", referencedColumnName="id")');
                    this.atributObj.push(' */');
                    atributo = 'private $' + nomeCampoAtributo + ';\n';

                    // serializa objeto
                    let serial = "'" + nomeCampoAtributo + "' => $this->get" + nomeCampoGetSet + "(),";
                    this.serializeObj.push(serial);
                } else if (relacionamento.side == 'Inverse') {
                    if (relacionamento.classeMestre == "") {//se for vazio, o relacionamento foi encontrado na classe de detalhe e deve ser mapeado como tal
                        this.atributObj.push('/**');
                        this.atributObj.push(' * @ORM\\OneToOne(targetEntity="' + nomeCampoGetSet + '", inversedBy="' + this.objetoPrincipal + '")');
                        this.atributObj.push(' * @ORM\\JoinColumn(name="ID_' + nomeTabelaRelacionamento + '", referencedColumnName="id")');
                        this.atributObj.push(' */');
                        atributo = 'private $' + nomeCampoAtributo + ';\n';
                    } else {
                        this.atributObj.push('/**');
                        this.atributObj.push(' * @ORM\\OneToOne(targetEntity="' + nomeCampoGetSet + '", mappedBy="' + this.objetoPrincipal + '", cascade={"persist", "remove"})');
                        this.atributObj.push(' */');
                        atributo = 'private $' + nomeCampoAtributo + ';\n';

                        // mapeamento para objetos
                        this.mapeamentoObj.push("if (isset($objetoJson->" + nomeCampoAtributo + ")) {");
                        this.mapeamentoObj.push("\t$this->set" + nomeCampoGetSet + "(new " + nomeCampoGetSet + "($objetoJson->" + nomeCampoAtributo + "));");
                        this.mapeamentoObj.push("\t$this->get" + nomeCampoGetSet + "()->set" + this.class + "($this);");
                        this.mapeamentoObj.push("}\n");

                        // serializa objeto
                        let serial = "'" + nomeCampoAtributo + "' => $this->get" + nomeCampoGetSet + "(),";
                        this.serializeObj.push(serial);
                    }
                }
                this.atributObj.push(atributo);
                // define os Getters e Setters - objetos
                this.defineGetSetObjeto(nomeCampoGetSet, nomeCampoAtributo);
            } else if (relacionamento.cardinalidade == '@OneToMany') {
                // define o atributo - lista
                let atributo = '';
                if (relacionamento.classeMestre == "") {//se for vazio, o relacionamento foi encontrado na classe de detalhe e deve ser mapeado como tal
                    this.atributList.push('/**');
                    this.atributList.push(' * @ORM\\ManyToOne(targetEntity="' + nomeCampoGetSet + '", inversedBy="lista' + this.class + '")');
                    this.atributList.push(' * @ORM\\JoinColumn(name="ID_' + nomeTabelaRelacionamento + '", referencedColumnName="id")');
                    this.atributList.push(' */');
                    atributo = 'private $' + nomeCampoAtributo + ';\n';
                    // define os Getters e Setters - objetos
                    this.defineGetSetObjeto(nomeCampoGetSet, nomeCampoAtributo);
                } else {
                    // import
                    this.importArrayCollection = true;

                    this.atributList.push('/**');
                    this.atributList.push(' * @ORM\\OneToMany(targetEntity="' + nomeCampoGetSet + '", mappedBy="' + this.objetoPrincipal + '", cascade={"persist", "remove"})');
                    this.atributList.push(' */');
                    atributo = 'private $lista' + nomeCampoGetSet + ';\n';

                    // mapeamento para listas
                    this.mapeamentoList.push("$this->lista" + nomeCampoGetSet + " = new ArrayCollection();");
                    this.mapeamentoList.push("$lista" + nomeCampoGetSet + "Json = $objetoJson->lista" + nomeCampoGetSet + ";");
                    this.mapeamentoList.push("if ($lista" + nomeCampoGetSet + "Json != null) {");
                    this.mapeamentoList.push("\tfor ($i = 0; $i < count($lista" + nomeCampoGetSet + "Json); $i++) {");
                    this.mapeamentoList.push("\t\t$objeto = new " + nomeCampoGetSet + "($lista" + nomeCampoGetSet + "Json[$i]);");
                    this.mapeamentoList.push("\t\t$objeto->set" + this.class + "($this);");
                    this.mapeamentoList.push("\t\t$this->lista" + nomeCampoGetSet + "->add($objeto);");
                    this.mapeamentoList.push("\t}");
                    this.mapeamentoList.push("}\n");

                    // serializa lista
                    let serial = "'lista" + nomeCampoGetSet + "' => $this->getLista" + nomeCampoGetSet + "(),";
                    this.serializeList.push(serial);
                    // define os Getters e Setters - listas
                    this.defineGetSetLista(nomeCampoGetSet, nomeCampoAtributo, classeMestreGetSet);
                }
                this.atributList.push(atributo);
            }
        }
    }

    defineGetSetObjeto(nomeCampoGetSet: string, nomeCampoAtributo: string) {
        let get = 'public function get' + nomeCampoGetSet + '(): ?' + nomeCampoGetSet + ' \n\t{\n\t\t';
        get = get + 'return $this->' + nomeCampoAtributo + ';\n\t}\n\n\t';

        let set = 'public function set' + nomeCampoGetSet + '(?' + nomeCampoGetSet + ' $' + nomeCampoAtributo + ') \n\t{\n\t\t';
        set = set + '$this->' + nomeCampoAtributo + ' = $' + nomeCampoAtributo + ';\n\t}\n';

        let getSet = get + set;

        this.gettersSettersObj.push(getSet);
    }

    defineGetSetLista(nomeCampoGetSet: string, nomeCampoAtributo: string, classeMestreGetSet: string) {
        let get = 'public function getLista' + nomeCampoGetSet + '() \n\t{\n\t\t';
        get = get + 'return $this->lista' + nomeCampoGetSet + '->toArray();\n\t}\n\n\t';

        let set = 'public function setLista' + nomeCampoGetSet + '(array $lista' + nomeCampoGetSet + ') {\n\t\t';
        set = set + '$this->lista' + nomeCampoGetSet + ' = new ArrayCollection();\n\t\t';
        set = set + 'for ($i = 0; $i < count($lista' + nomeCampoGetSet + '); $i++) {\n\t\t\t';
        set = set + '$' + nomeCampoAtributo + ' = $lista' + nomeCampoGetSet + '[$i];\n\t\t\t';
        set = set + '$' + nomeCampoAtributo + '->set' + classeMestreGetSet + '($this);\n\t\t\t';
        set = set + '$this->lista' + nomeCampoGetSet + '->add($' + nomeCampoAtributo + ');\n\t\t}\n\t}\n';

        let getSet = get + set;

        this.gettersSettersList.push(getSet);
    }

    // define o tipo de dado
    getTipo(pType: any): string {
        if (pType.includes('int')) {
            return 'integer';
        } else if (pType.includes('varchar')) {
            return 'string';
        } else if (pType.includes('decimal')) {
            return 'float';
        } else if (pType.includes('char')) {
            return 'string';
        } else if (pType.includes('text')) {
            return 'string';
        } else if (pType.includes('date')) {
            return 'date';
        }
    }

}