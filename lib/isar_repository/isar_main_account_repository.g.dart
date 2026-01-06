// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'isar_main_account_repository.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetIsarMainAccountEntryCollection on Isar {
  IsarCollection<IsarMainAccountEntry> get isarMainAccountEntrys =>
      this.collection();
}

const IsarMainAccountEntrySchema = CollectionSchema(
  name: r'IsarMainAccountEntry',
  id: -8452722989268488158,
  properties: {
    r'accountNumber': PropertySchema(
      id: 0,
      name: r'accountNumber',
      type: IsarType.string,
    ),
    r'accountType': PropertySchema(
      id: 1,
      name: r'accountType',
      type: IsarType.string,
    ),
    r'mainAccount': PropertySchema(
      id: 2,
      name: r'mainAccount',
      type: IsarType.string,
    ),
    r'showInBalance': PropertySchema(
      id: 3,
      name: r'showInBalance',
      type: IsarType.bool,
    )
  },
  estimateSize: _isarMainAccountEntryEstimateSize,
  serialize: _isarMainAccountEntrySerialize,
  deserialize: _isarMainAccountEntryDeserialize,
  deserializeProp: _isarMainAccountEntryDeserializeProp,
  idName: r'id',
  indexes: {
    r'accountNumber': IndexSchema(
      id: -3113303652791322435,
      name: r'accountNumber',
      unique: true,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'accountNumber',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _isarMainAccountEntryGetId,
  getLinks: _isarMainAccountEntryGetLinks,
  attach: _isarMainAccountEntryAttach,
  version: '3.1.0+1',
);

int _isarMainAccountEntryEstimateSize(
  IsarMainAccountEntry object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.accountNumber.length * 3;
  bytesCount += 3 + object.accountType.length * 3;
  bytesCount += 3 + object.mainAccount.length * 3;
  return bytesCount;
}

void _isarMainAccountEntrySerialize(
  IsarMainAccountEntry object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.accountNumber);
  writer.writeString(offsets[1], object.accountType);
  writer.writeString(offsets[2], object.mainAccount);
  writer.writeBool(offsets[3], object.showInBalance);
}

IsarMainAccountEntry _isarMainAccountEntryDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = IsarMainAccountEntry();
  object.accountNumber = reader.readString(offsets[0]);
  object.accountType = reader.readString(offsets[1]);
  object.id = id;
  object.mainAccount = reader.readString(offsets[2]);
  object.showInBalance = reader.readBool(offsets[3]);
  return object;
}

