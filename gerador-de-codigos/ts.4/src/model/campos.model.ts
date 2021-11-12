export class CamposModel {
    // dados que vem do banco
    Field: string;
    Type: string;
    Collation: string;
    Null: string;
    Key: string;
    Default: string;
    Extra: string;
    Privileges: string;
    Comment: string;

    // dados criados e utilizados localmente
    nomeCampo: string; // o mesmo Field acima
    nomeCampoTabela: string; // o nome do campo em caixa alta
    nomeCampoAtributo: string; // o nome do campo em camelCase
    nomeCampoGetSet: string; // o nome do campo em camelCase, mas com a primeira letra em maiusculo
    tipoCampo: string; // o mesmo Type acima
    tipoDadoOrdenacao: string; // usado na listaPage para definir o tipo de dado de ordenação do campo
    tamanhoCampo: number; // esse dado vem no tipo do campo, mas é convertido aqui para inteiro e é definido como 1000 se o tipo do campo for 'text'
    quantidadeLinhas: number; // se o tamanho do campo for 'text' ou maior que 200 a quantidade será definida como 3 - usado nos textFormField

}