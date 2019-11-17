// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'moor_database.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class Recipe extends DataClass implements Insertable<Recipe> {
  final int id;
  final String title;
  final String recipeType;
  final String preparationText;
  final String imageUrl;
  final String preparationTime;
  final DateTime syncDate;
  Recipe(
      {@required this.id,
      @required this.title,
      @required this.recipeType,
      @required this.preparationText,
      @required this.imageUrl,
      @required this.preparationTime,
      this.syncDate});
  factory Recipe.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    final dateTimeType = db.typeSystem.forDartType<DateTime>();
    return Recipe(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      title:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}title']),
      recipeType: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}recipe_type']),
      preparationText: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}preparation_text']),
      imageUrl: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}image_url']),
      preparationTime: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}preparation_time']),
      syncDate: dateTimeType
          .mapFromDatabaseResponse(data['${effectivePrefix}sync_date']),
    );
  }
  factory Recipe.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return Recipe(
      id: serializer.fromJson<int>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      recipeType: serializer.fromJson<String>(json['recipeType']),
      preparationText: serializer.fromJson<String>(json['preparationText']),
      imageUrl: serializer.fromJson<String>(json['imageUrl']),
      preparationTime: serializer.fromJson<String>(json['preparationTime']),
      syncDate: serializer.fromJson<DateTime>(json['syncDate']),
    );
  }
  @override
  Map<String, dynamic> toJson(
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return {
      'id': serializer.toJson<int>(id),
      'title': serializer.toJson<String>(title),
      'recipeType': serializer.toJson<String>(recipeType),
      'preparationText': serializer.toJson<String>(preparationText),
      'imageUrl': serializer.toJson<String>(imageUrl),
      'preparationTime': serializer.toJson<String>(preparationTime),
      'syncDate': serializer.toJson<DateTime>(syncDate),
    };
  }

  @override
  RecipesCompanion createCompanion(bool nullToAbsent) {
    return RecipesCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      title:
          title == null && nullToAbsent ? const Value.absent() : Value(title),
      recipeType: recipeType == null && nullToAbsent
          ? const Value.absent()
          : Value(recipeType),
      preparationText: preparationText == null && nullToAbsent
          ? const Value.absent()
          : Value(preparationText),
      imageUrl: imageUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(imageUrl),
      preparationTime: preparationTime == null && nullToAbsent
          ? const Value.absent()
          : Value(preparationTime),
      syncDate: syncDate == null && nullToAbsent
          ? const Value.absent()
          : Value(syncDate),
    );
  }

  Recipe copyWith(
          {int id,
          String title,
          String recipeType,
          String preparationText,
          String imageUrl,
          String preparationTime,
          DateTime syncDate}) =>
      Recipe(
        id: id ?? this.id,
        title: title ?? this.title,
        recipeType: recipeType ?? this.recipeType,
        preparationText: preparationText ?? this.preparationText,
        imageUrl: imageUrl ?? this.imageUrl,
        preparationTime: preparationTime ?? this.preparationTime,
        syncDate: syncDate ?? this.syncDate,
      );
  @override
  String toString() {
    return (StringBuffer('Recipe(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('recipeType: $recipeType, ')
          ..write('preparationText: $preparationText, ')
          ..write('imageUrl: $imageUrl, ')
          ..write('preparationTime: $preparationTime, ')
          ..write('syncDate: $syncDate')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(
          title.hashCode,
          $mrjc(
              recipeType.hashCode,
              $mrjc(
                  preparationText.hashCode,
                  $mrjc(imageUrl.hashCode,
                      $mrjc(preparationTime.hashCode, syncDate.hashCode)))))));
  @override
  bool operator ==(other) =>
      identical(this, other) ||
      (other is Recipe &&
          other.id == this.id &&
          other.title == this.title &&
          other.recipeType == this.recipeType &&
          other.preparationText == this.preparationText &&
          other.imageUrl == this.imageUrl &&
          other.preparationTime == this.preparationTime &&
          other.syncDate == this.syncDate);
}

class RecipesCompanion extends UpdateCompanion<Recipe> {
  final Value<int> id;
  final Value<String> title;
  final Value<String> recipeType;
  final Value<String> preparationText;
  final Value<String> imageUrl;
  final Value<String> preparationTime;
  final Value<DateTime> syncDate;
  const RecipesCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.recipeType = const Value.absent(),
    this.preparationText = const Value.absent(),
    this.imageUrl = const Value.absent(),
    this.preparationTime = const Value.absent(),
    this.syncDate = const Value.absent(),
  });
  RecipesCompanion.insert({
    this.id = const Value.absent(),
    @required String title,
    @required String recipeType,
    @required String preparationText,
    @required String imageUrl,
    @required String preparationTime,
    this.syncDate = const Value.absent(),
  })  : title = Value(title),
        recipeType = Value(recipeType),
        preparationText = Value(preparationText),
        imageUrl = Value(imageUrl),
        preparationTime = Value(preparationTime);
  RecipesCompanion copyWith(
      {Value<int> id,
      Value<String> title,
      Value<String> recipeType,
      Value<String> preparationText,
      Value<String> imageUrl,
      Value<String> preparationTime,
      Value<DateTime> syncDate}) {
    return RecipesCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      recipeType: recipeType ?? this.recipeType,
      preparationText: preparationText ?? this.preparationText,
      imageUrl: imageUrl ?? this.imageUrl,
      preparationTime: preparationTime ?? this.preparationTime,
      syncDate: syncDate ?? this.syncDate,
    );
  }
}

class $RecipesTable extends Recipes with TableInfo<$RecipesTable, Recipe> {
  final GeneratedDatabase _db;
  final String _alias;
  $RecipesTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedIntColumn _id;
  @override
  GeneratedIntColumn get id => _id ??= _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('id', $tableName, false,
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
  }