P _isarMainAccountEntryDeserializeProp<P>(
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
      return (reader.readBool(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _isarMainAccountEntryGetId(IsarMainAccountEntry object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _isarMainAccountEntryGetLinks(
    IsarMainAccountEntry object) {
  return [];
}

void _isarMainAccountEntryAttach(
    IsarCollection<dynamic> col, Id id, IsarMainAccountEntry object) {
  object.id = id;
}

extension IsarMainAccountEntryByIndex on IsarCollection<IsarMainAccountEntry> {
  Future<IsarMainAccountEntry?> getByAccountNumber(String accountNumber) {
    return getByIndex(r'accountNumber', [accountNumber]);
  }

  IsarMainAccountEntry? getByAccountNumberSync(String accountNumber) {
    return getByIndexSync(r'accountNumber', [accountNumber]);
  }

  Future<bool> deleteByAccountNumber(String accountNumber) {
    return deleteByIndex(r'accountNumber', [accountNumber]);
  }

  bool deleteByAccountNumberSync(String accountNumber) {
    return deleteByIndexSync(r'accountNumber', [accountNumber]);
  }

  Future<List<IsarMainAccountEntry?>> getAllByAccountNumber(
      List<String> accountNumberValues) {
    final values = accountNumberValues.map((e) => [e]).toList();
    return getAllByIndex(r'accountNumber', values);
  }

  List<IsarMainAccountEntry?> getAllByAccountNumberSync(
      List<String> accountNumberValues) {
    final values = accountNumberValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'accountNumber', values);
  }

  Future<int> deleteAllByAccountNumber(List<String> accountNumberValues) {
    final values = accountNumberValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'accountNumber', values);
  }

  int deleteAllByAccountNumberSync(List<String> accountNumberValues) {
    final values = accountNumberValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'accountNumber', values);
  }

  Future<Id> putByAccountNumber(IsarMainAccountEntry object) {
    return putByIndex(r'accountNumber', object);
  }

  Id putByAccountNumberSync(IsarMainAccountEntry object,
      {bool saveLinks = true}) {
    return putByIndexSync(r'accountNumber', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByAccountNumber(List<IsarMainAccountEntry> objects) {
    return putAllByIndex(r'accountNumber', objects);
  }

  List<Id> putAllByAccountNumberSync(List<IsarMainAccountEntry> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'accountNumber', objects, saveLinks: saveLinks);
  }
}

extension IsarMainAccountEntryQueryWhereSort
    on QueryBuilder<IsarMainAccountEntry, IsarMainAccountEntry, QWhere> {
  QueryBuilder<IsarMainAccountEntry, IsarMainAccountEntry, QAfterWhere>
      anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension IsarMainAccountEntryQueryWhere
    on QueryBuilder<IsarMainAccountEntry, IsarMainAccountEntry, QWhereClause> {
  QueryBuilder<IsarMainAccountEntry, IsarMainAccountEntry, QAfterWhereClause>
      idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<IsarMainAccountEntry, IsarMainAccountEntry, QAfterWhereClause>
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

  QueryBuilder<IsarMainAccountEntry, IsarMainAccountEntry, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<IsarMainAccountEntry, IsarMainAccountEntry, QAfterWhereClause>
      idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<IsarMainAccountEntry, IsarMainAccountEntry, QAfterWhereClause>
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

  QueryBuilder<IsarMainAccountEntry, IsarMainAccountEntry, QAfterWhereClause>
      accountNumberEqualTo(String accountNumber) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'accountNumber',
        value: [accountNumber],
      ));
    });
  }

  QueryBuilder<IsarMainAccountEntry, IsarMainAccountEntry, QAfterWhereClause>
      accountNumberNotEqualTo(String accountNumber) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'accountNumber',
              lower: [],
              upper: [accountNumber],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'accountNumber',
              lower: [accountNumber],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'accountNumber',
              lower: [accountNumber],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'accountNumber',
              lower: [],
              upper: [accountNumber],
              includeUpper: false,
            ));
      }
    });
  }
}

