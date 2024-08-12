// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_model.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

// ignore_for_file: type=lint
class TransactionModel extends _TransactionModel
    with RealmEntity, RealmObjectBase, RealmObject {
  TransactionModel(
    int id,
    double amount,
    String title,
    String description,
    String category,
    bool isExpense,
    DateTime date,
  ) {
    RealmObjectBase.set(this, 'id', id);
    RealmObjectBase.set(this, 'amount', amount);
    RealmObjectBase.set(this, 'title', title);
    RealmObjectBase.set(this, 'description', description);
    RealmObjectBase.set(this, 'category', category);
    RealmObjectBase.set(this, 'isExpense', isExpense);
    RealmObjectBase.set(this, 'date', date);
  }

  TransactionModel._();

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
  bool get isExpense => RealmObjectBase.get<bool>(this, 'isExpense') as bool;
  @override
  set isExpense(bool value) => RealmObjectBase.set(this, 'isExpense', value);

  @override
  DateTime get date => RealmObjectBase.get<DateTime>(this, 'date') as DateTime;
  @override
  set date(DateTime value) => RealmObjectBase.set(this, 'date', value);

  @override
  Stream<RealmObjectChanges<TransactionModel>> get changes =>
      RealmObjectBase.getChanges<TransactionModel>(this);

  @override
  Stream<RealmObjectChanges<TransactionModel>> changesFor(
          [List<String>? keyPaths]) =>
      RealmObjectBase.getChangesFor<TransactionModel>(this, keyPaths);

  @override
  TransactionModel freeze() =>
      RealmObjectBase.freezeObject<TransactionModel>(this);

  EJsonValue toEJson() {
    return <String, dynamic>{
      'id': id.toEJson(),
      'amount': amount.toEJson(),
      'title': title.toEJson(),
      'description': description.toEJson(),
      'category': category.toEJson(),
      'isExpense': isExpense.toEJson(),
      'date': date.toEJson(),
    };
  }

  static EJsonValue _toEJson(TransactionModel value) => value.toEJson();
  static TransactionModel _fromEJson(EJsonValue ejson) {
    if (ejson is! Map<String, dynamic>) return raiseInvalidEJson(ejson);
    return switch (ejson) {
      {
        'id': EJsonValue id,
        'amount': EJsonValue amount,
        'title': EJsonValue title,
        'description': EJsonValue description,
        'category': EJsonValue category,
        'isExpense': EJsonValue isExpense,
        'date': EJsonValue date,
      } =>
        TransactionModel(
          fromEJson(id),
          fromEJson(amount),
          fromEJson(title),
          fromEJson(description),
          fromEJson(category),
          fromEJson(isExpense),
          fromEJson(date),
        ),
      _ => raiseInvalidEJson(ejson),
    };
  }

  static final schema = () {
    RealmObjectBase.registerFactory(TransactionModel._);
    register(_toEJson, _fromEJson);
    return const SchemaObject(
        ObjectType.realmObject, TransactionModel, 'TransactionModel', [
      SchemaProperty('id', RealmPropertyType.int, primaryKey: true),
      SchemaProperty('amount', RealmPropertyType.double),
      SchemaProperty('title', RealmPropertyType.string),
      SchemaProperty('description', RealmPropertyType.string),
      SchemaProperty('category', RealmPropertyType.string),
      SchemaProperty('isExpense', RealmPropertyType.bool),
      SchemaProperty('date', RealmPropertyType.timestamp),
    ]);
  }();

  @override
  SchemaObject get objectSchema => RealmObjectBase.getSchema(this) ?? schema;
}
