// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recognition_record.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types, experimental_member_use

extension GetRecognitionRecordCollection on Isar {
  IsarCollection<RecognitionRecord> get recognitionRecords => this.collection();
}

const RecognitionRecordSchema = CollectionSchema(
  name: r'RecognitionRecord',
  id: 3815963420275888957,
  properties: {
    r'confidence': PropertySchema(
      id: 0,
      name: r'confidence',
      type: IsarType.double,
    ),
    r'createdAt': PropertySchema(
      id: 1,
      name: r'createdAt',
      type: IsarType.dateTime,
    ),
    r'imagePath': PropertySchema(
      id: 2,
      name: r'imagePath',
      type: IsarType.string,
    ),
    r'isDemo': PropertySchema(id: 3, name: r'isDemo', type: IsarType.bool),
    r'plantId': PropertySchema(id: 4, name: r'plantId', type: IsarType.string),
    r'recommendations': PropertySchema(
      id: 5,
      name: r'recommendations',
      type: IsarType.objectList,

      target: r'StoredRecommendation',
    ),
    r'resultId': PropertySchema(
      id: 6,
      name: r'resultId',
      type: IsarType.string,
    ),
    r'summary': PropertySchema(id: 7, name: r'summary', type: IsarType.string),
    r'title': PropertySchema(id: 8, name: r'title', type: IsarType.string),
  },

  estimateSize: _recognitionRecordEstimateSize,
  serialize: _recognitionRecordSerialize,
  deserialize: _recognitionRecordDeserialize,
  deserializeProp: _recognitionRecordDeserializeProp,
  idName: r'id',
  indexes: {
    r'resultId': IndexSchema(
      id: 1875462584315805120,
      name: r'resultId',
      unique: true,
      replace: true,
      properties: [
        IndexPropertySchema(
          name: r'resultId',
          type: IndexType.hash,
          caseSensitive: true,
        ),
      ],
    ),
    r'createdAt': IndexSchema(
      id: -3433535483987302584,
      name: r'createdAt',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'createdAt',
          type: IndexType.value,
          caseSensitive: false,
        ),
      ],
    ),
  },
  links: {},
  embeddedSchemas: {r'StoredRecommendation': StoredRecommendationSchema},

  getId: _recognitionRecordGetId,
  getLinks: _recognitionRecordGetLinks,
  attach: _recognitionRecordAttach,
  version: '3.4.1',
);

int _recognitionRecordEstimateSize(
  RecognitionRecord object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.imagePath;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.plantId;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.recommendations.length * 3;
  {
    final offsets = allOffsets[StoredRecommendation]!;
    for (var i = 0; i < object.recommendations.length; i++) {
      final value = object.recommendations[i];
      bytesCount += StoredRecommendationSchema.estimateSize(
        value,
        offsets,
        allOffsets,
      );
    }
  }
  bytesCount += 3 + object.resultId.length * 3;
  bytesCount += 3 + object.summary.length * 3;
  bytesCount += 3 + object.title.length * 3;
  return bytesCount;
}

void _recognitionRecordSerialize(
  RecognitionRecord object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDouble(offsets[0], object.confidence);
  writer.writeDateTime(offsets[1], object.createdAt);
  writer.writeString(offsets[2], object.imagePath);
  writer.writeBool(offsets[3], object.isDemo);
  writer.writeString(offsets[4], object.plantId);
  writer.writeObjectList<StoredRecommendation>(
    offsets[5],
    allOffsets,
    StoredRecommendationSchema.serialize,
    object.recommendations,
  );
  writer.writeString(offsets[6], object.resultId);
  writer.writeString(offsets[7], object.summary);
  writer.writeString(offsets[8], object.title);
}

RecognitionRecord _recognitionRecordDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = RecognitionRecord();
  object.confidence = reader.readDouble(offsets[0]);
  object.createdAt = reader.readDateTime(offsets[1]);
  object.id = id;
  object.imagePath = reader.readStringOrNull(offsets[2]);
  object.isDemo = reader.readBool(offsets[3]);
  object.plantId = reader.readStringOrNull(offsets[4]);
  object.recommendations =
      reader.readObjectList<StoredRecommendation>(
        offsets[5],
        StoredRecommendationSchema.deserialize,
        allOffsets,
        StoredRecommendation(),
      ) ??
      [];
  object.resultId = reader.readString(offsets[6]);
  object.summary = reader.readString(offsets[7]);
  object.title = reader.readString(offsets[8]);
  return object;
}

