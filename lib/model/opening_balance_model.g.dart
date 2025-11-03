// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'opening_balance_model.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetOpeningBalanceCollection on Isar {
  IsarCollection<OpeningBalance> get openingBalances => this.collection();
}

const OpeningBalanceSchema = CollectionSchema(
  name: r'OpeningBalance',
  id: 7485235766160790336,
  properties: {
    r'clBal': PropertySchema(
      id: 0,
      name: r'clBal',
      type: IsarType.double,
    ),
    r'clTot': PropertySchema(
      id: 1,
      name: r'clTot',
      type: IsarType.double,
    ),
    r'crTot': PropertySchema(
      id: 2,
      name: r'crTot',
      type: IsarType.double,
    ),
    r'customerCode': PropertySchema(
      id: 3,
      name: r'customerCode',
      type: IsarType.string,
    ),
    r'deductionCode': PropertySchema(
      id: 4,
      name: r'deductionCode',
      type: IsarType.string,
    ),
    r'drTot': PropertySchema(
      id: 5,
      name: r'drTot',
      type: IsarType.double,
    ),
    r'openingBalance': PropertySchema(
      id: 6,
      name: r'openingBalance',
      type: IsarType.double,
    )
  },
  estimateSize: _openingBalanceEstimateSize,
  serialize: _openingBalanceSerialize,
  deserialize: _openingBalanceDeserialize,
  deserializeProp: _openingBalanceDeserializeProp,
  idName: r'id',
  indexes: {
    r'deductionCode_customerCode': IndexSchema(
      id: -5443016035470412815,
      name: r'deductionCode_customerCode',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'deductionCode',
          type: IndexType.hash,
          caseSensitive: true,
        ),
        IndexPropertySchema(
          name: r'customerCode',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _openingBalanceGetId,
  getLinks: _openingBalanceGetLinks,
  attach: _openingBalanceAttach,
  version: '3.1.0+1',
);

int _openingBalanceEstimateSize(
  OpeningBalance object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.customerCode.length * 3;
  bytesCount += 3 + object.deductionCode.length * 3;
  return bytesCount;
}

void _openingBalanceSerialize(
  OpeningBalance object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDouble(offsets[0], object.clBal);
  writer.writeDouble(offsets[1], object.clTot);
  writer.writeDouble(offsets[2], object.crTot);
  writer.writeString(offsets[3], object.customerCode);
  writer.writeString(offsets[4], object.deductionCode);
  writer.writeDouble(offsets[5], object.drTot);
  writer.writeDouble(offsets[6], object.openingBalance);
}

OpeningBalance _openingBalanceDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = OpeningBalance(
    clBal: reader.readDouble(offsets[0]),
    clTot: reader.readDouble(offsets[1]),
    crTot: reader.readDouble(offsets[2]),
    customerCode: reader.readString(offsets[3]),
    deductionCode: reader.readString(offsets[4]),
    drTot: reader.readDouble(offsets[5]),
    openingBalance: reader.readDouble(offsets[6]),
  );
  object.id = id;
  return object;
}

P _openingBalanceDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDouble(offset)) as P;
    case 1:
      return (reader.readDouble(offset)) as P;
    case 2:
      return (reader.readDouble(offset)) as P;
    case 3:
      return (reader.readString(offset)) as P;
    case 4:
      return (reader.readString(offset)) as P;
    case 5:
      return (reader.readDouble(offset)) as P;
    case 6:
      return (reader.readDouble(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _openingBalanceGetId(OpeningBalance object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _openingBalanceGetLinks(OpeningBalance object) {
  return [];
}

void _openingBalanceAttach(
    IsarCollection<dynamic> col, Id id, OpeningBalance object) {
  object.id = id;
}

extension OpeningBalanceQueryWhereSort
    on QueryBuilder<OpeningBalance, OpeningBalance, QWhere> {
  QueryBuilder<OpeningBalance, OpeningBalance, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension OpeningBalanceQueryWhere
    on QueryBuilder<OpeningBalance, OpeningBalance, QWhereClause> {
  QueryBuilder<OpeningBalance, OpeningBalance, QAfterWhereClause> idEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<OpeningBalance, OpeningBalance, QAfterWhereClause> idNotEqualTo(
      Id id) {
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

  QueryBuilder<OpeningBalance, OpeningBalance, QAfterWhereClause> idGreaterThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<OpeningBalance, OpeningBalance, QAfterWhereClause> idLessThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<OpeningBalance, OpeningBalance, QAfterWhereClause> idBetween(
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

  QueryBuilder<OpeningBalance, OpeningBalance, QAfterWhereClause>
      deductionCodeEqualToAnyCustomerCode(String deductionCode) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'deductionCode_customerCode',
        value: [deductionCode],
      ));
    });
  }

  QueryBuilder<OpeningBalance, OpeningBalance, QAfterWhereClause>
      deductionCodeNotEqualToAnyCustomerCode(String deductionCode) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'deductionCode_customerCode',
              lower: [],
              upper: [deductionCode],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'deductionCode_customerCode',
              lower: [deductionCode],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'deductionCode_customerCode',
              lower: [deductionCode],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'deductionCode_customerCode',
              lower: [],
              upper: [deductionCode],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<OpeningBalance, OpeningBalance, QAfterWhereClause>
      deductionCodeCustomerCodeEqualTo(
          String deductionCode, String customerCode) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'deductionCode_customerCode',
        value: [deductionCode, customerCode],
      ));
    });
  }

  QueryBuilder<OpeningBalance, OpeningBalance, QAfterWhereClause>
      deductionCodeEqualToCustomerCodeNotEqualTo(
          String deductionCode, String customerCode) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'deductionCode_customerCode',
              lower: [deductionCode],
              upper: [deductionCode, customerCode],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'deductionCode_customerCode',
              lower: [deductionCode, customerCode],
              includeLower: false,
              upper: [deductionCode],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'deductionCode_customerCode',
              lower: [deductionCode, customerCode],
              includeLower: false,
              upper: [deductionCode],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'deductionCode_customerCode',
              lower: [deductionCode],
              upper: [deductionCode, customerCode],
              includeUpper: false,
            ));
      }
    });
  }
}

