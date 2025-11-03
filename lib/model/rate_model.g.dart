// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rate_model.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetRateModelCollection on Isar {
  IsarCollection<RateModel> get rateModels => this.collection();
}

const RateModelSchema = CollectionSchema(
  name: r'RateModel',
  id: -6016065698018055469,
  properties: {
    r'col': PropertySchema(
      id: 0,
      name: r'col',
      type: IsarType.long,
    ),
    r'date': PropertySchema(
      id: 1,
      name: r'date',
      type: IsarType.dateTime,
    ),
    r'excelJson': PropertySchema(
      id: 2,
      name: r'excelJson',
      type: IsarType.string,
    ),
    r'increment': PropertySchema(
      id: 3,
      name: r'increment',
      type: IsarType.double,
    ),
    r'isCurrent': PropertySchema(
      id: 4,
      name: r'isCurrent',
      type: IsarType.bool,
    ),
    r'maxFat': PropertySchema(
      id: 5,
      name: r'maxFat',
      type: IsarType.double,
    ),
    r'maxRate': PropertySchema(
      id: 6,
      name: r'maxRate',
      type: IsarType.double,
    ),
    r'maxsnf': PropertySchema(
      id: 7,
      name: r'maxsnf',
      type: IsarType.double,
    ),
    r'milkType': PropertySchema(
      id: 8,
      name: r'milkType',
      type: IsarType.long,
    ),
    r'minFat': PropertySchema(
      id: 9,
      name: r'minFat',
      type: IsarType.double,
    ),
    r'minRate': PropertySchema(
      id: 10,
      name: r'minRate',
      type: IsarType.double,
    ),
    r'minsnf': PropertySchema(
      id: 11,
      name: r'minsnf',
      type: IsarType.double,
    ),
    r'name': PropertySchema(
      id: 12,
      name: r'name',
      type: IsarType.string,
    ),
    r'row': PropertySchema(
      id: 13,
      name: r'row',
      type: IsarType.long,
    )
  },
  estimateSize: _rateModelEstimateSize,
  serialize: _rateModelSerialize,
  deserialize: _rateModelDeserialize,
  deserializeProp: _rateModelDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _rateModelGetId,
  getLinks: _rateModelGetLinks,
  attach: _rateModelAttach,
  version: '3.1.0+1',
);

int _rateModelEstimateSize(
  RateModel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.excelJson.length * 3;
  bytesCount += 3 + object.name.length * 3;
  return bytesCount;
}

void _rateModelSerialize(
  RateModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.col);
  writer.writeDateTime(offsets[1], object.date);
  writer.writeString(offsets[2], object.excelJson);
  writer.writeDouble(offsets[3], object.increment);
  writer.writeBool(offsets[4], object.isCurrent);
  writer.writeDouble(offsets[5], object.maxFat);
  writer.writeDouble(offsets[6], object.maxRate);
  writer.writeDouble(offsets[7], object.maxsnf);
  writer.writeLong(offsets[8], object.milkType);
  writer.writeDouble(offsets[9], object.minFat);
  writer.writeDouble(offsets[10], object.minRate);
  writer.writeDouble(offsets[11], object.minsnf);
  writer.writeString(offsets[12], object.name);
  writer.writeLong(offsets[13], object.row);
}

RateModel _rateModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = RateModel(
    col: reader.readLong(offsets[0]),
    date: reader.readDateTime(offsets[1]),
    excelJson: reader.readString(offsets[2]),
    increment: reader.readDouble(offsets[3]),
    isCurrent: reader.readBool(offsets[4]),
    maxFat: reader.readDouble(offsets[5]),
    maxRate: reader.readDouble(offsets[6]),
    maxsnf: reader.readDouble(offsets[7]),
    milkType: reader.readLong(offsets[8]),
    minFat: reader.readDouble(offsets[9]),
    minRate: reader.readDouble(offsets[10]),
    minsnf: reader.readDouble(offsets[11]),
    name: reader.readString(offsets[12]),
    row: reader.readLong(offsets[13]),
  );
  object.id = id;
  return object;
}

