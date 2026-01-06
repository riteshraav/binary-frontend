// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bank_model.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetBankMasterCollection on Isar {
  IsarCollection<BankMaster> get bankMasters => this.collection();
}

const BankMasterSchema = CollectionSchema(
  name: r'BankMaster',
  id: 8178503431223665014,
  properties: {
    r'branch': PropertySchema(
      id: 0,
      name: r'branch',
      type: IsarType.string,
    ),
    r'code': PropertySchema(
      id: 1,
      name: r'code',
      type: IsarType.long,
    ),
    r'ifsc': PropertySchema(
      id: 2,
      name: r'ifsc',
      type: IsarType.string,
    ),
    r'name': PropertySchema(
      id: 3,
      name: r'name',
      type: IsarType.string,
    )
  },
  estimateSize: _bankMasterEstimateSize,
  serialize: _bankMasterSerialize,
  deserialize: _bankMasterDeserialize,
  deserializeProp: _bankMasterDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _bankMasterGetId,
  getLinks: _bankMasterGetLinks,
  attach: _bankMasterAttach,
  version: '3.1.0+1',
);

int _bankMasterEstimateSize(
  BankMaster object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.branch.length * 3;
  bytesCount += 3 + object.ifsc.length * 3;
  bytesCount += 3 + object.name.length * 3;
  return bytesCount;
}

void _bankMasterSerialize(
  BankMaster object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.branch);
  writer.writeLong(offsets[1], object.code);
  writer.writeString(offsets[2], object.ifsc);
  writer.writeString(offsets[3], object.name);
}

BankMaster _bankMasterDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = BankMaster(
    branch: reader.readString(offsets[0]),
    code: reader.readLongOrNull(offsets[1]),
    ifsc: reader.readString(offsets[2]),
    name: reader.readString(offsets[3]),
  );
  object.id = id;
  return object;
}

P _bankMasterDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readLongOrNull(offset)) as P;
    case 2:
      return (reader.readString(offset)) as P;
    case 3:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _bankMasterGetId(BankMaster object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _bankMasterGetLinks(BankMaster object) {
  return [];
}

void _bankMasterAttach(IsarCollection<dynamic> col, Id id, BankMaster object) {
  object.id = id;
}

extension BankMasterQueryWhereSort
    on QueryBuilder<BankMaster, BankMaster, QWhere> {
  QueryBuilder<BankMaster, BankMaster, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension BankMasterQueryWhere
    on QueryBuilder<BankMaster, BankMaster, QWhereClause> {
  QueryBuilder<BankMaster, BankMaster, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<BankMaster, BankMaster, QAfterWhereClause> idNotEqualTo(Id id) {
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

  QueryBuilder<BankMaster, BankMaster, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<BankMaster, BankMaster, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<BankMaster, BankMaster, QAfterWhereClause> idBetween(
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

extension BankMasterQueryFilter
    on QueryBuilder<BankMaster, BankMaster, QFilterCondition> {
  QueryBuilder<BankMaster, BankMaster, QAfterFilterCondition> branchEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'branch',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BankMaster, BankMaster, QAfterFilterCondition> branchGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'branch',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BankMaster, BankMaster, QAfterFilterCondition> branchLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'branch',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BankMaster, BankMaster, QAfterFilterCondition> branchBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'branch',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BankMaster, BankMaster, QAfterFilterCondition> branchStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'branch',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BankMaster, BankMaster, QAfterFilterCondition> branchEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'branch',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BankMaster, BankMaster, QAfterFilterCondition> branchContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'branch',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BankMaster, BankMaster, QAfterFilterCondition> branchMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'branch',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BankMaster, BankMaster, QAfterFilterCondition> branchIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'branch',
        value: '',
      ));
    });
  }

  QueryBuilder<BankMaster, BankMaster, QAfterFilterCondition>
      branchIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'branch',
        value: '',
      ));
    });
  }

  QueryBuilder<BankMaster, BankMaster, QAfterFilterCondition> codeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'code',
      ));
    });
  }

  QueryBuilder<BankMaster, BankMaster, QAfterFilterCondition> codeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'code',
      ));
    });
  }

  QueryBuilder<BankMaster, BankMaster, QAfterFilterCondition> codeEqualTo(
      int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'code',
        value: value,
      ));
    });
  }

  QueryBuilder<BankMaster, BankMaster, QAfterFilterCondition> codeGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'code',
        value: value,
      ));
    });
  }

  QueryBuilder<BankMaster, BankMaster, QAfterFilterCondition> codeLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'code',
        value: value,
      ));
    });
  }

  QueryBuilder<BankMaster, BankMaster, QAfterFilterCondition> codeBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'code',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<BankMaster, BankMaster, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<BankMaster, BankMaster, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<BankMaster, BankMaster, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<BankMaster, BankMaster, QAfterFilterCondition> idBetween(
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

  QueryBuilder<BankMaster, BankMaster, QAfterFilterCondition> ifscEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'ifsc',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BankMaster, BankMaster, QAfterFilterCondition> ifscGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'ifsc',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BankMaster, BankMaster, QAfterFilterCondition> ifscLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'ifsc',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BankMaster, BankMaster, QAfterFilterCondition> ifscBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'ifsc',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BankMaster, BankMaster, QAfterFilterCondition> ifscStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'ifsc',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BankMaster, BankMaster, QAfterFilterCondition> ifscEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'ifsc',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BankMaster, BankMaster, QAfterFilterCondition> ifscContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'ifsc',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BankMaster, BankMaster, QAfterFilterCondition> ifscMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'ifsc',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BankMaster, BankMaster, QAfterFilterCondition> ifscIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'ifsc',
        value: '',
      ));
    });
  }

  QueryBuilder<BankMaster, BankMaster, QAfterFilterCondition> ifscIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'ifsc',
        value: '',
      ));
    });
  }

  QueryBuilder<BankMaster, BankMaster, QAfterFilterCondition> nameEqualTo(
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

  QueryBuilder<BankMaster, BankMaster, QAfterFilterCondition> nameGreaterThan(
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

  QueryBuilder<BankMaster, BankMaster, QAfterFilterCondition> nameLessThan(
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

  QueryBuilder<BankMaster, BankMaster, QAfterFilterCondition> nameBetween(
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

  QueryBuilder<BankMaster, BankMaster, QAfterFilterCondition> nameStartsWith(
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

  QueryBuilder<BankMaster, BankMaster, QAfterFilterCondition> nameEndsWith(
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

  QueryBuilder<BankMaster, BankMaster, QAfterFilterCondition> nameContains(
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

  QueryBuilder<BankMaster, BankMaster, QAfterFilterCondition> nameMatches(
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

  QueryBuilder<BankMaster, BankMaster, QAfterFilterCondition> nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<BankMaster, BankMaster, QAfterFilterCondition> nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'name',
        value: '',
      ));
    });
  }
}

extension BankMasterQueryObject
    on QueryBuilder<BankMaster, BankMaster, QFilterCondition> {}

extension BankMasterQueryLinks
    on QueryBuilder<BankMaster, BankMaster, QFilterCondition> {}

extension BankMasterQuerySortBy
    on QueryBuilder<BankMaster, BankMaster, QSortBy> {
  QueryBuilder<BankMaster, BankMaster, QAfterSortBy> sortByBranch() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'branch', Sort.asc);
    });
  }

  QueryBuilder<BankMaster, BankMaster, QAfterSortBy> sortByBranchDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'branch', Sort.desc);
    });
  }

  QueryBuilder<BankMaster, BankMaster, QAfterSortBy> sortByCode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'code', Sort.asc);
    });
  }

  QueryBuilder<BankMaster, BankMaster, QAfterSortBy> sortByCodeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'code', Sort.desc);
    });
  }

  QueryBuilder<BankMaster, BankMaster, QAfterSortBy> sortByIfsc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ifsc', Sort.asc);
    });
  }

  QueryBuilder<BankMaster, BankMaster, QAfterSortBy> sortByIfscDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ifsc', Sort.desc);
    });
  }

  QueryBuilder<BankMaster, BankMaster, QAfterSortBy> sortByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<BankMaster, BankMaster, QAfterSortBy> sortByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }
}

