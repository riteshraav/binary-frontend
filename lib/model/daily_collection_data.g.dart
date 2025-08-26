// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'daily_collection_data.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetDailyCollectionDataCollection on Isar {
  IsarCollection<DailyCollectionData> get dailyCollectionDatas =>
      this.collection();
}

const DailyCollectionDataSchema = CollectionSchema(
  name: r'DailyCollectionData',
  id: 1186983955749210341,
  properties: {
    r'adminId': PropertySchema(
      id: 0,
      name: r'adminId',
      type: IsarType.string,
    ),
    r'avgFat': PropertySchema(
      id: 1,
      name: r'avgFat',
      type: IsarType.double,
    ),
    r'avgSnf': PropertySchema(
      id: 2,
      name: r'avgSnf',
      type: IsarType.double,
    ),
    r'customerCount': PropertySchema(
      id: 3,
      name: r'customerCount',
      type: IsarType.long,
    ),
    r'date': PropertySchema(
      id: 4,
      name: r'date',
      type: IsarType.dateTime,
    ),
    r'milkType': PropertySchema(
      id: 5,
      name: r'milkType',
      type: IsarType.long,
    ),
    r'quantity': PropertySchema(
      id: 6,
      name: r'quantity',
      type: IsarType.double,
    ),
    r'totalAmount': PropertySchema(
      id: 7,
      name: r'totalAmount',
      type: IsarType.double,
    ),
    r'totalCan': PropertySchema(
      id: 8,
      name: r'totalCan',
      type: IsarType.long,
    )
  },
  estimateSize: _dailyCollectionDataEstimateSize,
  serialize: _dailyCollectionDataSerialize,
  deserialize: _dailyCollectionDataDeserialize,
  deserializeProp: _dailyCollectionDataDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _dailyCollectionDataGetId,
  getLinks: _dailyCollectionDataGetLinks,
  attach: _dailyCollectionDataAttach,
  version: '3.1.0+1',
);

int _dailyCollectionDataEstimateSize(
  DailyCollectionData object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.adminId.length * 3;
  return bytesCount;
}

void _dailyCollectionDataSerialize(
  DailyCollectionData object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.adminId);
  writer.writeDouble(offsets[1], object.avgFat);
  writer.writeDouble(offsets[2], object.avgSnf);
  writer.writeLong(offsets[3], object.customerCount);
  writer.writeDateTime(offsets[4], object.date);
  writer.writeLong(offsets[5], object.milkType);
  writer.writeDouble(offsets[6], object.quantity);
  writer.writeDouble(offsets[7], object.totalAmount);
  writer.writeLong(offsets[8], object.totalCan);
}

DailyCollectionData _dailyCollectionDataDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = DailyCollectionData(
    reader.readDateTime(offsets[4]),
    reader.readLong(offsets[3]),
    reader.readString(offsets[0]),
    reader.readLong(offsets[5]),
    reader.readDouble(offsets[1]),
    reader.readDouble(offsets[2]),
    reader.readDouble(offsets[6]),
    reader.readLong(offsets[8]),
    reader.readDouble(offsets[7]),
  );
  object.id = id;
  return object;
}