P _rateModelDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLong(offset)) as P;
    case 1:
      return (reader.readDateTime(offset)) as P;
    case 2:
      return (reader.readString(offset)) as P;
    case 3:
      return (reader.readDouble(offset)) as P;
    case 4:
      return (reader.readBool(offset)) as P;
    case 5:
      return (reader.readDouble(offset)) as P;
    case 6:
      return (reader.readDouble(offset)) as P;
    case 7:
      return (reader.readDouble(offset)) as P;
    case 8:
      return (reader.readLong(offset)) as P;
    case 9:
      return (reader.readDouble(offset)) as P;
    case 10:
      return (reader.readDouble(offset)) as P;
    case 11:
      return (reader.readDouble(offset)) as P;
    case 12:
      return (reader.readString(offset)) as P;
    case 13:
      return (reader.readLong(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _rateModelGetId(RateModel object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _rateModelGetLinks(RateModel object) {
  return [];
}

void _rateModelAttach(IsarCollection<dynamic> col, Id id, RateModel object) {
  object.id = id;
}

extension RateModelQueryWhereSort
    on QueryBuilder<RateModel, RateModel, QWhere> {
  QueryBuilder<RateModel, RateModel, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension RateModelQueryWhere
    on QueryBuilder<RateModel, RateModel, QWhereClause> {
  QueryBuilder<RateModel, RateModel, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<RateModel, RateModel, QAfterWhereClause> idNotEqualTo(Id id) {
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

  QueryBuilder<RateModel, RateModel, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<RateModel, RateModel, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<RateModel, RateModel, QAfterWhereClause> idBetween(
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

extension RateModelQueryFilter
    on QueryBuilder<RateModel, RateModel, QFilterCondition> {
  QueryBuilder<RateModel, RateModel, QAfterFilterCondition> colEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'col',
        value: value,
      ));
    });
  }

  QueryBuilder<RateModel, RateModel, QAfterFilterCondition> colGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'col',
        value: value,
      ));
    });
  }

  QueryBuilder<RateModel, RateModel, QAfterFilterCondition> colLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'col',
        value: value,
      ));
    });
  }

  QueryBuilder<RateModel, RateModel, QAfterFilterCondition> colBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'col',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<RateModel, RateModel, QAfterFilterCondition> dateEqualTo(
      DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'date',
        value: value,
      ));
    });
  }

  QueryBuilder<RateModel, RateModel, QAfterFilterCondition> dateGreaterThan(
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

  QueryBuilder<RateModel, RateModel, QAfterFilterCondition> dateLessThan(
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

  QueryBuilder<RateModel, RateModel, QAfterFilterCondition> dateBetween(
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

  QueryBuilder<RateModel, RateModel, QAfterFilterCondition> excelJsonEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'excelJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RateModel, RateModel, QAfterFilterCondition>
      excelJsonGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'excelJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RateModel, RateModel, QAfterFilterCondition> excelJsonLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'excelJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RateModel, RateModel, QAfterFilterCondition> excelJsonBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'excelJson',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RateModel, RateModel, QAfterFilterCondition> excelJsonStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'excelJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RateModel, RateModel, QAfterFilterCondition> excelJsonEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'excelJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RateModel, RateModel, QAfterFilterCondition> excelJsonContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'excelJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RateModel, RateModel, QAfterFilterCondition> excelJsonMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'excelJson',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RateModel, RateModel, QAfterFilterCondition> excelJsonIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'excelJson',
        value: '',
      ));
    });
  }

  QueryBuilder<RateModel, RateModel, QAfterFilterCondition>
      excelJsonIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'excelJson',
        value: '',
      ));
    });
  }

  QueryBuilder<RateModel, RateModel, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<RateModel, RateModel, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<RateModel, RateModel, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<RateModel, RateModel, QAfterFilterCondition> idBetween(
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

  QueryBuilder<RateModel, RateModel, QAfterFilterCondition> incrementEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'increment',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<RateModel, RateModel, QAfterFilterCondition>
      incrementGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'increment',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<RateModel, RateModel, QAfterFilterCondition> incrementLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'increment',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<RateModel, RateModel, QAfterFilterCondition> incrementBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'increment',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<RateModel, RateModel, QAfterFilterCondition> isCurrentEqualTo(
      bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isCurrent',
        value: value,
      ));
    });
  }

  QueryBuilder<RateModel, RateModel, QAfterFilterCondition> maxFatEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'maxFat',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<RateModel, RateModel, QAfterFilterCondition> maxFatGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'maxFat',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<RateModel, RateModel, QAfterFilterCondition> maxFatLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'maxFat',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<RateModel, RateModel, QAfterFilterCondition> maxFatBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'maxFat',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<RateModel, RateModel, QAfterFilterCondition> maxRateEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'maxRate',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<RateModel, RateModel, QAfterFilterCondition> maxRateGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'maxRate',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<RateModel, RateModel, QAfterFilterCondition> maxRateLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'maxRate',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<RateModel, RateModel, QAfterFilterCondition> maxRateBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'maxRate',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<RateModel, RateModel, QAfterFilterCondition> maxsnfEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'maxsnf',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<RateModel, RateModel, QAfterFilterCondition> maxsnfGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'maxsnf',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<RateModel, RateModel, QAfterFilterCondition> maxsnfLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'maxsnf',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<RateModel, RateModel, QAfterFilterCondition> maxsnfBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'maxsnf',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<RateModel, RateModel, QAfterFilterCondition> milkTypeEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'milkType',
        value: value,
      ));
    });
  }

  QueryBuilder<RateModel, RateModel, QAfterFilterCondition> milkTypeGreaterThan(
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

  QueryBuilder<RateModel, RateModel, QAfterFilterCondition> milkTypeLessThan(
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

  QueryBuilder<RateModel, RateModel, QAfterFilterCondition> milkTypeBetween(
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

  QueryBuilder<RateModel, RateModel, QAfterFilterCondition> minFatEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'minFat',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<RateModel, RateModel, QAfterFilterCondition> minFatGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'minFat',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<RateModel, RateModel, QAfterFilterCondition> minFatLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'minFat',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<RateModel, RateModel, QAfterFilterCondition> minFatBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'minFat',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<RateModel, RateModel, QAfterFilterCondition> minRateEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'minRate',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<RateModel, RateModel, QAfterFilterCondition> minRateGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'minRate',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<RateModel, RateModel, QAfterFilterCondition> minRateLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'minRate',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<RateModel, RateModel, QAfterFilterCondition> minRateBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'minRate',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<RateModel, RateModel, QAfterFilterCondition> minsnfEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'minsnf',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<RateModel, RateModel, QAfterFilterCondition> minsnfGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'minsnf',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<RateModel, RateModel, QAfterFilterCondition> minsnfLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'minsnf',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<RateModel, RateModel, QAfterFilterCondition> minsnfBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'minsnf',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<RateModel, RateModel, QAfterFilterCondition> nameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RateModel, RateModel, QAfterFilterCondition> nameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RateModel, RateModel, QAfterFilterCondition> nameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RateModel, RateModel, QAfterFilterCondition> nameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'name',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RateModel, RateModel, QAfterFilterCondition> nameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RateModel, RateModel, QAfterFilterCondition> nameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RateModel, RateModel, QAfterFilterCondition> nameContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RateModel, RateModel, QAfterFilterCondition> nameMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'name',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RateModel, RateModel, QAfterFilterCondition> nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<RateModel, RateModel, QAfterFilterCondition> nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<RateModel, RateModel, QAfterFilterCondition> rowEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'row',
        value: value,
      ));
    });
  }

  QueryBuilder<RateModel, RateModel, QAfterFilterCondition> rowGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'row',
        value: value,
      ));
    });
  }

  QueryBuilder<RateModel, RateModel, QAfterFilterCondition> rowLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'row',
        value: value,
      ));
    });
  }

  QueryBuilder<RateModel, RateModel, QAfterFilterCondition> rowBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'row',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension RateModelQueryObject
    on QueryBuilder<RateModel, RateModel, QFilterCondition> {}