extension OpeningBalanceQueryFilter
    on QueryBuilder<OpeningBalance, OpeningBalance, QFilterCondition> {
  QueryBuilder<OpeningBalance, OpeningBalance, QAfterFilterCondition>
      clBalEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'clBal',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<OpeningBalance, OpeningBalance, QAfterFilterCondition>
      clBalGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'clBal',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<OpeningBalance, OpeningBalance, QAfterFilterCondition>
      clBalLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'clBal',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<OpeningBalance, OpeningBalance, QAfterFilterCondition>
      clBalBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'clBal',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<OpeningBalance, OpeningBalance, QAfterFilterCondition>
      clTotEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'clTot',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<OpeningBalance, OpeningBalance, QAfterFilterCondition>
      clTotGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'clTot',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<OpeningBalance, OpeningBalance, QAfterFilterCondition>
      clTotLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'clTot',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<OpeningBalance, OpeningBalance, QAfterFilterCondition>
      clTotBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'clTot',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<OpeningBalance, OpeningBalance, QAfterFilterCondition>
      crTotEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'crTot',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<OpeningBalance, OpeningBalance, QAfterFilterCondition>
      crTotGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'crTot',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<OpeningBalance, OpeningBalance, QAfterFilterCondition>
      crTotLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'crTot',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<OpeningBalance, OpeningBalance, QAfterFilterCondition>
      crTotBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'crTot',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<OpeningBalance, OpeningBalance, QAfterFilterCondition>
      customerCodeEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'customerCode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OpeningBalance, OpeningBalance, QAfterFilterCondition>
      customerCodeGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'customerCode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OpeningBalance, OpeningBalance, QAfterFilterCondition>
      customerCodeLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'customerCode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OpeningBalance, OpeningBalance, QAfterFilterCondition>
      customerCodeBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'customerCode',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OpeningBalance, OpeningBalance, QAfterFilterCondition>
      customerCodeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'customerCode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OpeningBalance, OpeningBalance, QAfterFilterCondition>
      customerCodeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'customerCode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OpeningBalance, OpeningBalance, QAfterFilterCondition>
      customerCodeContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'customerCode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OpeningBalance, OpeningBalance, QAfterFilterCondition>
      customerCodeMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'customerCode',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OpeningBalance, OpeningBalance, QAfterFilterCondition>
      customerCodeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'customerCode',
        value: '',
      ));
    });
  }

  QueryBuilder<OpeningBalance, OpeningBalance, QAfterFilterCondition>
      customerCodeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'customerCode',
        value: '',
      ));
    });
  }

  QueryBuilder<OpeningBalance, OpeningBalance, QAfterFilterCondition>
      deductionCodeEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'deductionCode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OpeningBalance, OpeningBalance, QAfterFilterCondition>
      deductionCodeGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'deductionCode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OpeningBalance, OpeningBalance, QAfterFilterCondition>
      deductionCodeLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'deductionCode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OpeningBalance, OpeningBalance, QAfterFilterCondition>
      deductionCodeBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'deductionCode',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OpeningBalance, OpeningBalance, QAfterFilterCondition>
      deductionCodeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'deductionCode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OpeningBalance, OpeningBalance, QAfterFilterCondition>
      deductionCodeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'deductionCode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OpeningBalance, OpeningBalance, QAfterFilterCondition>
      deductionCodeContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'deductionCode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OpeningBalance, OpeningBalance, QAfterFilterCondition>
      deductionCodeMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'deductionCode',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OpeningBalance, OpeningBalance, QAfterFilterCondition>
      deductionCodeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'deductionCode',
        value: '',
      ));
    });
  }

  QueryBuilder<OpeningBalance, OpeningBalance, QAfterFilterCondition>
      deductionCodeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'deductionCode',
        value: '',
      ));
    });
  }

  QueryBuilder<OpeningBalance, OpeningBalance, QAfterFilterCondition>
      drTotEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'drTot',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<OpeningBalance, OpeningBalance, QAfterFilterCondition>
      drTotGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'drTot',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<OpeningBalance, OpeningBalance, QAfterFilterCondition>
      drTotLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'drTot',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<OpeningBalance, OpeningBalance, QAfterFilterCondition>
      drTotBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'drTot',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<OpeningBalance, OpeningBalance, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<OpeningBalance, OpeningBalance, QAfterFilterCondition>
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

  QueryBuilder<OpeningBalance, OpeningBalance, QAfterFilterCondition>
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

  QueryBuilder<OpeningBalance, OpeningBalance, QAfterFilterCondition> idBetween(
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

  QueryBuilder<OpeningBalance, OpeningBalance, QAfterFilterCondition>
      openingBalanceEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'openingBalance',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<OpeningBalance, OpeningBalance, QAfterFilterCondition>
      openingBalanceGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'openingBalance',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<OpeningBalance, OpeningBalance, QAfterFilterCondition>
      openingBalanceLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'openingBalance',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<OpeningBalance, OpeningBalance, QAfterFilterCondition>
      openingBalanceBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'openingBalance',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }
}