P _recognitionRecordDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDouble(offset)) as P;
    case 1:
      return (reader.readDateTime(offset)) as P;
    case 2:
      return (reader.readStringOrNull(offset)) as P;
    case 3:
      return (reader.readBool(offset)) as P;
    case 4:
      return (reader.readStringOrNull(offset)) as P;
    case 5:
      return (reader.readObjectList<StoredRecommendation>(
                offset,
                StoredRecommendationSchema.deserialize,
                allOffsets,
                StoredRecommendation(),
              ) ??
              [])
          as P;
    case 6:
      return (reader.readString(offset)) as P;
    case 7:
      return (reader.readString(offset)) as P;
    case 8:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _recognitionRecordGetId(RecognitionRecord object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _recognitionRecordGetLinks(
  RecognitionRecord object,
) {
  return [];
}

void _recognitionRecordAttach(
  IsarCollection<dynamic> col,
  Id id,
  RecognitionRecord object,
) {
  object.id = id;
}

extension RecognitionRecordByIndex on IsarCollection<RecognitionRecord> {
  Future<RecognitionRecord?> getByResultId(String resultId) {
    return getByIndex(r'resultId', [resultId]);
  }

  RecognitionRecord? getByResultIdSync(String resultId) {
    return getByIndexSync(r'resultId', [resultId]);
  }

  Future<bool> deleteByResultId(String resultId) {
    return deleteByIndex(r'resultId', [resultId]);
  }

  bool deleteByResultIdSync(String resultId) {
    return deleteByIndexSync(r'resultId', [resultId]);
  }

  Future<List<RecognitionRecord?>> getAllByResultId(
    List<String> resultIdValues,
  ) {
    final values = resultIdValues.map((e) => [e]).toList();
    return getAllByIndex(r'resultId', values);
  }

  List<RecognitionRecord?> getAllByResultIdSync(List<String> resultIdValues) {
    final values = resultIdValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'resultId', values);
  }

  Future<int> deleteAllByResultId(List<String> resultIdValues) {
    final values = resultIdValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'resultId', values);
  }

  int deleteAllByResultIdSync(List<String> resultIdValues) {
    final values = resultIdValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'resultId', values);
  }

  Future<Id> putByResultId(RecognitionRecord object) {
    return putByIndex(r'resultId', object);
  }

  Id putByResultIdSync(RecognitionRecord object, {bool saveLinks = true}) {
    return putByIndexSync(r'resultId', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByResultId(List<RecognitionRecord> objects) {
    return putAllByIndex(r'resultId', objects);
  }

  List<Id> putAllByResultIdSync(
    List<RecognitionRecord> objects, {
    bool saveLinks = true,
  }) {
    return putAllByIndexSync(r'resultId', objects, saveLinks: saveLinks);
  }
}

extension RecognitionRecordQueryWhereSort
    on QueryBuilder<RecognitionRecord, RecognitionRecord, QWhere> {
  QueryBuilder<RecognitionRecord, RecognitionRecord, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<RecognitionRecord, RecognitionRecord, QAfterWhere>
  anyCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'createdAt'),
      );
    });
  }
}

