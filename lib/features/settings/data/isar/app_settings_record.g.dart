// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_settings_record.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types, experimental_member_use

extension GetAppSettingsRecordCollection on Isar {
  IsarCollection<AppSettingsRecord> get appSettingsRecords => this.collection();
}

const AppSettingsRecordSchema = CollectionSchema(
  name: r'AppSettingsRecord',
  id: -5800169138830006153,
  properties: {
    r'climateZoneId': PropertySchema(
      id: 0,
      name: r'climateZoneId',
      type: IsarType.string,
    ),
    r'recognitionApiKey': PropertySchema(
      id: 1,
      name: r'recognitionApiKey',
      type: IsarType.string,
    ),
    r'recognitionBackend': PropertySchema(
      id: 2,
      name: r'recognitionBackend',
      type: IsarType.string,
    ),
    r'recognitionEndpoint': PropertySchema(
      id: 3,
      name: r'recognitionEndpoint',
      type: IsarType.string,
    ),
    r'recognitionFolderId': PropertySchema(
      id: 4,
      name: r'recognitionFolderId',
      type: IsarType.string,
    ),
    r'recognitionModel': PropertySchema(
      id: 5,
      name: r'recognitionModel',
      type: IsarType.string,
    ),
    r'themeMode': PropertySchema(
      id: 6,
      name: r'themeMode',
      type: IsarType.string,
    ),
  },

  estimateSize: _appSettingsRecordEstimateSize,
  serialize: _appSettingsRecordSerialize,
  deserialize: _appSettingsRecordDeserialize,
  deserializeProp: _appSettingsRecordDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},

  getId: _appSettingsRecordGetId,
  getLinks: _appSettingsRecordGetLinks,
  attach: _appSettingsRecordAttach,
  version: '3.4.1',
);

int _appSettingsRecordEstimateSize(
  AppSettingsRecord object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.climateZoneId.length * 3;
  bytesCount += 3 + object.recognitionApiKey.length * 3;
  bytesCount += 3 + object.recognitionBackend.length * 3;
  bytesCount += 3 + object.recognitionEndpoint.length * 3;
  bytesCount += 3 + object.recognitionFolderId.length * 3;
  bytesCount += 3 + object.recognitionModel.length * 3;
  bytesCount += 3 + object.themeMode.length * 3;
  return bytesCount;
}

void _appSettingsRecordSerialize(
  AppSettingsRecord object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.climateZoneId);
  writer.writeString(offsets[1], object.recognitionApiKey);
  writer.writeString(offsets[2], object.recognitionBackend);
  writer.writeString(offsets[3], object.recognitionEndpoint);
  writer.writeString(offsets[4], object.recognitionFolderId);
  writer.writeString(offsets[5], object.recognitionModel);
  writer.writeString(offsets[6], object.themeMode);
}

AppSettingsRecord _appSettingsRecordDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = AppSettingsRecord();
  object.climateZoneId = reader.readString(offsets[0]);
  object.id = id;
  object.recognitionApiKey = reader.readString(offsets[1]);
  object.recognitionBackend = reader.readString(offsets[2]);
  object.recognitionEndpoint = reader.readString(offsets[3]);
  object.recognitionFolderId = reader.readString(offsets[4]);
  object.recognitionModel = reader.readString(offsets[5]);
  object.themeMode = reader.readString(offsets[6]);
  return object;
}