P _dailyCollectionDataDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readDouble(offset)) as P;
    case 2:
      return (reader.readDouble(offset)) as P;
    case 3:
      return (reader.readLong(offset)) as P;
    case 4:
      return (reader.readDateTime(offset)) as P;
    case 5:
      return (reader.readLong(offset)) as P;
    case 6:
      return (reader.readDouble(offset)) as P;
    case 7:
      return (reader.readDouble(offset)) as P;
    case 8:
      return (reader.readLong(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _dailyCollectionDataGetId(DailyCollectionData object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _dailyCollectionDataGetLinks(
    DailyCollectionData object) {
  return [];
}

void _dailyCollectionDataAttach(
    IsarCollection<dynamic> col, Id id, DailyCollectionData object) {
  object.id = id;
}

extension DailyCollectionDataQueryWhereSort
    on QueryBuilder<DailyCollectionData, DailyCollectionData, QWhere> {
  QueryBuilder<DailyCollectionData, DailyCollectionData, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension DailyCollectionDataQueryWhere
    on QueryBuilder<DailyCollectionData, DailyCollectionData, QWhereClause> {
  QueryBuilder<DailyCollectionData, DailyCollectionData, QAfterWhereClause>
      idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<DailyCollectionData, DailyCollectionData, QAfterWhereClause>
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

  QueryBuilder<DailyCollectionData, DailyCollectionData, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<DailyCollectionData, DailyCollectionData, QAfterWhereClause>
      idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<DailyCollectionData, DailyCollectionData, QAfterWhereClause>
      idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension DailyCollectionDataQueryFilter on QueryBuilder<DailyCollectionData,
    DailyCollectionData, QFilterCondition> {
  QueryBuilder<DailyCollectionData, DailyCollectionData, QAfterFilterCondition>
      adminIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'adminId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DailyCollectionData, DailyCollectionData, QAfterFilterCondition>
      adminIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'adminId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DailyCollectionData, DailyCollectionData, QAfterFilterCondition>
      adminIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'adminId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DailyCollectionData, DailyCollectionData, QAfterFilterCondition>
      adminIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'adminId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DailyCollectionData, DailyCollectionData, QAfterFilterCondition>
      adminIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'adminId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DailyCollectionData, DailyCollectionData, QAfterFilterCondition>
      adminIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'adminId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DailyCollectionData, DailyCollectionData, QAfterFilterCondition>
      adminIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'adminId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DailyCollectionData, DailyCollectionData, QAfterFilterCondition>
      adminIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'adminId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DailyCollectionData, DailyCollectionData, QAfterFilterCondition>
      adminIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'adminId',
        value: '',
      ));
    });
  }

  QueryBuilder<DailyCollectionData, DailyCollectionData, QAfterFilterCondition>
      adminIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'adminId',
        value: '',
      ));
    });
  }

  QueryBuilder<DailyCollectionData, DailyCollectionData, QAfterFilterCondition>
      avgFatEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'avgFat',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<DailyCollectionData, DailyCollectionData, QAfterFilterCondition>
      avgFatGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'avgFat',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<DailyCollectionData, DailyCollectionData, QAfterFilterCondition>
      avgFatLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'avgFat',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<DailyCollectionData, DailyCollectionData, QAfterFilterCondition>
      avgFatBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'avgFat',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<DailyCollectionData, DailyCollectionData, QAfterFilterCondition>
      avgSnfEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'avgSnf',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<DailyCollectionData, DailyCollectionData, QAfterFilterCondition>
      avgSnfGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'avgSnf',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<DailyCollectionData, DailyCollectionData, QAfterFilterCondition>
      avgSnfLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'avgSnf',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<DailyCollectionData, DailyCollectionData, QAfterFilterCondition>
      avgSnfBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'avgSnf',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<DailyCollectionData, DailyCollectionData, QAfterFilterCondition>
      customerCountEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'customerCount',
        value: value,
      ));
    });
  }

  QueryBuilder<DailyCollectionData, DailyCollectionData, QAfterFilterCondition>
      customerCountGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'customerCount',
        value: value,
      ));
    });
  }

  QueryBuilder<DailyCollectionData, DailyCollectionData, QAfterFilterCondition>
      customerCountLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'customerCount',
        value: value,
      ));
    });
  }

  QueryBuilder<DailyCollectionData, DailyCollectionData, QAfterFilterCondition>
      customerCountBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'customerCount',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<DailyCollectionData, DailyCollectionData, QAfterFilterCondition>
      dateEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'date',
        value: value,
      ));
    });
  }

  QueryBuilder<DailyCollectionData, DailyCollectionData, QAfterFilterCondition>
      dateGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'date',
        value: value,
      ));
    });
  }

  QueryBuilder<DailyCollectionData, DailyCollectionData, QAfterFilterCondition>
      dateLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'date',
        value: value,
      ));
    });
  }

  QueryBuilder<DailyCollectionData, DailyCollectionData, QAfterFilterCondition>
      dateBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'date',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<DailyCollectionData, DailyCollectionData, QAfterFilterCondition>
      idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<DailyCollectionData, DailyCollectionData, QAfterFilterCondition>
      idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<DailyCollectionData, DailyCollectionData, QAfterFilterCondition>
      idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<DailyCollectionData, DailyCollectionData, QAfterFilterCondition>
      idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<DailyCollectionData, DailyCollectionData, QAfterFilterCondition>
      milkTypeEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'milkType',
        value: value,
      ));
    });
  }

  QueryBuilder<DailyCollectionData, DailyCollectionData, QAfterFilterCondition>
      milkTypeGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'milkType',
        value: value,
      ));
    });
  }

  QueryBuilder<DailyCollectionData, DailyCollectionData, QAfterFilterCondition>
      milkTypeLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'milkType',
        value: value,
      ));
    });
  }

  QueryBuilder<DailyCollectionData, DailyCollectionData, QAfterFilterCondition>
      milkTypeBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'milkType',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<DailyCollectionData, DailyCollectionData, QAfterFilterCondition>
      quantityEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'quantity',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<DailyCollectionData, DailyCollectionData, QAfterFilterCondition>
      quantityGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'quantity',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<DailyCollectionData, DailyCollectionData, QAfterFilterCondition>
      quantityLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'quantity',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<DailyCollectionData, DailyCollectionData, QAfterFilterCondition>
      quantityBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'quantity',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<DailyCollectionData, DailyCollectionData, QAfterFilterCondition>
      totalAmountEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'totalAmount',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<DailyCollectionData, DailyCollectionData, QAfterFilterCondition>
      totalAmountGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'totalAmount',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<DailyCollectionData, DailyCollectionData, QAfterFilterCondition>
      totalAmountLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'totalAmount',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<DailyCollectionData, DailyCollectionData, QAfterFilterCondition>
      totalAmountBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'totalAmount',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<DailyCollectionData, DailyCollectionData, QAfterFilterCondition>
      totalCanEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'totalCan',
        value: value,
      ));
    });
  }

  QueryBuilder<DailyCollectionData, DailyCollectionData, QAfterFilterCondition>
      totalCanGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'totalCan',
        value: value,
      ));
    });
  }

  QueryBuilder<DailyCollectionData, DailyCollectionData, QAfterFilterCondition>
      totalCanLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'totalCan',
        value: value,
      ));
    });
  }

  QueryBuilder<DailyCollectionData, DailyCollectionData, QAfterFilterCondition>
      totalCanBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'totalCan',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension DailyCollectionDataQueryObject on QueryBuilder<DailyCollectionData,
    DailyCollectionData, QFilterCondition> {}