extension RecognitionRecordQueryWhere
    on QueryBuilder<RecognitionRecord, RecognitionRecord, QWhereClause> {
  QueryBuilder<RecognitionRecord, RecognitionRecord, QAfterWhereClause>
  idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(lower: id, upper: id));
    });
  }

  QueryBuilder<RecognitionRecord, RecognitionRecord, QAfterWhereClause>
  idNotEqualTo(Id id) {
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

  QueryBuilder<RecognitionRecord, RecognitionRecord, QAfterWhereClause>
  idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<RecognitionRecord, RecognitionRecord, QAfterWhereClause>
  idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<RecognitionRecord, RecognitionRecord, QAfterWhereClause>
  idBetween(
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

  QueryBuilder<RecognitionRecord, RecognitionRecord, QAfterWhereClause>
  resultIdEqualTo(String resultId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.equalTo(indexName: r'resultId', value: [resultId]),
      );
    });
  }

  QueryBuilder<RecognitionRecord, RecognitionRecord, QAfterWhereClause>
  resultIdNotEqualTo(String resultId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'resultId',
                lower: [],
                upper: [resultId],
                includeUpper: false,
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'resultId',
                lower: [resultId],
                includeLower: false,
                upper: [],
              ),
            );
      } else {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'resultId',
                lower: [resultId],
                includeLower: false,
                upper: [],
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'resultId',
                lower: [],
                upper: [resultId],
                includeUpper: false,
              ),
            );
      }
    });
  }

  QueryBuilder<RecognitionRecord, RecognitionRecord, QAfterWhereClause>
  createdAtEqualTo(DateTime createdAt) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.equalTo(indexName: r'createdAt', value: [createdAt]),
      );
    });
  }

  QueryBuilder<RecognitionRecord, RecognitionRecord, QAfterWhereClause>
  createdAtNotEqualTo(DateTime createdAt) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'createdAt',
                lower: [],
                upper: [createdAt],
                includeUpper: false,
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'createdAt',
                lower: [createdAt],
                includeLower: false,
                upper: [],
              ),
            );
      } else {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'createdAt',
                lower: [createdAt],
                includeLower: false,
                upper: [],
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'createdAt',
                lower: [],
                upper: [createdAt],
                includeUpper: false,
              ),
            );
      }
    });
  }

  QueryBuilder<RecognitionRecord, RecognitionRecord, QAfterWhereClause>
  createdAtGreaterThan(DateTime createdAt, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'createdAt',
          lower: [createdAt],
          includeLower: include,
          upper: [],
        ),
      );
    });
  }

  QueryBuilder<RecognitionRecord, RecognitionRecord, QAfterWhereClause>
  createdAtLessThan(DateTime createdAt, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'createdAt',
          lower: [],
          upper: [createdAt],
          includeUpper: include,
        ),
      );
    });
  }

  QueryBuilder<RecognitionRecord, RecognitionRecord, QAfterWhereClause>
  createdAtBetween(
    DateTime lowerCreatedAt,
    DateTime upperCreatedAt, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'createdAt',
          lower: [lowerCreatedAt],
          includeLower: includeLower,
          upper: [upperCreatedAt],
          includeUpper: includeUpper,
        ),
      );
    });
  }
}

