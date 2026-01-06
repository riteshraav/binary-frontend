// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'deduction_entry_model.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetDeductionEntryCollection on Isar {
  IsarCollection<DeductionEntry> get deductionEntrys => this.collection();
}

const DeductionEntrySchema = CollectionSchema(
  name: r'DeductionEntry',
  id: -8956765157651340543,
  properties: {
    r'adminId': PropertySchema(
      id: 0,
      name: r'adminId',
      type: IsarType.string,
    ),
    r'customerCode': PropertySchema(
      id: 1,
      name: r'customerCode',
      type: IsarType.string,
    ),
    r'dedAmount': PropertySchema(
      id: 2,
      name: r'dedAmount',
      type: IsarType.double,
    ),
    r'dedCode': PropertySchema(
      id: 3,
      name: r'dedCode',
      type: IsarType.string,
    ),
    r'milkType': PropertySchema(
      id: 4,
      name: r'milkType',
      type: IsarType.long,
    )
  },
  estimateSize: _deductionEntryEstimateSize,
  serialize: _deductionEntrySerialize,
  deserialize: _deductionEntryDeserialize,
  deserializeProp: _deductionEntryDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _deductionEntryGetId,
  getLinks: _deductionEntryGetLinks,
  attach: _deductionEntryAttach,
  version: '3.1.0+1',
);

int _deductionEntryEstimateSize(
  DeductionEntry object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.adminId.length * 3;
  bytesCount += 3 + object.customerCode.length * 3;
  bytesCount += 3 + object.dedCode.length * 3;
  return bytesCount;
}

void _deductionEntrySerialize(
  DeductionEntry object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.adminId);
  writer.writeString(offsets[1], object.customerCode);
  writer.writeDouble(offsets[2], object.dedAmount);
  writer.writeString(offsets[3], object.dedCode);
  writer.writeLong(offsets[4], object.milkType);
}

DeductionEntry _deductionEntryDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = DeductionEntry(
    adminId: reader.readString(offsets[0]),
    customerCode: reader.readString(offsets[1]),
    dedAmount: reader.readDouble(offsets[2]),
    dedCode: reader.readString(offsets[3]),
    milkType: reader.readLong(offsets[4]),
  );
  object.id = id;
  return object;
}