extension DailyCollectionDataQueryLinks on QueryBuilder<DailyCollectionData,
    DailyCollectionData, QFilterCondition> {}

extension DailyCollectionDataQuerySortBy
    on QueryBuilder<DailyCollectionData, DailyCollectionData, QSortBy> {
  QueryBuilder<DailyCollectionData, DailyCollectionData, QAfterSortBy>
      sortByAdminId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'adminId', Sort.asc);
    });
  }

  QueryBuilder<DailyCollectionData, DailyCollectionData, QAfterSortBy>
      sortByAdminIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'adminId', Sort.desc);
    });
  }

  QueryBuilder<DailyCollectionData, DailyCollectionData, QAfterSortBy>
      sortByAvgFat() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'avgFat', Sort.asc);
    });
  }

  QueryBuilder<DailyCollectionData, DailyCollectionData, QAfterSortBy>
      sortByAvgFatDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'avgFat', Sort.desc);
    });
  }

  QueryBuilder<DailyCollectionData, DailyCollectionData, QAfterSortBy>
      sortByAvgSnf() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'avgSnf', Sort.asc);
    });
  }

  QueryBuilder<DailyCollectionData, DailyCollectionData, QAfterSortBy>
      sortByAvgSnfDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'avgSnf', Sort.desc);
    });
  }

  QueryBuilder<DailyCollectionData, DailyCollectionData, QAfterSortBy>
      sortByCustomerCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'customerCount', Sort.asc);
    });
  }

  QueryBuilder<DailyCollectionData, DailyCollectionData, QAfterSortBy>
      sortByCustomerCountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'customerCount', Sort.desc);
    });
  }

  QueryBuilder<DailyCollectionData, DailyCollectionData, QAfterSortBy>
      sortByDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.asc);
    });
  }

  QueryBuilder<DailyCollectionData, DailyCollectionData, QAfterSortBy>
      sortByDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.desc);
    });
  }

  QueryBuilder<DailyCollectionData, DailyCollectionData, QAfterSortBy>
      sortByMilkType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'milkType', Sort.asc);
    });
  }

  QueryBuilder<DailyCollectionData, DailyCollectionData, QAfterSortBy>
      sortByMilkTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'milkType', Sort.desc);
    });
  }

  QueryBuilder<DailyCollectionData, DailyCollectionData, QAfterSortBy>
      sortByQuantity() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'quantity', Sort.asc);
    });
  }

  QueryBuilder<DailyCollectionData, DailyCollectionData, QAfterSortBy>
      sortByQuantityDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'quantity', Sort.desc);
    });
  }

  QueryBuilder<DailyCollectionData, DailyCollectionData, QAfterSortBy>
      sortByTotalAmount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalAmount', Sort.asc);
    });
  }

  QueryBuilder<DailyCollectionData, DailyCollectionData, QAfterSortBy>
      sortByTotalAmountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalAmount', Sort.desc);
    });
  }

  QueryBuilder<DailyCollectionData, DailyCollectionData, QAfterSortBy>
      sortByTotalCan() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalCan', Sort.asc);
    });
  }

  QueryBuilder<DailyCollectionData, DailyCollectionData, QAfterSortBy>
      sortByTotalCanDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalCan', Sort.desc);
    });
  }
}