extension RecognitionRecordQueryFilter
    on QueryBuilder<RecognitionRecord, RecognitionRecord, QFilterCondition> {
  QueryBuilder<RecognitionRecord, RecognitionRecord, QAfterFilterCondition>
  confidenceEqualTo(double value, {double epsilon = Query.epsilon}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'confidence',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<RecognitionRecord, RecognitionRecord, QAfterFilterCondition>
  confidenceGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'confidence',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<RecognitionRecord, RecognitionRecord, QAfterFilterCondition>
  confidenceLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'confidence',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<RecognitionRecord, RecognitionRecord, QAfterFilterCondition>
  confidenceBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'confidence',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<RecognitionRecord, RecognitionRecord, QAfterFilterCondition>
  createdAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'createdAt', value: value),
      );
    });
  }

  QueryBuilder<RecognitionRecord, RecognitionRecord, QAfterFilterCondition>
  createdAtGreaterThan(DateTime value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'createdAt',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<RecognitionRecord, RecognitionRecord, QAfterFilterCondition>
  createdAtLessThan(DateTime value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'createdAt',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<RecognitionRecord, RecognitionRecord, QAfterFilterCondition>
  createdAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'createdAt',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<RecognitionRecord, RecognitionRecord, QAfterFilterCondition>
  idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'id', value: value),
      );
    });
  }

  QueryBuilder<RecognitionRecord, RecognitionRecord, QAfterFilterCondition>
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

  QueryBuilder<RecognitionRecord, RecognitionRecord, QAfterFilterCondition>
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

  QueryBuilder<RecognitionRecord, RecognitionRecord, QAfterFilterCondition>
  idBetween(
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

  QueryBuilder<RecognitionRecord, RecognitionRecord, QAfterFilterCondition>
  imagePathIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'imagePath'),
      );
    });
  }

  QueryBuilder<RecognitionRecord, RecognitionRecord, QAfterFilterCondition>
  imagePathIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'imagePath'),
      );
    });
  }

  QueryBuilder<RecognitionRecord, RecognitionRecord, QAfterFilterCondition>
  imagePathEqualTo(String? value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'imagePath',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<RecognitionRecord, RecognitionRecord, QAfterFilterCondition>
  imagePathGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'imagePath',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<RecognitionRecord, RecognitionRecord, QAfterFilterCondition>
  imagePathLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'imagePath',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<RecognitionRecord, RecognitionRecord, QAfterFilterCondition>
  imagePathBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'imagePath',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<RecognitionRecord, RecognitionRecord, QAfterFilterCondition>
  imagePathStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'imagePath',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<RecognitionRecord, RecognitionRecord, QAfterFilterCondition>
  imagePathEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'imagePath',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<RecognitionRecord, RecognitionRecord, QAfterFilterCondition>
  imagePathContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'imagePath',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<RecognitionRecord, RecognitionRecord, QAfterFilterCondition>
  imagePathMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'imagePath',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<RecognitionRecord, RecognitionRecord, QAfterFilterCondition>
  imagePathIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'imagePath', value: ''),
      );
    });
  }

  QueryBuilder<RecognitionRecord, RecognitionRecord, QAfterFilterCondition>
  imagePathIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'imagePath', value: ''),
      );
    });
  }

  QueryBuilder<RecognitionRecord, RecognitionRecord, QAfterFilterCondition>
  isDemoEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'isDemo', value: value),
      );
    });
  }

  QueryBuilder<RecognitionRecord, RecognitionRecord, QAfterFilterCondition>
  plantIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'plantId'),
      );
    });
  }

  QueryBuilder<RecognitionRecord, RecognitionRecord, QAfterFilterCondition>
  plantIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'plantId'),
      );
    });
  }

  QueryBuilder<RecognitionRecord, RecognitionRecord, QAfterFilterCondition>
  plantIdEqualTo(String? value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'plantId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<RecognitionRecord, RecognitionRecord, QAfterFilterCondition>
  plantIdGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'plantId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<RecognitionRecord, RecognitionRecord, QAfterFilterCondition>
  plantIdLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'plantId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<RecognitionRecord, RecognitionRecord, QAfterFilterCondition>
  plantIdBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'plantId',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<RecognitionRecord, RecognitionRecord, QAfterFilterCondition>
  plantIdStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'plantId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<RecognitionRecord, RecognitionRecord, QAfterFilterCondition>
  plantIdEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'plantId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<RecognitionRecord, RecognitionRecord, QAfterFilterCondition>
  plantIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'plantId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<RecognitionRecord, RecognitionRecord, QAfterFilterCondition>
  plantIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'plantId',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<RecognitionRecord, RecognitionRecord, QAfterFilterCondition>
  plantIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'plantId', value: ''),
      );
    });
  }

  QueryBuilder<RecognitionRecord, RecognitionRecord, QAfterFilterCondition>
  plantIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'plantId', value: ''),
      );
    });
  }

  QueryBuilder<RecognitionRecord, RecognitionRecord, QAfterFilterCondition>
  recommendationsLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'recommendations', length, true, length, true);
    });
  }

  QueryBuilder<RecognitionRecord, RecognitionRecord, QAfterFilterCondition>
  recommendationsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'recommendations', 0, true, 0, true);
    });
  }

  QueryBuilder<RecognitionRecord, RecognitionRecord, QAfterFilterCondition>
  recommendationsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'recommendations', 0, false, 999999, true);
    });
  }

  QueryBuilder<RecognitionRecord, RecognitionRecord, QAfterFilterCondition>
  recommendationsLengthLessThan(int length, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'recommendations', 0, true, length, include);
    });
  }

  QueryBuilder<RecognitionRecord, RecognitionRecord, QAfterFilterCondition>
  recommendationsLengthGreaterThan(int length, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'recommendations',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<RecognitionRecord, RecognitionRecord, QAfterFilterCondition>
  recommendationsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'recommendations',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<RecognitionRecord, RecognitionRecord, QAfterFilterCondition>
  resultIdEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'resultId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<RecognitionRecord, RecognitionRecord, QAfterFilterCondition>
  resultIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'resultId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<RecognitionRecord, RecognitionRecord, QAfterFilterCondition>
  resultIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'resultId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<RecognitionRecord, RecognitionRecord, QAfterFilterCondition>
  resultIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'resultId',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<RecognitionRecord, RecognitionRecord, QAfterFilterCondition>
  resultIdStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'resultId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<RecognitionRecord, RecognitionRecord, QAfterFilterCondition>
  resultIdEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'resultId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<RecognitionRecord, RecognitionRecord, QAfterFilterCondition>
  resultIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'resultId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<RecognitionRecord, RecognitionRecord, QAfterFilterCondition>
  resultIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'resultId',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<RecognitionRecord, RecognitionRecord, QAfterFilterCondition>
  resultIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'resultId', value: ''),
      );
    });
  }

  QueryBuilder<RecognitionRecord, RecognitionRecord, QAfterFilterCondition>
  resultIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'resultId', value: ''),
      );
    });
  }

  QueryBuilder<RecognitionRecord, RecognitionRecord, QAfterFilterCondition>
  summaryEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'summary',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<RecognitionRecord, RecognitionRecord, QAfterFilterCondition>
  summaryGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'summary',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<RecognitionRecord, RecognitionRecord, QAfterFilterCondition>
  summaryLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'summary',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<RecognitionRecord, RecognitionRecord, QAfterFilterCondition>
  summaryBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'summary',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<RecognitionRecord, RecognitionRecord, QAfterFilterCondition>
  summaryStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'summary',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<RecognitionRecord, RecognitionRecord, QAfterFilterCondition>
  summaryEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'summary',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<RecognitionRecord, RecognitionRecord, QAfterFilterCondition>
  summaryContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'summary',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<RecognitionRecord, RecognitionRecord, QAfterFilterCondition>
  summaryMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'summary',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<RecognitionRecord, RecognitionRecord, QAfterFilterCondition>
  summaryIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'summary', value: ''),
      );
    });
  }

  QueryBuilder<RecognitionRecord, RecognitionRecord, QAfterFilterCondition>
  summaryIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'summary', value: ''),
      );
    });
  }

  QueryBuilder<RecognitionRecord, RecognitionRecord, QAfterFilterCondition>
  titleEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'title',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<RecognitionRecord, RecognitionRecord, QAfterFilterCondition>
  titleGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'title',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<RecognitionRecord, RecognitionRecord, QAfterFilterCondition>
  titleLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'title',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<RecognitionRecord, RecognitionRecord, QAfterFilterCondition>
  titleBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'title',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<RecognitionRecord, RecognitionRecord, QAfterFilterCondition>
  titleStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'title',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<RecognitionRecord, RecognitionRecord, QAfterFilterCondition>
  titleEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'title',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<RecognitionRecord, RecognitionRecord, QAfterFilterCondition>
  titleContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'title',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<RecognitionRecord, RecognitionRecord, QAfterFilterCondition>
  titleMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'title',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<RecognitionRecord, RecognitionRecord, QAfterFilterCondition>
  titleIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'title', value: ''),
      );
    });
  }

  QueryBuilder<RecognitionRecord, RecognitionRecord, QAfterFilterCondition>
  titleIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'title', value: ''),
      );
    });
  }
}