  final VerificationMeta _titleMeta = const VerificationMeta('title');
  GeneratedTextColumn _title;
  @override
  GeneratedTextColumn get title => _title ??= _constructTitle();
  GeneratedTextColumn _constructTitle() {
    return GeneratedTextColumn('title', $tableName, false,
        minTextLength: 1, maxTextLength: 70);
  }

  final VerificationMeta _recipeTypeMeta = const VerificationMeta('recipeType');
  GeneratedTextColumn _recipeType;
  @override
  GeneratedTextColumn get recipeType => _recipeType ??= _constructRecipeType();
  GeneratedTextColumn _constructRecipeType() {
    return GeneratedTextColumn('recipe_type', $tableName, false,
        minTextLength: 1,
        maxTextLength: 70,
        $customConstraints: 'REFERENCES recipeTypes(name)');
  }

  final VerificationMeta _preparationTextMeta =
      const VerificationMeta('preparationText');
  GeneratedTextColumn _preparationText;
  @override
  GeneratedTextColumn get preparationText =>
      _preparationText ??= _constructPreparationText();
  GeneratedTextColumn _constructPreparationText() {
    return GeneratedTextColumn('preparation_text', $tableName, false,
        minTextLength: 1, maxTextLength: 10000);
  }

  final VerificationMeta _imageUrlMeta = const VerificationMeta('imageUrl');
  GeneratedTextColumn _imageUrl;
  @override
  GeneratedTextColumn get imageUrl => _imageUrl ??= _constructImageUrl();
  GeneratedTextColumn _constructImageUrl() {
    return GeneratedTextColumn('image_url', $tableName, false,
        minTextLength: 1, maxTextLength: 270);
  }

  final VerificationMeta _preparationTimeMeta =
      const VerificationMeta('preparationTime');
  GeneratedTextColumn _preparationTime;
  @override
  GeneratedTextColumn get preparationTime =>
      _preparationTime ??= _constructPreparationTime();
  GeneratedTextColumn _constructPreparationTime() {
    return GeneratedTextColumn('preparation_time', $tableName, false,
        minTextLength: 1, maxTextLength: 70);
  }

  final VerificationMeta _syncDateMeta = const VerificationMeta('syncDate');
  GeneratedDateTimeColumn _syncDate;
  @override
  GeneratedDateTimeColumn get syncDate => _syncDate ??= _constructSyncDate();
  GeneratedDateTimeColumn _constructSyncDate() {
    return GeneratedDateTimeColumn(
      'sync_date',
      $tableName,
      true,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [
        id,
        title,
        recipeType,
        preparationText,
        imageUrl,
        preparationTime,
        syncDate
      ];
  @override
  $RecipesTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'recipes';
  @override
  final String actualTableName = 'recipes';
  @override
  VerificationContext validateIntegrity(RecipesCompanion d,
      {bool isInserting = false}) {
    final context = VerificationContext();
    if (d.id.present) {
      context.handle(_idMeta, id.isAcceptableValue(d.id.value, _idMeta));
    } else if (id.isRequired && isInserting) {
      context.missing(_idMeta);
    }
    if (d.title.present) {
      context.handle(
          _titleMeta, title.isAcceptableValue(d.title.value, _titleMeta));
    } else if (title.isRequired && isInserting) {
      context.missing(_titleMeta);
    }
    if (d.recipeType.present) {
      context.handle(_recipeTypeMeta,
          recipeType.isAcceptableValue(d.recipeType.value, _recipeTypeMeta));
    } else if (recipeType.isRequired && isInserting) {
      context.missing(_recipeTypeMeta);
    }
    if (d.preparationText.present) {
      context.handle(
          _preparationTextMeta,
          preparationText.isAcceptableValue(
              d.preparationText.value, _preparationTextMeta));
    } else if (preparationText.isRequired && isInserting) {
      context.missing(_preparationTextMeta);
    }
    if (d.imageUrl.present) {
      context.handle(_imageUrlMeta,
          imageUrl.isAcceptableValue(d.imageUrl.value, _imageUrlMeta));
    } else if (imageUrl.isRequired && isInserting) {
      context.missing(_imageUrlMeta);
    }
    if (d.preparationTime.present) {
      context.handle(
          _preparationTimeMeta,
          preparationTime.isAcceptableValue(
              d.preparationTime.value, _preparationTimeMeta));
    } else if (preparationTime.isRequired && isInserting) {
      context.missing(_preparationTimeMeta);
    }
    if (d.syncDate.present) {
      context.handle(_syncDateMeta,
          syncDate.isAcceptableValue(d.syncDate.value, _syncDateMeta));
    } else if (syncDate.isRequired && isInserting) {
      context.missing(_syncDateMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id, title};
  @override
  Recipe map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return Recipe.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  Map<String, Variable> entityToSql(RecipesCompanion d) {
    final map = <String, Variable>{};
    if (d.id.present) {
      map['id'] = Variable<int, IntType>(d.id.value);
    }
    if (d.title.present) {
      map['title'] = Variable<String, StringType>(d.title.value);
    }
    if (d.recipeType.present) {
      map['recipe_type'] = Variable<String, StringType>(d.recipeType.value);
    }
    if (d.preparationText.present) {
      map['preparation_text'] =
          Variable<String, StringType>(d.preparationText.value);
    }
    if (d.imageUrl.present) {
      map['image_url'] = Variable<String, StringType>(d.imageUrl.value);
    }
    if (d.preparationTime.present) {
      map['preparation_time'] =
          Variable<String, StringType>(d.preparationTime.value);
    }
    if (d.syncDate.present) {
      map['sync_date'] = Variable<DateTime, DateTimeType>(d.syncDate.value);
    }
    return map;
  }

  @override
  $RecipesTable createAlias(String alias) {
    return $RecipesTable(_db, alias);
  }
}

class RecipeId extends DataClass implements Insertable<RecipeId> {
  final int id;
  final int remoteId;
  final int localId;
  RecipeId({@required this.id, @required this.remoteId, this.localId});
  factory RecipeId.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    return RecipeId(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      remoteId:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}remote_id']),
      localId:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}local_id']),
    );
  }
  factory RecipeId.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return RecipeId(
      id: serializer.fromJson<int>(json['id']),
      remoteId: serializer.fromJson<int>(json['remoteId']),
      localId: serializer.fromJson<int>(json['localId']),
    );
  }
  @override
  Map<String, dynamic> toJson(
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return {
      'id': serializer.toJson<int>(id),
      'remoteId': serializer.toJson<int>(remoteId),
      'localId': serializer.toJson<int>(localId),
    };
  }