extension IsarMainAccountEntryQueryFilter on QueryBuilder<IsarMainAccountEntry,
    IsarMainAccountEntry, QFilterCondition> {
  QueryBuilder<IsarMainAccountEntry, IsarMainAccountEntry,
      QAfterFilterCondition> accountNumberEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'accountNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarMainAccountEntry, IsarMainAccountEntry,
      QAfterFilterCondition> accountNumberGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'accountNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarMainAccountEntry, IsarMainAccountEntry,
      QAfterFilterCondition> accountNumberLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'accountNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarMainAccountEntry, IsarMainAccountEntry,
      QAfterFilterCondition> accountNumberBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'accountNumber',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarMainAccountEntry, IsarMainAccountEntry,
      QAfterFilterCondition> accountNumberStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'accountNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarMainAccountEntry, IsarMainAccountEntry,
      QAfterFilterCondition> accountNumberEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'accountNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarMainAccountEntry, IsarMainAccountEntry,
          QAfterFilterCondition>
      accountNumberContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'accountNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarMainAccountEntry, IsarMainAccountEntry,
          QAfterFilterCondition>
      accountNumberMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'accountNumber',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarMainAccountEntry, IsarMainAccountEntry,
      QAfterFilterCondition> accountNumberIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'accountNumber',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarMainAccountEntry, IsarMainAccountEntry,
      QAfterFilterCondition> accountNumberIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'accountNumber',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarMainAccountEntry, IsarMainAccountEntry,
      QAfterFilterCondition> accountTypeEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'accountType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarMainAccountEntry, IsarMainAccountEntry,
      QAfterFilterCondition> accountTypeGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'accountType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarMainAccountEntry, IsarMainAccountEntry,
      QAfterFilterCondition> accountTypeLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'accountType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarMainAccountEntry, IsarMainAccountEntry,
      QAfterFilterCondition> accountTypeBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'accountType',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarMainAccountEntry, IsarMainAccountEntry,
      QAfterFilterCondition> accountTypeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'accountType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarMainAccountEntry, IsarMainAccountEntry,
      QAfterFilterCondition> accountTypeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'accountType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarMainAccountEntry, IsarMainAccountEntry,
          QAfterFilterCondition>
      accountTypeContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'accountType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarMainAccountEntry, IsarMainAccountEntry,
          QAfterFilterCondition>
      accountTypeMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'accountType',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarMainAccountEntry, IsarMainAccountEntry,
      QAfterFilterCondition> accountTypeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'accountType',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarMainAccountEntry, IsarMainAccountEntry,
      QAfterFilterCondition> accountTypeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'accountType',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarMainAccountEntry, IsarMainAccountEntry,
      QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarMainAccountEntry, IsarMainAccountEntry,
      QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<IsarMainAccountEntry, IsarMainAccountEntry,
      QAfterFilterCondition> idLessThan(
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

  QueryBuilder<IsarMainAccountEntry, IsarMainAccountEntry,
      QAfterFilterCondition> idBetween(
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

  QueryBuilder<IsarMainAccountEntry, IsarMainAccountEntry,
      QAfterFilterCondition> mainAccountEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'mainAccount',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarMainAccountEntry, IsarMainAccountEntry,
      QAfterFilterCondition> mainAccountGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'mainAccount',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarMainAccountEntry, IsarMainAccountEntry,
      QAfterFilterCondition> mainAccountLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'mainAccount',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarMainAccountEntry, IsarMainAccountEntry,
      QAfterFilterCondition> mainAccountBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'mainAccount',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarMainAccountEntry, IsarMainAccountEntry,
      QAfterFilterCondition> mainAccountStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'mainAccount',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarMainAccountEntry, IsarMainAccountEntry,
      QAfterFilterCondition> mainAccountEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'mainAccount',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarMainAccountEntry, IsarMainAccountEntry,
          QAfterFilterCondition>
      mainAccountContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'mainAccount',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarMainAccountEntry, IsarMainAccountEntry,
          QAfterFilterCondition>
      mainAccountMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'mainAccount',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarMainAccountEntry, IsarMainAccountEntry,
      QAfterFilterCondition> mainAccountIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'mainAccount',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarMainAccountEntry, IsarMainAccountEntry,
      QAfterFilterCondition> mainAccountIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'mainAccount',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarMainAccountEntry, IsarMainAccountEntry,
      QAfterFilterCondition> showInBalanceEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'showInBalance',
        value: value,
      ));
    });
  }
}

extension IsarMainAccountEntryQueryObject on QueryBuilder<IsarMainAccountEntry,
    IsarMainAccountEntry, QFilterCondition> {}

extension IsarMainAccountEntryQueryLinks on QueryBuilder<IsarMainAccountEntry,
    IsarMainAccountEntry, QFilterCondition> {}

extension IsarMainAccountEntryQuerySortBy
    on QueryBuilder<IsarMainAccountEntry, IsarMainAccountEntry, QSortBy> {
  QueryBuilder<IsarMainAccountEntry, IsarMainAccountEntry, QAfterSortBy>
      sortByAccountNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'accountNumber', Sort.asc);
    });
  }

  QueryBuilder<IsarMainAccountEntry, IsarMainAccountEntry, QAfterSortBy>
      sortByAccountNumberDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'accountNumber', Sort.desc);
    });
  }

  QueryBuilder<IsarMainAccountEntry, IsarMainAccountEntry, QAfterSortBy>
      sortByAccountType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'accountType', Sort.asc);
    });
  }

  QueryBuilder<IsarMainAccountEntry, IsarMainAccountEntry, QAfterSortBy>
      sortByAccountTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'accountType', Sort.desc);
    });
  }

  QueryBuilder<IsarMainAccountEntry, IsarMainAccountEntry, QAfterSortBy>
      sortByMainAccount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mainAccount', Sort.asc);
    });
  }

  QueryBuilder<IsarMainAccountEntry, IsarMainAccountEntry, QAfterSortBy>
      sortByMainAccountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mainAccount', Sort.desc);
    });
  }

  QueryBuilder<IsarMainAccountEntry, IsarMainAccountEntry, QAfterSortBy>
      sortByShowInBalance() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'showInBalance', Sort.asc);
    });
  }

  QueryBuilder<IsarMainAccountEntry, IsarMainAccountEntry, QAfterSortBy>
      sortByShowInBalanceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'showInBalance', Sort.desc);
    });
  }
}