extension RecognitionRecordQueryObject
    on QueryBuilder<RecognitionRecord, RecognitionRecord, QFilterCondition> {
  QueryBuilder<RecognitionRecord, RecognitionRecord, QAfterFilterCondition>
  recommendationsElement(FilterQuery<StoredRecommendation> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'recommendations');
    });
  }
}

extension RecognitionRecordQueryLinks
    on QueryBuilder<RecognitionRecord, RecognitionRecord, QFilterCondition> {}

extension RecognitionRecordQuerySortBy
    on QueryBuilder<RecognitionRecord, RecognitionRecord, QSortBy> {
  QueryBuilder<RecognitionRecord, RecognitionRecord, QAfterSortBy>
  sortByConfidence() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'confidence', Sort.asc);
    });
  }

  QueryBuilder<RecognitionRecord, RecognitionRecord, QAfterSortBy>
  sortByConfidenceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'confidence', Sort.desc);
    });
  }

  QueryBuilder<RecognitionRecord, RecognitionRecord, QAfterSortBy>
  sortByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<RecognitionRecord, RecognitionRecord, QAfterSortBy>
  sortByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<RecognitionRecord, RecognitionRecord, QAfterSortBy>
  sortByImagePath() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'imagePath', Sort.asc);
    });
  }

  QueryBuilder<RecognitionRecord, RecognitionRecord, QAfterSortBy>
  sortByImagePathDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'imagePath', Sort.desc);
    });
  }

  QueryBuilder<RecognitionRecord, RecognitionRecord, QAfterSortBy>
  sortByIsDemo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isDemo', Sort.asc);
    });
  }

  QueryBuilder<RecognitionRecord, RecognitionRecord, QAfterSortBy>
  sortByIsDemoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isDemo', Sort.desc);
    });
  }

  QueryBuilder<RecognitionRecord, RecognitionRecord, QAfterSortBy>
  sortByPlantId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'plantId', Sort.asc);
    });
  }

  QueryBuilder<RecognitionRecord, RecognitionRecord, QAfterSortBy>
  sortByPlantIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'plantId', Sort.desc);
    });
  }

  QueryBuilder<RecognitionRecord, RecognitionRecord, QAfterSortBy>
  sortByResultId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'resultId', Sort.asc);
    });
  }

  QueryBuilder<RecognitionRecord, RecognitionRecord, QAfterSortBy>
  sortByResultIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'resultId', Sort.desc);
    });
  }

  QueryBuilder<RecognitionRecord, RecognitionRecord, QAfterSortBy>
  sortBySummary() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'summary', Sort.asc);
    });
  }

  QueryBuilder<RecognitionRecord, RecognitionRecord, QAfterSortBy>
  sortBySummaryDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'summary', Sort.desc);
    });
  }

  QueryBuilder<RecognitionRecord, RecognitionRecord, QAfterSortBy>
  sortByTitle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.asc);
    });
  }

  QueryBuilder<RecognitionRecord, RecognitionRecord, QAfterSortBy>
  sortByTitleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.desc);
    });
  }
}

