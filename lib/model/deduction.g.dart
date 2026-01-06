// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'deduction.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetDeductionCollection on Isar {
  IsarCollection<Deduction> get deductions => this.collection();
}

const DeductionSchema = CollectionSchema(
  name: r'Deduction',
  id: 2430497432991381622,
  properties: {
    r'aakarani': PropertySchema(
      id: 0,
      name: r'aakarani',
      type: IsarType.string,
    ),
    r'code': PropertySchema(
      id: 1,
      name: r'code',
      type: IsarType.string,
    ),
    r'kapatLock': PropertySchema(
      id: 2,
      name: r'kapatLock',
      type: IsarType.bool,
    ),
    r'milkat': PropertySchema(
      id: 3,
      name: r'milkat',
      type: IsarType.bool,
    ),
    r'name': PropertySchema(
      id: 4,
      name: r'name',
      type: IsarType.string,
    ),
    r'priority': PropertySchema(
      id: 5,
      name: r'priority',
      type: IsarType.long,
    ),
    r'rate': PropertySchema(
      id: 6,
      name: r'rate',
      type: IsarType.double,
    ),
    r'rounding': PropertySchema(
      id: 7,
      name: r'rounding',
      type: IsarType.bool,
    ),
    r'vasuliType': PropertySchema(
      id: 8,
      name: r'vasuliType',
      type: IsarType.string,
    )
  },
  estimateSize: _deductionEstimateSize,
  serialize: _deductionSerialize,
  deserialize: _deductionDeserialize,
  deserializeProp: _deductionDeserializeProp,
  idName: r'id',
  indexes: {
    r'code': IndexSchema(
      id: 329780482934683790,
      name: r'code',
      unique: true,
      replace: true,
      properties: [
        IndexPropertySchema(
          name: r'code',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _deductionGetId,
  getLinks: _deductionGetLinks,
  attach: _deductionAttach,
  version: '3.1.0+1',
);

int _deductionEstimateSize(
  Deduction object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.aakarani.length * 3;
  bytesCount += 3 + object.code.length * 3;
  bytesCount += 3 + object.name.length * 3;
  bytesCount += 3 + object.vasuliType.length * 3;
  return bytesCount;
}

void _deductionSerialize(
  Deduction object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.aakarani);
  writer.writeString(offsets[1], object.code);
  writer.writeBool(offsets[2], object.kapatLock);
  writer.writeBool(offsets[3], object.milkat);
  writer.writeString(offsets[4], object.name);
  writer.writeLong(offsets[5], object.priority);
  writer.writeDouble(offsets[6], object.rate);
  writer.writeBool(offsets[7], object.rounding);
  writer.writeString(offsets[8], object.vasuliType);
}

Deduction _deductionDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Deduction(
    aakarani: reader.readString(offsets[0]),
    code: reader.readString(offsets[1]),
    kapatLock: reader.readBool(offsets[2]),
    milkat: reader.readBool(offsets[3]),
    name: reader.readString(offsets[4]),
    priority: reader.readLong(offsets[5]),
    rate: reader.readDouble(offsets[6]),
    rounding: reader.readBool(offsets[7]),
    vasuliType: reader.readString(offsets[8]),
  );
  object.id = id;
  return object;
}

P _deductionDeserializeProp<P>(
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
      return (reader.readBool(offset)) as P;
    case 3:
      return (reader.readBool(offset)) as P;
    case 4:
      return (reader.readString(offset)) as P;
    case 5:
      return (reader.readLong(offset)) as P;
    case 6:
      return (reader.readDouble(offset)) as P;
    case 7:
      return (reader.readBool(offset)) as P;
    case 8:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _deductionGetId(Deduction object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _deductionGetLinks(Deduction object) {
  return [];
}

void _deductionAttach(IsarCollection<dynamic> col, Id id, Deduction object) {
  object.id = id;
}

extension DeductionByIndex on IsarCollection<Deduction> {
  Future<Deduction?> getByCode(String code) {
    return getByIndex(r'code', [code]);
  }

  Deduction? getByCodeSync(String code) {
    return getByIndexSync(r'code', [code]);
  }

  Future<bool> deleteByCode(String code) {
    return deleteByIndex(r'code', [code]);
  }

  bool deleteByCodeSync(String code) {
    return deleteByIndexSync(r'code', [code]);
  }

  Future<List<Deduction?>> getAllByCode(List<String> codeValues) {
    final values = codeValues.map((e) => [e]).toList();
    return getAllByIndex(r'code', values);
  }

  List<Deduction?> getAllByCodeSync(List<String> codeValues) {
    final values = codeValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'code', values);
  }

  Future<int> deleteAllByCode(List<String> codeValues) {
    final values = codeValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'code', values);
  }

  int deleteAllByCodeSync(List<String> codeValues) {
    final values = codeValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'code', values);
  }

  Future<Id> putByCode(Deduction object) {
    return putByIndex(r'code', object);
  }

  Id putByCodeSync(Deduction object, {bool saveLinks = true}) {
    return putByIndexSync(r'code', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByCode(List<Deduction> objects) {
    return putAllByIndex(r'code', objects);
  }

  List<Id> putAllByCodeSync(List<Deduction> objects, {bool saveLinks = true}) {
    return putAllByIndexSync(r'code', objects, saveLinks: saveLinks);
  }
}

extension DeductionQueryWhereSort
    on QueryBuilder<Deduction, Deduction, QWhere> {
  QueryBuilder<Deduction, Deduction, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension DeductionQueryWhere
    on QueryBuilder<Deduction, Deduction, QWhereClause> {
  QueryBuilder<Deduction, Deduction, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<Deduction, Deduction, QAfterWhereClause> idNotEqualTo(Id id) {
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

  QueryBuilder<Deduction, Deduction, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<Deduction, Deduction, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<Deduction, Deduction, QAfterWhereClause> idBetween(
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

  QueryBuilder<Deduction, Deduction, QAfterWhereClause> codeEqualTo(
      String code) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'code',
        value: [code],
      ));
    });
  }

  QueryBuilder<Deduction, Deduction, QAfterWhereClause> codeNotEqualTo(
      String code) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'code',
              lower: [],
              upper: [code],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'code',
              lower: [code],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'code',
              lower: [code],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'code',
              lower: [],
              upper: [code],
              includeUpper: false,
            ));
      }
    });
  }
}