  @override
  RecipeIdsCompanion createCompanion(bool nullToAbsent) {
    return RecipeIdsCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      remoteId: remoteId == null && nullToAbsent
          ? const Value.absent()
          : Value(remoteId),
      localId: localId == null && nullToAbsent
          ? const Value.absent()
          : Value(localId),
    );
  }

  RecipeId copyWith({int id, int remoteId, int localId}) => RecipeId(
        id: id ?? this.id,
        remoteId: remoteId ?? this.remoteId,
        localId: localId ?? this.localId,
      );
  @override
  String toString() {
    return (StringBuffer('RecipeId(')
          ..write('id: $id, ')
          ..write('remoteId: $remoteId, ')
          ..write('localId: $localId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      $mrjf($mrjc(id.hashCode, $mrjc(remoteId.hashCode, localId.hashCode)));
  @override
  bool operator ==(other) =>
      identical(this, other) ||
      (other is RecipeId &&
          other.id == this.id &&
          other.remoteId == this.remoteId &&
          other.localId == this.localId);
}

class RecipeIdsCompanion extends UpdateCompanion<RecipeId> {
  final Value<int> id;
  final Value<int> remoteId;
  final Value<int> localId;
  const RecipeIdsCompanion({
    this.id = const Value.absent(),
    this.remoteId = const Value.absent(),
    this.localId = const Value.absent(),
  });
  RecipeIdsCompanion.insert({
    this.id = const Value.absent(),
    @required int remoteId,
    this.localId = const Value.absent(),
  }) : remoteId = Value(remoteId);
  RecipeIdsCompanion copyWith(
      {Value<int> id, Value<int> remoteId, Value<int> localId}) {
    return RecipeIdsCompanion(
      id: id ?? this.id,
      remoteId: remoteId ?? this.remoteId,
      localId: localId ?? this.localId,
    );
  }
}

class $RecipeIdsTable extends RecipeIds
    with TableInfo<$RecipeIdsTable, RecipeId> {
  final GeneratedDatabase _db;
  final String _alias;
  $RecipeIdsTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedIntColumn _id;
  @override
  GeneratedIntColumn get id => _id ??= _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('id', $tableName, false,
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
  }

  final VerificationMeta _remoteIdMeta = const VerificationMeta('remoteId');
  GeneratedIntColumn _remoteId;
  @override
  GeneratedIntColumn get remoteId => _remoteId ??= _constructRemoteId();
  GeneratedIntColumn _constructRemoteId() {
    return GeneratedIntColumn('remote_id', $tableName, false,
        $customConstraints: 'UNIQUE remoteId');
  }

  final VerificationMeta _localIdMeta = const VerificationMeta('localId');
  GeneratedIntColumn _localId;
  @override
  GeneratedIntColumn get localId => _localId ??= _constructLocalId();
  GeneratedIntColumn _constructLocalId() {
    return GeneratedIntColumn('local_id', $tableName, true,
        $customConstraints: 'REFERENCES recipes(id)');
  }

  @override
  List<GeneratedColumn> get $columns => [id, remoteId, localId];
  @override
  $RecipeIdsTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'recipe_ids';
  @override
  final String actualTableName = 'recipe_ids';
  @override
  VerificationContext validateIntegrity(RecipeIdsCompanion d,
      {bool isInserting = false}) {
    final context = VerificationContext();
    if (d.id.present) {
      context.handle(_idMeta, id.isAcceptableValue(d.id.value, _idMeta));
    } else if (id.isRequired && isInserting) {
      context.missing(_idMeta);
    }
    if (d.remoteId.present) {
      context.handle(_remoteIdMeta,
          remoteId.isAcceptableValue(d.remoteId.value, _remoteIdMeta));
    } else if (remoteId.isRequired && isInserting) {
      context.missing(_remoteIdMeta);
    }
    if (d.localId.present) {
      context.handle(_localIdMeta,
          localId.isAcceptableValue(d.localId.value, _localIdMeta));
    } else if (localId.isRequired && isInserting) {
      context.missing(_localIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  RecipeId map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return RecipeId.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  Map<String, Variable> entityToSql(RecipeIdsCompanion d) {
    final map = <String, Variable>{};
    if (d.id.present) {
      map['id'] = Variable<int, IntType>(d.id.value);
    }
    if (d.remoteId.present) {
      map['remote_id'] = Variable<int, IntType>(d.remoteId.value);
    }
    if (d.localId.present) {
      map['local_id'] = Variable<int, IntType>(d.localId.value);
    }
    return map;
  }

  @override
  $RecipeIdsTable createAlias(String alias) {
    return $RecipeIdsTable(_db, alias);
  }
}

class Ingredient extends DataClass implements Insertable<Ingredient> {
  final int id;
  final String name;
  final String ingredientType;
  final DateTime syncDate;
  Ingredient(
      {@required this.id,
      @required this.name,
      @required this.ingredientType,
      this.syncDate});
  factory Ingredient.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    final dateTimeType = db.typeSystem.forDartType<DateTime>();
    return Ingredient(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      name: stringType.mapFromDatabaseResponse(data['${effectivePrefix}name']),
      ingredientType: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}ingredient_type']),
      syncDate: dateTimeType
          .mapFromDatabaseResponse(data['${effectivePrefix}sync_date']),
    );
  }
  factory Ingredient.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return Ingredient(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      ingredientType: serializer.fromJson<String>(json['ingredientType']),
      syncDate: serializer.fromJson<DateTime>(json['syncDate']),
    );
  }
  @override
  Map<String, dynamic> toJson(
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return {
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'ingredientType': serializer.toJson<String>(ingredientType),
      'syncDate': serializer.toJson<DateTime>(syncDate),
    };
  }

  @override
  IngredientsCompanion createCompanion(bool nullToAbsent) {
    return IngredientsCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
      ingredientType: ingredientType == null && nullToAbsent
          ? const Value.absent()
          : Value(ingredientType),
      syncDate: syncDate == null && nullToAbsent
          ? const Value.absent()
          : Value(syncDate),
    );
  }

  Ingredient copyWith(
          {int id, String name, String ingredientType, DateTime syncDate}) =>
      Ingredient(
        id: id ?? this.id,
        name: name ?? this.name,
        ingredientType: ingredientType ?? this.ingredientType,
        syncDate: syncDate ?? this.syncDate,
      );
  @override
  String toString() {
    return (StringBuffer('Ingredient(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('ingredientType: $ingredientType, ')
          ..write('syncDate: $syncDate')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(id.hashCode,
      $mrjc(name.hashCode, $mrjc(ingredientType.hashCode, syncDate.hashCode))));
  @override
  bool operator ==(other) =>
      identical(this, other) ||
      (other is Ingredient &&
          other.id == this.id &&
          other.name == this.name &&
          other.ingredientType == this.ingredientType &&
          other.syncDate == this.syncDate);
}

class IngredientsCompanion extends UpdateCompanion<Ingredient> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> ingredientType;
  final Value<DateTime> syncDate;
  const IngredientsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.ingredientType = const Value.absent(),
    this.syncDate = const Value.absent(),
  });
  IngredientsCompanion.insert({
    this.id = const Value.absent(),
    @required String name,
    @required String ingredientType,
    this.syncDate = const Value.absent(),
  })  : name = Value(name),
        ingredientType = Value(ingredientType);
  IngredientsCompanion copyWith(
      {Value<int> id,
      Value<String> name,
      Value<String> ingredientType,
      Value<DateTime> syncDate}) {
    return IngredientsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      ingredientType: ingredientType ?? this.ingredientType,
      syncDate: syncDate ?? this.syncDate,
    );
  }
}

