export class ObjetoSincroniza {

	tabela: string;
	registros: string;
		
	/**
	* Constructor
	*/
	constructor(objetoJson: {}) {
		if (objetoJson != null) {
			this.tabela = objetoJson['tabela'];
			this.registros = objetoJson['registros'];
		}
	}
    
}