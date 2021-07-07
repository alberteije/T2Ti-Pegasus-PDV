<html>
<div class="bloco">
                    <div class="titulo_bloco">
                        <h1>T2Ti Pegasus PDV</h1>
                    </div>
  Este repositório mantém o código do sistema T2Ti Pegasus PDV. Este sistema faz parte de um projeto maior chamado T2Ti ERP 3.0. 
	<br /><br />
	O Projeto T2Ti ERP 3.0 é um Treinamento! No entanto, não se trata de um treinamento usual como se encontra por aí. Durante o treinamento nós simulamos um ambiente real de desenvolvimento e vamos aprontando as aplicações enquanto gravamos as vídeo aulas e fornecemos suporte para os alunos. O T2Ti Pegasus PDV é a primeira aplicação que faz parte do T2Ti ERP 3.0 e é lançada em produção. Veja mais detalhes sobre o Projeto T2Ti ERP 3.0 no seguinte link: http://t2ti.com/erp3/
  <br/><br/>
                    <hr />
                    <h3>T2Ti ERP 3.0</h3>
			<a href="http://t2ti.com/erp3/">
			<img src="http://t2ti.com/images/news/erp3-linguagens-flutter.png" />
			</a>
                    <br />              
O T2Ti ERP 3.0 é feito com várias tecnologias de ponta. O cliente (frontend) é desenvolvido em Flutter e são construídos cinco servidores (backend) nas linguagens: C#, Delphi, Java, Node e PHP. 	
                    <hr />
                    <h3>T2Ti Pegasus PDV</h3>
			<a href="https://t2tisistemas.com/produtos/multi/pegasus-pdv/">
			<img src="http://t2ti.com/images/erp3/mobile-screen-topo.png" />
			</a>
                    <br /> <br /> 
Como mencionado anteriormente, o T2Ti Pegasus PDV é a primeiríssima parte do T2Ti ERP 3.0 que está indo para produção. Neste momento ele se encontra em fase beta. Você pode baixar os fontes e alterar de acordo com sua vontade e pode também acompanhar o andamento do projeto no <a href="https://trello.com/b/xnlmJ1wc/t2ti-pegasus-pdv">Quadro Trello Público</a> criado para este fim. O objetivo aqui é que os participantes do Projeto T2Ti ERP 3.0 vejam como um projeto pode ser mantido no formato Open Source com a participação da comunidade de desenvolvedores.	
                    <br /> <br /> 
Clique na imagem acima para acessar a página comercial da aplicação e analisar algumas características do mesmo.
<hr />
                    <h3>Características do Projeto</h3>
