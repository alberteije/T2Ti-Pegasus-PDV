import * as lodash from "lodash";
import { CamposModel } from '../../model/campos.model';
import { ComentarioDerJsonModel } from '../../model/comentario.der.json.model';
import { Biblioteca } from "../../util/biblioteca";

/// classe base que ajuda a gerar o model do Java usando o mustache
export class JavaModel {

    table: string; // armazena o nome da tabela
    modulo: string; // armazena o package
    class: string; // armazena o nome da classe
    objetoPrincipal: string; // armazena o nome do objeto principal, que costuma ser o nome da classe com a primeira letra em minúsculo

    atribut = []; // armazena os Atributos da classe
    gettersSetters = []; // armazena os Getters e os Setters
    atributObj = []; // armazena os objetos - relacionamentos OneToOne
    atributList = []; // armazena as listas - relacionamentos OneToMany
    gettersSettersObj = []; // armazena Getters e os Setters do tipo OneToOne
    gettersSettersList = []; // armazena Getters e os Setters do tipo OneToMany
    imports = []; // armazena os demais imports para a classe

    campoModel: CamposModel;
    relacionamentosDetalhe: ComentarioDerJsonModel[]; // armazena relacionamentos de uma tabela Detalhe que serão encontrado aqui no Model

    importDate: boolean; // controla os imports para datas
    importBigDecimal: boolean; // controla os imports para decimais
    importJsonIgnore: boolean; // controla o import para o jsonIgore
    importOneToOne: boolean;
    importManyToOne: boolean;
    importCascadeType: boolean;