extension RateModelQueryLinks
    on QueryBuilder<RateModel, RateModel, QFilterCondition> {}

extension RateModelQuerySortBy on QueryBuilder<RateModel, RateModel, QSortBy> {
  QueryBuilder<RateModel, RateModel, QAfterSortBy> sortByCol() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'col', Sort.asc);
    });
  }

  QueryBuilder<RateModel, RateModel, QAfterSortBy> sortByColDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'col', Sort.desc);
    });
  }

  QueryBuilder<RateModel, RateModel, QAfterSortBy> sortByDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.asc);
    });
  }

  QueryBuilder<RateModel, RateModel, QAfterSortBy> sortByDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.desc);
    });
  }

  QueryBuilder<RateModel, RateModel, QAfterSortBy> sortByExcelJson() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'excelJson', Sort.asc);
    });
  }

  QueryBuilder<RateModel, RateModel, QAfterSortBy> sortByExcelJsonDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'excelJson', Sort.desc);
    });
  }

  QueryBuilder<RateModel, RateModel, QAfterSortBy> sortByIncrement() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'increment', Sort.asc);
    });
  }

  QueryBuilder<RateModel, RateModel, QAfterSortBy> sortByIncrementDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'increment', Sort.desc);
    });
  }

  QueryBuilder<RateModel, RateModel, QAfterSortBy> sortByIsCurrent() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isCurrent', Sort.asc);
    });
  }

  QueryBuilder<RateModel, RateModel, QAfterSortBy> sortByIsCurrentDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isCurrent', Sort.desc);
    });
  }

  QueryBuilder<RateModel, RateModel, QAfterSortBy> sortByMaxFat() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'maxFat', Sort.asc);
    });
  }

  QueryBuilder<RateModel, RateModel, QAfterSortBy> sortByMaxFatDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'maxFat', Sort.desc);
    });
  }

  QueryBuilder<RateModel, RateModel, QAfterSortBy> sortByMaxRate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'maxRate', Sort.asc);
    });
  }

  QueryBuilder<RateModel, RateModel, QAfterSortBy> sortByMaxRateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'maxRate', Sort.desc);
    });
  }

  QueryBuilder<RateModel, RateModel, QAfterSortBy> sortByMaxsnf() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'maxsnf', Sort.asc);
    });
  }

  QueryBuilder<RateModel, RateModel, QAfterSortBy> sortByMaxsnfDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'maxsnf', Sort.desc);
    });
  }

  QueryBuilder<RateModel, RateModel, QAfterSortBy> sortByMilkType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'milkType', Sort.asc);
    });
  }

  QueryBuilder<RateModel, RateModel, QAfterSortBy> sortByMilkTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'milkType', Sort.desc);
    });
  }

  QueryBuilder<RateModel, RateModel, QAfterSortBy> sortByMinFat() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'minFat', Sort.asc);
    });
  }

  QueryBuilder<RateModel, RateModel, QAfterSortBy> sortByMinFatDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'minFat', Sort.desc);
    });
  }

  QueryBuilder<RateModel, RateModel, QAfterSortBy> sortByMinRate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'minRate', Sort.asc);
    });
  }

  QueryBuilder<RateModel, RateModel, QAfterSortBy> sortByMinRateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'minRate', Sort.desc);
    });
  }

  QueryBuilder<RateModel, RateModel, QAfterSortBy> sortByMinsnf() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'minsnf', Sort.asc);
    });
  }

  QueryBuilder<RateModel, RateModel, QAfterSortBy> sortByMinsnfDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'minsnf', Sort.desc);
    });
  }

  QueryBuilder<RateModel, RateModel, QAfterSortBy> sortByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<RateModel, RateModel, QAfterSortBy> sortByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<RateModel, RateModel, QAfterSortBy> sortByRow() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'row', Sort.asc);
    });
  }

  QueryBuilder<RateModel, RateModel, QAfterSortBy> sortByRowDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'row', Sort.desc);
    });
  }
}

