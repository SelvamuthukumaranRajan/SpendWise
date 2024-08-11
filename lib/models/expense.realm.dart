// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expense.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

// ignore_for_file: type=lint
class Expense extends _Expense with RealmEntity, RealmObjectBase, RealmObject {
  Expense(
    int id,
    double amount,
    String title,
    String description,
    String category,
    DateTime date,
  ) {
    RealmObjectBase.set(this, 'id', id);
    RealmObjectBase.set(this, 'amount', amount);
    RealmObjectBase.set(this, 'title', title);
    RealmObjectBase.set(this, 'description', description);
    RealmObjectBase.set(this, 'category', category);
    RealmObjectBase.set(this, 'date', date);
  }

  Expense._();

  @override
  int get id => RealmObjectBase.get<int>(this, 'id') as int;
  @override
  set id(int value) => RealmObjectBase.set(this, 'id', value);

  @override
  double get amount => RealmObjectBase.get<double>(this, 'amount') as double;
  @override
  set amount(double value) => RealmObjectBase.set(this, 'amount', value);

  @override
  String get title => RealmObjectBase.get<String>(this, 'title') as String;
  @override
  set title(String value) => RealmObjectBase.set(this, 'title', value);

  @override
  String get description =>
      RealmObjectBase.get<String>(this, 'description') as String;
  @override
  set description(String value) =>
      RealmObjectBase.set(this, 'description', value);

  @override
  String get category =>
      RealmObjectBase.get<String>(this, 'category') as String;
  @override
  set category(String value) => RealmObjectBase.set(this, 'category', value);

  @override
  DateTime get date => RealmObjectBase.get<DateTime>(this, 'date') as DateTime;
  @override
  set date(DateTime value) => RealmObjectBase.set(this, 'date', value);

  @override
  Stream<RealmObjectChanges<Expense>> get changes =>
      RealmObjectBase.getChanges<Expense>(this);

  @override
  Stream<RealmObjectChanges<Expense>> changesFor([List<String>? keyPaths]) =>
      RealmObjectBase.getChangesFor<Expense>(this, keyPaths);

  @override
  Expense freeze() => RealmObjectBase.freezeObject<Expense>(this);

  EJsonValue toEJson() {
    return <String, dynamic>{
      'id': id.toEJson(),
      'amount': amount.toEJson(),
      'title': title.toEJson(),
      'description': description.toEJson(),
      'category': category.toEJson(),
      'date': date.toEJson(),
    };
  }

  static EJsonValue _toEJson(Expense value) => value.toEJson();
  static Expense _fromEJson(EJsonValue ejson) {
    return switch (ejson) {
      {
        'id': EJsonValue id,
        'amount': EJsonValue amount,
        'title': EJsonValue title,
        'description': EJsonValue description,
        'category': EJsonValue category,
        'date': EJsonValue date,
      } =>
        Expense(
          fromEJson(id),
          fromEJson(amount),
          fromEJson(title),
          fromEJson(description),
          fromEJson(category),
          fromEJson(date),
        ),
      _ => raiseInvalidEJson(ejson),
    };
  }

  static final schema = () {
    RealmObjectBase.registerFactory(Expense._);
    register(_toEJson, _fromEJson);
    return SchemaObject(ObjectType.realmObject, Expense, 'Expense', [
      SchemaProperty('id', RealmPropertyType.int, primaryKey: true),
      SchemaProperty('amount', RealmPropertyType.double),
      SchemaProperty('title', RealmPropertyType.string),
      SchemaProperty('description', RealmPropertyType.string),
      SchemaProperty('category', RealmPropertyType.string),
      SchemaProperty('date', RealmPropertyType.timestamp),
    ]);
  }();

  @override
  SchemaObject get objectSchema => RealmObjectBase.getSchema(this) ?? schema;
}