P _appSettingsRecordDeserializeProp<P>(
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
    case 3:
      return (reader.readString(offset)) as P;
    case 4:
      return (reader.readString(offset)) as P;
    case 5:
      return (reader.readString(offset)) as P;
    case 6:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _appSettingsRecordGetId(AppSettingsRecord object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _appSettingsRecordGetLinks(
  AppSettingsRecord object,
) {
  return [];
}

void _appSettingsRecordAttach(
  IsarCollection<dynamic> col,
  Id id,
  AppSettingsRecord object,
) {
  object.id = id;
}

extension AppSettingsRecordQueryWhereSort
    on QueryBuilder<AppSettingsRecord, AppSettingsRecord, QWhere> {
  QueryBuilder<AppSettingsRecord, AppSettingsRecord, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension AppSettingsRecordQueryWhere
    on QueryBuilder<AppSettingsRecord, AppSettingsRecord, QWhereClause> {
  QueryBuilder<AppSettingsRecord, AppSettingsRecord, QAfterWhereClause>
  idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(lower: id, upper: id));
    });
  }

  QueryBuilder<AppSettingsRecord, AppSettingsRecord, QAfterWhereClause>
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

  QueryBuilder<AppSettingsRecord, AppSettingsRecord, QAfterWhereClause>
  idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<AppSettingsRecord, AppSettingsRecord, QAfterWhereClause>
  idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<AppSettingsRecord, AppSettingsRecord, QAfterWhereClause>
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
}

