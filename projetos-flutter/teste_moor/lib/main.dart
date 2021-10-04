import 'dart:ffi';
import 'dart:io';

import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:moor/ffi.dart';

import 'package:sqlite3/open.dart';

import 'database.dart';

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();
  // setTargetPlatformForDesktop();
  open.overrideFor(OperatingSystem.windows, _openOnWindows);

  final file = File('pegasus.sqlite');
  var db = AppDatabase(VmDatabase(file, logStatements: true));

  // Tag tag = new Tag(name: faker.address.countryCode(), color: 123);
  // db.tagDao.insertTag(tag);

  // Task task = new Task(id: null, tagName: tag.name, name: faker.person.name(), dueDate: DateTime.now(), completed: false);
  // db.taskDao.insertTask(task);

  // var lista = await db.taskDao.getAllTasks();
  // print(lista);

  // var lista2 = await db.taskDao.getAllTasksWithTags();
  // for (var item in lista2) {
  //   print(item.task);
  //   print(item.tag);
  //   print('=======================================');
  // }

  // // novo movimento
  // PdvMovimento movimento = new PdvMovimento(
  //   id: null,
  //   dataAbertura: DateTime.now(),
  //   horaAbertura: DateTime.now().hour.toString(),
  //   dataFechamento: DateTime.now().add(new Duration(days: 1)),
  //   horaFechamento: DateTime.now().hour.toString(),
  //   totalSuprimento: 1000,
  //   totalSangria: faker.randomGenerator.decimal(scale: 500),
  //   totalFinal: faker.randomGenerator.decimal(scale: 500),
  // );
  
  // // insere 2 sangrias
  // PdvSangria sangria = new PdvSangria(
  //   id: null,
  //   // idPdvMovimento: idMovimento,
  //   dataSangria: DateTime.now(),
  //   horaSangria: '22:10:55',
  //   valor: faker.randomGenerator.decimal(scale: 2),
  //   observacao: faker.person.name(),
  // );
  // // db.pdvSangriaDao.inserir(sangria);
  // PdvSangria sangria2 = new PdvSangria(
  //   id: null,
  //   // idPdvMovimento: idMovimento,
  //   dataSangria: DateTime.now(),
  //   horaSangria: '22:12:55',
  //   valor: faker.randomGenerator.decimal(scale: 2),
  //   observacao: faker.person.name(),
  // );
  // // db.pdvSangriaDao.inserir(sangria);
  
  // List<PdvSangria> listaPdvSangria = new List<PdvSangria>();
  // listaPdvSangria.add(sangria);
  // listaPdvSangria.add(sangria2);

  // var idMovimento = await db.pdvMovimentoDao.inserir(movimento, listaPdvSangria);

  // print("=====> " + idMovimento.toString());

  // var lista2 = await db.pdvMovimentoDao.consultarMovimentoComFilhos();
  // for (var item in lista2) {
  //   print(item.movimento);
  //   print('-------------------------------');
  //   print(item.sangria);
  //   print('=======================================');
  // }


  // // alterando movimento e sangrias
  // PdvMovimento movimento = await db.pdvMovimentoDao.consultarObjeto(2);
  // movimento = movimento.copyWith(totalSuprimento: 3000);
  // List<PdvSangria> listaSangria = await db.pdvSangriaDao.consultarLista(movimento.id);
  // listaSangria[0] = listaSangria[0].copyWith(horaSangria: '10:10:55');
  // listaSangria[1] = listaSangria[1].copyWith(horaSangria: '11:12:55');

  // PdvSangria sangria2 = new PdvSangria(
  //   id: null,
  //   // idPdvMovimento: idMovimento,
  //   dataSangria: DateTime.now(),
  //   horaSangria: '12:12:55',
  //   valor: faker.randomGenerator.decimal(scale: 2),
  //   observacao: faker.person.name(),
  // );

  // listaSangria.add(sangria2);

  var retorno = await db.pdvMovimentoDao.consultarListaFiltro('TOTAL_SUPRIMENTO', '3');
  print(retorno);

  // print(movimento);

  runApp(MyApp());
}

DynamicLibrary _openOnWindows() {
  final scriptDir = File(Platform.script.toFilePath()).parent;
  final libraryNextToScript = File('${scriptDir.path}/sqlite3.dll');
  return DynamicLibrary.open(libraryNextToScript.path);
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