extension RateModelQuerySortThenBy
    on QueryBuilder<RateModel, RateModel, QSortThenBy> {
  QueryBuilder<RateModel, RateModel, QAfterSortBy> thenByCol() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'col', Sort.asc);
    });
  }

  QueryBuilder<RateModel, RateModel, QAfterSortBy> thenByColDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'col', Sort.desc);
    });
  }

  QueryBuilder<RateModel, RateModel, QAfterSortBy> thenByDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.asc);
    });
  }

  QueryBuilder<RateModel, RateModel, QAfterSortBy> thenByDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.desc);
    });
  }

  QueryBuilder<RateModel, RateModel, QAfterSortBy> thenByExcelJson() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'excelJson', Sort.asc);
    });
  }

  QueryBuilder<RateModel, RateModel, QAfterSortBy> thenByExcelJsonDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'excelJson', Sort.desc);
    });
  }

  QueryBuilder<RateModel, RateModel, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<RateModel, RateModel, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<RateModel, RateModel, QAfterSortBy> thenByIncrement() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'increment', Sort.asc);
    });
  }

  QueryBuilder<RateModel, RateModel, QAfterSortBy> thenByIncrementDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'increment', Sort.desc);
    });
  }

  QueryBuilder<RateModel, RateModel, QAfterSortBy> thenByIsCurrent() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isCurrent', Sort.asc);
    });
  }

  QueryBuilder<RateModel, RateModel, QAfterSortBy> thenByIsCurrentDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isCurrent', Sort.desc);
    });
  }

  QueryBuilder<RateModel, RateModel, QAfterSortBy> thenByMaxFat() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'maxFat', Sort.asc);
    });
  }

  QueryBuilder<RateModel, RateModel, QAfterSortBy> thenByMaxFatDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'maxFat', Sort.desc);
    });
  }

  QueryBuilder<RateModel, RateModel, QAfterSortBy> thenByMaxRate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'maxRate', Sort.asc);
    });
  }

  QueryBuilder<RateModel, RateModel, QAfterSortBy> thenByMaxRateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'maxRate', Sort.desc);
    });
  }

  QueryBuilder<RateModel, RateModel, QAfterSortBy> thenByMaxsnf() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'maxsnf', Sort.asc);
    });
  }

  QueryBuilder<RateModel, RateModel, QAfterSortBy> thenByMaxsnfDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'maxsnf', Sort.desc);
    });
  }

  QueryBuilder<RateModel, RateModel, QAfterSortBy> thenByMilkType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'milkType', Sort.asc);
    });
  }

  QueryBuilder<RateModel, RateModel, QAfterSortBy> thenByMilkTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'milkType', Sort.desc);
    });
  }

  QueryBuilder<RateModel, RateModel, QAfterSortBy> thenByMinFat() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'minFat', Sort.asc);
    });
  }

  QueryBuilder<RateModel, RateModel, QAfterSortBy> thenByMinFatDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'minFat', Sort.desc);
    });
  }

  QueryBuilder<RateModel, RateModel, QAfterSortBy> thenByMinRate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'minRate', Sort.asc);
    });
  }

  QueryBuilder<RateModel, RateModel, QAfterSortBy> thenByMinRateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'minRate', Sort.desc);
    });
  }

  QueryBuilder<RateModel, RateModel, QAfterSortBy> thenByMinsnf() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'minsnf', Sort.asc);
    });
  }

  QueryBuilder<RateModel, RateModel, QAfterSortBy> thenByMinsnfDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'minsnf', Sort.desc);
    });
  }

  QueryBuilder<RateModel, RateModel, QAfterSortBy> thenByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<RateModel, RateModel, QAfterSortBy> thenByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<RateModel, RateModel, QAfterSortBy> thenByRow() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'row', Sort.asc);
    });
  }

  QueryBuilder<RateModel, RateModel, QAfterSortBy> thenByRowDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'row', Sort.desc);
    });
  }
}

