<html>
<div class="bloco">
                    <div class="titulo_bloco">
                        <h1>T2Ti Pegasus PDV</h1>
                    </div>
  Este repositório mantém o código do sistema T2Ti Pegasus PDV. Na versão Lite é possível emitir Recibo (desenvolvido para MEI) e na versão fiscal é possível emitir documentos fiscais: NFC-e, SAT e MFE (SAT e MFE em desenvolvimento).
                    <hr />
                    <h3>Curso T2Ti Pegasus PDV</h3>
			<a href="http://t2ti.com/curso/video/pegasus-pdv-5000/?utm_source=GITHUB">
			<img src="http://t2ti.com/images/erp3/mobile-screen-topo.png" />
			</a>
                    <br /> <br /> 
Para compreender como implementar o Pegasus PDV com emissão de recibo para MEI e com emissão de documentos fiscais (NFC-e, SAT e MFE), faça o Curso T2Ti Pegasus PDV disponível no seguinte link <a href="http://t2ti.com/curso/video/pegasus-pdv-5000/?utm_source=GITHUB">http://t2ti.com/curso/video/pegasus-pdv-5000/</a>. O Pegasus PDV já está em produção em fase beta. Você pode baixar os fontes e alterar de acordo com sua vontade e pode também acompanhar o andamento do projeto no <a href="https://trello.com/b/xnlmJ1wc/t2ti-pegasus-pdv">Quadro Trello Público</a> criado para este fim. 	
                    <br /> <br /> 
	Clique na imagem acima para acessar a página do Curso Pegasus PDV que contém <b>153 horas em vídeo aulas</b>. Após fazer este curso você estará apto para contruir o seu próprio PDV com a emissão de recibo, NFC-e, SAT ou MFE. Além disso, compreenderá plenamente como utilizar o código fonte aqui disponível.
			<a href="http://t2ti.com/curso/video/pegasus-pdv-5000/?utm_source=GITHUB">
				<center><img src="http://t2ti.com/images/erp3/pegasus-consome-acbr-monitor.jpg" /></center>
			</a>
	<hr />
                    <h3>Características do Projeto</h3>
Veja abaixo uma lista de características do projeto. Provavelmente existe alguma coisa que você, desenvolvedor, está procurando para o seu projeto e vai aproveitar daqui. É possível também que você já inicie seu negócio com essa aplicação. Desejamos tudo de bom e muito sucesso para você!
	<br />
	<br />
                                    <ul>
                                        <li>
                                            <b> <a href="https://flutter.dev/">Flutter:</a></b> O T2Ti Pegasus PDV é desenvolvido em Flutter e, dessa maneira, poderá rodar em diversas plataformas: Windows, Linux, MacOS, Android, iOS e para Web. Nessa fase Beta estamos fazendo testes no Windows e no Android. Com o lançamento do projeto no github sabemos que contaremos com testes realizados por desenvolvedores em outras plataformas. Em breve a T2Ti também iniciará testes nas demais plataformas. Para compilar o projeto use a versão 2.2.2 do Flutter.
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
	<hr width="20%" />
Se tiver alguma dificuldade para rodar o projeto, siga o passo a passo abaixo. Lembrando que não estamos usando a última versão do Flutter ainda. O projeto deve rodar na versão 2.2.2.<br />
<br />1: faça um downgrade para o fluter v2.2.2 canal beta
<br />2: crie um projeto novo, com o mesmo nome pegasus_pdv
<br />3: copie os arquivos .env, sqlite.dll e as pastas lib e assets do pegasus
<br />4: no pubspec.yaml e pubspec.lock (se existir) deixe a versão do moor em 4.3.2
<br />5: em C:\Users\SEU_USUARIO\AppData\Local\Pub\Cache\hosted\pub.dartlang.org -> deixe a pasta do moor 4.3.2 (verifique a pasta onde seus pacotes são armazenados)
<br />6: execute o comando: flutter clean
<br />7: execute o comando: flutter update-packages
<br />8: execute o  comando: flutter pub get	
	<hr />
	Assista ao vídeo de apresentação no Youtube.
	<br /><br />
<center>	
								<a href="https://www.youtube.com/watch?v=8ppZrzLvFjs?rel=0">
									<img src="https://img.youtube.com/vi/8ppZrzLvFjs/maxresdefault.jpg" alt="telas" /> </a>
				</center>	
</html>