extension RecognitionRecordQuerySortThenBy
    on QueryBuilder<RecognitionRecord, RecognitionRecord, QSortThenBy> {
  QueryBuilder<RecognitionRecord, RecognitionRecord, QAfterSortBy>
  thenByConfidence() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'confidence', Sort.asc);
    });
  }

  QueryBuilder<RecognitionRecord, RecognitionRecord, QAfterSortBy>
  thenByConfidenceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'confidence', Sort.desc);
    });
  }

  QueryBuilder<RecognitionRecord, RecognitionRecord, QAfterSortBy>
  thenByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<RecognitionRecord, RecognitionRecord, QAfterSortBy>
  thenByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<RecognitionRecord, RecognitionRecord, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<RecognitionRecord, RecognitionRecord, QAfterSortBy>
  thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<RecognitionRecord, RecognitionRecord, QAfterSortBy>
  thenByImagePath() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'imagePath', Sort.asc);
    });
  }

  QueryBuilder<RecognitionRecord, RecognitionRecord, QAfterSortBy>
  thenByImagePathDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'imagePath', Sort.desc);
    });
  }

  QueryBuilder<RecognitionRecord, RecognitionRecord, QAfterSortBy>
  thenByIsDemo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isDemo', Sort.asc);
    });
  }

  QueryBuilder<RecognitionRecord, RecognitionRecord, QAfterSortBy>
  thenByIsDemoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isDemo', Sort.desc);
    });
  }

  QueryBuilder<RecognitionRecord, RecognitionRecord, QAfterSortBy>
  thenByPlantId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'plantId', Sort.asc);
    });
  }

  QueryBuilder<RecognitionRecord, RecognitionRecord, QAfterSortBy>
  thenByPlantIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'plantId', Sort.desc);
    });
  }

  QueryBuilder<RecognitionRecord, RecognitionRecord, QAfterSortBy>
  thenByResultId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'resultId', Sort.asc);
    });
  }

  QueryBuilder<RecognitionRecord, RecognitionRecord, QAfterSortBy>
  thenByResultIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'resultId', Sort.desc);
    });
  }

  QueryBuilder<RecognitionRecord, RecognitionRecord, QAfterSortBy>
  thenBySummary() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'summary', Sort.asc);
    });
  }

  QueryBuilder<RecognitionRecord, RecognitionRecord, QAfterSortBy>
  thenBySummaryDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'summary', Sort.desc);
    });
  }

  QueryBuilder<RecognitionRecord, RecognitionRecord, QAfterSortBy>
  thenByTitle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.asc);
    });
  }

  QueryBuilder<RecognitionRecord, RecognitionRecord, QAfterSortBy>
  thenByTitleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.desc);
    });
  }
}

