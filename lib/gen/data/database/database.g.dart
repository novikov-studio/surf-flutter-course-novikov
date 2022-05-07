// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../data/database/database.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: type=lint
class HistoryEntry extends DataClass implements Insertable<HistoryEntry> {
  final String pattern;
  HistoryEntry({required this.pattern});
  factory HistoryEntry.fromData(Map<String, dynamic> data, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return HistoryEntry(
      pattern: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}pattern'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['pattern'] = Variable<String>(pattern);
    return map;
  }

  HistoryCompanion toCompanion(bool nullToAbsent) {
    return HistoryCompanion(
      pattern: Value(pattern),
    );
  }

  factory HistoryEntry.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return HistoryEntry(
      pattern: serializer.fromJson<String>(json['pattern']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'pattern': serializer.toJson<String>(pattern),
    };
  }

  HistoryEntry copyWith({String? pattern}) => HistoryEntry(
        pattern: pattern ?? this.pattern,
      );
  @override
  String toString() {
    return (StringBuffer('HistoryEntry(')
          ..write('pattern: $pattern')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => pattern.hashCode;
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is HistoryEntry && other.pattern == this.pattern);
}

class HistoryCompanion extends UpdateCompanion<HistoryEntry> {
  final Value<String> pattern;
  const HistoryCompanion({
    this.pattern = const Value.absent(),
  });
  HistoryCompanion.insert({
    required String pattern,
  }) : pattern = Value(pattern);
  static Insertable<HistoryEntry> custom({
    Expression<String>? pattern,
  }) {
    return RawValuesInsertable({
      if (pattern != null) 'pattern': pattern,
    });
  }