extension OpeningBalanceQueryObject
    on QueryBuilder<OpeningBalance, OpeningBalance, QFilterCondition> {}

extension OpeningBalanceQueryLinks
    on QueryBuilder<OpeningBalance, OpeningBalance, QFilterCondition> {}

extension OpeningBalanceQuerySortBy
    on QueryBuilder<OpeningBalance, OpeningBalance, QSortBy> {
  QueryBuilder<OpeningBalance, OpeningBalance, QAfterSortBy> sortByClBal() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'clBal', Sort.asc);
    });
  }

  QueryBuilder<OpeningBalance, OpeningBalance, QAfterSortBy> sortByClBalDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'clBal', Sort.desc);
    });
  }

  QueryBuilder<OpeningBalance, OpeningBalance, QAfterSortBy> sortByClTot() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'clTot', Sort.asc);
    });
  }

  QueryBuilder<OpeningBalance, OpeningBalance, QAfterSortBy> sortByClTotDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'clTot', Sort.desc);
    });
  }

  QueryBuilder<OpeningBalance, OpeningBalance, QAfterSortBy> sortByCrTot() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'crTot', Sort.asc);
    });
  }

  QueryBuilder<OpeningBalance, OpeningBalance, QAfterSortBy> sortByCrTotDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'crTot', Sort.desc);
    });
  }

  QueryBuilder<OpeningBalance, OpeningBalance, QAfterSortBy>
      sortByCustomerCode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'customerCode', Sort.asc);
    });
  }

  QueryBuilder<OpeningBalance, OpeningBalance, QAfterSortBy>
      sortByCustomerCodeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'customerCode', Sort.desc);
    });
  }

  QueryBuilder<OpeningBalance, OpeningBalance, QAfterSortBy>
      sortByDeductionCode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'deductionCode', Sort.asc);
    });
  }

  QueryBuilder<OpeningBalance, OpeningBalance, QAfterSortBy>
      sortByDeductionCodeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'deductionCode', Sort.desc);
    });
  }

  QueryBuilder<OpeningBalance, OpeningBalance, QAfterSortBy> sortByDrTot() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'drTot', Sort.asc);
    });
  }

  QueryBuilder<OpeningBalance, OpeningBalance, QAfterSortBy> sortByDrTotDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'drTot', Sort.desc);
    });
  }

  QueryBuilder<OpeningBalance, OpeningBalance, QAfterSortBy>
      sortByOpeningBalance() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'openingBalance', Sort.asc);
    });
  }

  QueryBuilder<OpeningBalance, OpeningBalance, QAfterSortBy>
      sortByOpeningBalanceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'openingBalance', Sort.desc);
    });
  }
}