extension RateModelQueryWhereDistinct
    on QueryBuilder<RateModel, RateModel, QDistinct> {
  QueryBuilder<RateModel, RateModel, QDistinct> distinctByCol() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'col');
    });
  }

  QueryBuilder<RateModel, RateModel, QDistinct> distinctByDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'date');
    });
  }

  QueryBuilder<RateModel, RateModel, QDistinct> distinctByExcelJson(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'excelJson', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<RateModel, RateModel, QDistinct> distinctByIncrement() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'increment');
    });
  }

  QueryBuilder<RateModel, RateModel, QDistinct> distinctByIsCurrent() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isCurrent');
    });
  }

  QueryBuilder<RateModel, RateModel, QDistinct> distinctByMaxFat() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'maxFat');
    });
  }

  QueryBuilder<RateModel, RateModel, QDistinct> distinctByMaxRate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'maxRate');
    });
  }

  QueryBuilder<RateModel, RateModel, QDistinct> distinctByMaxsnf() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'maxsnf');
    });
  }

  QueryBuilder<RateModel, RateModel, QDistinct> distinctByMilkType() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'milkType');
    });
  }

  QueryBuilder<RateModel, RateModel, QDistinct> distinctByMinFat() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'minFat');
    });
  }

  QueryBuilder<RateModel, RateModel, QDistinct> distinctByMinRate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'minRate');
    });
  }

  QueryBuilder<RateModel, RateModel, QDistinct> distinctByMinsnf() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'minsnf');
    });
  }

  QueryBuilder<RateModel, RateModel, QDistinct> distinctByName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'name', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<RateModel, RateModel, QDistinct> distinctByRow() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'row');
    });
  }
}

