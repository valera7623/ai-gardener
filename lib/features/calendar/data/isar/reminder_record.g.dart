// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reminder_record.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types, experimental_member_use

extension GetReminderRecordCollection on Isar {
  IsarCollection<ReminderRecord> get reminderRecords => this.collection();
}

const ReminderRecordSchema = CollectionSchema(
  name: r'ReminderRecord',
  id: -2844910318522388638,
  properties: {
    r'enabled': PropertySchema(id: 0, name: r'enabled', type: IsarType.bool),
    r'notificationId': PropertySchema(
      id: 1,
      name: r'notificationId',
      type: IsarType.long,
    ),
    r'scheduledFor': PropertySchema(
      id: 2,
      name: r'scheduledFor',
      type: IsarType.dateTime,
    ),
    r'taskId': PropertySchema(id: 3, name: r'taskId', type: IsarType.string),
  },

  estimateSize: _reminderRecordEstimateSize,
  serialize: _reminderRecordSerialize,
  deserialize: _reminderRecordDeserialize,
  deserializeProp: _reminderRecordDeserializeProp,
  idName: r'id',
  indexes: {
    r'taskId': IndexSchema(
      id: -6391211041487498726,
      name: r'taskId',
      unique: true,
      replace: true,
      properties: [
        IndexPropertySchema(
          name: r'taskId',
          type: IndexType.hash,
          caseSensitive: true,
        ),
      ],
    ),
  },
  links: {},
  embeddedSchemas: {},

  getId: _reminderRecordGetId,
  getLinks: _reminderRecordGetLinks,
  attach: _reminderRecordAttach,
  version: '3.4.1',
);

int _reminderRecordEstimateSize(
  ReminderRecord object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.taskId.length * 3;
  return bytesCount;
}

void _reminderRecordSerialize(
  ReminderRecord object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeBool(offsets[0], object.enabled);
  writer.writeLong(offsets[1], object.notificationId);
  writer.writeDateTime(offsets[2], object.scheduledFor);
  writer.writeString(offsets[3], object.taskId);
}

ReminderRecord _reminderRecordDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = ReminderRecord();
  object.enabled = reader.readBool(offsets[0]);
  object.id = id;
  object.notificationId = reader.readLong(offsets[1]);
  object.scheduledFor = reader.readDateTime(offsets[2]);
  object.taskId = reader.readString(offsets[3]);
  return object;
}

P _reminderRecordDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readBool(offset)) as P;
    case 1:
      return (reader.readLong(offset)) as P;
    case 2:
      return (reader.readDateTime(offset)) as P;
    case 3:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _reminderRecordGetId(ReminderRecord object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _reminderRecordGetLinks(ReminderRecord object) {
  return [];
}

void _reminderRecordAttach(
  IsarCollection<dynamic> col,
  Id id,
  ReminderRecord object,
) {
  object.id = id;
}

extension ReminderRecordByIndex on IsarCollection<ReminderRecord> {
  Future<ReminderRecord?> getByTaskId(String taskId) {
    return getByIndex(r'taskId', [taskId]);
  }

  ReminderRecord? getByTaskIdSync(String taskId) {
    return getByIndexSync(r'taskId', [taskId]);
  }

  Future<bool> deleteByTaskId(String taskId) {
    return deleteByIndex(r'taskId', [taskId]);
  }

  bool deleteByTaskIdSync(String taskId) {
    return deleteByIndexSync(r'taskId', [taskId]);
  }

  Future<List<ReminderRecord?>> getAllByTaskId(List<String> taskIdValues) {
    final values = taskIdValues.map((e) => [e]).toList();
    return getAllByIndex(r'taskId', values);
  }

  List<ReminderRecord?> getAllByTaskIdSync(List<String> taskIdValues) {
    final values = taskIdValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'taskId', values);
  }

  Future<int> deleteAllByTaskId(List<String> taskIdValues) {
    final values = taskIdValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'taskId', values);
  }

  int deleteAllByTaskIdSync(List<String> taskIdValues) {
    final values = taskIdValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'taskId', values);
  }

  Future<Id> putByTaskId(ReminderRecord object) {
    return putByIndex(r'taskId', object);
  }

  Id putByTaskIdSync(ReminderRecord object, {bool saveLinks = true}) {
    return putByIndexSync(r'taskId', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByTaskId(List<ReminderRecord> objects) {
    return putAllByIndex(r'taskId', objects);
  }

  List<Id> putAllByTaskIdSync(
    List<ReminderRecord> objects, {
    bool saveLinks = true,
  }) {
    return putAllByIndexSync(r'taskId', objects, saveLinks: saveLinks);
  }
}

extension ReminderRecordQueryWhereSort
    on QueryBuilder<ReminderRecord, ReminderRecord, QWhere> {
  QueryBuilder<ReminderRecord, ReminderRecord, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension ReminderRecordQueryWhere
    on QueryBuilder<ReminderRecord, ReminderRecord, QWhereClause> {
  QueryBuilder<ReminderRecord, ReminderRecord, QAfterWhereClause> idEqualTo(
    Id id,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(lower: id, upper: id));
    });
  }

  QueryBuilder<ReminderRecord, ReminderRecord, QAfterWhereClause> idNotEqualTo(
    Id id,
  ) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<ReminderRecord, ReminderRecord, QAfterWhereClause> idGreaterThan(
    Id id, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<ReminderRecord, ReminderRecord, QAfterWhereClause> idLessThan(
    Id id, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<ReminderRecord, ReminderRecord, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.between(
          lower: lowerId,
          includeLower: includeLower,
          upper: upperId,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<ReminderRecord, ReminderRecord, QAfterWhereClause> taskIdEqualTo(
    String taskId,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.equalTo(indexName: r'taskId', value: [taskId]),
      );
    });
  }

  QueryBuilder<ReminderRecord, ReminderRecord, QAfterWhereClause>
  taskIdNotEqualTo(String taskId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'taskId',
                lower: [],
                upper: [taskId],
                includeUpper: false,
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'taskId',
                lower: [taskId],
                includeLower: false,
                upper: [],
              ),
            );
      } else {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'taskId',
                lower: [taskId],
                includeLower: false,
                upper: [],
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'taskId',
                lower: [],
                upper: [taskId],
                includeUpper: false,
              ),
            );
      }
    });
  }
}

