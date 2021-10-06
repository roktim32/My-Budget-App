// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: camel_case_types

import 'dart:typed_data';

import 'package:objectbox/flatbuffers/flat_buffers.dart' as fb;
import 'package:objectbox/internal.dart'; // generated code can access "internal" functionality
import 'package:objectbox/objectbox.dart';
import 'package:objectbox_flutter_libs/objectbox_flutter_libs.dart';

import 'models/category_model.dart';
import 'models/expense_model.dart';

export 'package:objectbox/objectbox.dart'; // so that callers only have to import this file

final _entities = <ModelEntity>[
  ModelEntity(
      id: const IdUid(1, 3658129585401553738),
      name: 'Expense',
      lastPropertyId: const IdUid(5, 4381740189502859182),
      flags: 0,
      properties: <ModelProperty>[
        ModelProperty(
            id: const IdUid(1, 2614013803659503840),
            name: 'id',
            type: 6,
            flags: 1),
        ModelProperty(
            id: const IdUid(2, 3924798840126354823),
            name: 'name',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(3, 910435364459056429),
            name: 'cost',
            type: 8,
            flags: 0),
        ModelProperty(
            id: const IdUid(4, 2775245476718522859),
            name: 'dateTime',
            type: 10,
            flags: 0),
        ModelProperty(
            id: const IdUid(5, 4381740189502859182),
            name: 'categoryId',
            type: 11,
            flags: 520,
            indexId: const IdUid(1, 6989280812313410658),
            relationTarget: 'Category')
      ],
      relations: <ModelRelation>[],
      backlinks: <ModelBacklink>[]),
  ModelEntity(
      id: const IdUid(2, 560964384694149390),
      name: 'Category',
      lastPropertyId: const IdUid(3, 7210705644682472937),
      flags: 0,
      properties: <ModelProperty>[
        ModelProperty(
            id: const IdUid(1, 2746575537484937484),
            name: 'id',
            type: 6,
            flags: 1),
        ModelProperty(
            id: const IdUid(2, 648064715966854462),
            name: 'name',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(3, 7210705644682472937),
            name: 'maxAmount',
            type: 8,
            flags: 0)
      ],
      relations: <ModelRelation>[],
      backlinks: <ModelBacklink>[
        ModelBacklink(name: 'expenses', srcEntity: 'Expense', srcField: '')
      ])
];

/// Open an ObjectBox store with the model declared in this file.
Future<Store> openStore(
        {String? directory,
        int? maxDBSizeInKB,
        int? fileMode,
        int? maxReaders,
        bool queriesCaseSensitiveDefault = true,
        String? macosApplicationGroup}) async =>
    Store(getObjectBoxModel(),
        directory: directory ?? (await defaultStoreDirectory()).path,
        maxDBSizeInKB: maxDBSizeInKB,
        fileMode: fileMode,
        maxReaders: maxReaders,
        queriesCaseSensitiveDefault: queriesCaseSensitiveDefault,
        macosApplicationGroup: macosApplicationGroup);

/// ObjectBox model definition, pass it to [Store] - Store(getObjectBoxModel())
ModelDefinition getObjectBoxModel() {
  final model = ModelInfo(
      entities: _entities,
      lastEntityId: const IdUid(2, 560964384694149390),
      lastIndexId: const IdUid(1, 6989280812313410658),
      lastRelationId: const IdUid(0, 0),
      lastSequenceId: const IdUid(0, 0),
      retiredEntityUids: const [],
      retiredIndexUids: const [],
      retiredPropertyUids: const [],
      retiredRelationUids: const [],
      modelVersion: 5,
      modelVersionParserMinimum: 5,
      version: 1);

  final bindings = <Type, EntityDefinition>{
    Expense: EntityDefinition<Expense>(
        model: _entities[0],
        toOneRelations: (Expense object) => [object.category],
        toManyRelations: (Expense object) => {},
        getId: (Expense object) => object.id,
        setId: (Expense object, int id) {
          object.id = id;
        },
        objectToFB: (Expense object, fb.Builder fbb) {
          final nameOffset = fbb.writeString(object.name);
          fbb.startTable(6);
          fbb.addInt64(0, object.id);
          fbb.addOffset(1, nameOffset);
          fbb.addFloat64(2, object.cost);
          fbb.addInt64(3, object.dateTime.millisecondsSinceEpoch);
          fbb.addInt64(4, object.category.targetId);
          fbb.finish(fbb.endTable());
          return object.id;
        },
        objectFromFB: (Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);

          final object = Expense(
              name:
                  const fb.StringReader().vTableGet(buffer, rootOffset, 6, ''),
              cost:
                  const fb.Float64Reader().vTableGet(buffer, rootOffset, 8, 0),
              dateTime: DateTime.fromMillisecondsSinceEpoch(
                  const fb.Int64Reader().vTableGet(buffer, rootOffset, 10, 0)))
            ..id = const fb.Int64Reader().vTableGet(buffer, rootOffset, 4, 0);
          object.category.targetId =
              const fb.Int64Reader().vTableGet(buffer, rootOffset, 12, 0);
          object.category.attach(store);
          return object;
        }),
    Category: EntityDefinition<Category>(
        model: _entities[1],
        toOneRelations: (Category object) => [],
        toManyRelations: (Category object) => {
              RelInfo<Expense>.toOneBacklink(
                      5, object.id, (Expense srcObject) => srcObject.category):
                  object.expenses
            },
        getId: (Category object) => object.id,
        setId: (Category object, int id) {
          object.id = id;
        },
        objectToFB: (Category object, fb.Builder fbb) {
          final nameOffset = fbb.writeString(object.name);
          fbb.startTable(4);
          fbb.addInt64(0, object.id);
          fbb.addOffset(1, nameOffset);
          fbb.addFloat64(2, object.maxAmount);
          fbb.finish(fbb.endTable());
          return object.id;
        },
        objectFromFB: (Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);

          final object = Category(
              name:
                  const fb.StringReader().vTableGet(buffer, rootOffset, 6, ''),
              maxAmount:
                  const fb.Float64Reader().vTableGet(buffer, rootOffset, 8, 0))
            ..id = const fb.Int64Reader().vTableGet(buffer, rootOffset, 4, 0);
          InternalToManyAccess.setRelInfo(
              object.expenses,
              store,
              RelInfo<Expense>.toOneBacklink(
                  5, object.id, (Expense srcObject) => srcObject.category),
              store.box<Category>());
          return object;
        })
  };

  return ModelDefinition(model, bindings);
}

/// [Expense] entity fields to define ObjectBox queries.
class Expense_ {
  /// see [Expense.id]
  static final id = QueryIntegerProperty<Expense>(_entities[0].properties[0]);

  /// see [Expense.name]
  static final name = QueryStringProperty<Expense>(_entities[0].properties[1]);

  /// see [Expense.cost]
  static final cost = QueryDoubleProperty<Expense>(_entities[0].properties[2]);

  /// see [Expense.dateTime]
  static final dateTime =
      QueryIntegerProperty<Expense>(_entities[0].properties[3]);

  /// see [Expense.category]
  static final category =
      QueryRelationToOne<Expense, Category>(_entities[0].properties[4]);
}

/// [Category] entity fields to define ObjectBox queries.
class Category_ {
  /// see [Category.id]
  static final id = QueryIntegerProperty<Category>(_entities[1].properties[0]);

  /// see [Category.name]
  static final name = QueryStringProperty<Category>(_entities[1].properties[1]);

  /// see [Category.maxAmount]
  static final maxAmount =
      QueryDoubleProperty<Category>(_entities[1].properties[2]);
}