Veja abaixo uma lista de características do projeto. Provavelmente existe alguma coisa que você, desenvolvedor, está procurando para o seu projeto e vai aproveitar daqui. É possível também que você já inicie seu negócio com essa aplicação. Desejamos tudo de bom e muito sucesso para você!
	<br />
	<br />
                                    <ul>
                                        <li>
                                            <b> <a href="https://flutter.dev/">Flutter:</a></b> O T2Ti Pegasus PDV é desenvolvido em Flutter e, dessa maneira, poderá rodar em diversas plataformas: Windows, Linux, MacOS, Android, iOS e para Web. Nessa fase Beta estamos fazendo testes no Windows e no Android. Com o lançamento do projeto no github sabemos que contaremos com testes realizados por desenvolvedores em outras plataformas. Em breve a T2Ti também iniciará testes nas demais plataformas.
                                        </li>
                                        <li>
						<b> <a href="https://www.sqlite.org/index.html">SQLite:</a> </b> A versão Lite do T2Ti Pegasus PDV é monousuário e funciona com banco de dados local. O banco de dados escolhido para este fim foi o SQLite. A versão Premium funcionará com o SQLite como banco de dados local, mas contará com o recurso de sincronização com o banco de dados da retaguarda.
                                        </li>
                                        <li>
                                            <b> <a href="https://moor.simonbinder.eu/">Moor:</a> </b> Para facilitar a utilização do banco de dados SQLite nós usamos o ORM Moor
                                        </li>
                                        <li>
                                            <b> <a href="https://pub.dev/packages/flutter_barcode_scanner">Barcode Scanner:</a> </b> 
                                            Pacote utilizado para escanear o código de barra dos produtos utilizando a câmera do celular.
                                        </li>
                                        <li>
                                            <b><a href="https://pub.dev/packages/flutter_bootstrap"> Flutter Bootstrap: </a></b>                                             						Pacote utilizado para facilitar a criação de telas responsivas.
                                        </li>
                                        <li>
                                            <b><a href="https://pub.dev/packages/printing"> Priting: </a></b>                                             						Pacote utilizado para criar relatórios incríveis com os Widgets com opção de impressão e compartilhamento de arquivo PDF.
                                        </li>
                                        <li>
                                            <b><a href="https://pub.dev/packages/flutter_masked_text"> Flutter Masked Text: </a></b>                                             						Pacote utilizado para criar widget de input com máscaras definidas pelo desenvolvedor.
                                        </li>
                                        <li>
                                            <b><a href="https://pub.dev/packages/cpf_cnpj_validator"> CPF/CNPJ Validator: </a></b>                                             						Pacote utilizado para validar CPF e CNPJ.
                                        </li>
                                        <li>
                                            <b><a href="https://pub.dev/packages/bottomreveal"> Bottom Reveal: </a></b>                                             						Pacote utilizado para revelar a parte de baixo da tela de forma animada.
                                        </li>
                                        <li>
                                            <b><a href="https://pub.dev/packages/flutter_sparkline"> Flutter Sparkline: </a></b>                                             						Pacote utilizado para gerar um gráfico simples de vendas na tela de Dashboard.
                                        </li>
                                        <li>
                                            <b><a href="https://pub.dev/packages/awesome_dialog"> Awesome Dialog: </a></b>                                             						Pacote utilizado para gerar caixas de diálogo estilizadas bem apresentáveis e de bom gosto.
                                        </li>
                                        <li>
                                            <b><a href="https://pub.dev/packages/image_picker"> Image Picker: </a></b>                                             						Pacote utilizado para pegar imagens no dispositivo. Usado no momento de alterar o logotipo da empresa que usa a aplicação.
                                        </li>
                                        <li>
                                            <b><a href="https://pub.dev/packages/catcher"> Catcher: </a></b>                                             						Pacote utilizado para capturar os erros e exceções da aplicação e enviá-los para o Sentry para o devido tratamento.
                                        </li>
                                        <li>
                                            <b><a href="https://pub.dev/packages/sentry_flutter"> Sentry: </a></b>                                             						Pacote utilizado para enviar os erros e exceções capturados pelo Catcher para o Sentry para o devido tratamento.
                                        </li>
                                        <li>
                                            <b><a href="https://pub.dev/packages/desktop_window"> Desktop Window: </a></b>                                             						Pacote utilizado para manipular alguns itens da aplicação quando rodando no ambiente Desktop.
                                        </li>
                                        <li>
                                            <b><a href="https://pub.dev/packages/flutter_dotenv"> Flutter Dotenv: </a></b>                                             						Pacote utilizado para ler os dados do arquivo '.env'. Neste arquivo deixamos alguns dados sesíveis que não sobem para o repositório.
                                        </li>
                                        <li>
                                            <b><a href="https://pub.dev/packages/encrypt"> Encrypt: </a></b>                                             						Pacote utilizado para criptografar e descriptografar os dados do arquivo '.env'.
                                        </li>
                                        <li>
                                            <b><a href="https://pub.dev/packages/url_launcher"> URL Launcher: </a></b>                                             						Pacote utilizado para carregar uma URL no navegador. Usamos para enviar o usuário para uma playlist do Youtube com os vídeos de ajuda da aplicação. Utilizado também para que o usuário entre em contato com a SH através de e-mail.
                                        </li>
                                        <li>
                                            <b><a href="https://pub.dev/packages/email_validator"> Email Validator: </a></b>                                             						Pacote utilizado para validar e-mails.
                                        </li>
                                    </ul>
                        <hr />
                        <h3>Funcionamento - Como Botar pra Rodar</h3> 
                       Você pode fazer um clone do repositório ou baixar o arquivo zipado, de acordo com sua preferência.		
                    <br />  
                    <br />  
	Crie um novo projeto com o comando 'flutter create pegasus_pdv'. Nós criamos a aplicação no canal Beta por conta do suporte para Desktop. Você pode utilizar o canal Beta ou o canal Dev. Para mudar de canal use o comando 'flutter channel beta' e depois o comando 'flutter upgrade'.
                    <br />  
                    <br />  
	Depois de criar o projeto, copie as pastas 'lib' e 'assets' para dentro do seu projeto. Copie ainda os arquivos 'sqlite3.dll' para a raiz do projeto, para que seja possível utilizar a aplicação no Windows. Copie o arquivo 'env.example' para a raiz do projeto e renomeio para '.env'. Preencha as chaves do arquivo com os dados necessários.
                    <br />  
                    <br />  
	Finalmente copie o arquivo 'pubspec.yaml' substituindo o arquivo que já existe. Após copiar este arquivo execute o comando 'flutter pub get' para atualizar os pacotes.
                    <br />  
                    <br />  
	Pronto! Está tudo certo para usar a aplicação. Abra o projeto no VS Code ou no Android Studio e execute ou então execute a aplicação com o seguinte comando 'flutter run -d windows'.
  	<br /><br />
	<a href="http://t2ti.com/erp3/">
	<b>Entre no treinamento T2Ti ERP 3.0 para aprender como desenvolver o ERP completo incluindo o T2Ti Pegasus PDV.</b>
	</a>
	<hr />
	Assista ao vídeo de apresentação no Youtube.
	<br /><br />
<center>	
								<a href="https://www.youtube.com/watch?v=HyWsySaM5fk?rel=0">
									<img src="https://img.youtube.com/vi/HyWsySaM5fk/maxresdefault.jpg" alt="telas" /> </a>
				</center>	
</html>