extension ReminderRecordQueryFilter
    on QueryBuilder<ReminderRecord, ReminderRecord, QFilterCondition> {
  QueryBuilder<ReminderRecord, ReminderRecord, QAfterFilterCondition>
  enabledEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'enabled', value: value),
      );
    });
  }

  QueryBuilder<ReminderRecord, ReminderRecord, QAfterFilterCondition> idEqualTo(
    Id value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'id', value: value),
      );
    });
  }

  QueryBuilder<ReminderRecord, ReminderRecord, QAfterFilterCondition>
  idGreaterThan(Id value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'id',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<ReminderRecord, ReminderRecord, QAfterFilterCondition>
  idLessThan(Id value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'id',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<ReminderRecord, ReminderRecord, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'id',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<ReminderRecord, ReminderRecord, QAfterFilterCondition>
  notificationIdEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'notificationId', value: value),
      );
    });
  }

  QueryBuilder<ReminderRecord, ReminderRecord, QAfterFilterCondition>
  notificationIdGreaterThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'notificationId',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<ReminderRecord, ReminderRecord, QAfterFilterCondition>
  notificationIdLessThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'notificationId',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<ReminderRecord, ReminderRecord, QAfterFilterCondition>
  notificationIdBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'notificationId',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<ReminderRecord, ReminderRecord, QAfterFilterCondition>
  scheduledForEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'scheduledFor', value: value),
      );
    });
  }

  QueryBuilder<ReminderRecord, ReminderRecord, QAfterFilterCondition>
  scheduledForGreaterThan(DateTime value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'scheduledFor',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<ReminderRecord, ReminderRecord, QAfterFilterCondition>
  scheduledForLessThan(DateTime value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'scheduledFor',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<ReminderRecord, ReminderRecord, QAfterFilterCondition>
  scheduledForBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'scheduledFor',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<ReminderRecord, ReminderRecord, QAfterFilterCondition>
  taskIdEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'taskId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ReminderRecord, ReminderRecord, QAfterFilterCondition>
  taskIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'taskId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ReminderRecord, ReminderRecord, QAfterFilterCondition>
  taskIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'taskId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ReminderRecord, ReminderRecord, QAfterFilterCondition>
  taskIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'taskId',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ReminderRecord, ReminderRecord, QAfterFilterCondition>
  taskIdStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'taskId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ReminderRecord, ReminderRecord, QAfterFilterCondition>
  taskIdEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'taskId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ReminderRecord, ReminderRecord, QAfterFilterCondition>
  taskIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'taskId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ReminderRecord, ReminderRecord, QAfterFilterCondition>
  taskIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'taskId',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ReminderRecord, ReminderRecord, QAfterFilterCondition>
  taskIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'taskId', value: ''),
      );
    });
  }

  QueryBuilder<ReminderRecord, ReminderRecord, QAfterFilterCondition>
  taskIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'taskId', value: ''),
      );
    });
  }
}

