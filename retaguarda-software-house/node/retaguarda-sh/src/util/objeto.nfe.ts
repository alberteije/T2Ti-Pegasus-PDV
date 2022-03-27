/**
   * classe transiente que armazena o objeto enviado pelo pagseguro
   */

export class ObjetoNfe {

	cnpj: string;
	justificativa: string;
	ano: string;
	modelo: string;
	serie: string;
	numeroInicial: string;
	numeroFinal: string;
	chaveAcesso: string;
		
	/**
	* Constructor
	*/
	constructor(objetoJson: {}) {
		if (objetoJson != null) {
			this.cnpj = objetoJson['cnpj'];
			this.justificativa = objetoJson['justificativa'];
			this.ano = objetoJson['ano'];
			this.modelo = objetoJson['modelo'];
			this.serie = objetoJson['serie'];
			this.numeroInicial = objetoJson['numeroInicial'];
			this.numeroFinal = objetoJson['numeroFinal'];
			this.chaveAcesso = objetoJson['chaveAcesso'];
		}
	}
    
}