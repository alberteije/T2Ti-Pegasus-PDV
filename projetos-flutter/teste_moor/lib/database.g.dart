// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class Task extends DataClass implements Insertable<Task> {
  final int id;
  final String tagName;
  final String name;
  final DateTime dueDate;
  final bool completed;
  Task(
      {@required this.id,
      this.tagName,
      @required this.name,
      this.dueDate,
      @required this.completed});
  factory Task.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    final dateTimeType = db.typeSystem.forDartType<DateTime>();
    final boolType = db.typeSystem.forDartType<bool>();
    return Task(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      tagName: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}tag_name']),
      name: stringType.mapFromDatabaseResponse(data['${effectivePrefix}name']),
      dueDate: dateTimeType
          .mapFromDatabaseResponse(data['${effectivePrefix}due_date']),
      completed:
          boolType.mapFromDatabaseResponse(data['${effectivePrefix}completed']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<int>(id);
    }
    if (!nullToAbsent || tagName != null) {
      map['tag_name'] = Variable<String>(tagName);
    }
    if (!nullToAbsent || name != null) {
      map['name'] = Variable<String>(name);
    }
    if (!nullToAbsent || dueDate != null) {
      map['due_date'] = Variable<DateTime>(dueDate);
    }
    if (!nullToAbsent || completed != null) {
      map['completed'] = Variable<bool>(completed);
    }
    return map;
  }

  TasksCompanion toCompanion(bool nullToAbsent) {
    return TasksCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      tagName: tagName == null && nullToAbsent
          ? const Value.absent()
          : Value(tagName),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
      dueDate: dueDate == null && nullToAbsent
          ? const Value.absent()
          : Value(dueDate),
      completed: completed == null && nullToAbsent
          ? const Value.absent()
          : Value(completed),
    );
  }

  factory Task.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Task(
      id: serializer.fromJson<int>(json['id']),
      tagName: serializer.fromJson<String>(json['tagName']),
      name: serializer.fromJson<String>(json['name']),
      dueDate: serializer.fromJson<DateTime>(json['dueDate']),
      completed: serializer.fromJson<bool>(json['completed']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'tagName': serializer.toJson<String>(tagName),
      'name': serializer.toJson<String>(name),
      'dueDate': serializer.toJson<DateTime>(dueDate),
      'completed': serializer.toJson<bool>(completed),
    };
  }

  Task copyWith(
          {int id,
          String tagName,
          String name,
          DateTime dueDate,
          bool completed}) =>
      Task(
        id: id ?? this.id,
        tagName: tagName ?? this.tagName,
        name: name ?? this.name,
        dueDate: dueDate ?? this.dueDate,
        completed: completed ?? this.completed,
      );
  @override
  String toString() {
    return (StringBuffer('Task(')
          ..write('id: $id, ')
          ..write('tagName: $tagName, ')
          ..write('name: $name, ')
          ..write('dueDate: $dueDate, ')
          ..write('completed: $completed')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(tagName.hashCode,
          $mrjc(name.hashCode, $mrjc(dueDate.hashCode, completed.hashCode)))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is Task &&
          other.id == this.id &&
          other.tagName == this.tagName &&
          other.name == this.name &&
          other.dueDate == this.dueDate &&
          other.completed == this.completed);
}

