/*
Title: T2Ti ERP 3.0                                                                
Description: Classe que armazena listas fixas que são carregadas em DropdownButtons
                                                                                
The MIT License                                                                 
                                                                                
Copyright: Copyright (C) 2021 T2Ti.COM                                          
                                                                                
Permission is hereby granted, free of charge, to any person                     
obtaining a copy of this software and associated documentation                  
files (the "Software"), to deal in the Software without                         
restriction, including without limitation the rights to use,                    
copy, modify, merge, publish, distribute, sublicense, and/or sell               
copies of the Software, and to permit persons to whom the                       
Software is furnished to do so, subject to the following                        
conditions:                                                                     
                                                                                
The above copyright notice and this permission notice shall be                  
included in all copies or substantial portions of the Software.                 
                                                                                
THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,                 
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES                 
OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND                        
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT                     
HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,                    
WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING                    
FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR                   
OTHER DEALINGS IN THE SOFTWARE.                                                 
                                                                                
       The author may be contacted at:                                          
           t2ti.com@gmail.com                                                   
                                                                                
@author Albert Eije (alberteije@gmail.com)                    
@version 1.0.0
*******************************************************************************/
class DropdownLista {
  /// singleton
  factory DropdownLista() {
    _this ??= DropdownLista._();
    return _this;
  }
  static DropdownLista _this;
  DropdownLista._() : super();

  static const List<String> listaUF = <String>[
    'AC',
    'AL',
    'AP',
    'AM',
    'BA',
    'CE',
    'DF',
    'ES',
    'GO',
    'MA',
    'MT',
    'MS',
    'MG',
    'PA',
    'PB',
    'PR',
    'PE',
    'PI',
    'RJ',
    'RN',
    'RS',
    'RO',
    'RR',
    'SC',
    'SP',
    'SE',
    'TO'
  ];

  static const List<String> listaCombustivelRenavam = <String>[
	'01=Álcool',
	'02=Gasolina',
	'03=Diesel',
	'04=Gasogênio',
	'05=GásMetano',
	'06=Elétrico/Fonte Interna',
	'07=Elétrico/Fonte Externa',
	'08=Gasolina/Gás Natural Combustível',
	'09=Álcool/Gás Natural Combustível',
	'10=Diesel/Gas Natural Combustível',
	'11=Vide/Campo/Observação',
	'12=Álcool/Gás Natural Veicular',
	'13=Gasolina/Gás Natural Veicular',
	'14=Diesel/Gás Natural Veicular',
	'15=Gás Natural Veicular',
	'16=Álcool/Gasolina',
	'17=Gasolina/Álcool/Gás Natural Veicular',
	'18=Gasolina/eletrico'
  ];

  static const List<String> listaVeiculoRenavam = <String>[
	'02=CICLOMOTO',
	'03=MOTONETA',
	'04=MOTOCICLO',
	'05=TRICICLO',
	'06=AUTOMÓVEL',
	'07=MICRO-ÔNIBUS',
	'08=ÔNIBUS',
	'10=REBOQUE',
	'11=SEMIRREBOQUE',
	'13=CAMIONETA',
	'14=CAMINHÃO',
	'17=CAMINHÃO TRATOR',
	'18=TRATOR RODAS',
	'19=TRATOR ESTEIRAS',
	'20=TRATOR MISTO',
	'21=QUADRICICLO',
	'22=ESP / ÔNIBUS',
	'23=CAMINHONETE',
	'24=CARGA/CAM',
	'25=UTILITÁRIO',
	'26=MOTOR-CASA'
  ];

  static const List<String> listaCorDenatran = <String>[
	'01-AMARELO',
	'02-AZUL',
	'03-BEGE',
	'04-BRANCA',
	'05-CINZA',
	'06-DOURADA',
	'07-GRENA',
	'08-LARANJA',
	'09-MARROM',
	'10-PRATA',
	'11-PRETA',
	'12-ROSA',
	'13-ROXA',
	'14-VERDE',
	'15-VERMELHA',
	'16-FANTASIA'
  ];

  static const List<String> listaNfeMeioPagamento = <String>[
	'01=Dinheiro',
	'02=Cheque',
	'03=Cartão de Crédito',
	'04=Cartão de Débito',
	'05=Crédito Loja',
	'10=Vale Alimentação',
	'11=Vale Refeição',
	'12=Vale Presente',
	'13=Vale Combustível',
	'15=Boleto Bancário',
	'90=Sem Pagamento',
	'99=Outros'
  ];

  static const List<String> listaIcmsOrigemMercadoria = <String>[
	'0=Nacional, exceto as indicadas nos códigos 3, 4, 5 e 8',
	'1=Estrangeira=Importação direta, exceto a indicada no código 6',
	'2=Estrangeira=Adquirida no mercado interno, exceto a indicada no código 7',
	'3=Nacional, mercadoria ou bem com Conteúdo de Importação superior a 40% e inferior ou igual a 70%',
	'4=Nacional, cuja produção tenha sido feita em conformidade com os processos produtivos básicos de que tratam as legislações citadas nos Ajustes',
	'5=Nacional, mercadoria ou bem com Conteúdo de Importação inferior ou igual a 40%',
	'6=Estrangeira=Importação direta, sem similar nacional, constante em lista da CAMEX e gás natural',
	'7=Estrangeira=Adquirida no mercado interno, sem similar nacional, constante em lista da CAMEX e gás natural',
	'8=Nacional, mercadoria ou bem com Conteúdo de Importação superior a 70%',
  ];

  static const List<String> listaIcmsMotivoDesoneracao = <String>[
	'01=Táxi',
	'02=Deficiente Físico',
	'03=Produtor Agropecuário',
	'04=Frotista/Locadora',
	'05=Diplomático/Consular',
	'06=Utilitários e Motocicletas da Amazônia Ocidental e Áreas de Livre Comércio',
	'07=SUFRAMA',
	'08=Venda a Órgãos Públicos',
	'09=outros',
	'10=Deficiente Condutor',
	'11=Deficiente não condutor',
	'12=Órgão de fomento e desenvolvimento agropecuário',
	'16=Olimpíadas Rio 2016',
	'90=Solicitação do Fisco'
  ];
  
}