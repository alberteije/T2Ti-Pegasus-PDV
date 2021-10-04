import 'package:moor/moor.dart';

import 'pdv_movimento.dart';
import 'pdv_sangria.dart';
import 'tag.dart';
import 'task.dart';

part 'database.g.dart';

@UseMoor(
  tables: [
    Tasks, 
    Tags, 
    PdvMovimentos,
    PdvSangrias,
    ], 
  daos: [
    TaskDao, 
    TagDao,
    PdvMovimentoDao,
    PdvSangriaDao,
    ],
    )
class AppDatabase extends _$AppDatabase {
  // we tell the database where to store the data with this constructor
  AppDatabase(QueryExecutor e) : super(e);

  // you should bump this number whenever you change or add a table definition. Migrations
  // are covered later in this readme.
  @override
  int get schemaVersion => 1;
}

@UseDao(tables: [
          PdvMovimentos, 
		  PdvSangrias
		  ])
class PdvMovimentoDao extends DatabaseAccessor<AppDatabase> with _$PdvMovimentoDaoMixin {
  final AppDatabase db;

  PdvMovimentoDao(this.db) : super(db);

  Future<List<PdvMovimento>> consultarLista() => select(pdvMovimentos).get();

  Future<List<PdvMovimento>> consultarListaFiltro(String campo, String valor) async {
    return (customSelect('SELECT * FROM PDV_MOVIMENTO WHERE ' + campo + ' like "%' + valor + '%"', 
                                readsFrom: {pdvMovimentos}).map((row) {
                                  return PdvMovimento.fromData(row.data, db);  
                                }).get());
  }

  Stream<List<PdvMovimento>> observarLista() => select(pdvMovimentos).watch();

  Future<PdvMovimento> consultarObjeto(int pId) {
    return (select(pdvMovimentos)..where((t) => t.id.equals(pId))).getSingle();
  } 

  Future<int> inserir(Insertable<PdvMovimento> movimento, List<PdvSangria> listaPdvSangria) {
    return transaction(() async {
      final idInserido = await into(pdvMovimentos).insert(movimento);

      inserirFilhos(movimento as PdvMovimento, listaPdvSangria);

      return idInserido;
    });    
  } 

  Future<bool> alterar(Insertable<PdvMovimento> movimento, List<PdvSangria> listaPdvSangria) {
    return transaction(() async {

      excluirFilhos(movimento as PdvMovimento);
      inserirFilhos(movimento as PdvMovimento, listaPdvSangria);

      return update(pdvMovimentos).replace(movimento);
    });    
  } 

  Future<int> excluir(Insertable<PdvMovimento> movimento) {
    return transaction(() async {
      excluirFilhos(movimento as PdvMovimento);
      return delete(pdvMovimentos).delete(movimento);
    });    
  }

  void excluirFilhos(PdvMovimento movimento) {
    (delete(pdvSangrias)..where((t) => t.idPdvMovimento.equals(movimento.id))).go();
  }

  void inserirFilhos(PdvMovimento movimento, List<PdvSangria> listaPdvSangria) {
      for (var sangria in listaPdvSangria) {
        if (sangria.id == null) {
          sangria = sangria.copyWith(idPdvMovimento: movimento.id);
        }
        into(pdvSangrias).insert(sangria);  
      }
  }

}

@UseDao(tables: [PdvSangrias])
class PdvSangriaDao extends DatabaseAccessor<AppDatabase> with _$PdvSangriaDaoMixin {
  final AppDatabase db;

  PdvSangriaDao(this.db) : super(db);

  Future<List<PdvSangria>> consultarLista(int pIdMovimento) {
    return (select(pdvSangrias)..where((t) => t.idPdvMovimento.equals(pIdMovimento))).get();
  } 

  Future inserir(Insertable<PdvSangria> sangria) => into(pdvSangrias).insert(sangria);
}

@UseDao(
  tables: [Tasks, Tags],
)
class TaskDao extends DatabaseAccessor<AppDatabase> with _$TaskDaoMixin {
  final AppDatabase db;

  TaskDao(this.db) : super(db);

  Future<List<Task>> getAllTasks() {
    return select(tasks).get();
  }

  Stream<List<TaskWithTag>> watchAllTasks() {
    return (select(tasks)
          ..orderBy(
            [
              (t) =>
                  OrderingTerm(expression: t.dueDate, mode: OrderingMode.desc),
              (t) => OrderingTerm(expression: t.name),
            ],
          ))
        .join(
          [
            leftOuterJoin(tags, tags.name.equalsExp(tasks.tagName)),
          ],
        )
        .watch()
        .map((rows) => rows.map(
              (row) {
                return TaskWithTag(
                  task: row.readTable(tasks),
                  tag: row.readTable(tags),
                );
              },
            ).toList());
  }

  Future<List<TaskWithTag>> getAllTasksWithTags() {
    return select(tasks)
      .join([
        leftOuterJoin(tags, tags.name.equalsExp(tasks.tagName)),
      ]).map((row) {
        final task = row.readTable(tasks);
        final tag = row.readTable(tags);

        return TaskWithTag(task: task, tag: tag);
      }).get();
  }

  Future insertTask(Insertable<Task> task) => into(tasks).insert(task);
  Future updateTask(Insertable<Task> task) => update(tasks).replace(task);
  Future deleteTask(Insertable<Task> task) => delete(tasks).delete(task);
}

@UseDao(tables: [Tags])
class TagDao extends DatabaseAccessor<AppDatabase> with _$TagDaoMixin {
  final AppDatabase db;

  TagDao(this.db) : super(db);

  Stream<List<Tag>> watchTags() => select(tags).watch();
  Future insertTag(Insertable<Tag> tag) => into(tags).insert(tag);
}