extension AppSettingsRecordQueryFilter
    on QueryBuilder<AppSettingsRecord, AppSettingsRecord, QFilterCondition> {
  QueryBuilder<AppSettingsRecord, AppSettingsRecord, QAfterFilterCondition>
  climateZoneIdEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'climateZoneId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AppSettingsRecord, AppSettingsRecord, QAfterFilterCondition>
  climateZoneIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'climateZoneId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AppSettingsRecord, AppSettingsRecord, QAfterFilterCondition>
  climateZoneIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'climateZoneId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AppSettingsRecord, AppSettingsRecord, QAfterFilterCondition>
  climateZoneIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'climateZoneId',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AppSettingsRecord, AppSettingsRecord, QAfterFilterCondition>
  climateZoneIdStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'climateZoneId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AppSettingsRecord, AppSettingsRecord, QAfterFilterCondition>
  climateZoneIdEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'climateZoneId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AppSettingsRecord, AppSettingsRecord, QAfterFilterCondition>
  climateZoneIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'climateZoneId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AppSettingsRecord, AppSettingsRecord, QAfterFilterCondition>
  climateZoneIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'climateZoneId',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AppSettingsRecord, AppSettingsRecord, QAfterFilterCondition>
  climateZoneIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'climateZoneId', value: ''),
      );
    });
  }

  QueryBuilder<AppSettingsRecord, AppSettingsRecord, QAfterFilterCondition>
  climateZoneIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'climateZoneId', value: ''),
      );
    });
  }

  QueryBuilder<AppSettingsRecord, AppSettingsRecord, QAfterFilterCondition>
  idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'id', value: value),
      );
    });
  }

  QueryBuilder<AppSettingsRecord, AppSettingsRecord, QAfterFilterCondition>
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

  QueryBuilder<AppSettingsRecord, AppSettingsRecord, QAfterFilterCondition>
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

  QueryBuilder<AppSettingsRecord, AppSettingsRecord, QAfterFilterCondition>
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

  QueryBuilder<AppSettingsRecord, AppSettingsRecord, QAfterFilterCondition>
  recognitionApiKeyEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'recognitionApiKey',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AppSettingsRecord, AppSettingsRecord, QAfterFilterCondition>
  recognitionApiKeyGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'recognitionApiKey',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AppSettingsRecord, AppSettingsRecord, QAfterFilterCondition>
  recognitionApiKeyLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'recognitionApiKey',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AppSettingsRecord, AppSettingsRecord, QAfterFilterCondition>
  recognitionApiKeyBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'recognitionApiKey',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AppSettingsRecord, AppSettingsRecord, QAfterFilterCondition>
  recognitionApiKeyStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'recognitionApiKey',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AppSettingsRecord, AppSettingsRecord, QAfterFilterCondition>
  recognitionApiKeyEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'recognitionApiKey',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AppSettingsRecord, AppSettingsRecord, QAfterFilterCondition>
  recognitionApiKeyContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'recognitionApiKey',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AppSettingsRecord, AppSettingsRecord, QAfterFilterCondition>
  recognitionApiKeyMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'recognitionApiKey',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AppSettingsRecord, AppSettingsRecord, QAfterFilterCondition>
  recognitionApiKeyIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'recognitionApiKey', value: ''),
      );
    });
  }

  QueryBuilder<AppSettingsRecord, AppSettingsRecord, QAfterFilterCondition>
  recognitionApiKeyIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'recognitionApiKey', value: ''),
      );
    });
  }

  QueryBuilder<AppSettingsRecord, AppSettingsRecord, QAfterFilterCondition>
  recognitionBackendEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'recognitionBackend',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AppSettingsRecord, AppSettingsRecord, QAfterFilterCondition>
  recognitionBackendGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'recognitionBackend',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AppSettingsRecord, AppSettingsRecord, QAfterFilterCondition>
  recognitionBackendLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'recognitionBackend',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AppSettingsRecord, AppSettingsRecord, QAfterFilterCondition>
  recognitionBackendBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'recognitionBackend',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AppSettingsRecord, AppSettingsRecord, QAfterFilterCondition>
  recognitionBackendStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'recognitionBackend',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AppSettingsRecord, AppSettingsRecord, QAfterFilterCondition>
  recognitionBackendEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'recognitionBackend',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AppSettingsRecord, AppSettingsRecord, QAfterFilterCondition>
  recognitionBackendContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'recognitionBackend',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AppSettingsRecord, AppSettingsRecord, QAfterFilterCondition>
  recognitionBackendMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'recognitionBackend',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AppSettingsRecord, AppSettingsRecord, QAfterFilterCondition>
  recognitionBackendIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'recognitionBackend', value: ''),
      );
    });
  }

  QueryBuilder<AppSettingsRecord, AppSettingsRecord, QAfterFilterCondition>
  recognitionBackendIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'recognitionBackend', value: ''),
      );
    });
  }

  QueryBuilder<AppSettingsRecord, AppSettingsRecord, QAfterFilterCondition>
  recognitionEndpointEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'recognitionEndpoint',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AppSettingsRecord, AppSettingsRecord, QAfterFilterCondition>
  recognitionEndpointGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'recognitionEndpoint',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AppSettingsRecord, AppSettingsRecord, QAfterFilterCondition>
  recognitionEndpointLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'recognitionEndpoint',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AppSettingsRecord, AppSettingsRecord, QAfterFilterCondition>
  recognitionEndpointBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'recognitionEndpoint',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AppSettingsRecord, AppSettingsRecord, QAfterFilterCondition>
  recognitionEndpointStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'recognitionEndpoint',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AppSettingsRecord, AppSettingsRecord, QAfterFilterCondition>
  recognitionEndpointEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'recognitionEndpoint',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AppSettingsRecord, AppSettingsRecord, QAfterFilterCondition>
  recognitionEndpointContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'recognitionEndpoint',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AppSettingsRecord, AppSettingsRecord, QAfterFilterCondition>
  recognitionEndpointMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'recognitionEndpoint',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AppSettingsRecord, AppSettingsRecord, QAfterFilterCondition>
  recognitionEndpointIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'recognitionEndpoint', value: ''),
      );
    });
  }

  QueryBuilder<AppSettingsRecord, AppSettingsRecord, QAfterFilterCondition>
  recognitionEndpointIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          property: r'recognitionEndpoint',
          value: '',
        ),
      );
    });
  }

  QueryBuilder<AppSettingsRecord, AppSettingsRecord, QAfterFilterCondition>
  recognitionFolderIdEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'recognitionFolderId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AppSettingsRecord, AppSettingsRecord, QAfterFilterCondition>
  recognitionFolderIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'recognitionFolderId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AppSettingsRecord, AppSettingsRecord, QAfterFilterCondition>
  recognitionFolderIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'recognitionFolderId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AppSettingsRecord, AppSettingsRecord, QAfterFilterCondition>
  recognitionFolderIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'recognitionFolderId',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AppSettingsRecord, AppSettingsRecord, QAfterFilterCondition>
  recognitionFolderIdStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'recognitionFolderId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AppSettingsRecord, AppSettingsRecord, QAfterFilterCondition>
  recognitionFolderIdEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'recognitionFolderId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AppSettingsRecord, AppSettingsRecord, QAfterFilterCondition>
  recognitionFolderIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'recognitionFolderId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AppSettingsRecord, AppSettingsRecord, QAfterFilterCondition>
  recognitionFolderIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'recognitionFolderId',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AppSettingsRecord, AppSettingsRecord, QAfterFilterCondition>
  recognitionFolderIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'recognitionFolderId', value: ''),
      );
    });
  }

  QueryBuilder<AppSettingsRecord, AppSettingsRecord, QAfterFilterCondition>
  recognitionFolderIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          property: r'recognitionFolderId',
          value: '',
        ),
      );
    });
  }

  QueryBuilder<AppSettingsRecord, AppSettingsRecord, QAfterFilterCondition>
  recognitionModelEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'recognitionModel',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AppSettingsRecord, AppSettingsRecord, QAfterFilterCondition>
  recognitionModelGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'recognitionModel',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AppSettingsRecord, AppSettingsRecord, QAfterFilterCondition>
  recognitionModelLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'recognitionModel',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AppSettingsRecord, AppSettingsRecord, QAfterFilterCondition>
  recognitionModelBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'recognitionModel',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AppSettingsRecord, AppSettingsRecord, QAfterFilterCondition>
  recognitionModelStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'recognitionModel',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AppSettingsRecord, AppSettingsRecord, QAfterFilterCondition>
  recognitionModelEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'recognitionModel',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AppSettingsRecord, AppSettingsRecord, QAfterFilterCondition>
  recognitionModelContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'recognitionModel',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AppSettingsRecord, AppSettingsRecord, QAfterFilterCondition>
  recognitionModelMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'recognitionModel',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AppSettingsRecord, AppSettingsRecord, QAfterFilterCondition>
  recognitionModelIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'recognitionModel', value: ''),
      );
    });
  }

  QueryBuilder<AppSettingsRecord, AppSettingsRecord, QAfterFilterCondition>
  recognitionModelIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'recognitionModel', value: ''),
      );
    });
  }

  QueryBuilder<AppSettingsRecord, AppSettingsRecord, QAfterFilterCondition>
  themeModeEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'themeMode',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AppSettingsRecord, AppSettingsRecord, QAfterFilterCondition>
  themeModeGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'themeMode',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AppSettingsRecord, AppSettingsRecord, QAfterFilterCondition>
  themeModeLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'themeMode',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AppSettingsRecord, AppSettingsRecord, QAfterFilterCondition>
  themeModeBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'themeMode',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AppSettingsRecord, AppSettingsRecord, QAfterFilterCondition>
  themeModeStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'themeMode',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AppSettingsRecord, AppSettingsRecord, QAfterFilterCondition>
  themeModeEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'themeMode',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AppSettingsRecord, AppSettingsRecord, QAfterFilterCondition>
  themeModeContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'themeMode',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AppSettingsRecord, AppSettingsRecord, QAfterFilterCondition>
  themeModeMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'themeMode',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AppSettingsRecord, AppSettingsRecord, QAfterFilterCondition>
  themeModeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'themeMode', value: ''),
      );
    });
  }

  QueryBuilder<AppSettingsRecord, AppSettingsRecord, QAfterFilterCondition>
  themeModeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'themeMode', value: ''),
      );
    });
  }
}