class TasksCompanion extends UpdateCompanion<Task> {
  final Value<int> id;
  final Value<String> tagName;
  final Value<String> name;
  final Value<DateTime> dueDate;
  final Value<bool> completed;
  const TasksCompanion({
    this.id = const Value.absent(),
    this.tagName = const Value.absent(),
    this.name = const Value.absent(),
    this.dueDate = const Value.absent(),
    this.completed = const Value.absent(),
  });
  TasksCompanion.insert({
    this.id = const Value.absent(),
    this.tagName = const Value.absent(),
    @required String name,
    this.dueDate = const Value.absent(),
    this.completed = const Value.absent(),
  }) : name = Value(name);
  static Insertable<Task> custom({
    Expression<int> id,
    Expression<String> tagName,
    Expression<String> name,
    Expression<DateTime> dueDate,
    Expression<bool> completed,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (tagName != null) 'tag_name': tagName,
      if (name != null) 'name': name,
      if (dueDate != null) 'due_date': dueDate,
      if (completed != null) 'completed': completed,
    });
  }

  TasksCompanion copyWith(
      {Value<int> id,
      Value<String> tagName,
      Value<String> name,
      Value<DateTime> dueDate,
      Value<bool> completed}) {
    return TasksCompanion(
      id: id ?? this.id,
      tagName: tagName ?? this.tagName,
      name: name ?? this.name,
      dueDate: dueDate ?? this.dueDate,
      completed: completed ?? this.completed,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (tagName.present) {
      map['tag_name'] = Variable<String>(tagName.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (dueDate.present) {
      map['due_date'] = Variable<DateTime>(dueDate.value);
    }
    if (completed.present) {
      map['completed'] = Variable<bool>(completed.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TasksCompanion(')
          ..write('id: $id, ')
          ..write('tagName: $tagName, ')
          ..write('name: $name, ')
          ..write('dueDate: $dueDate, ')
          ..write('completed: $completed')
          ..write(')'))
        .toString();
  }
}

class $TasksTable extends Tasks with TableInfo<$TasksTable, Task> {
  final GeneratedDatabase _db;
  final String _alias;
  $TasksTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedIntColumn _id;
  @override
  GeneratedIntColumn get id => _id ??= _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('id', $tableName, false,
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
  }

  final VerificationMeta _tagNameMeta = const VerificationMeta('tagName');
  GeneratedTextColumn _tagName;
  @override
  GeneratedTextColumn get tagName => _tagName ??= _constructTagName();
  GeneratedTextColumn _constructTagName() {
    return GeneratedTextColumn('tag_name', $tableName, true,
        $customConstraints: 'NULL REFERENCES tags(name)');
  }

  final VerificationMeta _nameMeta = const VerificationMeta('name');
  GeneratedTextColumn _name;
  @override
  GeneratedTextColumn get name => _name ??= _constructName();
  GeneratedTextColumn _constructName() {
    return GeneratedTextColumn('name', $tableName, false,
        minTextLength: 1, maxTextLength: 50);
  }

  final VerificationMeta _dueDateMeta = const VerificationMeta('dueDate');
  GeneratedDateTimeColumn _dueDate;
  @override
  GeneratedDateTimeColumn get dueDate => _dueDate ??= _constructDueDate();
  GeneratedDateTimeColumn _constructDueDate() {
    return GeneratedDateTimeColumn(
      'due_date',
      $tableName,
      true,
    );
  }

  final VerificationMeta _completedMeta = const VerificationMeta('completed');
  GeneratedBoolColumn _completed;
  @override
  GeneratedBoolColumn get completed => _completed ??= _constructCompleted();
  GeneratedBoolColumn _constructCompleted() {
    return GeneratedBoolColumn('completed', $tableName, false,
        defaultValue: Constant(false));
  }

  @override
  List<GeneratedColumn> get $columns => [id, tagName, name, dueDate, completed];
  @override
  $TasksTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'tasks';
  @override
  final String actualTableName = 'tasks';
  @override
  VerificationContext validateIntegrity(Insertable<Task> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id'], _idMeta));
    }
    if (data.containsKey('tag_name')) {
      context.handle(_tagNameMeta,
          tagName.isAcceptableOrUnknown(data['tag_name'], _tagNameMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name'], _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('due_date')) {
      context.handle(_dueDateMeta,
          dueDate.isAcceptableOrUnknown(data['due_date'], _dueDateMeta));
    }
    if (data.containsKey('completed')) {
      context.handle(_completedMeta,
          completed.isAcceptableOrUnknown(data['completed'], _completedMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Task map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return Task.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $TasksTable createAlias(String alias) {
    return $TasksTable(_db, alias);
  }
}

class Tag extends DataClass implements Insertable<Tag> {
  final String name;
  final int color;
  Tag({@required this.name, @required this.color});
  factory Tag.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final stringType = db.typeSystem.forDartType<String>();
    final intType = db.typeSystem.forDartType<int>();
    return Tag(
      name: stringType.mapFromDatabaseResponse(data['${effectivePrefix}name']),
      color: intType.mapFromDatabaseResponse(data['${effectivePrefix}color']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || name != null) {
      map['name'] = Variable<String>(name);
    }
    if (!nullToAbsent || color != null) {
      map['color'] = Variable<int>(color);
    }
    return map;
  }

  TagsCompanion toCompanion(bool nullToAbsent) {
    return TagsCompanion(
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
      color:
          color == null && nullToAbsent ? const Value.absent() : Value(color),
    );
  }

  factory Tag.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Tag(
      name: serializer.fromJson<String>(json['name']),
      color: serializer.fromJson<int>(json['color']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'name': serializer.toJson<String>(name),
      'color': serializer.toJson<int>(color),
    };
  }

  Tag copyWith({String name, int color}) => Tag(
        name: name ?? this.name,
        color: color ?? this.color,
      );
  @override
  String toString() {
    return (StringBuffer('Tag(')
          ..write('name: $name, ')
          ..write('color: $color')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(name.hashCode, color.hashCode));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is Tag && other.name == this.name && other.color == this.color);
}

class TagsCompanion extends UpdateCompanion<Tag> {
  final Value<String> name;
  final Value<int> color;
  const TagsCompanion({
    this.name = const Value.absent(),
    this.color = const Value.absent(),
  });
  TagsCompanion.insert({
    @required String name,
    @required int color,
  })  : name = Value(name),
        color = Value(color);
  static Insertable<Tag> custom({
    Expression<String> name,
    Expression<int> color,
  }) {
    return RawValuesInsertable({
      if (name != null) 'name': name,
      if (color != null) 'color': color,
    });
  }

  TagsCompanion copyWith({Value<String> name, Value<int> color}) {
    return TagsCompanion(
      name: name ?? this.name,
      color: color ?? this.color,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (color.present) {
      map['color'] = Variable<int>(color.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TagsCompanion(')
          ..write('name: $name, ')
          ..write('color: $color')
          ..write(')'))
        .toString();
  }
}

class $TagsTable extends Tags with TableInfo<$TagsTable, Tag> {
  final GeneratedDatabase _db;
  final String _alias;
  $TagsTable(this._db, [this._alias]);
  final VerificationMeta _nameMeta = const VerificationMeta('name');
  GeneratedTextColumn _name;
  @override
  GeneratedTextColumn get name => _name ??= _constructName();
  GeneratedTextColumn _constructName() {
    return GeneratedTextColumn('name', $tableName, false,
        minTextLength: 1, maxTextLength: 10);
  }

  final VerificationMeta _colorMeta = const VerificationMeta('color');
  GeneratedIntColumn _color;
  @override
  GeneratedIntColumn get color => _color ??= _constructColor();
  GeneratedIntColumn _constructColor() {
    return GeneratedIntColumn(
      'color',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [name, color];
  @override
  $TagsTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'tags';
  @override
  final String actualTableName = 'tags';
  @override
  VerificationContext validateIntegrity(Insertable<Tag> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name'], _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('color')) {
      context.handle(
          _colorMeta, color.isAcceptableOrUnknown(data['color'], _colorMeta));
    } else if (isInserting) {
      context.missing(_colorMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {name};
  @override
  Tag map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return Tag.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $TagsTable createAlias(String alias) {
    return $TagsTable(_db, alias);
  }
}

class PdvMovimento extends DataClass implements Insertable<PdvMovimento> {
  final int id;
  final DateTime dataAbertura;
  final String horaAbertura;
  final DateTime dataFechamento;
  final String horaFechamento;
  final double totalSuprimento;
  final double totalSangria;
  final double totalFinal;
  PdvMovimento(
      {@required this.id,
      this.dataAbertura,
      this.horaAbertura,
      this.dataFechamento,
      this.horaFechamento,
      this.totalSuprimento,
      this.totalSangria,
      this.totalFinal});
  factory PdvMovimento.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final dateTimeType = db.typeSystem.forDartType<DateTime>();
    final stringType = db.typeSystem.forDartType<String>();
    final doubleType = db.typeSystem.forDartType<double>();
    return PdvMovimento(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}ID']),
      dataAbertura: dateTimeType
          .mapFromDatabaseResponse(data['${effectivePrefix}DATA_ABERTURA']),
      horaAbertura: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}HORA_ABERTURA']),
      dataFechamento: dateTimeType
          .mapFromDatabaseResponse(data['${effectivePrefix}DATA_FECHAMENTO']),
      horaFechamento: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}HORA_FECHAMENTO']),
      totalSuprimento: doubleType
          .mapFromDatabaseResponse(data['${effectivePrefix}TOTAL_SUPRIMENTO']),
      totalSangria: doubleType
          .mapFromDatabaseResponse(data['${effectivePrefix}TOTAL_SANGRIA']),
      totalFinal: doubleType
          .mapFromDatabaseResponse(data['${effectivePrefix}TOTAL_FINAL']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['ID'] = Variable<int>(id);
    }
    if (!nullToAbsent || dataAbertura != null) {
      map['DATA_ABERTURA'] = Variable<DateTime>(dataAbertura);
    }
    if (!nullToAbsent || horaAbertura != null) {
      map['HORA_ABERTURA'] = Variable<String>(horaAbertura);
    }
    if (!nullToAbsent || dataFechamento != null) {
      map['DATA_FECHAMENTO'] = Variable<DateTime>(dataFechamento);
    }
    if (!nullToAbsent || horaFechamento != null) {
      map['HORA_FECHAMENTO'] = Variable<String>(horaFechamento);
    }
    if (!nullToAbsent || totalSuprimento != null) {
      map['TOTAL_SUPRIMENTO'] = Variable<double>(totalSuprimento);
    }
    if (!nullToAbsent || totalSangria != null) {
      map['TOTAL_SANGRIA'] = Variable<double>(totalSangria);
    }
    if (!nullToAbsent || totalFinal != null) {
      map['TOTAL_FINAL'] = Variable<double>(totalFinal);
    }
    return map;
  }

  PdvMovimentosCompanion toCompanion(bool nullToAbsent) {
    return PdvMovimentosCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      dataAbertura: dataAbertura == null && nullToAbsent
          ? const Value.absent()
          : Value(dataAbertura),
      horaAbertura: horaAbertura == null && nullToAbsent
          ? const Value.absent()
          : Value(horaAbertura),
      dataFechamento: dataFechamento == null && nullToAbsent
          ? const Value.absent()
          : Value(dataFechamento),
      horaFechamento: horaFechamento == null && nullToAbsent
          ? const Value.absent()
          : Value(horaFechamento),
      totalSuprimento: totalSuprimento == null && nullToAbsent
          ? const Value.absent()
          : Value(totalSuprimento),
      totalSangria: totalSangria == null && nullToAbsent
          ? const Value.absent()
          : Value(totalSangria),
      totalFinal: totalFinal == null && nullToAbsent
          ? const Value.absent()
          : Value(totalFinal),
    );
  }

  factory PdvMovimento.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return PdvMovimento(
      id: serializer.fromJson<int>(json['id']),
      dataAbertura: serializer.fromJson<DateTime>(json['dataAbertura']),
      horaAbertura: serializer.fromJson<String>(json['horaAbertura']),
      dataFechamento: serializer.fromJson<DateTime>(json['dataFechamento']),
      horaFechamento: serializer.fromJson<String>(json['horaFechamento']),
      totalSuprimento: serializer.fromJson<double>(json['totalSuprimento']),
      totalSangria: serializer.fromJson<double>(json['totalSangria']),
      totalFinal: serializer.fromJson<double>(json['totalFinal']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'dataAbertura': serializer.toJson<DateTime>(dataAbertura),
      'horaAbertura': serializer.toJson<String>(horaAbertura),
      'dataFechamento': serializer.toJson<DateTime>(dataFechamento),
      'horaFechamento': serializer.toJson<String>(horaFechamento),
      'totalSuprimento': serializer.toJson<double>(totalSuprimento),
      'totalSangria': serializer.toJson<double>(totalSangria),
      'totalFinal': serializer.toJson<double>(totalFinal),
    };
  }

  PdvMovimento copyWith(
          {int id,
          DateTime dataAbertura,
          String horaAbertura,
          DateTime dataFechamento,
          String horaFechamento,
          double totalSuprimento,
          double totalSangria,
          double totalFinal}) =>
      PdvMovimento(
        id: id ?? this.id,
        dataAbertura: dataAbertura ?? this.dataAbertura,
        horaAbertura: horaAbertura ?? this.horaAbertura,
        dataFechamento: dataFechamento ?? this.dataFechamento,
        horaFechamento: horaFechamento ?? this.horaFechamento,
        totalSuprimento: totalSuprimento ?? this.totalSuprimento,
        totalSangria: totalSangria ?? this.totalSangria,
        totalFinal: totalFinal ?? this.totalFinal,
      );
  @override
  String toString() {
    return (StringBuffer('PdvMovimento(')
          ..write('id: $id, ')
          ..write('dataAbertura: $dataAbertura, ')
          ..write('horaAbertura: $horaAbertura, ')
          ..write('dataFechamento: $dataFechamento, ')
          ..write('horaFechamento: $horaFechamento, ')
          ..write('totalSuprimento: $totalSuprimento, ')
          ..write('totalSangria: $totalSangria, ')
          ..write('totalFinal: $totalFinal')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(
          dataAbertura.hashCode,
          $mrjc(
              horaAbertura.hashCode,
              $mrjc(
                  dataFechamento.hashCode,
                  $mrjc(
                      horaFechamento.hashCode,
                      $mrjc(
                          totalSuprimento.hashCode,
                          $mrjc(totalSangria.hashCode,
                              totalFinal.hashCode))))))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is PdvMovimento &&
          other.id == this.id &&
          other.dataAbertura == this.dataAbertura &&
          other.horaAbertura == this.horaAbertura &&
          other.dataFechamento == this.dataFechamento &&
          other.horaFechamento == this.horaFechamento &&
          other.totalSuprimento == this.totalSuprimento &&
          other.totalSangria == this.totalSangria &&
          other.totalFinal == this.totalFinal);
}

class PdvMovimentosCompanion extends UpdateCompanion<PdvMovimento> {
  final Value<int> id;
  final Value<DateTime> dataAbertura;
  final Value<String> horaAbertura;
  final Value<DateTime> dataFechamento;
  final Value<String> horaFechamento;
  final Value<double> totalSuprimento;
  final Value<double> totalSangria;
  final Value<double> totalFinal;
  const PdvMovimentosCompanion({
    this.id = const Value.absent(),
    this.dataAbertura = const Value.absent(),
    this.horaAbertura = const Value.absent(),
    this.dataFechamento = const Value.absent(),
    this.horaFechamento = const Value.absent(),
    this.totalSuprimento = const Value.absent(),
    this.totalSangria = const Value.absent(),
    this.totalFinal = const Value.absent(),
  });
  PdvMovimentosCompanion.insert({
    this.id = const Value.absent(),
    this.dataAbertura = const Value.absent(),
    this.horaAbertura = const Value.absent(),
    this.dataFechamento = const Value.absent(),
    this.horaFechamento = const Value.absent(),
    this.totalSuprimento = const Value.absent(),
    this.totalSangria = const Value.absent(),
    this.totalFinal = const Value.absent(),
  });
  static Insertable<PdvMovimento> custom({
    Expression<int> id,
    Expression<DateTime> dataAbertura,
    Expression<String> horaAbertura,
    Expression<DateTime> dataFechamento,
    Expression<String> horaFechamento,
    Expression<double> totalSuprimento,
    Expression<double> totalSangria,
    Expression<double> totalFinal,
  }) {
    return RawValuesInsertable({
      if (id != null) 'ID': id,
      if (dataAbertura != null) 'DATA_ABERTURA': dataAbertura,
      if (horaAbertura != null) 'HORA_ABERTURA': horaAbertura,
      if (dataFechamento != null) 'DATA_FECHAMENTO': dataFechamento,
      if (horaFechamento != null) 'HORA_FECHAMENTO': horaFechamento,
      if (totalSuprimento != null) 'TOTAL_SUPRIMENTO': totalSuprimento,
      if (totalSangria != null) 'TOTAL_SANGRIA': totalSangria,
      if (totalFinal != null) 'TOTAL_FINAL': totalFinal,
    });
  }

  PdvMovimentosCompanion copyWith(
      {Value<int> id,
      Value<DateTime> dataAbertura,
      Value<String> horaAbertura,
      Value<DateTime> dataFechamento,
      Value<String> horaFechamento,
      Value<double> totalSuprimento,
      Value<double> totalSangria,
      Value<double> totalFinal}) {
    return PdvMovimentosCompanion(
      id: id ?? this.id,
      dataAbertura: dataAbertura ?? this.dataAbertura,
      horaAbertura: horaAbertura ?? this.horaAbertura,
      dataFechamento: dataFechamento ?? this.dataFechamento,
      horaFechamento: horaFechamento ?? this.horaFechamento,
      totalSuprimento: totalSuprimento ?? this.totalSuprimento,
      totalSangria: totalSangria ?? this.totalSangria,
      totalFinal: totalFinal ?? this.totalFinal,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['ID'] = Variable<int>(id.value);
    }
    if (dataAbertura.present) {
      map['DATA_ABERTURA'] = Variable<DateTime>(dataAbertura.value);
    }
    if (horaAbertura.present) {
      map['HORA_ABERTURA'] = Variable<String>(horaAbertura.value);
    }
    if (dataFechamento.present) {
      map['DATA_FECHAMENTO'] = Variable<DateTime>(dataFechamento.value);
    }
    if (horaFechamento.present) {
      map['HORA_FECHAMENTO'] = Variable<String>(horaFechamento.value);
    }
    if (totalSuprimento.present) {
      map['TOTAL_SUPRIMENTO'] = Variable<double>(totalSuprimento.value);
    }
    if (totalSangria.present) {
      map['TOTAL_SANGRIA'] = Variable<double>(totalSangria.value);
    }
    if (totalFinal.present) {
      map['TOTAL_FINAL'] = Variable<double>(totalFinal.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PdvMovimentosCompanion(')
          ..write('id: $id, ')
          ..write('dataAbertura: $dataAbertura, ')
          ..write('horaAbertura: $horaAbertura, ')
          ..write('dataFechamento: $dataFechamento, ')
          ..write('horaFechamento: $horaFechamento, ')
          ..write('totalSuprimento: $totalSuprimento, ')
          ..write('totalSangria: $totalSangria, ')
          ..write('totalFinal: $totalFinal')
          ..write(')'))
        .toString();
  }
}

class $PdvMovimentosTable extends PdvMovimentos
    with TableInfo<$PdvMovimentosTable, PdvMovimento> {
  final GeneratedDatabase _db;
  final String _alias;
  $PdvMovimentosTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedIntColumn _id;
  @override
  GeneratedIntColumn get id => _id ??= _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('ID', $tableName, false,
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
  }

  final VerificationMeta _dataAberturaMeta =
      const VerificationMeta('dataAbertura');
  GeneratedDateTimeColumn _dataAbertura;
  @override
  GeneratedDateTimeColumn get dataAbertura =>
      _dataAbertura ??= _constructDataAbertura();
  GeneratedDateTimeColumn _constructDataAbertura() {
    return GeneratedDateTimeColumn(
      'DATA_ABERTURA',
      $tableName,
      true,
    );
  }

  final VerificationMeta _horaAberturaMeta =
      const VerificationMeta('horaAbertura');
  GeneratedTextColumn _horaAbertura;
  @override
  GeneratedTextColumn get horaAbertura =>
      _horaAbertura ??= _constructHoraAbertura();
  GeneratedTextColumn _constructHoraAbertura() {
    return GeneratedTextColumn('HORA_ABERTURA', $tableName, true,
        minTextLength: 1, maxTextLength: 8);
  }

  final VerificationMeta _dataFechamentoMeta =
      const VerificationMeta('dataFechamento');
  GeneratedDateTimeColumn _dataFechamento;
  @override
  GeneratedDateTimeColumn get dataFechamento =>
      _dataFechamento ??= _constructDataFechamento();
  GeneratedDateTimeColumn _constructDataFechamento() {
    return GeneratedDateTimeColumn(
      'DATA_FECHAMENTO',
      $tableName,
      true,
    );
  }

  final VerificationMeta _horaFechamentoMeta =
      const VerificationMeta('horaFechamento');
  GeneratedTextColumn _horaFechamento;
  @override
  GeneratedTextColumn get horaFechamento =>
      _horaFechamento ??= _constructHoraFechamento();
  GeneratedTextColumn _constructHoraFechamento() {
    return GeneratedTextColumn('HORA_FECHAMENTO', $tableName, true,
        minTextLength: 1, maxTextLength: 8);
  }

  final VerificationMeta _totalSuprimentoMeta =
      const VerificationMeta('totalSuprimento');
  GeneratedRealColumn _totalSuprimento;
  @override
  GeneratedRealColumn get totalSuprimento =>
      _totalSuprimento ??= _constructTotalSuprimento();
  GeneratedRealColumn _constructTotalSuprimento() {
    return GeneratedRealColumn(
      'TOTAL_SUPRIMENTO',
      $tableName,
      true,
    );
  }

  final VerificationMeta _totalSangriaMeta =
      const VerificationMeta('totalSangria');
  GeneratedRealColumn _totalSangria;
  @override
  GeneratedRealColumn get totalSangria =>
      _totalSangria ??= _constructTotalSangria();
  GeneratedRealColumn _constructTotalSangria() {
    return GeneratedRealColumn(
      'TOTAL_SANGRIA',
      $tableName,
      true,
    );
  }

  final VerificationMeta _totalFinalMeta = const VerificationMeta('totalFinal');
  GeneratedRealColumn _totalFinal;
  @override
  GeneratedRealColumn get totalFinal => _totalFinal ??= _constructTotalFinal();
  GeneratedRealColumn _constructTotalFinal() {
    return GeneratedRealColumn(
      'TOTAL_FINAL',
      $tableName,
      true,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [
        id,
        dataAbertura,
        horaAbertura,
        dataFechamento,
        horaFechamento,
        totalSuprimento,
        totalSangria,
        totalFinal
      ];
  @override
  $PdvMovimentosTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'PDV_MOVIMENTO';
  @override
  final String actualTableName = 'PDV_MOVIMENTO';
  @override
  VerificationContext validateIntegrity(Insertable<PdvMovimento> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('ID')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['ID'], _idMeta));
    }
    if (data.containsKey('DATA_ABERTURA')) {
      context.handle(
          _dataAberturaMeta,
          dataAbertura.isAcceptableOrUnknown(
              data['DATA_ABERTURA'], _dataAberturaMeta));
    }
    if (data.containsKey('HORA_ABERTURA')) {
      context.handle(
          _horaAberturaMeta,
          horaAbertura.isAcceptableOrUnknown(
              data['HORA_ABERTURA'], _horaAberturaMeta));
    }
    if (data.containsKey('DATA_FECHAMENTO')) {
      context.handle(
          _dataFechamentoMeta,
          dataFechamento.isAcceptableOrUnknown(
              data['DATA_FECHAMENTO'], _dataFechamentoMeta));
    }
    if (data.containsKey('HORA_FECHAMENTO')) {
      context.handle(
          _horaFechamentoMeta,
          horaFechamento.isAcceptableOrUnknown(
              data['HORA_FECHAMENTO'], _horaFechamentoMeta));
    }
    if (data.containsKey('TOTAL_SUPRIMENTO')) {
      context.handle(
          _totalSuprimentoMeta,
          totalSuprimento.isAcceptableOrUnknown(
              data['TOTAL_SUPRIMENTO'], _totalSuprimentoMeta));
    }
    if (data.containsKey('TOTAL_SANGRIA')) {
      context.handle(
          _totalSangriaMeta,
          totalSangria.isAcceptableOrUnknown(
              data['TOTAL_SANGRIA'], _totalSangriaMeta));
    }
    if (data.containsKey('TOTAL_FINAL')) {
      context.handle(
          _totalFinalMeta,
          totalFinal.isAcceptableOrUnknown(
              data['TOTAL_FINAL'], _totalFinalMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PdvMovimento map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return PdvMovimento.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $PdvMovimentosTable createAlias(String alias) {
    return $PdvMovimentosTable(_db, alias);
  }
}

class PdvSangria extends DataClass implements Insertable<PdvSangria> {
  final int id;
  final int idPdvMovimento;
  final DateTime dataSangria;
  final String horaSangria;
  final double valor;
  final String observacao;
  PdvSangria(
      {@required this.id,
      this.idPdvMovimento,
      this.dataSangria,
      this.horaSangria,
      this.valor,
      this.observacao});
  factory PdvSangria.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final dateTimeType = db.typeSystem.forDartType<DateTime>();
    final stringType = db.typeSystem.forDartType<String>();
    final doubleType = db.typeSystem.forDartType<double>();
    return PdvSangria(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}ID']),
      idPdvMovimento: intType
          .mapFromDatabaseResponse(data['${effectivePrefix}ID_PDV_MOVIMENTO']),
      dataSangria: dateTimeType
          .mapFromDatabaseResponse(data['${effectivePrefix}DATA_SANGRIA']),
      horaSangria: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}HORA_SANGRIA']),
      valor:
          doubleType.mapFromDatabaseResponse(data['${effectivePrefix}VALOR']),
      observacao: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}OBSERVACAO']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['ID'] = Variable<int>(id);
    }
    if (!nullToAbsent || idPdvMovimento != null) {
      map['ID_PDV_MOVIMENTO'] = Variable<int>(idPdvMovimento);
    }
    if (!nullToAbsent || dataSangria != null) {
      map['DATA_SANGRIA'] = Variable<DateTime>(dataSangria);
    }
    if (!nullToAbsent || horaSangria != null) {
      map['HORA_SANGRIA'] = Variable<String>(horaSangria);
    }
    if (!nullToAbsent || valor != null) {
      map['VALOR'] = Variable<double>(valor);
    }
    if (!nullToAbsent || observacao != null) {
      map['OBSERVACAO'] = Variable<String>(observacao);
    }
    return map;
  }

  PdvSangriasCompanion toCompanion(bool nullToAbsent) {
    return PdvSangriasCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      idPdvMovimento: idPdvMovimento == null && nullToAbsent
          ? const Value.absent()
          : Value(idPdvMovimento),
      dataSangria: dataSangria == null && nullToAbsent
          ? const Value.absent()
          : Value(dataSangria),
      horaSangria: horaSangria == null && nullToAbsent
          ? const Value.absent()
          : Value(horaSangria),
      valor:
          valor == null && nullToAbsent ? const Value.absent() : Value(valor),
      observacao: observacao == null && nullToAbsent
          ? const Value.absent()
          : Value(observacao),
    );
  }

  factory PdvSangria.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return PdvSangria(
      id: serializer.fromJson<int>(json['id']),
      idPdvMovimento: serializer.fromJson<int>(json['idPdvMovimento']),
      dataSangria: serializer.fromJson<DateTime>(json['dataSangria']),
      horaSangria: serializer.fromJson<String>(json['horaSangria']),
      valor: serializer.fromJson<double>(json['valor']),
      observacao: serializer.fromJson<String>(json['observacao']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'idPdvMovimento': serializer.toJson<int>(idPdvMovimento),
      'dataSangria': serializer.toJson<DateTime>(dataSangria),
      'horaSangria': serializer.toJson<String>(horaSangria),
      'valor': serializer.toJson<double>(valor),
      'observacao': serializer.toJson<String>(observacao),
    };
  }

  PdvSangria copyWith(
          {int id,
          int idPdvMovimento,
          DateTime dataSangria,
          String horaSangria,
          double valor,
          String observacao}) =>
      PdvSangria(
        id: id ?? this.id,
        idPdvMovimento: idPdvMovimento ?? this.idPdvMovimento,
        dataSangria: dataSangria ?? this.dataSangria,
        horaSangria: horaSangria ?? this.horaSangria,
        valor: valor ?? this.valor,
        observacao: observacao ?? this.observacao,
      );
  @override
  String toString() {
    return (StringBuffer('PdvSangria(')
          ..write('id: $id, ')
          ..write('idPdvMovimento: $idPdvMovimento, ')
          ..write('dataSangria: $dataSangria, ')
          ..write('horaSangria: $horaSangria, ')
          ..write('valor: $valor, ')
          ..write('observacao: $observacao')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(
          idPdvMovimento.hashCode,
          $mrjc(
              dataSangria.hashCode,
              $mrjc(horaSangria.hashCode,
                  $mrjc(valor.hashCode, observacao.hashCode))))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is PdvSangria &&
          other.id == this.id &&
          other.idPdvMovimento == this.idPdvMovimento &&
          other.dataSangria == this.dataSangria &&
          other.horaSangria == this.horaSangria &&
          other.valor == this.valor &&
          other.observacao == this.observacao);
}

class PdvSangriasCompanion extends UpdateCompanion<PdvSangria> {
  final Value<int> id;
  final Value<int> idPdvMovimento;
  final Value<DateTime> dataSangria;
  final Value<String> horaSangria;
  final Value<double> valor;
  final Value<String> observacao;
  const PdvSangriasCompanion({
    this.id = const Value.absent(),
    this.idPdvMovimento = const Value.absent(),
    this.dataSangria = const Value.absent(),
    this.horaSangria = const Value.absent(),
    this.valor = const Value.absent(),
    this.observacao = const Value.absent(),
  });
  PdvSangriasCompanion.insert({
    this.id = const Value.absent(),
    this.idPdvMovimento = const Value.absent(),
    this.dataSangria = const Value.absent(),
    this.horaSangria = const Value.absent(),
    this.valor = const Value.absent(),
    this.observacao = const Value.absent(),
  });
  static Insertable<PdvSangria> custom({
    Expression<int> id,
    Expression<int> idPdvMovimento,
    Expression<DateTime> dataSangria,
    Expression<String> horaSangria,
    Expression<double> valor,
    Expression<String> observacao,
  }) {
    return RawValuesInsertable({
      if (id != null) 'ID': id,
      if (idPdvMovimento != null) 'ID_PDV_MOVIMENTO': idPdvMovimento,
      if (dataSangria != null) 'DATA_SANGRIA': dataSangria,
      if (horaSangria != null) 'HORA_SANGRIA': horaSangria,
      if (valor != null) 'VALOR': valor,
      if (observacao != null) 'OBSERVACAO': observacao,
    });
  }

  PdvSangriasCompanion copyWith(
      {Value<int> id,
      Value<int> idPdvMovimento,
      Value<DateTime> dataSangria,
      Value<String> horaSangria,
      Value<double> valor,
      Value<String> observacao}) {
    return PdvSangriasCompanion(
      id: id ?? this.id,
      idPdvMovimento: idPdvMovimento ?? this.idPdvMovimento,
      dataSangria: dataSangria ?? this.dataSangria,
      horaSangria: horaSangria ?? this.horaSangria,
      valor: valor ?? this.valor,
      observacao: observacao ?? this.observacao,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['ID'] = Variable<int>(id.value);
    }
    if (idPdvMovimento.present) {
      map['ID_PDV_MOVIMENTO'] = Variable<int>(idPdvMovimento.value);
    }
    if (dataSangria.present) {
      map['DATA_SANGRIA'] = Variable<DateTime>(dataSangria.value);
    }
    if (horaSangria.present) {
      map['HORA_SANGRIA'] = Variable<String>(horaSangria.value);
    }
    if (valor.present) {
      map['VALOR'] = Variable<double>(valor.value);
    }
    if (observacao.present) {
      map['OBSERVACAO'] = Variable<String>(observacao.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PdvSangriasCompanion(')
          ..write('id: $id, ')
          ..write('idPdvMovimento: $idPdvMovimento, ')
          ..write('dataSangria: $dataSangria, ')
          ..write('horaSangria: $horaSangria, ')
          ..write('valor: $valor, ')
          ..write('observacao: $observacao')
          ..write(')'))
        .toString();
  }
}

class $PdvSangriasTable extends PdvSangrias
    with TableInfo<$PdvSangriasTable, PdvSangria> {
  final GeneratedDatabase _db;
  final String _alias;
  $PdvSangriasTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedIntColumn _id;
  @override
  GeneratedIntColumn get id => _id ??= _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('ID', $tableName, false,
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
  }

  final VerificationMeta _idPdvMovimentoMeta =
      const VerificationMeta('idPdvMovimento');
  GeneratedIntColumn _idPdvMovimento;
  @override
  GeneratedIntColumn get idPdvMovimento =>
      _idPdvMovimento ??= _constructIdPdvMovimento();
  GeneratedIntColumn _constructIdPdvMovimento() {
    return GeneratedIntColumn('ID_PDV_MOVIMENTO', $tableName, true,
        $customConstraints: 'NULLABLE REFERENCES PDV_MOVIMENTO(ID)');
  }

  final VerificationMeta _dataSangriaMeta =
      const VerificationMeta('dataSangria');
  GeneratedDateTimeColumn _dataSangria;
  @override
  GeneratedDateTimeColumn get dataSangria =>
      _dataSangria ??= _constructDataSangria();
  GeneratedDateTimeColumn _constructDataSangria() {
    return GeneratedDateTimeColumn(
      'DATA_SANGRIA',
      $tableName,
      true,
    );
  }

  final VerificationMeta _horaSangriaMeta =
      const VerificationMeta('horaSangria');
  GeneratedTextColumn _horaSangria;
  @override
  GeneratedTextColumn get horaSangria =>
      _horaSangria ??= _constructHoraSangria();
  GeneratedTextColumn _constructHoraSangria() {
    return GeneratedTextColumn('HORA_SANGRIA', $tableName, true,
        minTextLength: 1, maxTextLength: 8);
  }

  final VerificationMeta _valorMeta = const VerificationMeta('valor');
  GeneratedRealColumn _valor;
  @override
  GeneratedRealColumn get valor => _valor ??= _constructValor();
  GeneratedRealColumn _constructValor() {
    return GeneratedRealColumn(
      'VALOR',
      $tableName,
      true,
    );
  }

  final VerificationMeta _observacaoMeta = const VerificationMeta('observacao');
  GeneratedTextColumn _observacao;
  @override
  GeneratedTextColumn get observacao => _observacao ??= _constructObservacao();
  GeneratedTextColumn _constructObservacao() {
    return GeneratedTextColumn('OBSERVACAO', $tableName, true,
        minTextLength: 1, maxTextLength: 250);
  }

  @override
  List<GeneratedColumn> get $columns =>
      [id, idPdvMovimento, dataSangria, horaSangria, valor, observacao];
  @override
  $PdvSangriasTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'PDV_SANGRIA';
  @override
  final String actualTableName = 'PDV_SANGRIA';
  @override
  VerificationContext validateIntegrity(Insertable<PdvSangria> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('ID')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['ID'], _idMeta));
    }
    if (data.containsKey('ID_PDV_MOVIMENTO')) {
      context.handle(
          _idPdvMovimentoMeta,
          idPdvMovimento.isAcceptableOrUnknown(
              data['ID_PDV_MOVIMENTO'], _idPdvMovimentoMeta));
    }
    if (data.containsKey('DATA_SANGRIA')) {
      context.handle(
          _dataSangriaMeta,
          dataSangria.isAcceptableOrUnknown(
              data['DATA_SANGRIA'], _dataSangriaMeta));
    }
    if (data.containsKey('HORA_SANGRIA')) {
      context.handle(
          _horaSangriaMeta,
          horaSangria.isAcceptableOrUnknown(
              data['HORA_SANGRIA'], _horaSangriaMeta));
    }
    if (data.containsKey('VALOR')) {
      context.handle(
          _valorMeta, valor.isAcceptableOrUnknown(data['VALOR'], _valorMeta));
    }
    if (data.containsKey('OBSERVACAO')) {
      context.handle(
          _observacaoMeta,
          observacao.isAcceptableOrUnknown(
              data['OBSERVACAO'], _observacaoMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PdvSangria map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return PdvSangria.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $PdvSangriasTable createAlias(String alias) {
    return $PdvSangriasTable(_db, alias);
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  $TasksTable _tasks;
  $TasksTable get tasks => _tasks ??= $TasksTable(this);
  $TagsTable _tags;
  $TagsTable get tags => _tags ??= $TagsTable(this);
  $PdvMovimentosTable _pdvMovimentos;
  $PdvMovimentosTable get pdvMovimentos =>
      _pdvMovimentos ??= $PdvMovimentosTable(this);
  $PdvSangriasTable _pdvSangrias;
  $PdvSangriasTable get pdvSangrias => _pdvSangrias ??= $PdvSangriasTable(this);
  TaskDao _taskDao;
  TaskDao get taskDao => _taskDao ??= TaskDao(this as AppDatabase);
  TagDao _tagDao;
  TagDao get tagDao => _tagDao ??= TagDao(this as AppDatabase);
  PdvMovimentoDao _pdvMovimentoDao;
  PdvMovimentoDao get pdvMovimentoDao =>
      _pdvMovimentoDao ??= PdvMovimentoDao(this as AppDatabase);
  PdvSangriaDao _pdvSangriaDao;
  PdvSangriaDao get pdvSangriaDao =>
      _pdvSangriaDao ??= PdvSangriaDao(this as AppDatabase);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [tasks, tags, pdvMovimentos, pdvSangrias];
}

// **************************************************************************
// DaoGenerator
// **************************************************************************

mixin _$PdvMovimentoDaoMixin on DatabaseAccessor<AppDatabase> {
  $PdvMovimentosTable get pdvMovimentos => attachedDatabase.pdvMovimentos;
  $PdvSangriasTable get pdvSangrias => attachedDatabase.pdvSangrias;
}
mixin _$PdvSangriaDaoMixin on DatabaseAccessor<AppDatabase> {
  $PdvSangriasTable get pdvSangrias => attachedDatabase.pdvSangrias;
}
mixin _$TaskDaoMixin on DatabaseAccessor<AppDatabase> {
  $TasksTable get tasks => attachedDatabase.tasks;
  $TagsTable get tags => attachedDatabase.tags;
}
mixin _$TagDaoMixin on DatabaseAccessor<AppDatabase> {
  $TagsTable get tags => attachedDatabase.tags;
}