    constructor(tabela: string, modulo: string, dataPacket: CamposModel[], relacionamentos: ComentarioDerJsonModel[]) {
        // imports diversos
        this.importDate = false;
        this.importBigDecimal = false;
        this.importJsonIgnore = false;
        this.importOneToOne = false;
        this.importManyToOne = false;
        this.importCascadeType = false;
    
        // nome da classe
        this.class = lodash.camelCase(tabela);
        this.objetoPrincipal = this.class;
        this.class = lodash.upperFirst(this.class);

        // package
        this.modulo = modulo;

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
            } else { // não insere campos PK como atributos, eles serão tratados como objetos ou listas
                // pega o tipo de dado
                let tipoDado = this.getTipo(this.campoModel.Type);

                // define o atributo
                let atributo = '';
                if (this.campoModel.nomeCampoTabela == 'ID') {
                    atributo = '@Id\n\t@GeneratedValue(strategy = GenerationType.IDENTITY)\n\t';
                } else {
                    if (tipoDado == 'Date') {
                        atributo = '@Temporal(TemporalType.DATE)\n\t';
                    }
                    atributo = atributo + '@Column(name="' + this.campoModel.nomeCampoTabela + '")\n\t';
                }
                atributo = atributo + 'private ' + tipoDado + ' ' + this.campoModel.nomeCampoAtributo + ';\n';
                this.atribut.push(atributo);

                // define os Getters e Setters - atributos normais
                let get = 'public ' + tipoDado + ' get' + this.campoModel.nomeCampoGetSet + '() {\n\t\t';
                get = get + 'return this.' + this.campoModel.nomeCampoAtributo + ';\n\t}\n\n\t';

                let set = 'public void set' + this.campoModel.nomeCampoGetSet + '(' + tipoDado + ' ' + this.campoModel.nomeCampoAtributo + ') {\n\t\t';
                set = set + 'this.' + this.campoModel.nomeCampoAtributo + ' = ' + this.campoModel.nomeCampoAtributo + ';\n\t}\n';

                let getSet = get + set;

                this.gettersSetters.push(getSet);
            }
        }

        // imports para alguns tipos de dados
        if (this.importBigDecimal) {
            this.imports.push('import java.math.BigDecimal;')
        }
        if (this.importDate) {
            this.imports.push('import java.util.Date;')
            this.imports.push('import javax.persistence.Temporal;')
            this.imports.push('import javax.persistence.TemporalType;')
        }

        // relacionamentos agregados ao Mestre
        if (relacionamentos != null) {
            this.tratarRelacionamentos(relacionamentos);
        }

        // relacionamentos agregados ao Detalhe
        if (this.relacionamentosDetalhe != null) {
            this.imports.push('import javax.persistence.JoinColumn;')
            this.tratarRelacionamentos(this.relacionamentosDetalhe);
        }

        // arruma imports de acordo com o conteúdo de objetos e listas
        if (this.importOneToOne) {
            this.imports.push('import javax.persistence.OneToOne;');
        }
        if (this.importManyToOne) {
            this.imports.push('import javax.persistence.ManyToOne;');
        }
        if (this.gettersSettersList.length > 0) {
            this.imports.push('import java.util.Set;');
            this.imports.push('import javax.persistence.OneToMany;');
        }
        if (this.importJsonIgnore) {
            this.imports.push('import com.fasterxml.jackson.annotation.JsonIgnore;')
        }
        if (this.importCascadeType) {
            this.imports.push('import javax.persistence.CascadeType;');
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
                if (relacionamento.side == 'Local') {
                    this.importManyToOne = true;
                    this.atributObj.push('@ManyToOne\n\t@JoinColumn(name="ID_' + nomeTabelaRelacionamento + '")');
                } else if (relacionamento.side == 'Inverse') {
                    this.importOneToOne = true;
                    if (relacionamento.classeMestre == "") {//se for vazio, o relacionamento foi encontrado na classe de detalhe e deve ser mapeado como tal
                        this.importJsonIgnore = true;
                        this.atributObj.push('@OneToOne\n\t@JsonIgnore\n\t@JoinColumn(name="ID_' + nomeTabelaRelacionamento + '")');
                    } else {
                        this.importCascadeType = true;
                        this.atributObj.push('@OneToOne(mappedBy = "' + this.objetoPrincipal + '", cascade = CascadeType.ALL, orphanRemoval = ' + relacionamento.orphanRemoval + ')');
                    }
                }
                let atributo = 'private ' + nomeCampoGetSet + ' ' + nomeCampoAtributo + ';\n';
                this.atributObj.push(atributo);

                // define os Getters e Setters - objetos
                this.defineGetSetObjeto(nomeCampoGetSet, nomeCampoAtributo, classeMestreGetSet);
            } else if (relacionamento.cardinalidade == '@OneToMany') {
                // define o atributo - lista
                let atributo = '';
                if (relacionamento.classeMestre == "") {//se for vazio, o relacionamento foi encontrado na classe de detalhe e deve ser mapeado como tal
                    this.importManyToOne = true;
                    this.importJsonIgnore = true;
                    this.atributList.push('@ManyToOne\n\t@JsonIgnore\n\t@JoinColumn(name="ID_' + nomeTabelaRelacionamento + '")');
                    atributo = 'private ' + nomeCampoGetSet + ' ' + nomeCampoAtributo + ';\n';
                    this.atributList.push(atributo);
                    // define os Getters e Setters - objetos
                    this.defineGetSetObjeto(nomeCampoGetSet, nomeCampoAtributo, classeMestreGetSet);
                } else {
                    this.importCascadeType = true;
                    this.atributList.push('@OneToMany(mappedBy = "' + this.objetoPrincipal + '", cascade = CascadeType.ALL, orphanRemoval = ' + relacionamento.orphanRemoval + ')');
                    atributo = 'private Set<' + nomeCampoGetSet + '> lista' + nomeCampoGetSet + ';\n';
                    this.atributList.push(atributo);
                    // define os Getters e Setters - listas
                    this.defineGetSetLista(nomeCampoGetSet, nomeCampoAtributo, classeMestreGetSet);
                }
            }
        }
    }

    defineGetSetObjeto(nomeCampoGetSet: string, nomeCampoAtributo: string, classeMestreGetSet: string) {
        let get = 'public ' + nomeCampoGetSet + ' get' + nomeCampoGetSet + '() {\n\t\t';
        get = get + 'return this.' + nomeCampoAtributo + ';\n\t}\n\n\t';

        let set = 'public void set' + nomeCampoGetSet + '(' + nomeCampoGetSet + ' ' + nomeCampoAtributo + ') {\n\t\t';
        set = set + 'this.' + nomeCampoAtributo + ' = ' + nomeCampoAtributo + ';\n';
        if (classeMestreGetSet != '') {
            set = set + '\t\tif (' + nomeCampoAtributo + ' != null) {\n\t\t\t';
            set = set + nomeCampoAtributo + '.set' + classeMestreGetSet + '(this);\n\t\t}\n';
        }
        set = set + '\t}\n';
        let getSet = get + set;

        this.gettersSettersObj.push(getSet);
    }

    defineGetSetLista(nomeCampoGetSet: string, nomeCampoAtributo: string, classeMestreGetSet: string) {
        let get = 'public Set<' + nomeCampoGetSet + '> getLista' + nomeCampoGetSet + '() {\n\t\t';
        get = get + 'return this.lista' + nomeCampoGetSet + ';\n\t}\n\n\t';

        let set = 'public void setLista' + nomeCampoGetSet + '(Set<' + nomeCampoGetSet + '> lista' + nomeCampoGetSet + ') {\n\t\t';
        set = set + 'this.lista' + nomeCampoGetSet + ' = lista' + nomeCampoGetSet + ';\n\t\t';
        set = set + 'for (' + nomeCampoGetSet + ' ' + nomeCampoAtributo + ' : lista' + nomeCampoGetSet + ') {\n\t\t\t';
        set = set + nomeCampoAtributo + '.set' + classeMestreGetSet + '(this);\n\t\t}\n\t}\n';

        let getSet = get + set;

        this.gettersSettersList.push(getSet);
    }

    // define o tipo de dado
    getTipo(pType: any): string {
        if (pType.includes('int')) {
            return 'Integer';
        } else if (pType.includes('varchar')) {
            return 'String';
        } else if (pType.includes('decimal')) {
            this.importBigDecimal = true;
            return 'BigDecimal';
        } else if (pType.includes('char')) {
            return 'String';
        } else if (pType.includes('text')) {
            return 'String';
        } else if (pType.includes('date')) {
            this.importDate = true;
            return 'Date';
        } else if (pType.includes('timestamp')) {
            this.importDate = true;
            return 'Date';
        }
    }

}