extension RecognitionRecordQueryWhereDistinct
    on QueryBuilder<RecognitionRecord, RecognitionRecord, QDistinct> {
  QueryBuilder<RecognitionRecord, RecognitionRecord, QDistinct>
  distinctByConfidence() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'confidence');
    });
  }

  QueryBuilder<RecognitionRecord, RecognitionRecord, QDistinct>
  distinctByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'createdAt');
    });
  }

  QueryBuilder<RecognitionRecord, RecognitionRecord, QDistinct>
  distinctByImagePath({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'imagePath', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<RecognitionRecord, RecognitionRecord, QDistinct>
  distinctByIsDemo() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isDemo');
    });
  }

  QueryBuilder<RecognitionRecord, RecognitionRecord, QDistinct>
  distinctByPlantId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'plantId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<RecognitionRecord, RecognitionRecord, QDistinct>
  distinctByResultId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'resultId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<RecognitionRecord, RecognitionRecord, QDistinct>
  distinctBySummary({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'summary', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<RecognitionRecord, RecognitionRecord, QDistinct>
  distinctByTitle({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'title', caseSensitive: caseSensitive);
    });
  }
}

extension RecognitionRecordQueryProperty
    on QueryBuilder<RecognitionRecord, RecognitionRecord, QQueryProperty> {
  QueryBuilder<RecognitionRecord, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<RecognitionRecord, double, QQueryOperations>
  confidenceProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'confidence');
    });
  }

  QueryBuilder<RecognitionRecord, DateTime, QQueryOperations>
  createdAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'createdAt');
    });
  }

  QueryBuilder<RecognitionRecord, String?, QQueryOperations>
  imagePathProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'imagePath');
    });
  }

  QueryBuilder<RecognitionRecord, bool, QQueryOperations> isDemoProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isDemo');
    });
  }

  QueryBuilder<RecognitionRecord, String?, QQueryOperations> plantIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'plantId');
    });
  }

  QueryBuilder<RecognitionRecord, List<StoredRecommendation>, QQueryOperations>
  recommendationsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'recommendations');
    });
  }

  QueryBuilder<RecognitionRecord, String, QQueryOperations> resultIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'resultId');
    });
  }

  QueryBuilder<RecognitionRecord, String, QQueryOperations> summaryProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'summary');
    });
  }

  QueryBuilder<RecognitionRecord, String, QQueryOperations> titleProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'title');
    });
  }
}

// **************************************************************************
// IsarEmbeddedGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types, experimental_member_use

const StoredRecommendationSchema = Schema(
  name: r'StoredRecommendation',
  id: 5656655697844936523,
  properties: {
    r'description': PropertySchema(
      id: 0,
      name: r'description',
      type: IsarType.string,
    ),
    r'title': PropertySchema(id: 1, name: r'title', type: IsarType.string),
    r'topic': PropertySchema(id: 2, name: r'topic', type: IsarType.string),
  },

  estimateSize: _storedRecommendationEstimateSize,
  serialize: _storedRecommendationSerialize,
  deserialize: _storedRecommendationDeserialize,
  deserializeProp: _storedRecommendationDeserializeProp,
);

int _storedRecommendationEstimateSize(
  StoredRecommendation object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.description.length * 3;
  bytesCount += 3 + object.title.length * 3;
  bytesCount += 3 + object.topic.length * 3;
  return bytesCount;
}

void _storedRecommendationSerialize(
  StoredRecommendation object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.description);
  writer.writeString(offsets[1], object.title);
  writer.writeString(offsets[2], object.topic);
}

StoredRecommendation _storedRecommendationDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = StoredRecommendation();
  object.description = reader.readString(offsets[0]);
  object.title = reader.readString(offsets[1]);
  object.topic = reader.readString(offsets[2]);
  return object;
}