  HistoryCompanion copyWith({Value<String>? pattern}) {
    return HistoryCompanion(
      pattern: pattern ?? this.pattern,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (pattern.present) {
      map['pattern'] = Variable<String>(pattern.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('HistoryCompanion(')
          ..write('pattern: $pattern')
          ..write(')'))
        .toString();
  }
}

class $HistoryTable extends History
    with TableInfo<$HistoryTable, HistoryEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $HistoryTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _patternMeta = const VerificationMeta('pattern');
  @override
  late final GeneratedColumn<String?> pattern = GeneratedColumn<String?>(
      'pattern', aliasedName, false,
      type: const StringType(),
      requiredDuringInsert: true,
      defaultConstraints: 'UNIQUE');
  @override
  List<GeneratedColumn> get $columns => [pattern];
  @override
  String get aliasedName => _alias ?? 'history';
  @override
  String get actualTableName => 'history';
  @override
  VerificationContext validateIntegrity(Insertable<HistoryEntry> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('pattern')) {
      context.handle(_patternMeta,
          pattern.isAcceptableOrUnknown(data['pattern']!, _patternMeta));
    } else if (isInserting) {
      context.missing(_patternMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => <GeneratedColumn>{};
  @override
  HistoryEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    return HistoryEntry.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $HistoryTable createAlias(String alias) {
    return $HistoryTable(attachedDatabase, alias);
  }
}

class Favorite extends DataClass implements Insertable<Favorite> {
  final int id;
  final String name;
  final double latitude;
  final double longitude;
  final String urls;
  final String? info;
  final String? details;
  final String category;
  final DateTime? plannedDate;
  final DateTime? visitedDate;
  Favorite(
      {required this.id,
      required this.name,
      required this.latitude,
      required this.longitude,
      required this.urls,
      this.info,
      this.details,
      required this.category,
      this.plannedDate,
      this.visitedDate});
  factory Favorite.fromData(Map<String, dynamic> data, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return Favorite(
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      name: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}name'])!,
      latitude: const RealType()
          .mapFromDatabaseResponse(data['${effectivePrefix}latitude'])!,
      longitude: const RealType()
          .mapFromDatabaseResponse(data['${effectivePrefix}longitude'])!,
      urls: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}urls'])!,
      info: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}info']),
      details: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}details']),
      category: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}category'])!,
      plannedDate: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}planned_date']),
      visitedDate: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}visited_date']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['latitude'] = Variable<double>(latitude);
    map['longitude'] = Variable<double>(longitude);
    map['urls'] = Variable<String>(urls);
    if (!nullToAbsent || info != null) {
      map['info'] = Variable<String?>(info);
    }
    if (!nullToAbsent || details != null) {
      map['details'] = Variable<String?>(details);
    }
    map['category'] = Variable<String>(category);
    if (!nullToAbsent || plannedDate != null) {
      map['planned_date'] = Variable<DateTime?>(plannedDate);
    }
    if (!nullToAbsent || visitedDate != null) {
      map['visited_date'] = Variable<DateTime?>(visitedDate);
    }
    return map;
  }

  FavoritesCompanion toCompanion(bool nullToAbsent) {
    return FavoritesCompanion(
      id: Value(id),
      name: Value(name),
      latitude: Value(latitude),
      longitude: Value(longitude),
      urls: Value(urls),
      info: info == null && nullToAbsent ? const Value.absent() : Value(info),
      details: details == null && nullToAbsent
          ? const Value.absent()
          : Value(details),
      category: Value(category),
      plannedDate: plannedDate == null && nullToAbsent
          ? const Value.absent()
          : Value(plannedDate),
      visitedDate: visitedDate == null && nullToAbsent
          ? const Value.absent()
          : Value(visitedDate),
    );
  }

  factory Favorite.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Favorite(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      latitude: serializer.fromJson<double>(json['latitude']),
      longitude: serializer.fromJson<double>(json['longitude']),
      urls: serializer.fromJson<String>(json['urls']),
      info: serializer.fromJson<String?>(json['info']),
      details: serializer.fromJson<String?>(json['details']),
      category: serializer.fromJson<String>(json['category']),
      plannedDate: serializer.fromJson<DateTime?>(json['plannedDate']),
      visitedDate: serializer.fromJson<DateTime?>(json['visitedDate']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'latitude': serializer.toJson<double>(latitude),
      'longitude': serializer.toJson<double>(longitude),
      'urls': serializer.toJson<String>(urls),
      'info': serializer.toJson<String?>(info),
      'details': serializer.toJson<String?>(details),
      'category': serializer.toJson<String>(category),
      'plannedDate': serializer.toJson<DateTime?>(plannedDate),
      'visitedDate': serializer.toJson<DateTime?>(visitedDate),
    };
  }

  Favorite copyWith(
          {int? id,
          String? name,
          double? latitude,
          double? longitude,
          String? urls,
          String? info,
          String? details,
          String? category,
          DateTime? plannedDate,
          DateTime? visitedDate}) =>
      Favorite(
        id: id ?? this.id,
        name: name ?? this.name,
        latitude: latitude ?? this.latitude,
        longitude: longitude ?? this.longitude,
        urls: urls ?? this.urls,
        info: info ?? this.info,
        details: details ?? this.details,
        category: category ?? this.category,
        plannedDate: plannedDate ?? this.plannedDate,
        visitedDate: visitedDate ?? this.visitedDate,
      );
  @override
  String toString() {
    return (StringBuffer('Favorite(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('latitude: $latitude, ')
          ..write('longitude: $longitude, ')
          ..write('urls: $urls, ')
          ..write('info: $info, ')
          ..write('details: $details, ')
          ..write('category: $category, ')
          ..write('plannedDate: $plannedDate, ')
          ..write('visitedDate: $visitedDate')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, latitude, longitude, urls, info,
      details, category, plannedDate, visitedDate);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Favorite &&
          other.id == this.id &&
          other.name == this.name &&
          other.latitude == this.latitude &&
          other.longitude == this.longitude &&
          other.urls == this.urls &&
          other.info == this.info &&
          other.details == this.details &&
          other.category == this.category &&
          other.plannedDate == this.plannedDate &&
          other.visitedDate == this.visitedDate);
}