extension AppSettingsRecordQueryObject
    on QueryBuilder<AppSettingsRecord, AppSettingsRecord, QFilterCondition> {}

extension AppSettingsRecordQueryLinks
    on QueryBuilder<AppSettingsRecord, AppSettingsRecord, QFilterCondition> {}

extension AppSettingsRecordQuerySortBy
    on QueryBuilder<AppSettingsRecord, AppSettingsRecord, QSortBy> {
  QueryBuilder<AppSettingsRecord, AppSettingsRecord, QAfterSortBy>
  sortByClimateZoneId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'climateZoneId', Sort.asc);
    });
  }

  QueryBuilder<AppSettingsRecord, AppSettingsRecord, QAfterSortBy>
  sortByClimateZoneIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'climateZoneId', Sort.desc);
    });
  }

  QueryBuilder<AppSettingsRecord, AppSettingsRecord, QAfterSortBy>
  sortByRecognitionApiKey() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'recognitionApiKey', Sort.asc);
    });
  }

  QueryBuilder<AppSettingsRecord, AppSettingsRecord, QAfterSortBy>
  sortByRecognitionApiKeyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'recognitionApiKey', Sort.desc);
    });
  }

  QueryBuilder<AppSettingsRecord, AppSettingsRecord, QAfterSortBy>
  sortByRecognitionBackend() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'recognitionBackend', Sort.asc);
    });
  }

  QueryBuilder<AppSettingsRecord, AppSettingsRecord, QAfterSortBy>
  sortByRecognitionBackendDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'recognitionBackend', Sort.desc);
    });
  }

  QueryBuilder<AppSettingsRecord, AppSettingsRecord, QAfterSortBy>
  sortByRecognitionEndpoint() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'recognitionEndpoint', Sort.asc);
    });
  }

  QueryBuilder<AppSettingsRecord, AppSettingsRecord, QAfterSortBy>
  sortByRecognitionEndpointDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'recognitionEndpoint', Sort.desc);
    });
  }

  QueryBuilder<AppSettingsRecord, AppSettingsRecord, QAfterSortBy>
  sortByRecognitionFolderId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'recognitionFolderId', Sort.asc);
    });
  }

  QueryBuilder<AppSettingsRecord, AppSettingsRecord, QAfterSortBy>
  sortByRecognitionFolderIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'recognitionFolderId', Sort.desc);
    });
  }

  QueryBuilder<AppSettingsRecord, AppSettingsRecord, QAfterSortBy>
  sortByRecognitionModel() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'recognitionModel', Sort.asc);
    });
  }

  QueryBuilder<AppSettingsRecord, AppSettingsRecord, QAfterSortBy>
  sortByRecognitionModelDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'recognitionModel', Sort.desc);
    });
  }

  QueryBuilder<AppSettingsRecord, AppSettingsRecord, QAfterSortBy>
  sortByThemeMode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'themeMode', Sort.asc);
    });
  }

  QueryBuilder<AppSettingsRecord, AppSettingsRecord, QAfterSortBy>
  sortByThemeModeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'themeMode', Sort.desc);
    });
  }
}