extension DailyCollectionDataQuerySortThenBy
    on QueryBuilder<DailyCollectionData, DailyCollectionData, QSortThenBy> {
  QueryBuilder<DailyCollectionData, DailyCollectionData, QAfterSortBy>
      thenByAdminId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'adminId', Sort.asc);
    });
  }

  QueryBuilder<DailyCollectionData, DailyCollectionData, QAfterSortBy>
      thenByAdminIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'adminId', Sort.desc);
    });
  }

  QueryBuilder<DailyCollectionData, DailyCollectionData, QAfterSortBy>
      thenByAvgFat() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'avgFat', Sort.asc);
    });
  }

  QueryBuilder<DailyCollectionData, DailyCollectionData, QAfterSortBy>
      thenByAvgFatDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'avgFat', Sort.desc);
    });
  }

  QueryBuilder<DailyCollectionData, DailyCollectionData, QAfterSortBy>
      thenByAvgSnf() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'avgSnf', Sort.asc);
    });
  }

  QueryBuilder<DailyCollectionData, DailyCollectionData, QAfterSortBy>
      thenByAvgSnfDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'avgSnf', Sort.desc);
    });
  }

  QueryBuilder<DailyCollectionData, DailyCollectionData, QAfterSortBy>
      thenByCustomerCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'customerCount', Sort.asc);
    });
  }

  QueryBuilder<DailyCollectionData, DailyCollectionData, QAfterSortBy>
      thenByCustomerCountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'customerCount', Sort.desc);
    });
  }

  QueryBuilder<DailyCollectionData, DailyCollectionData, QAfterSortBy>
      thenByDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.asc);
    });
  }

  QueryBuilder<DailyCollectionData, DailyCollectionData, QAfterSortBy>
      thenByDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.desc);
    });
  }

  QueryBuilder<DailyCollectionData, DailyCollectionData, QAfterSortBy>
      thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<DailyCollectionData, DailyCollectionData, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<DailyCollectionData, DailyCollectionData, QAfterSortBy>
      thenByMilkType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'milkType', Sort.asc);
    });
  }

  QueryBuilder<DailyCollectionData, DailyCollectionData, QAfterSortBy>
      thenByMilkTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'milkType', Sort.desc);
    });
  }

  QueryBuilder<DailyCollectionData, DailyCollectionData, QAfterSortBy>
      thenByQuantity() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'quantity', Sort.asc);
    });
  }

  QueryBuilder<DailyCollectionData, DailyCollectionData, QAfterSortBy>
      thenByQuantityDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'quantity', Sort.desc);
    });
  }

  QueryBuilder<DailyCollectionData, DailyCollectionData, QAfterSortBy>
      thenByTotalAmount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalAmount', Sort.asc);
    });
  }

  QueryBuilder<DailyCollectionData, DailyCollectionData, QAfterSortBy>
      thenByTotalAmountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalAmount', Sort.desc);
    });
  }

  QueryBuilder<DailyCollectionData, DailyCollectionData, QAfterSortBy>
      thenByTotalCan() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalCan', Sort.asc);
    });
  }

  QueryBuilder<DailyCollectionData, DailyCollectionData, QAfterSortBy>
      thenByTotalCanDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalCan', Sort.desc);
    });
  }
}