P _storedRecommendationDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readString(offset)) as P;
    case 2:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension StoredRecommendationQueryFilter
    on
        QueryBuilder<
          StoredRecommendation,
          StoredRecommendation,
          QFilterCondition
        > {
  QueryBuilder<
    StoredRecommendation,
    StoredRecommendation,
    QAfterFilterCondition
  >
  descriptionEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'description',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    StoredRecommendation,
    StoredRecommendation,
    QAfterFilterCondition
  >
  descriptionGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'description',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    StoredRecommendation,
    StoredRecommendation,
    QAfterFilterCondition
  >
  descriptionLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'description',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    StoredRecommendation,
    StoredRecommendation,
    QAfterFilterCondition
  >
  descriptionBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'description',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    StoredRecommendation,
    StoredRecommendation,
    QAfterFilterCondition
  >
  descriptionStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'description',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    StoredRecommendation,
    StoredRecommendation,
    QAfterFilterCondition
  >
  descriptionEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'description',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    StoredRecommendation,
    StoredRecommendation,
    QAfterFilterCondition
  >
  descriptionContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'description',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    StoredRecommendation,
    StoredRecommendation,
    QAfterFilterCondition
  >
  descriptionMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'description',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    StoredRecommendation,
    StoredRecommendation,
    QAfterFilterCondition
  >
  descriptionIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'description', value: ''),
      );
    });
  }

  QueryBuilder<
    StoredRecommendation,
    StoredRecommendation,
    QAfterFilterCondition
  >
  descriptionIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'description', value: ''),
      );
    });
  }

  QueryBuilder<
    StoredRecommendation,
    StoredRecommendation,
    QAfterFilterCondition
  >
  titleEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'title',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    StoredRecommendation,
    StoredRecommendation,
    QAfterFilterCondition
  >
  titleGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'title',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    StoredRecommendation,
    StoredRecommendation,
    QAfterFilterCondition
  >
  titleLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'title',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    StoredRecommendation,
    StoredRecommendation,
    QAfterFilterCondition
  >
  titleBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'title',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    StoredRecommendation,
    StoredRecommendation,
    QAfterFilterCondition
  >
  titleStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'title',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    StoredRecommendation,
    StoredRecommendation,
    QAfterFilterCondition
  >
  titleEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'title',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    StoredRecommendation,
    StoredRecommendation,
    QAfterFilterCondition
  >
  titleContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'title',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    StoredRecommendation,
    StoredRecommendation,
    QAfterFilterCondition
  >
  titleMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'title',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    StoredRecommendation,
    StoredRecommendation,
    QAfterFilterCondition
  >
  titleIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'title', value: ''),
      );
    });
  }

  QueryBuilder<
    StoredRecommendation,
    StoredRecommendation,
    QAfterFilterCondition
  >
  titleIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'title', value: ''),
      );
    });
  }

  QueryBuilder<
    StoredRecommendation,
    StoredRecommendation,
    QAfterFilterCondition
  >
  topicEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'topic',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    StoredRecommendation,
    StoredRecommendation,
    QAfterFilterCondition
  >
  topicGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'topic',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    StoredRecommendation,
    StoredRecommendation,
    QAfterFilterCondition
  >
  topicLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'topic',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    StoredRecommendation,
    StoredRecommendation,
    QAfterFilterCondition
  >
  topicBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'topic',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    StoredRecommendation,
    StoredRecommendation,
    QAfterFilterCondition
  >
  topicStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'topic',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    StoredRecommendation,
    StoredRecommendation,
    QAfterFilterCondition
  >
  topicEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'topic',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    StoredRecommendation,
    StoredRecommendation,
    QAfterFilterCondition
  >
  topicContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'topic',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    StoredRecommendation,
    StoredRecommendation,
    QAfterFilterCondition
  >
  topicMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'topic',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    StoredRecommendation,
    StoredRecommendation,
    QAfterFilterCondition
  >
  topicIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'topic', value: ''),
      );
    });
  }

  QueryBuilder<
    StoredRecommendation,
    StoredRecommendation,
    QAfterFilterCondition
  >
  topicIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'topic', value: ''),
      );
    });
  }
}

extension StoredRecommendationQueryObject
    on
        QueryBuilder<
          StoredRecommendation,
          StoredRecommendation,
          QFilterCondition
        > {}