extension OpeningBalanceQuerySortThenBy
    on QueryBuilder<OpeningBalance, OpeningBalance, QSortThenBy> {
  QueryBuilder<OpeningBalance, OpeningBalance, QAfterSortBy> thenByClBal() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'clBal', Sort.asc);
    });
  }

  QueryBuilder<OpeningBalance, OpeningBalance, QAfterSortBy> thenByClBalDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'clBal', Sort.desc);
    });
  }

  QueryBuilder<OpeningBalance, OpeningBalance, QAfterSortBy> thenByClTot() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'clTot', Sort.asc);
    });
  }

  QueryBuilder<OpeningBalance, OpeningBalance, QAfterSortBy> thenByClTotDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'clTot', Sort.desc);
    });
  }

  QueryBuilder<OpeningBalance, OpeningBalance, QAfterSortBy> thenByCrTot() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'crTot', Sort.asc);
    });
  }

  QueryBuilder<OpeningBalance, OpeningBalance, QAfterSortBy> thenByCrTotDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'crTot', Sort.desc);
    });
  }

  QueryBuilder<OpeningBalance, OpeningBalance, QAfterSortBy>
      thenByCustomerCode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'customerCode', Sort.asc);
    });
  }

  QueryBuilder<OpeningBalance, OpeningBalance, QAfterSortBy>
      thenByCustomerCodeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'customerCode', Sort.desc);
    });
  }

  QueryBuilder<OpeningBalance, OpeningBalance, QAfterSortBy>
      thenByDeductionCode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'deductionCode', Sort.asc);
    });
  }

  QueryBuilder<OpeningBalance, OpeningBalance, QAfterSortBy>
      thenByDeductionCodeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'deductionCode', Sort.desc);
    });
  }

  QueryBuilder<OpeningBalance, OpeningBalance, QAfterSortBy> thenByDrTot() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'drTot', Sort.asc);
    });
  }

  QueryBuilder<OpeningBalance, OpeningBalance, QAfterSortBy> thenByDrTotDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'drTot', Sort.desc);
    });
  }

  QueryBuilder<OpeningBalance, OpeningBalance, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<OpeningBalance, OpeningBalance, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<OpeningBalance, OpeningBalance, QAfterSortBy>
      thenByOpeningBalance() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'openingBalance', Sort.asc);
    });
  }

  QueryBuilder<OpeningBalance, OpeningBalance, QAfterSortBy>
      thenByOpeningBalanceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'openingBalance', Sort.desc);
    });
  }
}

extension OpeningBalanceQueryWhereDistinct
    on QueryBuilder<OpeningBalance, OpeningBalance, QDistinct> {
  QueryBuilder<OpeningBalance, OpeningBalance, QDistinct> distinctByClBal() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'clBal');
    });
  }

  QueryBuilder<OpeningBalance, OpeningBalance, QDistinct> distinctByClTot() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'clTot');
    });
  }

  QueryBuilder<OpeningBalance, OpeningBalance, QDistinct> distinctByCrTot() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'crTot');
    });
  }

  QueryBuilder<OpeningBalance, OpeningBalance, QDistinct>
      distinctByCustomerCode({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'customerCode', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<OpeningBalance, OpeningBalance, QDistinct>
      distinctByDeductionCode({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'deductionCode',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<OpeningBalance, OpeningBalance, QDistinct> distinctByDrTot() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'drTot');
    });
  }

  QueryBuilder<OpeningBalance, OpeningBalance, QDistinct>
      distinctByOpeningBalance() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'openingBalance');
    });
  }
}

extension OpeningBalanceQueryProperty
    on QueryBuilder<OpeningBalance, OpeningBalance, QQueryProperty> {
  QueryBuilder<OpeningBalance, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<OpeningBalance, double, QQueryOperations> clBalProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'clBal');
    });
  }

  QueryBuilder<OpeningBalance, double, QQueryOperations> clTotProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'clTot');
    });
  }

  QueryBuilder<OpeningBalance, double, QQueryOperations> crTotProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'crTot');
    });
  }

  QueryBuilder<OpeningBalance, String, QQueryOperations>
      customerCodeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'customerCode');
    });
  }

  QueryBuilder<OpeningBalance, String, QQueryOperations>
      deductionCodeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'deductionCode');
    });
  }

  QueryBuilder<OpeningBalance, double, QQueryOperations> drTotProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'drTot');
    });
  }

  QueryBuilder<OpeningBalance, double, QQueryOperations>
      openingBalanceProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'openingBalance');
    });
  }
}