extension RateModelQueryProperty
    on QueryBuilder<RateModel, RateModel, QQueryProperty> {
  QueryBuilder<RateModel, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<RateModel, int, QQueryOperations> colProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'col');
    });
  }

  QueryBuilder<RateModel, DateTime, QQueryOperations> dateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'date');
    });
  }

  QueryBuilder<RateModel, String, QQueryOperations> excelJsonProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'excelJson');
    });
  }

  QueryBuilder<RateModel, double, QQueryOperations> incrementProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'increment');
    });
  }

  QueryBuilder<RateModel, bool, QQueryOperations> isCurrentProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isCurrent');
    });
  }

  QueryBuilder<RateModel, double, QQueryOperations> maxFatProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'maxFat');
    });
  }

  QueryBuilder<RateModel, double, QQueryOperations> maxRateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'maxRate');
    });
  }

  QueryBuilder<RateModel, double, QQueryOperations> maxsnfProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'maxsnf');
    });
  }

  QueryBuilder<RateModel, int, QQueryOperations> milkTypeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'milkType');
    });
  }

  QueryBuilder<RateModel, double, QQueryOperations> minFatProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'minFat');
    });
  }

  QueryBuilder<RateModel, double, QQueryOperations> minRateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'minRate');
    });
  }

  QueryBuilder<RateModel, double, QQueryOperations> minsnfProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'minsnf');
    });
  }

  QueryBuilder<RateModel, String, QQueryOperations> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'name');
    });
  }

  QueryBuilder<RateModel, int, QQueryOperations> rowProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'row');
    });
  }
}