extension AppSettingsRecordQuerySortThenBy
    on QueryBuilder<AppSettingsRecord, AppSettingsRecord, QSortThenBy> {
  QueryBuilder<AppSettingsRecord, AppSettingsRecord, QAfterSortBy>
  thenByClimateZoneId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'climateZoneId', Sort.asc);
    });
  }

  QueryBuilder<AppSettingsRecord, AppSettingsRecord, QAfterSortBy>
  thenByClimateZoneIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'climateZoneId', Sort.desc);
    });
  }

  QueryBuilder<AppSettingsRecord, AppSettingsRecord, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<AppSettingsRecord, AppSettingsRecord, QAfterSortBy>
  thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<AppSettingsRecord, AppSettingsRecord, QAfterSortBy>
  thenByRecognitionApiKey() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'recognitionApiKey', Sort.asc);
    });
  }

  QueryBuilder<AppSettingsRecord, AppSettingsRecord, QAfterSortBy>
  thenByRecognitionApiKeyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'recognitionApiKey', Sort.desc);
    });
  }

  QueryBuilder<AppSettingsRecord, AppSettingsRecord, QAfterSortBy>
  thenByRecognitionBackend() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'recognitionBackend', Sort.asc);
    });
  }

  QueryBuilder<AppSettingsRecord, AppSettingsRecord, QAfterSortBy>
  thenByRecognitionBackendDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'recognitionBackend', Sort.desc);
    });
  }

  QueryBuilder<AppSettingsRecord, AppSettingsRecord, QAfterSortBy>
  thenByRecognitionEndpoint() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'recognitionEndpoint', Sort.asc);
    });
  }

  QueryBuilder<AppSettingsRecord, AppSettingsRecord, QAfterSortBy>
  thenByRecognitionEndpointDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'recognitionEndpoint', Sort.desc);
    });
  }

  QueryBuilder<AppSettingsRecord, AppSettingsRecord, QAfterSortBy>
  thenByRecognitionFolderId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'recognitionFolderId', Sort.asc);
    });
  }

  QueryBuilder<AppSettingsRecord, AppSettingsRecord, QAfterSortBy>
  thenByRecognitionFolderIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'recognitionFolderId', Sort.desc);
    });
  }

  QueryBuilder<AppSettingsRecord, AppSettingsRecord, QAfterSortBy>
  thenByRecognitionModel() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'recognitionModel', Sort.asc);
    });
  }

  QueryBuilder<AppSettingsRecord, AppSettingsRecord, QAfterSortBy>
  thenByRecognitionModelDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'recognitionModel', Sort.desc);
    });
  }

  QueryBuilder<AppSettingsRecord, AppSettingsRecord, QAfterSortBy>
  thenByThemeMode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'themeMode', Sort.asc);
    });
  }

  QueryBuilder<AppSettingsRecord, AppSettingsRecord, QAfterSortBy>
  thenByThemeModeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'themeMode', Sort.desc);
    });
  }
}