extension DeductionQueryFilter
    on QueryBuilder<Deduction, Deduction, QFilterCondition> {
  QueryBuilder<Deduction, Deduction, QAfterFilterCondition> aakaraniEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'aakarani',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Deduction, Deduction, QAfterFilterCondition> aakaraniGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'aakarani',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Deduction, Deduction, QAfterFilterCondition> aakaraniLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'aakarani',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Deduction, Deduction, QAfterFilterCondition> aakaraniBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'aakarani',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Deduction, Deduction, QAfterFilterCondition> aakaraniStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'aakarani',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Deduction, Deduction, QAfterFilterCondition> aakaraniEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'aakarani',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Deduction, Deduction, QAfterFilterCondition> aakaraniContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'aakarani',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Deduction, Deduction, QAfterFilterCondition> aakaraniMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'aakarani',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Deduction, Deduction, QAfterFilterCondition> aakaraniIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'aakarani',
        value: '',
      ));
    });
  }

  QueryBuilder<Deduction, Deduction, QAfterFilterCondition>
      aakaraniIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'aakarani',
        value: '',
      ));
    });
  }

  QueryBuilder<Deduction, Deduction, QAfterFilterCondition> codeEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'code',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Deduction, Deduction, QAfterFilterCondition> codeGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'code',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Deduction, Deduction, QAfterFilterCondition> codeLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'code',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Deduction, Deduction, QAfterFilterCondition> codeBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'code',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Deduction, Deduction, QAfterFilterCondition> codeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'code',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Deduction, Deduction, QAfterFilterCondition> codeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'code',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Deduction, Deduction, QAfterFilterCondition> codeContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'code',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Deduction, Deduction, QAfterFilterCondition> codeMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'code',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Deduction, Deduction, QAfterFilterCondition> codeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'code',
        value: '',
      ));
    });
  }

  QueryBuilder<Deduction, Deduction, QAfterFilterCondition> codeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'code',
        value: '',
      ));
    });
  }

  QueryBuilder<Deduction, Deduction, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Deduction, Deduction, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<Deduction, Deduction, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<Deduction, Deduction, QAfterFilterCondition> idBetween(
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

  QueryBuilder<Deduction, Deduction, QAfterFilterCondition> kapatLockEqualTo(
      bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'kapatLock',
        value: value,
      ));
    });
  }

  QueryBuilder<Deduction, Deduction, QAfterFilterCondition> milkatEqualTo(
      bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'milkat',
        value: value,
      ));
    });
  }

  QueryBuilder<Deduction, Deduction, QAfterFilterCondition> nameEqualTo(
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

  QueryBuilder<Deduction, Deduction, QAfterFilterCondition> nameGreaterThan(
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

  QueryBuilder<Deduction, Deduction, QAfterFilterCondition> nameLessThan(
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

  QueryBuilder<Deduction, Deduction, QAfterFilterCondition> nameBetween(
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

  QueryBuilder<Deduction, Deduction, QAfterFilterCondition> nameStartsWith(
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

  QueryBuilder<Deduction, Deduction, QAfterFilterCondition> nameEndsWith(
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

  QueryBuilder<Deduction, Deduction, QAfterFilterCondition> nameContains(
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

  QueryBuilder<Deduction, Deduction, QAfterFilterCondition> nameMatches(
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

  QueryBuilder<Deduction, Deduction, QAfterFilterCondition> nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<Deduction, Deduction, QAfterFilterCondition> nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<Deduction, Deduction, QAfterFilterCondition> priorityEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'priority',
        value: value,
      ));
    });
  }

  QueryBuilder<Deduction, Deduction, QAfterFilterCondition> priorityGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'priority',
        value: value,
      ));
    });
  }

  QueryBuilder<Deduction, Deduction, QAfterFilterCondition> priorityLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'priority',
        value: value,
      ));
    });
  }

  QueryBuilder<Deduction, Deduction, QAfterFilterCondition> priorityBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'priority',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Deduction, Deduction, QAfterFilterCondition> rateEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'rate',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Deduction, Deduction, QAfterFilterCondition> rateGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'rate',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Deduction, Deduction, QAfterFilterCondition> rateLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'rate',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Deduction, Deduction, QAfterFilterCondition> rateBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'rate',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Deduction, Deduction, QAfterFilterCondition> roundingEqualTo(
      bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'rounding',
        value: value,
      ));
    });
  }

  QueryBuilder<Deduction, Deduction, QAfterFilterCondition> vasuliTypeEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'vasuliType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Deduction, Deduction, QAfterFilterCondition>
      vasuliTypeGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'vasuliType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Deduction, Deduction, QAfterFilterCondition> vasuliTypeLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'vasuliType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Deduction, Deduction, QAfterFilterCondition> vasuliTypeBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'vasuliType',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Deduction, Deduction, QAfterFilterCondition>
      vasuliTypeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'vasuliType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Deduction, Deduction, QAfterFilterCondition> vasuliTypeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'vasuliType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Deduction, Deduction, QAfterFilterCondition> vasuliTypeContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'vasuliType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Deduction, Deduction, QAfterFilterCondition> vasuliTypeMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'vasuliType',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Deduction, Deduction, QAfterFilterCondition>
      vasuliTypeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'vasuliType',
        value: '',
      ));
    });
  }

  QueryBuilder<Deduction, Deduction, QAfterFilterCondition>
      vasuliTypeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'vasuliType',
        value: '',
      ));
    });
  }
}