extension ReminderRecordQueryObject
    on QueryBuilder<ReminderRecord, ReminderRecord, QFilterCondition> {}

extension ReminderRecordQueryLinks
    on QueryBuilder<ReminderRecord, ReminderRecord, QFilterCondition> {}

extension ReminderRecordQuerySortBy
    on QueryBuilder<ReminderRecord, ReminderRecord, QSortBy> {
  QueryBuilder<ReminderRecord, ReminderRecord, QAfterSortBy> sortByEnabled() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'enabled', Sort.asc);
    });
  }

  QueryBuilder<ReminderRecord, ReminderRecord, QAfterSortBy>
  sortByEnabledDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'enabled', Sort.desc);
    });
  }

  QueryBuilder<ReminderRecord, ReminderRecord, QAfterSortBy>
  sortByNotificationId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notificationId', Sort.asc);
    });
  }

  QueryBuilder<ReminderRecord, ReminderRecord, QAfterSortBy>
  sortByNotificationIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notificationId', Sort.desc);
    });
  }

  QueryBuilder<ReminderRecord, ReminderRecord, QAfterSortBy>
  sortByScheduledFor() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'scheduledFor', Sort.asc);
    });
  }

  QueryBuilder<ReminderRecord, ReminderRecord, QAfterSortBy>
  sortByScheduledForDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'scheduledFor', Sort.desc);
    });
  }

  QueryBuilder<ReminderRecord, ReminderRecord, QAfterSortBy> sortByTaskId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'taskId', Sort.asc);
    });
  }

  QueryBuilder<ReminderRecord, ReminderRecord, QAfterSortBy>
  sortByTaskIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'taskId', Sort.desc);
    });
  }
}

extension ReminderRecordQuerySortThenBy
    on QueryBuilder<ReminderRecord, ReminderRecord, QSortThenBy> {
  QueryBuilder<ReminderRecord, ReminderRecord, QAfterSortBy> thenByEnabled() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'enabled', Sort.asc);
    });
  }

  QueryBuilder<ReminderRecord, ReminderRecord, QAfterSortBy>
  thenByEnabledDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'enabled', Sort.desc);
    });
  }

  QueryBuilder<ReminderRecord, ReminderRecord, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<ReminderRecord, ReminderRecord, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<ReminderRecord, ReminderRecord, QAfterSortBy>
  thenByNotificationId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notificationId', Sort.asc);
    });
  }

  QueryBuilder<ReminderRecord, ReminderRecord, QAfterSortBy>
  thenByNotificationIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notificationId', Sort.desc);
    });
  }

  QueryBuilder<ReminderRecord, ReminderRecord, QAfterSortBy>
  thenByScheduledFor() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'scheduledFor', Sort.asc);
    });
  }

  QueryBuilder<ReminderRecord, ReminderRecord, QAfterSortBy>
  thenByScheduledForDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'scheduledFor', Sort.desc);
    });
  }

  QueryBuilder<ReminderRecord, ReminderRecord, QAfterSortBy> thenByTaskId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'taskId', Sort.asc);
    });
  }

  QueryBuilder<ReminderRecord, ReminderRecord, QAfterSortBy>
  thenByTaskIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'taskId', Sort.desc);
    });
  }
}

extension ReminderRecordQueryWhereDistinct
    on QueryBuilder<ReminderRecord, ReminderRecord, QDistinct> {
  QueryBuilder<ReminderRecord, ReminderRecord, QDistinct> distinctByEnabled() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'enabled');
    });
  }

  QueryBuilder<ReminderRecord, ReminderRecord, QDistinct>
  distinctByNotificationId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'notificationId');
    });
  }

  QueryBuilder<ReminderRecord, ReminderRecord, QDistinct>
  distinctByScheduledFor() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'scheduledFor');
    });
  }

  QueryBuilder<ReminderRecord, ReminderRecord, QDistinct> distinctByTaskId({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'taskId', caseSensitive: caseSensitive);
    });
  }
}

extension ReminderRecordQueryProperty
    on QueryBuilder<ReminderRecord, ReminderRecord, QQueryProperty> {
  QueryBuilder<ReminderRecord, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<ReminderRecord, bool, QQueryOperations> enabledProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'enabled');
    });
  }

  QueryBuilder<ReminderRecord, int, QQueryOperations> notificationIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'notificationId');
    });
  }

  QueryBuilder<ReminderRecord, DateTime, QQueryOperations>
  scheduledForProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'scheduledFor');
    });
  }

  QueryBuilder<ReminderRecord, String, QQueryOperations> taskIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'taskId');
    });
  }
}