P _deductionEntryDeserializeProp<P>(
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
      return (reader.readDouble(offset)) as P;
    case 3:
      return (reader.readString(offset)) as P;
    case 4:
      return (reader.readLong(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _deductionEntryGetId(DeductionEntry object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _deductionEntryGetLinks(DeductionEntry object) {
  return [];
}

void _deductionEntryAttach(
    IsarCollection<dynamic> col, Id id, DeductionEntry object) {
  object.id = id;
}

extension DeductionEntryQueryWhereSort
    on QueryBuilder<DeductionEntry, DeductionEntry, QWhere> {
  QueryBuilder<DeductionEntry, DeductionEntry, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension DeductionEntryQueryWhere
    on QueryBuilder<DeductionEntry, DeductionEntry, QWhereClause> {
  QueryBuilder<DeductionEntry, DeductionEntry, QAfterWhereClause> idEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<DeductionEntry, DeductionEntry, QAfterWhereClause> idNotEqualTo(
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

  QueryBuilder<DeductionEntry, DeductionEntry, QAfterWhereClause> idGreaterThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<DeductionEntry, DeductionEntry, QAfterWhereClause> idLessThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<DeductionEntry, DeductionEntry, QAfterWhereClause> idBetween(
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

extension DeductionEntryQueryFilter
    on QueryBuilder<DeductionEntry, DeductionEntry, QFilterCondition> {
  QueryBuilder<DeductionEntry, DeductionEntry, QAfterFilterCondition>
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

  QueryBuilder<DeductionEntry, DeductionEntry, QAfterFilterCondition>
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

  QueryBuilder<DeductionEntry, DeductionEntry, QAfterFilterCondition>
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

  QueryBuilder<DeductionEntry, DeductionEntry, QAfterFilterCondition>
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

  QueryBuilder<DeductionEntry, DeductionEntry, QAfterFilterCondition>
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

  QueryBuilder<DeductionEntry, DeductionEntry, QAfterFilterCondition>
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

  QueryBuilder<DeductionEntry, DeductionEntry, QAfterFilterCondition>
      adminIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'adminId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DeductionEntry, DeductionEntry, QAfterFilterCondition>
      adminIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'adminId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DeductionEntry, DeductionEntry, QAfterFilterCondition>
      adminIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'adminId',
        value: '',
      ));
    });
  }

  QueryBuilder<DeductionEntry, DeductionEntry, QAfterFilterCondition>
      adminIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'adminId',
        value: '',
      ));
    });
  }

  QueryBuilder<DeductionEntry, DeductionEntry, QAfterFilterCondition>
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

  QueryBuilder<DeductionEntry, DeductionEntry, QAfterFilterCondition>
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

  QueryBuilder<DeductionEntry, DeductionEntry, QAfterFilterCondition>
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

  QueryBuilder<DeductionEntry, DeductionEntry, QAfterFilterCondition>
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

  QueryBuilder<DeductionEntry, DeductionEntry, QAfterFilterCondition>
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

  QueryBuilder<DeductionEntry, DeductionEntry, QAfterFilterCondition>
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

  QueryBuilder<DeductionEntry, DeductionEntry, QAfterFilterCondition>
      customerCodeContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'customerCode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DeductionEntry, DeductionEntry, QAfterFilterCondition>
      customerCodeMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'customerCode',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DeductionEntry, DeductionEntry, QAfterFilterCondition>
      customerCodeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'customerCode',
        value: '',
      ));
    });
  }

  QueryBuilder<DeductionEntry, DeductionEntry, QAfterFilterCondition>
      customerCodeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'customerCode',
        value: '',
      ));
    });
  }

  QueryBuilder<DeductionEntry, DeductionEntry, QAfterFilterCondition>
      dedAmountEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'dedAmount',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<DeductionEntry, DeductionEntry, QAfterFilterCondition>
      dedAmountGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'dedAmount',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<DeductionEntry, DeductionEntry, QAfterFilterCondition>
      dedAmountLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'dedAmount',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<DeductionEntry, DeductionEntry, QAfterFilterCondition>
      dedAmountBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'dedAmount',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<DeductionEntry, DeductionEntry, QAfterFilterCondition>
      dedCodeEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'dedCode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DeductionEntry, DeductionEntry, QAfterFilterCondition>
      dedCodeGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'dedCode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DeductionEntry, DeductionEntry, QAfterFilterCondition>
      dedCodeLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'dedCode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DeductionEntry, DeductionEntry, QAfterFilterCondition>
      dedCodeBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'dedCode',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DeductionEntry, DeductionEntry, QAfterFilterCondition>
      dedCodeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'dedCode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DeductionEntry, DeductionEntry, QAfterFilterCondition>
      dedCodeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'dedCode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DeductionEntry, DeductionEntry, QAfterFilterCondition>
      dedCodeContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'dedCode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DeductionEntry, DeductionEntry, QAfterFilterCondition>
      dedCodeMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'dedCode',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DeductionEntry, DeductionEntry, QAfterFilterCondition>
      dedCodeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'dedCode',
        value: '',
      ));
    });
  }

  QueryBuilder<DeductionEntry, DeductionEntry, QAfterFilterCondition>
      dedCodeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'dedCode',
        value: '',
      ));
    });
  }

  QueryBuilder<DeductionEntry, DeductionEntry, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<DeductionEntry, DeductionEntry, QAfterFilterCondition>
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

  QueryBuilder<DeductionEntry, DeductionEntry, QAfterFilterCondition>
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

  QueryBuilder<DeductionEntry, DeductionEntry, QAfterFilterCondition> idBetween(
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

  QueryBuilder<DeductionEntry, DeductionEntry, QAfterFilterCondition>
      milkTypeEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'milkType',
        value: value,
      ));
    });
  }

  QueryBuilder<DeductionEntry, DeductionEntry, QAfterFilterCondition>
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

  QueryBuilder<DeductionEntry, DeductionEntry, QAfterFilterCondition>
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

  QueryBuilder<DeductionEntry, DeductionEntry, QAfterFilterCondition>
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
}

extension DeductionEntryQueryObject
    on QueryBuilder<DeductionEntry, DeductionEntry, QFilterCondition> {}

extension DeductionEntryQueryLinks
    on QueryBuilder<DeductionEntry, DeductionEntry, QFilterCondition> {}