extension BankMasterQuerySortThenBy
    on QueryBuilder<BankMaster, BankMaster, QSortThenBy> {
  QueryBuilder<BankMaster, BankMaster, QAfterSortBy> thenByBranch() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'branch', Sort.asc);
    });
  }

  QueryBuilder<BankMaster, BankMaster, QAfterSortBy> thenByBranchDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'branch', Sort.desc);
    });
  }

  QueryBuilder<BankMaster, BankMaster, QAfterSortBy> thenByCode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'code', Sort.asc);
    });
  }

  QueryBuilder<BankMaster, BankMaster, QAfterSortBy> thenByCodeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'code', Sort.desc);
    });
  }

  QueryBuilder<BankMaster, BankMaster, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<BankMaster, BankMaster, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<BankMaster, BankMaster, QAfterSortBy> thenByIfsc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ifsc', Sort.asc);
    });
  }

  QueryBuilder<BankMaster, BankMaster, QAfterSortBy> thenByIfscDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ifsc', Sort.desc);
    });
  }

  QueryBuilder<BankMaster, BankMaster, QAfterSortBy> thenByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<BankMaster, BankMaster, QAfterSortBy> thenByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }
}

extension BankMasterQueryWhereDistinct
    on QueryBuilder<BankMaster, BankMaster, QDistinct> {
  QueryBuilder<BankMaster, BankMaster, QDistinct> distinctByBranch(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'branch', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<BankMaster, BankMaster, QDistinct> distinctByCode() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'code');
    });
  }

  QueryBuilder<BankMaster, BankMaster, QDistinct> distinctByIfsc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'ifsc', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<BankMaster, BankMaster, QDistinct> distinctByName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'name', caseSensitive: caseSensitive);
    });
  }
}

extension BankMasterQueryProperty
    on QueryBuilder<BankMaster, BankMaster, QQueryProperty> {
  QueryBuilder<BankMaster, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<BankMaster, String, QQueryOperations> branchProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'branch');
    });
  }

  QueryBuilder<BankMaster, int?, QQueryOperations> codeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'code');
    });
  }

  QueryBuilder<BankMaster, String, QQueryOperations> ifscProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'ifsc');
    });
  }

  QueryBuilder<BankMaster, String, QQueryOperations> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'name');
    });
  }
}