class $IngredientsTable extends Ingredients
    with TableInfo<$IngredientsTable, Ingredient> {
  final GeneratedDatabase _db;
  final String _alias;
  $IngredientsTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedIntColumn _id;
  @override
  GeneratedIntColumn get id => _id ??= _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('id', $tableName, false,
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
  }

  final VerificationMeta _nameMeta = const VerificationMeta('name');
  GeneratedTextColumn _name;
  @override
  GeneratedTextColumn get name => _name ??= _constructName();
  GeneratedTextColumn _constructName() {
    return GeneratedTextColumn('name', $tableName, false,
        minTextLength: 1, maxTextLength: 70);
  }

  final VerificationMeta _ingredientTypeMeta =
      const VerificationMeta('ingredientType');
  GeneratedTextColumn _ingredientType;
  @override
  GeneratedTextColumn get ingredientType =>
      _ingredientType ??= _constructIngredientType();
  GeneratedTextColumn _constructIngredientType() {
    return GeneratedTextColumn('ingredient_type', $tableName, false,
        minTextLength: 1,
        maxTextLength: 70,
        $customConstraints: 'REFERENCES ingredientTypes(name)');
  }

  final VerificationMeta _syncDateMeta = const VerificationMeta('syncDate');
  GeneratedDateTimeColumn _syncDate;
  @override
  GeneratedDateTimeColumn get syncDate => _syncDate ??= _constructSyncDate();
  GeneratedDateTimeColumn _constructSyncDate() {
    return GeneratedDateTimeColumn(
      'sync_date',
      $tableName,
      true,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [id, name, ingredientType, syncDate];
  @override
  $IngredientsTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'ingredients';
  @override
  final String actualTableName = 'ingredients';
  @override
  VerificationContext validateIntegrity(IngredientsCompanion d,
      {bool isInserting = false}) {
    final context = VerificationContext();
    if (d.id.present) {
      context.handle(_idMeta, id.isAcceptableValue(d.id.value, _idMeta));
    } else if (id.isRequired && isInserting) {
      context.missing(_idMeta);
    }
    if (d.name.present) {
      context.handle(
          _nameMeta, name.isAcceptableValue(d.name.value, _nameMeta));
    } else if (name.isRequired && isInserting) {
      context.missing(_nameMeta);
    }
    if (d.ingredientType.present) {
      context.handle(
          _ingredientTypeMeta,
          ingredientType.isAcceptableValue(
              d.ingredientType.value, _ingredientTypeMeta));
    } else if (ingredientType.isRequired && isInserting) {
      context.missing(_ingredientTypeMeta);
    }
    if (d.syncDate.present) {
      context.handle(_syncDateMeta,
          syncDate.isAcceptableValue(d.syncDate.value, _syncDateMeta));
    } else if (syncDate.isRequired && isInserting) {
      context.missing(_syncDateMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id, name};
  @override
  Ingredient map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return Ingredient.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  Map<String, Variable> entityToSql(IngredientsCompanion d) {
    final map = <String, Variable>{};
    if (d.id.present) {
      map['id'] = Variable<int, IntType>(d.id.value);
    }
    if (d.name.present) {
      map['name'] = Variable<String, StringType>(d.name.value);
    }
    if (d.ingredientType.present) {
      map['ingredient_type'] =
          Variable<String, StringType>(d.ingredientType.value);
    }
    if (d.syncDate.present) {
      map['sync_date'] = Variable<DateTime, DateTimeType>(d.syncDate.value);
    }
    return map;
  }

  @override
  $IngredientsTable createAlias(String alias) {
    return $IngredientsTable(_db, alias);
  }
}

class IngredientType extends DataClass implements Insertable<IngredientType> {
  final int id;
  final String name;
  final DateTime syncDate;
  IngredientType({@required this.id, @required this.name, this.syncDate});
  factory IngredientType.fromData(
      Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    final dateTimeType = db.typeSystem.forDartType<DateTime>();
    return IngredientType(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      name: stringType.mapFromDatabaseResponse(data['${effectivePrefix}name']),
      syncDate: dateTimeType
          .mapFromDatabaseResponse(data['${effectivePrefix}sync_date']),
    );
  }
  factory IngredientType.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return IngredientType(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      syncDate: serializer.fromJson<DateTime>(json['syncDate']),
    );
  }
  @override
  Map<String, dynamic> toJson(
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return {
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'syncDate': serializer.toJson<DateTime>(syncDate),
    };
  }

  @override
  IngredientTypesCompanion createCompanion(bool nullToAbsent) {
    return IngredientTypesCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
      syncDate: syncDate == null && nullToAbsent
          ? const Value.absent()
          : Value(syncDate),
    );
  }

  IngredientType copyWith({int id, String name, DateTime syncDate}) =>
      IngredientType(
        id: id ?? this.id,
        name: name ?? this.name,
        syncDate: syncDate ?? this.syncDate,
      );
  @override
  String toString() {
    return (StringBuffer('IngredientType(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('syncDate: $syncDate')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      $mrjf($mrjc(id.hashCode, $mrjc(name.hashCode, syncDate.hashCode)));
  @override
  bool operator ==(other) =>
      identical(this, other) ||
      (other is IngredientType &&
          other.id == this.id &&
          other.name == this.name &&
          other.syncDate == this.syncDate);
}

class IngredientTypesCompanion extends UpdateCompanion<IngredientType> {
  final Value<int> id;
  final Value<String> name;
  final Value<DateTime> syncDate;
  const IngredientTypesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.syncDate = const Value.absent(),
  });
  IngredientTypesCompanion.insert({
    this.id = const Value.absent(),
    @required String name,
    this.syncDate = const Value.absent(),
  }) : name = Value(name);
  IngredientTypesCompanion copyWith(
      {Value<int> id, Value<String> name, Value<DateTime> syncDate}) {
    return IngredientTypesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      syncDate: syncDate ?? this.syncDate,
    );
  }
}

class $IngredientTypesTable extends IngredientTypes
    with TableInfo<$IngredientTypesTable, IngredientType> {
  final GeneratedDatabase _db;
  final String _alias;
  $IngredientTypesTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedIntColumn _id;
  @override
  GeneratedIntColumn get id => _id ??= _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('id', $tableName, false,
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
  }

  final VerificationMeta _nameMeta = const VerificationMeta('name');
  GeneratedTextColumn _name;
  @override
  GeneratedTextColumn get name => _name ??= _constructName();
  GeneratedTextColumn _constructName() {
    return GeneratedTextColumn('name', $tableName, false,
        minTextLength: 1, maxTextLength: 70);
  }

  final VerificationMeta _syncDateMeta = const VerificationMeta('syncDate');
  GeneratedDateTimeColumn _syncDate;
  @override
  GeneratedDateTimeColumn get syncDate => _syncDate ??= _constructSyncDate();
  GeneratedDateTimeColumn _constructSyncDate() {
    return GeneratedDateTimeColumn(
      'sync_date',
      $tableName,
      true,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [id, name, syncDate];
  @override
  $IngredientTypesTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'ingredient_types';
  @override
  final String actualTableName = 'ingredient_types';
  @override
  VerificationContext validateIntegrity(IngredientTypesCompanion d,
      {bool isInserting = false}) {
    final context = VerificationContext();
    if (d.id.present) {
      context.handle(_idMeta, id.isAcceptableValue(d.id.value, _idMeta));
    } else if (id.isRequired && isInserting) {
      context.missing(_idMeta);
    }
    if (d.name.present) {
      context.handle(
          _nameMeta, name.isAcceptableValue(d.name.value, _nameMeta));
    } else if (name.isRequired && isInserting) {
      context.missing(_nameMeta);
    }
    if (d.syncDate.present) {
      context.handle(_syncDateMeta,
          syncDate.isAcceptableValue(d.syncDate.value, _syncDateMeta));
    } else if (syncDate.isRequired && isInserting) {
      context.missing(_syncDateMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id, name};
  @override
  IngredientType map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return IngredientType.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  Map<String, Variable> entityToSql(IngredientTypesCompanion d) {
    final map = <String, Variable>{};
    if (d.id.present) {
      map['id'] = Variable<int, IntType>(d.id.value);
    }
    if (d.name.present) {
      map['name'] = Variable<String, StringType>(d.name.value);
    }
    if (d.syncDate.present) {
      map['sync_date'] = Variable<DateTime, DateTimeType>(d.syncDate.value);
    }
    return map;
  }

  @override
  $IngredientTypesTable createAlias(String alias) {
    return $IngredientTypesTable(_db, alias);
  }
}

class RecipeType extends DataClass implements Insertable<RecipeType> {
  final int id;
  final String name;
  final DateTime syncDate;
  RecipeType({@required this.id, @required this.name, this.syncDate});
  factory RecipeType.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    final dateTimeType = db.typeSystem.forDartType<DateTime>();
    return RecipeType(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      name: stringType.mapFromDatabaseResponse(data['${effectivePrefix}name']),
      syncDate: dateTimeType
          .mapFromDatabaseResponse(data['${effectivePrefix}sync_date']),
    );
  }
  factory RecipeType.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return RecipeType(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      syncDate: serializer.fromJson<DateTime>(json['syncDate']),
    );
  }
  @override
  Map<String, dynamic> toJson(
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return {
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'syncDate': serializer.toJson<DateTime>(syncDate),
    };
  }

  @override
  RecipeTypesCompanion createCompanion(bool nullToAbsent) {
    return RecipeTypesCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
      syncDate: syncDate == null && nullToAbsent
          ? const Value.absent()
          : Value(syncDate),
    );
  }

  RecipeType copyWith({int id, String name, DateTime syncDate}) => RecipeType(
        id: id ?? this.id,
        name: name ?? this.name,
        syncDate: syncDate ?? this.syncDate,
      );
  @override
  String toString() {
    return (StringBuffer('RecipeType(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('syncDate: $syncDate')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      $mrjf($mrjc(id.hashCode, $mrjc(name.hashCode, syncDate.hashCode)));
  @override
  bool operator ==(other) =>
      identical(this, other) ||
      (other is RecipeType &&
          other.id == this.id &&
          other.name == this.name &&
          other.syncDate == this.syncDate);
}

class RecipeTypesCompanion extends UpdateCompanion<RecipeType> {
  final Value<int> id;
  final Value<String> name;
  final Value<DateTime> syncDate;
  const RecipeTypesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.syncDate = const Value.absent(),
  });
  RecipeTypesCompanion.insert({
    this.id = const Value.absent(),
    @required String name,
    this.syncDate = const Value.absent(),
  }) : name = Value(name);
  RecipeTypesCompanion copyWith(
      {Value<int> id, Value<String> name, Value<DateTime> syncDate}) {
    return RecipeTypesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      syncDate: syncDate ?? this.syncDate,
    );
  }
}

class $RecipeTypesTable extends RecipeTypes
    with TableInfo<$RecipeTypesTable, RecipeType> {
  final GeneratedDatabase _db;
  final String _alias;
  $RecipeTypesTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedIntColumn _id;
  @override
  GeneratedIntColumn get id => _id ??= _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('id', $tableName, false,
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
  }

  final VerificationMeta _nameMeta = const VerificationMeta('name');
  GeneratedTextColumn _name;
  @override
  GeneratedTextColumn get name => _name ??= _constructName();
  GeneratedTextColumn _constructName() {
    return GeneratedTextColumn('name', $tableName, false,
        minTextLength: 1, maxTextLength: 70);
  }

  final VerificationMeta _syncDateMeta = const VerificationMeta('syncDate');
  GeneratedDateTimeColumn _syncDate;
  @override
  GeneratedDateTimeColumn get syncDate => _syncDate ??= _constructSyncDate();
  GeneratedDateTimeColumn _constructSyncDate() {
    return GeneratedDateTimeColumn(
      'sync_date',
      $tableName,
      true,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [id, name, syncDate];
  @override
  $RecipeTypesTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'recipe_types';
  @override
  final String actualTableName = 'recipe_types';
  @override
  VerificationContext validateIntegrity(RecipeTypesCompanion d,
      {bool isInserting = false}) {
    final context = VerificationContext();
    if (d.id.present) {
      context.handle(_idMeta, id.isAcceptableValue(d.id.value, _idMeta));
    } else if (id.isRequired && isInserting) {
      context.missing(_idMeta);
    }
    if (d.name.present) {
      context.handle(
          _nameMeta, name.isAcceptableValue(d.name.value, _nameMeta));
    } else if (name.isRequired && isInserting) {
      context.missing(_nameMeta);
    }
    if (d.syncDate.present) {
      context.handle(_syncDateMeta,
          syncDate.isAcceptableValue(d.syncDate.value, _syncDateMeta));
    } else if (syncDate.isRequired && isInserting) {
      context.missing(_syncDateMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id, name};
  @override
  RecipeType map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return RecipeType.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  Map<String, Variable> entityToSql(RecipeTypesCompanion d) {
    final map = <String, Variable>{};
    if (d.id.present) {
      map['id'] = Variable<int, IntType>(d.id.value);
    }
    if (d.name.present) {
      map['name'] = Variable<String, StringType>(d.name.value);
    }
    if (d.syncDate.present) {
      map['sync_date'] = Variable<DateTime, DateTimeType>(d.syncDate.value);
    }
    return map;
  }

  @override
  $RecipeTypesTable createAlias(String alias) {
    return $RecipeTypesTable(_db, alias);
  }
}

class IngredientAmount extends DataClass
    implements Insertable<IngredientAmount> {
  final int id;
  final String ingredientName;
  final String recipeTitle;
  final int amount;
  final String amountUnit;
  final DateTime syncDate;
  IngredientAmount(
      {@required this.id,
      @required this.ingredientName,
      @required this.recipeTitle,
      @required this.amount,
      @required this.amountUnit,
      this.syncDate});
  factory IngredientAmount.fromData(
      Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    final dateTimeType = db.typeSystem.forDartType<DateTime>();
    return IngredientAmount(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      ingredientName: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}ingredient_name']),
      recipeTitle: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}recipe_title']),
      amount: intType.mapFromDatabaseResponse(data['${effectivePrefix}amount']),
      amountUnit: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}amount_unit']),
      syncDate: dateTimeType
          .mapFromDatabaseResponse(data['${effectivePrefix}sync_date']),
    );
  }
  factory IngredientAmount.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return IngredientAmount(
      id: serializer.fromJson<int>(json['id']),
      ingredientName: serializer.fromJson<String>(json['ingredientName']),
      recipeTitle: serializer.fromJson<String>(json['recipeTitle']),
      amount: serializer.fromJson<int>(json['amount']),
      amountUnit: serializer.fromJson<String>(json['amountUnit']),
      syncDate: serializer.fromJson<DateTime>(json['syncDate']),
    );
  }
  @override
  Map<String, dynamic> toJson(
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return {
      'id': serializer.toJson<int>(id),
      'ingredientName': serializer.toJson<String>(ingredientName),
      'recipeTitle': serializer.toJson<String>(recipeTitle),
      'amount': serializer.toJson<int>(amount),
      'amountUnit': serializer.toJson<String>(amountUnit),
      'syncDate': serializer.toJson<DateTime>(syncDate),
    };
  }

  @override
  IngredientAmountsCompanion createCompanion(bool nullToAbsent) {
    return IngredientAmountsCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      ingredientName: ingredientName == null && nullToAbsent
          ? const Value.absent()
          : Value(ingredientName),
      recipeTitle: recipeTitle == null && nullToAbsent
          ? const Value.absent()
          : Value(recipeTitle),
      amount:
          amount == null && nullToAbsent ? const Value.absent() : Value(amount),
      amountUnit: amountUnit == null && nullToAbsent
          ? const Value.absent()
          : Value(amountUnit),
      syncDate: syncDate == null && nullToAbsent
          ? const Value.absent()
          : Value(syncDate),
    );
  }

  IngredientAmount copyWith(
          {int id,
          String ingredientName,
          String recipeTitle,
          int amount,
          String amountUnit,
          DateTime syncDate}) =>
      IngredientAmount(
        id: id ?? this.id,
        ingredientName: ingredientName ?? this.ingredientName,
        recipeTitle: recipeTitle ?? this.recipeTitle,
        amount: amount ?? this.amount,
        amountUnit: amountUnit ?? this.amountUnit,
        syncDate: syncDate ?? this.syncDate,
      );
  @override
  String toString() {
    return (StringBuffer('IngredientAmount(')
          ..write('id: $id, ')
          ..write('ingredientName: $ingredientName, ')
          ..write('recipeTitle: $recipeTitle, ')
          ..write('amount: $amount, ')
          ..write('amountUnit: $amountUnit, ')
          ..write('syncDate: $syncDate')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(
          ingredientName.hashCode,
          $mrjc(
              recipeTitle.hashCode,
              $mrjc(amount.hashCode,
                  $mrjc(amountUnit.hashCode, syncDate.hashCode))))));
  @override
  bool operator ==(other) =>
      identical(this, other) ||
      (other is IngredientAmount &&
          other.id == this.id &&
          other.ingredientName == this.ingredientName &&
          other.recipeTitle == this.recipeTitle &&
          other.amount == this.amount &&
          other.amountUnit == this.amountUnit &&
          other.syncDate == this.syncDate);
}

class IngredientAmountsCompanion extends UpdateCompanion<IngredientAmount> {
  final Value<int> id;
  final Value<String> ingredientName;
  final Value<String> recipeTitle;
  final Value<int> amount;
  final Value<String> amountUnit;
  final Value<DateTime> syncDate;
  const IngredientAmountsCompanion({
    this.id = const Value.absent(),
    this.ingredientName = const Value.absent(),
    this.recipeTitle = const Value.absent(),
    this.amount = const Value.absent(),
    this.amountUnit = const Value.absent(),
    this.syncDate = const Value.absent(),
  });
  IngredientAmountsCompanion.insert({
    this.id = const Value.absent(),
    @required String ingredientName,
    @required String recipeTitle,
    @required int amount,
    @required String amountUnit,
    this.syncDate = const Value.absent(),
  })  : ingredientName = Value(ingredientName),
        recipeTitle = Value(recipeTitle),
        amount = Value(amount),
        amountUnit = Value(amountUnit);
  IngredientAmountsCompanion copyWith(
      {Value<int> id,
      Value<String> ingredientName,
      Value<String> recipeTitle,
      Value<int> amount,
      Value<String> amountUnit,
      Value<DateTime> syncDate}) {
    return IngredientAmountsCompanion(
      id: id ?? this.id,
      ingredientName: ingredientName ?? this.ingredientName,
      recipeTitle: recipeTitle ?? this.recipeTitle,
      amount: amount ?? this.amount,
      amountUnit: amountUnit ?? this.amountUnit,
      syncDate: syncDate ?? this.syncDate,
    );
  }
}

class $IngredientAmountsTable extends IngredientAmounts
    with TableInfo<$IngredientAmountsTable, IngredientAmount> {
  final GeneratedDatabase _db;
  final String _alias;
  $IngredientAmountsTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedIntColumn _id;
  @override
  GeneratedIntColumn get id => _id ??= _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('id', $tableName, false,
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
  }

  final VerificationMeta _ingredientNameMeta =
      const VerificationMeta('ingredientName');
  GeneratedTextColumn _ingredientName;
  @override
  GeneratedTextColumn get ingredientName =>
      _ingredientName ??= _constructIngredientName();
  GeneratedTextColumn _constructIngredientName() {
    return GeneratedTextColumn('ingredient_name', $tableName, false,
        minTextLength: 1,
        maxTextLength: 70,
        $customConstraints: 'REFERENCES ingredients(name)');
  }

  final VerificationMeta _recipeTitleMeta =
      const VerificationMeta('recipeTitle');
  GeneratedTextColumn _recipeTitle;
  @override
  GeneratedTextColumn get recipeTitle =>
      _recipeTitle ??= _constructRecipeTitle();
  GeneratedTextColumn _constructRecipeTitle() {
    return GeneratedTextColumn('recipe_title', $tableName, false,
        minTextLength: 1,
        maxTextLength: 70,
        $customConstraints: 'REFERENCES recipes(title)');
  }

  final VerificationMeta _amountMeta = const VerificationMeta('amount');
  GeneratedIntColumn _amount;
  @override
  GeneratedIntColumn get amount => _amount ??= _constructAmount();
  GeneratedIntColumn _constructAmount() {
    return GeneratedIntColumn(
      'amount',
      $tableName,
      false,
    );
  }

  final VerificationMeta _amountUnitMeta = const VerificationMeta('amountUnit');
  GeneratedTextColumn _amountUnit;
  @override
  GeneratedTextColumn get amountUnit => _amountUnit ??= _constructAmountUnit();
  GeneratedTextColumn _constructAmountUnit() {
    return GeneratedTextColumn('amount_unit', $tableName, false,
        minTextLength: 1, maxTextLength: 20);
  }

  final VerificationMeta _syncDateMeta = const VerificationMeta('syncDate');
  GeneratedDateTimeColumn _syncDate;
  @override
  GeneratedDateTimeColumn get syncDate => _syncDate ??= _constructSyncDate();
  GeneratedDateTimeColumn _constructSyncDate() {
    return GeneratedDateTimeColumn(
      'sync_date',
      $tableName,
      true,
    );
  }

  @override
  List<GeneratedColumn> get $columns =>
      [id, ingredientName, recipeTitle, amount, amountUnit, syncDate];
  @override
  $IngredientAmountsTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'ingredient_amounts';
  @override
  final String actualTableName = 'ingredient_amounts';
  @override
  VerificationContext validateIntegrity(IngredientAmountsCompanion d,
      {bool isInserting = false}) {
    final context = VerificationContext();
    if (d.id.present) {
      context.handle(_idMeta, id.isAcceptableValue(d.id.value, _idMeta));
    } else if (id.isRequired && isInserting) {
      context.missing(_idMeta);
    }
    if (d.ingredientName.present) {
      context.handle(
          _ingredientNameMeta,
          ingredientName.isAcceptableValue(
              d.ingredientName.value, _ingredientNameMeta));
    } else if (ingredientName.isRequired && isInserting) {
      context.missing(_ingredientNameMeta);
    }
    if (d.recipeTitle.present) {
      context.handle(_recipeTitleMeta,
          recipeTitle.isAcceptableValue(d.recipeTitle.value, _recipeTitleMeta));
    } else if (recipeTitle.isRequired && isInserting) {
      context.missing(_recipeTitleMeta);
    }
    if (d.amount.present) {
      context.handle(
          _amountMeta, amount.isAcceptableValue(d.amount.value, _amountMeta));
    } else if (amount.isRequired && isInserting) {
      context.missing(_amountMeta);
    }
    if (d.amountUnit.present) {
      context.handle(_amountUnitMeta,
          amountUnit.isAcceptableValue(d.amountUnit.value, _amountUnitMeta));
    } else if (amountUnit.isRequired && isInserting) {
      context.missing(_amountUnitMeta);
    }
    if (d.syncDate.present) {
      context.handle(_syncDateMeta,
          syncDate.isAcceptableValue(d.syncDate.value, _syncDateMeta));
    } else if (syncDate.isRequired && isInserting) {
      context.missing(_syncDateMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  IngredientAmount map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return IngredientAmount.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  Map<String, Variable> entityToSql(IngredientAmountsCompanion d) {
    final map = <String, Variable>{};
    if (d.id.present) {
      map['id'] = Variable<int, IntType>(d.id.value);
    }
    if (d.ingredientName.present) {
      map['ingredient_name'] =
          Variable<String, StringType>(d.ingredientName.value);
    }
    if (d.recipeTitle.present) {
      map['recipe_title'] = Variable<String, StringType>(d.recipeTitle.value);
    }
    if (d.amount.present) {
      map['amount'] = Variable<int, IntType>(d.amount.value);
    }
    if (d.amountUnit.present) {
      map['amount_unit'] = Variable<String, StringType>(d.amountUnit.value);
    }
    if (d.syncDate.present) {
      map['sync_date'] = Variable<DateTime, DateTimeType>(d.syncDate.value);
    }
    return map;
  }

  @override
  $IngredientAmountsTable createAlias(String alias) {
    return $IngredientAmountsTable(_db, alias);
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  $RecipesTable _recipes;
  $RecipesTable get recipes => _recipes ??= $RecipesTable(this);
  $RecipeIdsTable _recipeIds;
  $RecipeIdsTable get recipeIds => _recipeIds ??= $RecipeIdsTable(this);
  $IngredientsTable _ingredients;
  $IngredientsTable get ingredients => _ingredients ??= $IngredientsTable(this);
  $IngredientTypesTable _ingredientTypes;
  $IngredientTypesTable get ingredientTypes =>
      _ingredientTypes ??= $IngredientTypesTable(this);
  $RecipeTypesTable _recipeTypes;
  $RecipeTypesTable get recipeTypes => _recipeTypes ??= $RecipeTypesTable(this);
  $IngredientAmountsTable _ingredientAmounts;
  $IngredientAmountsTable get ingredientAmounts =>
      _ingredientAmounts ??= $IngredientAmountsTable(this);
  RecipeDao _recipeDao;
  RecipeDao get recipeDao => _recipeDao ??= RecipeDao(this as AppDatabase);
  RecipeIdDao _recipeIdDao;
  RecipeIdDao get recipeIdDao =>
      _recipeIdDao ??= RecipeIdDao(this as AppDatabase);
  IngredientDao _ingredientDao;
  IngredientDao get ingredientDao =>
      _ingredientDao ??= IngredientDao(this as AppDatabase);
  IngredientTypeDao _ingredientTypeDao;
  IngredientTypeDao get ingredientTypeDao =>
      _ingredientTypeDao ??= IngredientTypeDao(this as AppDatabase);
  RecipeTypeDao _recipeTypeDao;
  RecipeTypeDao get recipeTypeDao =>
      _recipeTypeDao ??= RecipeTypeDao(this as AppDatabase);
  IngredientAmountDao _ingredientAmountDao;
  IngredientAmountDao get ingredientAmountDao =>
      _ingredientAmountDao ??= IngredientAmountDao(this as AppDatabase);
  @override
  List<TableInfo> get allTables => [
        recipes,
        recipeIds,
        ingredients,
        ingredientTypes,
        recipeTypes,
        ingredientAmounts
      ];
}