extension DailyCollectionDataQueryWhereDistinct
    on QueryBuilder<DailyCollectionData, DailyCollectionData, QDistinct> {
  QueryBuilder<DailyCollectionData, DailyCollectionData, QDistinct>
      distinctByAdminId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'adminId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<DailyCollectionData, DailyCollectionData, QDistinct>
      distinctByAvgFat() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'avgFat');
    });
  }

  QueryBuilder<DailyCollectionData, DailyCollectionData, QDistinct>
      distinctByAvgSnf() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'avgSnf');
    });
  }

  QueryBuilder<DailyCollectionData, DailyCollectionData, QDistinct>
      distinctByCustomerCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'customerCount');
    });
  }

  QueryBuilder<DailyCollectionData, DailyCollectionData, QDistinct>
      distinctByDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'date');
    });
  }

  QueryBuilder<DailyCollectionData, DailyCollectionData, QDistinct>
      distinctByMilkType() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'milkType');
    });
  }

  QueryBuilder<DailyCollectionData, DailyCollectionData, QDistinct>
      distinctByQuantity() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'quantity');
    });
  }

  QueryBuilder<DailyCollectionData, DailyCollectionData, QDistinct>
      distinctByTotalAmount() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'totalAmount');
    });
  }

  QueryBuilder<DailyCollectionData, DailyCollectionData, QDistinct>
      distinctByTotalCan() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'totalCan');
    });
  }
}

extension DailyCollectionDataQueryProperty
    on QueryBuilder<DailyCollectionData, DailyCollectionData, QQueryProperty> {
  QueryBuilder<DailyCollectionData, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<DailyCollectionData, String, QQueryOperations>
      adminIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'adminId');
    });
  }

  QueryBuilder<DailyCollectionData, double, QQueryOperations> avgFatProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'avgFat');
    });
  }

  QueryBuilder<DailyCollectionData, double, QQueryOperations> avgSnfProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'avgSnf');
    });
  }

  QueryBuilder<DailyCollectionData, int, QQueryOperations>
      customerCountProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'customerCount');
    });
  }

  QueryBuilder<DailyCollectionData, DateTime, QQueryOperations> dateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'date');
    });
  }

  QueryBuilder<DailyCollectionData, int, QQueryOperations> milkTypeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'milkType');
    });
  }

  QueryBuilder<DailyCollectionData, double, QQueryOperations>
      quantityProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'quantity');
    });
  }

  QueryBuilder<DailyCollectionData, double, QQueryOperations>
      totalAmountProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'totalAmount');
    });
  }

  QueryBuilder<DailyCollectionData, int, QQueryOperations> totalCanProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'totalCan');
    });
  }
}