extension DeductionEntryQuerySortBy
    on QueryBuilder<DeductionEntry, DeductionEntry, QSortBy> {
  QueryBuilder<DeductionEntry, DeductionEntry, QAfterSortBy> sortByAdminId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'adminId', Sort.asc);
    });
  }

  QueryBuilder<DeductionEntry, DeductionEntry, QAfterSortBy>
      sortByAdminIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'adminId', Sort.desc);
    });
  }

  QueryBuilder<DeductionEntry, DeductionEntry, QAfterSortBy>
      sortByCustomerCode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'customerCode', Sort.asc);
    });
  }

  QueryBuilder<DeductionEntry, DeductionEntry, QAfterSortBy>
      sortByCustomerCodeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'customerCode', Sort.desc);
    });
  }

  QueryBuilder<DeductionEntry, DeductionEntry, QAfterSortBy> sortByDedAmount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dedAmount', Sort.asc);
    });
  }

  QueryBuilder<DeductionEntry, DeductionEntry, QAfterSortBy>
      sortByDedAmountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dedAmount', Sort.desc);
    });
  }

  QueryBuilder<DeductionEntry, DeductionEntry, QAfterSortBy> sortByDedCode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dedCode', Sort.asc);
    });
  }

  QueryBuilder<DeductionEntry, DeductionEntry, QAfterSortBy>
      sortByDedCodeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dedCode', Sort.desc);
    });
  }

  QueryBuilder<DeductionEntry, DeductionEntry, QAfterSortBy> sortByMilkType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'milkType', Sort.asc);
    });
  }

  QueryBuilder<DeductionEntry, DeductionEntry, QAfterSortBy>
      sortByMilkTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'milkType', Sort.desc);
    });
  }
}

extension DeductionEntryQuerySortThenBy
    on QueryBuilder<DeductionEntry, DeductionEntry, QSortThenBy> {
  QueryBuilder<DeductionEntry, DeductionEntry, QAfterSortBy> thenByAdminId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'adminId', Sort.asc);
    });
  }

  QueryBuilder<DeductionEntry, DeductionEntry, QAfterSortBy>
      thenByAdminIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'adminId', Sort.desc);
    });
  }

  QueryBuilder<DeductionEntry, DeductionEntry, QAfterSortBy>
      thenByCustomerCode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'customerCode', Sort.asc);
    });
  }

  QueryBuilder<DeductionEntry, DeductionEntry, QAfterSortBy>
      thenByCustomerCodeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'customerCode', Sort.desc);
    });
  }

  QueryBuilder<DeductionEntry, DeductionEntry, QAfterSortBy> thenByDedAmount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dedAmount', Sort.asc);
    });
  }

  QueryBuilder<DeductionEntry, DeductionEntry, QAfterSortBy>
      thenByDedAmountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dedAmount', Sort.desc);
    });
  }

  QueryBuilder<DeductionEntry, DeductionEntry, QAfterSortBy> thenByDedCode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dedCode', Sort.asc);
    });
  }

  QueryBuilder<DeductionEntry, DeductionEntry, QAfterSortBy>
      thenByDedCodeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dedCode', Sort.desc);
    });
  }

  QueryBuilder<DeductionEntry, DeductionEntry, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<DeductionEntry, DeductionEntry, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<DeductionEntry, DeductionEntry, QAfterSortBy> thenByMilkType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'milkType', Sort.asc);
    });
  }

  QueryBuilder<DeductionEntry, DeductionEntry, QAfterSortBy>
      thenByMilkTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'milkType', Sort.desc);
    });
  }
}

extension DeductionEntryQueryWhereDistinct
    on QueryBuilder<DeductionEntry, DeductionEntry, QDistinct> {
  QueryBuilder<DeductionEntry, DeductionEntry, QDistinct> distinctByAdminId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'adminId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<DeductionEntry, DeductionEntry, QDistinct>
      distinctByCustomerCode({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'customerCode', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<DeductionEntry, DeductionEntry, QDistinct>
      distinctByDedAmount() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'dedAmount');
    });
  }

  QueryBuilder<DeductionEntry, DeductionEntry, QDistinct> distinctByDedCode(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'dedCode', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<DeductionEntry, DeductionEntry, QDistinct> distinctByMilkType() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'milkType');
    });
  }
}

extension DeductionEntryQueryProperty
    on QueryBuilder<DeductionEntry, DeductionEntry, QQueryProperty> {
  QueryBuilder<DeductionEntry, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<DeductionEntry, String, QQueryOperations> adminIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'adminId');
    });
  }

  QueryBuilder<DeductionEntry, String, QQueryOperations>
      customerCodeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'customerCode');
    });
  }

  QueryBuilder<DeductionEntry, double, QQueryOperations> dedAmountProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'dedAmount');
    });
  }

  QueryBuilder<DeductionEntry, String, QQueryOperations> dedCodeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'dedCode');
    });
  }

  QueryBuilder<DeductionEntry, int, QQueryOperations> milkTypeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'milkType');
    });
  }
}