class FavoritesCompanion extends UpdateCompanion<Favorite> {
  final Value<int> id;
  final Value<String> name;
  final Value<double> latitude;
  final Value<double> longitude;
  final Value<String> urls;
  final Value<String?> info;
  final Value<String?> details;
  final Value<String> category;
  final Value<DateTime?> plannedDate;
  final Value<DateTime?> visitedDate;
  const FavoritesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.latitude = const Value.absent(),
    this.longitude = const Value.absent(),
    this.urls = const Value.absent(),
    this.info = const Value.absent(),
    this.details = const Value.absent(),
    this.category = const Value.absent(),
    this.plannedDate = const Value.absent(),
    this.visitedDate = const Value.absent(),
  });
  FavoritesCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required double latitude,
    required double longitude,
    required String urls,
    this.info = const Value.absent(),
    this.details = const Value.absent(),
    required String category,
    this.plannedDate = const Value.absent(),
    this.visitedDate = const Value.absent(),
  })  : name = Value(name),
        latitude = Value(latitude),
        longitude = Value(longitude),
        urls = Value(urls),
        category = Value(category);
  static Insertable<Favorite> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<double>? latitude,
    Expression<double>? longitude,
    Expression<String>? urls,
    Expression<String?>? info,
    Expression<String?>? details,
    Expression<String>? category,
    Expression<DateTime?>? plannedDate,
    Expression<DateTime?>? visitedDate,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (latitude != null) 'latitude': latitude,
      if (longitude != null) 'longitude': longitude,
      if (urls != null) 'urls': urls,
      if (info != null) 'info': info,
      if (details != null) 'details': details,
      if (category != null) 'category': category,
      if (plannedDate != null) 'planned_date': plannedDate,
      if (visitedDate != null) 'visited_date': visitedDate,
    });
  }

  FavoritesCompanion copyWith(
      {Value<int>? id,
      Value<String>? name,
      Value<double>? latitude,
      Value<double>? longitude,
      Value<String>? urls,
      Value<String?>? info,
      Value<String?>? details,
      Value<String>? category,
      Value<DateTime?>? plannedDate,
      Value<DateTime?>? visitedDate}) {
    return FavoritesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      urls: urls ?? this.urls,
      info: info ?? this.info,
      details: details ?? this.details,
      category: category ?? this.category,
      plannedDate: plannedDate ?? this.plannedDate,
      visitedDate: visitedDate ?? this.visitedDate,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (latitude.present) {
      map['latitude'] = Variable<double>(latitude.value);
    }
    if (longitude.present) {
      map['longitude'] = Variable<double>(longitude.value);
    }
    if (urls.present) {
      map['urls'] = Variable<String>(urls.value);
    }
    if (info.present) {
      map['info'] = Variable<String?>(info.value);
    }
    if (details.present) {
      map['details'] = Variable<String?>(details.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (plannedDate.present) {
      map['planned_date'] = Variable<DateTime?>(plannedDate.value);
    }
    if (visitedDate.present) {
      map['visited_date'] = Variable<DateTime?>(visitedDate.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FavoritesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('latitude: $latitude, ')
          ..write('longitude: $longitude, ')
          ..write('urls: $urls, ')
          ..write('info: $info, ')
          ..write('details: $details, ')
          ..write('category: $category, ')
          ..write('plannedDate: $plannedDate, ')
          ..write('visitedDate: $visitedDate')
          ..write(')'))
        .toString();
  }
}

class $FavoritesTable extends Favorites
    with TableInfo<$FavoritesTable, Favorite> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FavoritesTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int?> id = GeneratedColumn<int?>(
      'id', aliasedName, false,
      type: const IntType(), requiredDuringInsert: false);
  final VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String?> name = GeneratedColumn<String?>(
      'name', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _latitudeMeta = const VerificationMeta('latitude');
  @override
  late final GeneratedColumn<double?> latitude = GeneratedColumn<double?>(
      'latitude', aliasedName, false,
      type: const RealType(), requiredDuringInsert: true);
  final VerificationMeta _longitudeMeta = const VerificationMeta('longitude');
  @override
  late final GeneratedColumn<double?> longitude = GeneratedColumn<double?>(
      'longitude', aliasedName, false,
      type: const RealType(), requiredDuringInsert: true);
  final VerificationMeta _urlsMeta = const VerificationMeta('urls');
  @override
  late final GeneratedColumn<String?> urls = GeneratedColumn<String?>(
      'urls', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _infoMeta = const VerificationMeta('info');
  @override
  late final GeneratedColumn<String?> info = GeneratedColumn<String?>(
      'info', aliasedName, true,
      type: const StringType(), requiredDuringInsert: false);
  final VerificationMeta _detailsMeta = const VerificationMeta('details');
  @override
  late final GeneratedColumn<String?> details = GeneratedColumn<String?>(
      'details', aliasedName, true,
      type: const StringType(), requiredDuringInsert: false);
  final VerificationMeta _categoryMeta = const VerificationMeta('category');
  @override
  late final GeneratedColumn<String?> category = GeneratedColumn<String?>(
      'category', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _plannedDateMeta =
      const VerificationMeta('plannedDate');
  @override
  late final GeneratedColumn<DateTime?> plannedDate =
      GeneratedColumn<DateTime?>('planned_date', aliasedName, true,
          type: const IntType(), requiredDuringInsert: false);
  final VerificationMeta _visitedDateMeta =
      const VerificationMeta('visitedDate');
  @override
  late final GeneratedColumn<DateTime?> visitedDate =
      GeneratedColumn<DateTime?>('visited_date', aliasedName, true,
          type: const IntType(), requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        name,
        latitude,
        longitude,
        urls,
        info,
        details,
        category,
        plannedDate,
        visitedDate
      ];
  @override
  String get aliasedName => _alias ?? 'favorites';
  @override
  String get actualTableName => 'favorites';
  @override
  VerificationContext validateIntegrity(Insertable<Favorite> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('latitude')) {
      context.handle(_latitudeMeta,
          latitude.isAcceptableOrUnknown(data['latitude']!, _latitudeMeta));
    } else if (isInserting) {
      context.missing(_latitudeMeta);
    }
    if (data.containsKey('longitude')) {
      context.handle(_longitudeMeta,
          longitude.isAcceptableOrUnknown(data['longitude']!, _longitudeMeta));
    } else if (isInserting) {
      context.missing(_longitudeMeta);
    }
    if (data.containsKey('urls')) {
      context.handle(
          _urlsMeta, urls.isAcceptableOrUnknown(data['urls']!, _urlsMeta));
    } else if (isInserting) {
      context.missing(_urlsMeta);
    }
    if (data.containsKey('info')) {
      context.handle(
          _infoMeta, info.isAcceptableOrUnknown(data['info']!, _infoMeta));
    }
    if (data.containsKey('details')) {
      context.handle(_detailsMeta,
          details.isAcceptableOrUnknown(data['details']!, _detailsMeta));
    }
    if (data.containsKey('category')) {
      context.handle(_categoryMeta,
          category.isAcceptableOrUnknown(data['category']!, _categoryMeta));
    } else if (isInserting) {
      context.missing(_categoryMeta);
    }
    if (data.containsKey('planned_date')) {
      context.handle(
          _plannedDateMeta,
          plannedDate.isAcceptableOrUnknown(
              data['planned_date']!, _plannedDateMeta));
    }
    if (data.containsKey('visited_date')) {
      context.handle(
          _visitedDateMeta,
          visitedDate.isAcceptableOrUnknown(
              data['visited_date']!, _visitedDateMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Favorite map(Map<String, dynamic> data, {String? tablePrefix}) {
    return Favorite.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $FavoritesTable createAlias(String alias) {
    return $FavoritesTable(attachedDatabase, alias);
  }
}

abstract class _$Database extends GeneratedDatabase {
  _$Database(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  late final $HistoryTable history = $HistoryTable(this);
  late final $FavoritesTable favorites = $FavoritesTable(this);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [history, favorites];
}