extension IsarMainAccountEntryQuerySortThenBy
    on QueryBuilder<IsarMainAccountEntry, IsarMainAccountEntry, QSortThenBy> {
  QueryBuilder<IsarMainAccountEntry, IsarMainAccountEntry, QAfterSortBy>
      thenByAccountNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'accountNumber', Sort.asc);
    });
  }

  QueryBuilder<IsarMainAccountEntry, IsarMainAccountEntry, QAfterSortBy>
      thenByAccountNumberDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'accountNumber', Sort.desc);
    });
  }

  QueryBuilder<IsarMainAccountEntry, IsarMainAccountEntry, QAfterSortBy>
      thenByAccountType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'accountType', Sort.asc);
    });
  }

  QueryBuilder<IsarMainAccountEntry, IsarMainAccountEntry, QAfterSortBy>
      thenByAccountTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'accountType', Sort.desc);
    });
  }

  QueryBuilder<IsarMainAccountEntry, IsarMainAccountEntry, QAfterSortBy>
      thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<IsarMainAccountEntry, IsarMainAccountEntry, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<IsarMainAccountEntry, IsarMainAccountEntry, QAfterSortBy>
      thenByMainAccount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mainAccount', Sort.asc);
    });
  }

  QueryBuilder<IsarMainAccountEntry, IsarMainAccountEntry, QAfterSortBy>
      thenByMainAccountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mainAccount', Sort.desc);
    });
  }

  QueryBuilder<IsarMainAccountEntry, IsarMainAccountEntry, QAfterSortBy>
      thenByShowInBalance() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'showInBalance', Sort.asc);
    });
  }

  QueryBuilder<IsarMainAccountEntry, IsarMainAccountEntry, QAfterSortBy>
      thenByShowInBalanceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'showInBalance', Sort.desc);
    });
  }
}

extension IsarMainAccountEntryQueryWhereDistinct
    on QueryBuilder<IsarMainAccountEntry, IsarMainAccountEntry, QDistinct> {
  QueryBuilder<IsarMainAccountEntry, IsarMainAccountEntry, QDistinct>
      distinctByAccountNumber({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'accountNumber',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<IsarMainAccountEntry, IsarMainAccountEntry, QDistinct>
      distinctByAccountType({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'accountType', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<IsarMainAccountEntry, IsarMainAccountEntry, QDistinct>
      distinctByMainAccount({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'mainAccount', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<IsarMainAccountEntry, IsarMainAccountEntry, QDistinct>
      distinctByShowInBalance() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'showInBalance');
    });
  }
}

extension IsarMainAccountEntryQueryProperty on QueryBuilder<
    IsarMainAccountEntry, IsarMainAccountEntry, QQueryProperty> {
  QueryBuilder<IsarMainAccountEntry, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<IsarMainAccountEntry, String, QQueryOperations>
      accountNumberProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'accountNumber');
    });
  }

  QueryBuilder<IsarMainAccountEntry, String, QQueryOperations>
      accountTypeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'accountType');
    });
  }

  QueryBuilder<IsarMainAccountEntry, String, QQueryOperations>
      mainAccountProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'mainAccount');
    });
  }

  QueryBuilder<IsarMainAccountEntry, bool, QQueryOperations>
      showInBalanceProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'showInBalance');
    });
  }
}