extension DeductionQueryObject
    on QueryBuilder<Deduction, Deduction, QFilterCondition> {}

extension DeductionQueryLinks
    on QueryBuilder<Deduction, Deduction, QFilterCondition> {}

extension DeductionQuerySortBy on QueryBuilder<Deduction, Deduction, QSortBy> {
  QueryBuilder<Deduction, Deduction, QAfterSortBy> sortByAakarani() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'aakarani', Sort.asc);
    });
  }

  QueryBuilder<Deduction, Deduction, QAfterSortBy> sortByAakaraniDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'aakarani', Sort.desc);
    });
  }

  QueryBuilder<Deduction, Deduction, QAfterSortBy> sortByCode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'code', Sort.asc);
    });
  }

  QueryBuilder<Deduction, Deduction, QAfterSortBy> sortByCodeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'code', Sort.desc);
    });
  }

  QueryBuilder<Deduction, Deduction, QAfterSortBy> sortByKapatLock() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'kapatLock', Sort.asc);
    });
  }

  QueryBuilder<Deduction, Deduction, QAfterSortBy> sortByKapatLockDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'kapatLock', Sort.desc);
    });
  }

  QueryBuilder<Deduction, Deduction, QAfterSortBy> sortByMilkat() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'milkat', Sort.asc);
    });
  }

  QueryBuilder<Deduction, Deduction, QAfterSortBy> sortByMilkatDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'milkat', Sort.desc);
    });
  }

  QueryBuilder<Deduction, Deduction, QAfterSortBy> sortByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<Deduction, Deduction, QAfterSortBy> sortByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<Deduction, Deduction, QAfterSortBy> sortByPriority() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'priority', Sort.asc);
    });
  }

  QueryBuilder<Deduction, Deduction, QAfterSortBy> sortByPriorityDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'priority', Sort.desc);
    });
  }

  QueryBuilder<Deduction, Deduction, QAfterSortBy> sortByRate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rate', Sort.asc);
    });
  }

  QueryBuilder<Deduction, Deduction, QAfterSortBy> sortByRateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rate', Sort.desc);
    });
  }

  QueryBuilder<Deduction, Deduction, QAfterSortBy> sortByRounding() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rounding', Sort.asc);
    });
  }

  QueryBuilder<Deduction, Deduction, QAfterSortBy> sortByRoundingDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rounding', Sort.desc);
    });
  }

  QueryBuilder<Deduction, Deduction, QAfterSortBy> sortByVasuliType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'vasuliType', Sort.asc);
    });
  }

  QueryBuilder<Deduction, Deduction, QAfterSortBy> sortByVasuliTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'vasuliType', Sort.desc);
    });
  }
}