extension AppSettingsRecordQueryWhereDistinct
    on QueryBuilder<AppSettingsRecord, AppSettingsRecord, QDistinct> {
  QueryBuilder<AppSettingsRecord, AppSettingsRecord, QDistinct>
  distinctByClimateZoneId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(
        r'climateZoneId',
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<AppSettingsRecord, AppSettingsRecord, QDistinct>
  distinctByRecognitionApiKey({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(
        r'recognitionApiKey',
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<AppSettingsRecord, AppSettingsRecord, QDistinct>
  distinctByRecognitionBackend({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(
        r'recognitionBackend',
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<AppSettingsRecord, AppSettingsRecord, QDistinct>
  distinctByRecognitionEndpoint({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(
        r'recognitionEndpoint',
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<AppSettingsRecord, AppSettingsRecord, QDistinct>
  distinctByRecognitionFolderId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(
        r'recognitionFolderId',
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<AppSettingsRecord, AppSettingsRecord, QDistinct>
  distinctByRecognitionModel({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(
        r'recognitionModel',
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<AppSettingsRecord, AppSettingsRecord, QDistinct>
  distinctByThemeMode({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'themeMode', caseSensitive: caseSensitive);
    });
  }
}

extension AppSettingsRecordQueryProperty
    on QueryBuilder<AppSettingsRecord, AppSettingsRecord, QQueryProperty> {
  QueryBuilder<AppSettingsRecord, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<AppSettingsRecord, String, QQueryOperations>
  climateZoneIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'climateZoneId');
    });
  }

  QueryBuilder<AppSettingsRecord, String, QQueryOperations>
  recognitionApiKeyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'recognitionApiKey');
    });
  }

  QueryBuilder<AppSettingsRecord, String, QQueryOperations>
  recognitionBackendProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'recognitionBackend');
    });
  }

  QueryBuilder<AppSettingsRecord, String, QQueryOperations>
  recognitionEndpointProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'recognitionEndpoint');
    });
  }

  QueryBuilder<AppSettingsRecord, String, QQueryOperations>
  recognitionFolderIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'recognitionFolderId');
    });
  }

  QueryBuilder<AppSettingsRecord, String, QQueryOperations>
  recognitionModelProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'recognitionModel');
    });
  }

  QueryBuilder<AppSettingsRecord, String, QQueryOperations>
  themeModeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'themeMode');
    });
  }
}