extension DeductionQuerySortThenBy
    on QueryBuilder<Deduction, Deduction, QSortThenBy> {
  QueryBuilder<Deduction, Deduction, QAfterSortBy> thenByAakarani() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'aakarani', Sort.asc);
    });
  }

  QueryBuilder<Deduction, Deduction, QAfterSortBy> thenByAakaraniDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'aakarani', Sort.desc);
    });
  }

  QueryBuilder<Deduction, Deduction, QAfterSortBy> thenByCode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'code', Sort.asc);
    });
  }

  QueryBuilder<Deduction, Deduction, QAfterSortBy> thenByCodeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'code', Sort.desc);
    });
  }

  QueryBuilder<Deduction, Deduction, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<Deduction, Deduction, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<Deduction, Deduction, QAfterSortBy> thenByKapatLock() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'kapatLock', Sort.asc);
    });
  }

  QueryBuilder<Deduction, Deduction, QAfterSortBy> thenByKapatLockDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'kapatLock', Sort.desc);
    });
  }

  QueryBuilder<Deduction, Deduction, QAfterSortBy> thenByMilkat() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'milkat', Sort.asc);
    });
  }

  QueryBuilder<Deduction, Deduction, QAfterSortBy> thenByMilkatDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'milkat', Sort.desc);
    });
  }

  QueryBuilder<Deduction, Deduction, QAfterSortBy> thenByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<Deduction, Deduction, QAfterSortBy> thenByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<Deduction, Deduction, QAfterSortBy> thenByPriority() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'priority', Sort.asc);
    });
  }

  QueryBuilder<Deduction, Deduction, QAfterSortBy> thenByPriorityDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'priority', Sort.desc);
    });
  }

  QueryBuilder<Deduction, Deduction, QAfterSortBy> thenByRate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rate', Sort.asc);
    });
  }

  QueryBuilder<Deduction, Deduction, QAfterSortBy> thenByRateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rate', Sort.desc);
    });
  }

  QueryBuilder<Deduction, Deduction, QAfterSortBy> thenByRounding() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rounding', Sort.asc);
    });
  }

  QueryBuilder<Deduction, Deduction, QAfterSortBy> thenByRoundingDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rounding', Sort.desc);
    });
  }

  QueryBuilder<Deduction, Deduction, QAfterSortBy> thenByVasuliType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'vasuliType', Sort.asc);
    });
  }

  QueryBuilder<Deduction, Deduction, QAfterSortBy> thenByVasuliTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'vasuliType', Sort.desc);
    });
  }
}

extension DeductionQueryWhereDistinct
    on QueryBuilder<Deduction, Deduction, QDistinct> {
  QueryBuilder<Deduction, Deduction, QDistinct> distinctByAakarani(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'aakarani', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Deduction, Deduction, QDistinct> distinctByCode(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'code', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Deduction, Deduction, QDistinct> distinctByKapatLock() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'kapatLock');
    });
  }

  QueryBuilder<Deduction, Deduction, QDistinct> distinctByMilkat() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'milkat');
    });
  }

  QueryBuilder<Deduction, Deduction, QDistinct> distinctByName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'name', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Deduction, Deduction, QDistinct> distinctByPriority() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'priority');
    });
  }

  QueryBuilder<Deduction, Deduction, QDistinct> distinctByRate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'rate');
    });
  }

  QueryBuilder<Deduction, Deduction, QDistinct> distinctByRounding() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'rounding');
    });
  }

  QueryBuilder<Deduction, Deduction, QDistinct> distinctByVasuliType(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'vasuliType', caseSensitive: caseSensitive);
    });
  }
}

extension DeductionQueryProperty
    on QueryBuilder<Deduction, Deduction, QQueryProperty> {
  QueryBuilder<Deduction, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<Deduction, String, QQueryOperations> aakaraniProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'aakarani');
    });
  }

  QueryBuilder<Deduction, String, QQueryOperations> codeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'code');
    });
  }

  QueryBuilder<Deduction, bool, QQueryOperations> kapatLockProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'kapatLock');
    });
  }

  QueryBuilder<Deduction, bool, QQueryOperations> milkatProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'milkat');
    });
  }

  QueryBuilder<Deduction, String, QQueryOperations> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'name');
    });
  }

  QueryBuilder<Deduction, int, QQueryOperations> priorityProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'priority');
    });
  }

  QueryBuilder<Deduction, double, QQueryOperations> rateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'rate');
    });
  }

  QueryBuilder<Deduction, bool, QQueryOperations> roundingProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'rounding');
    });
  }

  QueryBuilder<Deduction, String, QQueryOperations> vasuliTypeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'vasuliType');
    });
  }
}
