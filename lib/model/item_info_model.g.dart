// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_info_model.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetItemInfoModelCollection on Isar {
  IsarCollection<ItemInfoModel> get itemInfoModels => this.collection();
}

const ItemInfoModelSchema = CollectionSchema(
  name: r'ItemInfoModel',
  id: 5389066933617703771,
  properties: {
    r'code': PropertySchema(
      id: 0,
      name: r'code',
      type: IsarType.string,
    ),
    r'creditSalesAccount': PropertySchema(
      id: 1,
      name: r'creditSalesAccount',
      type: IsarType.string,
    ),
    r'currentQty': PropertySchema(
      id: 2,
      name: r'currentQty',
      type: IsarType.double,
    ),
    r'isActive': PropertySchema(
      id: 3,
      name: r'isActive',
      type: IsarType.bool,
    ),
    r'minQty': PropertySchema(
      id: 4,
      name: r'minQty',
      type: IsarType.double,
    ),
    r'name': PropertySchema(
      id: 5,
      name: r'name',
      type: IsarType.string,
    ),
    r'openingQty': PropertySchema(
      id: 6,
      name: r'openingQty',
      type: IsarType.double,
    ),
    r'purchaseAccount': PropertySchema(
      id: 7,
      name: r'purchaseAccount',
      type: IsarType.string,
    ),
    r'purchaseRate': PropertySchema(
      id: 8,
      name: r'purchaseRate',
      type: IsarType.double,
    ),
    r'salesAccount': PropertySchema(
      id: 9,
      name: r'salesAccount',
      type: IsarType.string,
    ),
    r'sellingRate': PropertySchema(
      id: 10,
      name: r'sellingRate',
      type: IsarType.double,
    ),
    r'unit': PropertySchema(
      id: 11,
      name: r'unit',
      type: IsarType.string,
    ),
    r'vat': PropertySchema(
      id: 12,
      name: r'vat',
      type: IsarType.double,
    )
  },
  estimateSize: _itemInfoModelEstimateSize,
  serialize: _itemInfoModelSerialize,
  deserialize: _itemInfoModelDeserialize,
  deserializeProp: _itemInfoModelDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _itemInfoModelGetId,
  getLinks: _itemInfoModelGetLinks,
  attach: _itemInfoModelAttach,
  version: '3.1.0+1',
);

int _itemInfoModelEstimateSize(
  ItemInfoModel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.code.length * 3;
  {
    final value = object.creditSalesAccount;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.name.length * 3;
  {
    final value = object.purchaseAccount;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.salesAccount;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.unit.length * 3;
  return bytesCount;
}

void _itemInfoModelSerialize(
  ItemInfoModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.code);
  writer.writeString(offsets[1], object.creditSalesAccount);
  writer.writeDouble(offsets[2], object.currentQty);
  writer.writeBool(offsets[3], object.isActive);
  writer.writeDouble(offsets[4], object.minQty);
  writer.writeString(offsets[5], object.name);
  writer.writeDouble(offsets[6], object.openingQty);
  writer.writeString(offsets[7], object.purchaseAccount);
  writer.writeDouble(offsets[8], object.purchaseRate);
  writer.writeString(offsets[9], object.salesAccount);
  writer.writeDouble(offsets[10], object.sellingRate);
  writer.writeString(offsets[11], object.unit);
  writer.writeDouble(offsets[12], object.vat);
}

ItemInfoModel _itemInfoModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = ItemInfoModel(
    code: reader.readString(offsets[0]),
    creditSalesAccount: reader.readStringOrNull(offsets[1]),
    currentQty: reader.readDoubleOrNull(offsets[2]) ?? 0,
    id: id,
    isActive: reader.readBoolOrNull(offsets[3]) ?? true,
    minQty: reader.readDoubleOrNull(offsets[4]) ?? 0,
    name: reader.readString(offsets[5]),
    openingQty: reader.readDoubleOrNull(offsets[6]) ?? 0,
    purchaseAccount: reader.readStringOrNull(offsets[7]),
    purchaseRate: reader.readDoubleOrNull(offsets[8]) ?? 0,
    salesAccount: reader.readStringOrNull(offsets[9]),
    sellingRate: reader.readDoubleOrNull(offsets[10]) ?? 0,
    unit: reader.readString(offsets[11]),
    vat: reader.readDoubleOrNull(offsets[12]) ?? 0,
  );
  return object;
}

P _itemInfoModelDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readStringOrNull(offset)) as P;
    case 2:
      return (reader.readDoubleOrNull(offset) ?? 0) as P;
    case 3:
      return (reader.readBoolOrNull(offset) ?? true) as P;
    case 4:
      return (reader.readDoubleOrNull(offset) ?? 0) as P;
    case 5:
      return (reader.readString(offset)) as P;
    case 6:
      return (reader.readDoubleOrNull(offset) ?? 0) as P;
    case 7:
      return (reader.readStringOrNull(offset)) as P;
    case 8:
      return (reader.readDoubleOrNull(offset) ?? 0) as P;
    case 9:
      return (reader.readStringOrNull(offset)) as P;
    case 10:
      return (reader.readDoubleOrNull(offset) ?? 0) as P;
    case 11:
      return (reader.readString(offset)) as P;
    case 12:
      return (reader.readDoubleOrNull(offset) ?? 0) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _itemInfoModelGetId(ItemInfoModel object) {
  return object.id ?? Isar.autoIncrement;
}

List<IsarLinkBase<dynamic>> _itemInfoModelGetLinks(ItemInfoModel object) {
  return [];
}

void _itemInfoModelAttach(
    IsarCollection<dynamic> col, Id id, ItemInfoModel object) {
  object.id = id;
}

extension ItemInfoModelQueryWhereSort
    on QueryBuilder<ItemInfoModel, ItemInfoModel, QWhere> {
  QueryBuilder<ItemInfoModel, ItemInfoModel, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension ItemInfoModelQueryWhere
    on QueryBuilder<ItemInfoModel, ItemInfoModel, QWhereClause> {
  QueryBuilder<ItemInfoModel, ItemInfoModel, QAfterWhereClause> idEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<ItemInfoModel, ItemInfoModel, QAfterWhereClause> idNotEqualTo(
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

  QueryBuilder<ItemInfoModel, ItemInfoModel, QAfterWhereClause> idGreaterThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<ItemInfoModel, ItemInfoModel, QAfterWhereClause> idLessThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<ItemInfoModel, ItemInfoModel, QAfterWhereClause> idBetween(
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

extension ItemInfoModelQueryFilter
    on QueryBuilder<ItemInfoModel, ItemInfoModel, QFilterCondition> {
  QueryBuilder<ItemInfoModel, ItemInfoModel, QAfterFilterCondition> codeEqualTo(
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

  QueryBuilder<ItemInfoModel, ItemInfoModel, QAfterFilterCondition>
      codeGreaterThan(
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

  QueryBuilder<ItemInfoModel, ItemInfoModel, QAfterFilterCondition>
      codeLessThan(
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

  QueryBuilder<ItemInfoModel, ItemInfoModel, QAfterFilterCondition> codeBetween(
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

  QueryBuilder<ItemInfoModel, ItemInfoModel, QAfterFilterCondition>
      codeStartsWith(
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

  QueryBuilder<ItemInfoModel, ItemInfoModel, QAfterFilterCondition>
      codeEndsWith(
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

  QueryBuilder<ItemInfoModel, ItemInfoModel, QAfterFilterCondition>
      codeContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'code',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ItemInfoModel, ItemInfoModel, QAfterFilterCondition> codeMatches(
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

  QueryBuilder<ItemInfoModel, ItemInfoModel, QAfterFilterCondition>
      codeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'code',
        value: '',
      ));
    });
  }

  QueryBuilder<ItemInfoModel, ItemInfoModel, QAfterFilterCondition>
      codeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'code',
        value: '',
      ));
    });
  }

  QueryBuilder<ItemInfoModel, ItemInfoModel, QAfterFilterCondition>
      creditSalesAccountIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'creditSalesAccount',
      ));
    });
  }

  QueryBuilder<ItemInfoModel, ItemInfoModel, QAfterFilterCondition>
      creditSalesAccountIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'creditSalesAccount',
      ));
    });
  }

  QueryBuilder<ItemInfoModel, ItemInfoModel, QAfterFilterCondition>
      creditSalesAccountEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'creditSalesAccount',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ItemInfoModel, ItemInfoModel, QAfterFilterCondition>
      creditSalesAccountGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'creditSalesAccount',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ItemInfoModel, ItemInfoModel, QAfterFilterCondition>
      creditSalesAccountLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'creditSalesAccount',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ItemInfoModel, ItemInfoModel, QAfterFilterCondition>
      creditSalesAccountBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'creditSalesAccount',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ItemInfoModel, ItemInfoModel, QAfterFilterCondition>
      creditSalesAccountStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'creditSalesAccount',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ItemInfoModel, ItemInfoModel, QAfterFilterCondition>
      creditSalesAccountEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'creditSalesAccount',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ItemInfoModel, ItemInfoModel, QAfterFilterCondition>
      creditSalesAccountContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'creditSalesAccount',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ItemInfoModel, ItemInfoModel, QAfterFilterCondition>
      creditSalesAccountMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'creditSalesAccount',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ItemInfoModel, ItemInfoModel, QAfterFilterCondition>
      creditSalesAccountIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'creditSalesAccount',
        value: '',
      ));
    });
  }

  QueryBuilder<ItemInfoModel, ItemInfoModel, QAfterFilterCondition>
      creditSalesAccountIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'creditSalesAccount',
        value: '',
      ));
    });
  }

  QueryBuilder<ItemInfoModel, ItemInfoModel, QAfterFilterCondition>
      currentQtyEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'currentQty',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<ItemInfoModel, ItemInfoModel, QAfterFilterCondition>
      currentQtyGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'currentQty',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<ItemInfoModel, ItemInfoModel, QAfterFilterCondition>
      currentQtyLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'currentQty',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<ItemInfoModel, ItemInfoModel, QAfterFilterCondition>
      currentQtyBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'currentQty',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<ItemInfoModel, ItemInfoModel, QAfterFilterCondition> idIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'id',
      ));
    });
  }

  QueryBuilder<ItemInfoModel, ItemInfoModel, QAfterFilterCondition>
      idIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'id',
      ));
    });
  }

  QueryBuilder<ItemInfoModel, ItemInfoModel, QAfterFilterCondition> idEqualTo(
      Id? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<ItemInfoModel, ItemInfoModel, QAfterFilterCondition>
      idGreaterThan(
    Id? value, {
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

  QueryBuilder<ItemInfoModel, ItemInfoModel, QAfterFilterCondition> idLessThan(
    Id? value, {
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

  QueryBuilder<ItemInfoModel, ItemInfoModel, QAfterFilterCondition> idBetween(
    Id? lower,
    Id? upper, {
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

  QueryBuilder<ItemInfoModel, ItemInfoModel, QAfterFilterCondition>
      isActiveEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isActive',
        value: value,
      ));
    });
  }

  QueryBuilder<ItemInfoModel, ItemInfoModel, QAfterFilterCondition>
      minQtyEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'minQty',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<ItemInfoModel, ItemInfoModel, QAfterFilterCondition>
      minQtyGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'minQty',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<ItemInfoModel, ItemInfoModel, QAfterFilterCondition>
      minQtyLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'minQty',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<ItemInfoModel, ItemInfoModel, QAfterFilterCondition>
      minQtyBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'minQty',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<ItemInfoModel, ItemInfoModel, QAfterFilterCondition> nameEqualTo(
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

  QueryBuilder<ItemInfoModel, ItemInfoModel, QAfterFilterCondition>
      nameGreaterThan(
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

  QueryBuilder<ItemInfoModel, ItemInfoModel, QAfterFilterCondition>
      nameLessThan(
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

  QueryBuilder<ItemInfoModel, ItemInfoModel, QAfterFilterCondition> nameBetween(
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

  QueryBuilder<ItemInfoModel, ItemInfoModel, QAfterFilterCondition>
      nameStartsWith(
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

  QueryBuilder<ItemInfoModel, ItemInfoModel, QAfterFilterCondition>
      nameEndsWith(
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

  QueryBuilder<ItemInfoModel, ItemInfoModel, QAfterFilterCondition>
      nameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ItemInfoModel, ItemInfoModel, QAfterFilterCondition> nameMatches(
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

  QueryBuilder<ItemInfoModel, ItemInfoModel, QAfterFilterCondition>
      nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<ItemInfoModel, ItemInfoModel, QAfterFilterCondition>
      nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<ItemInfoModel, ItemInfoModel, QAfterFilterCondition>
      openingQtyEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'openingQty',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<ItemInfoModel, ItemInfoModel, QAfterFilterCondition>
      openingQtyGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'openingQty',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<ItemInfoModel, ItemInfoModel, QAfterFilterCondition>
      openingQtyLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'openingQty',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<ItemInfoModel, ItemInfoModel, QAfterFilterCondition>
      openingQtyBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'openingQty',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<ItemInfoModel, ItemInfoModel, QAfterFilterCondition>
      purchaseAccountIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'purchaseAccount',
      ));
    });
  }

  QueryBuilder<ItemInfoModel, ItemInfoModel, QAfterFilterCondition>
      purchaseAccountIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'purchaseAccount',
      ));
    });
  }

  QueryBuilder<ItemInfoModel, ItemInfoModel, QAfterFilterCondition>
      purchaseAccountEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'purchaseAccount',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ItemInfoModel, ItemInfoModel, QAfterFilterCondition>
      purchaseAccountGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'purchaseAccount',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ItemInfoModel, ItemInfoModel, QAfterFilterCondition>
      purchaseAccountLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'purchaseAccount',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ItemInfoModel, ItemInfoModel, QAfterFilterCondition>
      purchaseAccountBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'purchaseAccount',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ItemInfoModel, ItemInfoModel, QAfterFilterCondition>
      purchaseAccountStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'purchaseAccount',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ItemInfoModel, ItemInfoModel, QAfterFilterCondition>
      purchaseAccountEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'purchaseAccount',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ItemInfoModel, ItemInfoModel, QAfterFilterCondition>
      purchaseAccountContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'purchaseAccount',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ItemInfoModel, ItemInfoModel, QAfterFilterCondition>
      purchaseAccountMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'purchaseAccount',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ItemInfoModel, ItemInfoModel, QAfterFilterCondition>
      purchaseAccountIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'purchaseAccount',
        value: '',
      ));
    });
  }

  QueryBuilder<ItemInfoModel, ItemInfoModel, QAfterFilterCondition>
      purchaseAccountIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'purchaseAccount',
        value: '',
      ));
    });
  }

  QueryBuilder<ItemInfoModel, ItemInfoModel, QAfterFilterCondition>
      purchaseRateEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'purchaseRate',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<ItemInfoModel, ItemInfoModel, QAfterFilterCondition>
      purchaseRateGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'purchaseRate',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<ItemInfoModel, ItemInfoModel, QAfterFilterCondition>
      purchaseRateLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'purchaseRate',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<ItemInfoModel, ItemInfoModel, QAfterFilterCondition>
      purchaseRateBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'purchaseRate',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<ItemInfoModel, ItemInfoModel, QAfterFilterCondition>
      salesAccountIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'salesAccount',
      ));
    });
  }

  QueryBuilder<ItemInfoModel, ItemInfoModel, QAfterFilterCondition>
      salesAccountIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'salesAccount',
      ));
    });
  }

  QueryBuilder<ItemInfoModel, ItemInfoModel, QAfterFilterCondition>
      salesAccountEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'salesAccount',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ItemInfoModel, ItemInfoModel, QAfterFilterCondition>
      salesAccountGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'salesAccount',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ItemInfoModel, ItemInfoModel, QAfterFilterCondition>
      salesAccountLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'salesAccount',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ItemInfoModel, ItemInfoModel, QAfterFilterCondition>
      salesAccountBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'salesAccount',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ItemInfoModel, ItemInfoModel, QAfterFilterCondition>
      salesAccountStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'salesAccount',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ItemInfoModel, ItemInfoModel, QAfterFilterCondition>
      salesAccountEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'salesAccount',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ItemInfoModel, ItemInfoModel, QAfterFilterCondition>
      salesAccountContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'salesAccount',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ItemInfoModel, ItemInfoModel, QAfterFilterCondition>
      salesAccountMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'salesAccount',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ItemInfoModel, ItemInfoModel, QAfterFilterCondition>
      salesAccountIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'salesAccount',
        value: '',
      ));
    });
  }

  QueryBuilder<ItemInfoModel, ItemInfoModel, QAfterFilterCondition>
      salesAccountIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'salesAccount',
        value: '',
      ));
    });
  }

  QueryBuilder<ItemInfoModel, ItemInfoModel, QAfterFilterCondition>
      sellingRateEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'sellingRate',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<ItemInfoModel, ItemInfoModel, QAfterFilterCondition>
      sellingRateGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'sellingRate',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<ItemInfoModel, ItemInfoModel, QAfterFilterCondition>
      sellingRateLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'sellingRate',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<ItemInfoModel, ItemInfoModel, QAfterFilterCondition>
      sellingRateBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'sellingRate',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<ItemInfoModel, ItemInfoModel, QAfterFilterCondition> unitEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'unit',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ItemInfoModel, ItemInfoModel, QAfterFilterCondition>
      unitGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'unit',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ItemInfoModel, ItemInfoModel, QAfterFilterCondition>
      unitLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'unit',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ItemInfoModel, ItemInfoModel, QAfterFilterCondition> unitBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'unit',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ItemInfoModel, ItemInfoModel, QAfterFilterCondition>
      unitStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'unit',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ItemInfoModel, ItemInfoModel, QAfterFilterCondition>
      unitEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'unit',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ItemInfoModel, ItemInfoModel, QAfterFilterCondition>
      unitContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'unit',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ItemInfoModel, ItemInfoModel, QAfterFilterCondition> unitMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'unit',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ItemInfoModel, ItemInfoModel, QAfterFilterCondition>
      unitIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'unit',
        value: '',
      ));
    });
  }

  QueryBuilder<ItemInfoModel, ItemInfoModel, QAfterFilterCondition>
      unitIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'unit',
        value: '',
      ));
    });
  }

  QueryBuilder<ItemInfoModel, ItemInfoModel, QAfterFilterCondition> vatEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'vat',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<ItemInfoModel, ItemInfoModel, QAfterFilterCondition>
      vatGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'vat',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<ItemInfoModel, ItemInfoModel, QAfterFilterCondition> vatLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'vat',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<ItemInfoModel, ItemInfoModel, QAfterFilterCondition> vatBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'vat',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }
}

extension ItemInfoModelQueryObject
    on QueryBuilder<ItemInfoModel, ItemInfoModel, QFilterCondition> {}

extension ItemInfoModelQueryLinks
    on QueryBuilder<ItemInfoModel, ItemInfoModel, QFilterCondition> {}

extension ItemInfoModelQuerySortBy
    on QueryBuilder<ItemInfoModel, ItemInfoModel, QSortBy> {
  QueryBuilder<ItemInfoModel, ItemInfoModel, QAfterSortBy> sortByCode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'code', Sort.asc);
    });
  }

  QueryBuilder<ItemInfoModel, ItemInfoModel, QAfterSortBy> sortByCodeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'code', Sort.desc);
    });
  }

  QueryBuilder<ItemInfoModel, ItemInfoModel, QAfterSortBy>
      sortByCreditSalesAccount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'creditSalesAccount', Sort.asc);
    });
  }

  QueryBuilder<ItemInfoModel, ItemInfoModel, QAfterSortBy>
      sortByCreditSalesAccountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'creditSalesAccount', Sort.desc);
    });
  }

  QueryBuilder<ItemInfoModel, ItemInfoModel, QAfterSortBy> sortByCurrentQty() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currentQty', Sort.asc);
    });
  }

  QueryBuilder<ItemInfoModel, ItemInfoModel, QAfterSortBy>
      sortByCurrentQtyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currentQty', Sort.desc);
    });
  }

  QueryBuilder<ItemInfoModel, ItemInfoModel, QAfterSortBy> sortByIsActive() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isActive', Sort.asc);
    });
  }

  QueryBuilder<ItemInfoModel, ItemInfoModel, QAfterSortBy>
      sortByIsActiveDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isActive', Sort.desc);
    });
  }

  QueryBuilder<ItemInfoModel, ItemInfoModel, QAfterSortBy> sortByMinQty() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'minQty', Sort.asc);
    });
  }

  QueryBuilder<ItemInfoModel, ItemInfoModel, QAfterSortBy> sortByMinQtyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'minQty', Sort.desc);
    });
  }

  QueryBuilder<ItemInfoModel, ItemInfoModel, QAfterSortBy> sortByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<ItemInfoModel, ItemInfoModel, QAfterSortBy> sortByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<ItemInfoModel, ItemInfoModel, QAfterSortBy> sortByOpeningQty() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'openingQty', Sort.asc);
    });
  }

  QueryBuilder<ItemInfoModel, ItemInfoModel, QAfterSortBy>
      sortByOpeningQtyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'openingQty', Sort.desc);
    });
  }

  QueryBuilder<ItemInfoModel, ItemInfoModel, QAfterSortBy>
      sortByPurchaseAccount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'purchaseAccount', Sort.asc);
    });
  }

  QueryBuilder<ItemInfoModel, ItemInfoModel, QAfterSortBy>
      sortByPurchaseAccountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'purchaseAccount', Sort.desc);
    });
  }

  QueryBuilder<ItemInfoModel, ItemInfoModel, QAfterSortBy>
      sortByPurchaseRate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'purchaseRate', Sort.asc);
    });
  }

  QueryBuilder<ItemInfoModel, ItemInfoModel, QAfterSortBy>
      sortByPurchaseRateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'purchaseRate', Sort.desc);
    });
  }

  QueryBuilder<ItemInfoModel, ItemInfoModel, QAfterSortBy>
      sortBySalesAccount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'salesAccount', Sort.asc);
    });
  }

  QueryBuilder<ItemInfoModel, ItemInfoModel, QAfterSortBy>
      sortBySalesAccountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'salesAccount', Sort.desc);
    });
  }

  QueryBuilder<ItemInfoModel, ItemInfoModel, QAfterSortBy> sortBySellingRate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sellingRate', Sort.asc);
    });
  }

  QueryBuilder<ItemInfoModel, ItemInfoModel, QAfterSortBy>
      sortBySellingRateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sellingRate', Sort.desc);
    });
  }

  QueryBuilder<ItemInfoModel, ItemInfoModel, QAfterSortBy> sortByUnit() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'unit', Sort.asc);
    });
  }

  QueryBuilder<ItemInfoModel, ItemInfoModel, QAfterSortBy> sortByUnitDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'unit', Sort.desc);
    });
  }

  QueryBuilder<ItemInfoModel, ItemInfoModel, QAfterSortBy> sortByVat() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'vat', Sort.asc);
    });
  }

  QueryBuilder<ItemInfoModel, ItemInfoModel, QAfterSortBy> sortByVatDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'vat', Sort.desc);
    });
  }
}

extension ItemInfoModelQuerySortThenBy
    on QueryBuilder<ItemInfoModel, ItemInfoModel, QSortThenBy> {
  QueryBuilder<ItemInfoModel, ItemInfoModel, QAfterSortBy> thenByCode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'code', Sort.asc);
    });
  }

  QueryBuilder<ItemInfoModel, ItemInfoModel, QAfterSortBy> thenByCodeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'code', Sort.desc);
    });
  }

  QueryBuilder<ItemInfoModel, ItemInfoModel, QAfterSortBy>
      thenByCreditSalesAccount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'creditSalesAccount', Sort.asc);
    });
  }

  QueryBuilder<ItemInfoModel, ItemInfoModel, QAfterSortBy>
      thenByCreditSalesAccountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'creditSalesAccount', Sort.desc);
    });
  }

  QueryBuilder<ItemInfoModel, ItemInfoModel, QAfterSortBy> thenByCurrentQty() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currentQty', Sort.asc);
    });
  }

  QueryBuilder<ItemInfoModel, ItemInfoModel, QAfterSortBy>
      thenByCurrentQtyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currentQty', Sort.desc);
    });
  }

  QueryBuilder<ItemInfoModel, ItemInfoModel, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<ItemInfoModel, ItemInfoModel, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<ItemInfoModel, ItemInfoModel, QAfterSortBy> thenByIsActive() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isActive', Sort.asc);
    });
  }

  QueryBuilder<ItemInfoModel, ItemInfoModel, QAfterSortBy>
      thenByIsActiveDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isActive', Sort.desc);
    });
  }

  QueryBuilder<ItemInfoModel, ItemInfoModel, QAfterSortBy> thenByMinQty() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'minQty', Sort.asc);
    });
  }

  QueryBuilder<ItemInfoModel, ItemInfoModel, QAfterSortBy> thenByMinQtyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'minQty', Sort.desc);
    });
  }

  QueryBuilder<ItemInfoModel, ItemInfoModel, QAfterSortBy> thenByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<ItemInfoModel, ItemInfoModel, QAfterSortBy> thenByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<ItemInfoModel, ItemInfoModel, QAfterSortBy> thenByOpeningQty() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'openingQty', Sort.asc);
    });
  }

  QueryBuilder<ItemInfoModel, ItemInfoModel, QAfterSortBy>
      thenByOpeningQtyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'openingQty', Sort.desc);
    });
  }

  QueryBuilder<ItemInfoModel, ItemInfoModel, QAfterSortBy>
      thenByPurchaseAccount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'purchaseAccount', Sort.asc);
    });
  }

  QueryBuilder<ItemInfoModel, ItemInfoModel, QAfterSortBy>
      thenByPurchaseAccountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'purchaseAccount', Sort.desc);
    });
  }

  QueryBuilder<ItemInfoModel, ItemInfoModel, QAfterSortBy>
      thenByPurchaseRate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'purchaseRate', Sort.asc);
    });
  }

  QueryBuilder<ItemInfoModel, ItemInfoModel, QAfterSortBy>
      thenByPurchaseRateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'purchaseRate', Sort.desc);
    });
  }

  QueryBuilder<ItemInfoModel, ItemInfoModel, QAfterSortBy>
      thenBySalesAccount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'salesAccount', Sort.asc);
    });
  }

  QueryBuilder<ItemInfoModel, ItemInfoModel, QAfterSortBy>
      thenBySalesAccountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'salesAccount', Sort.desc);
    });
  }

  QueryBuilder<ItemInfoModel, ItemInfoModel, QAfterSortBy> thenBySellingRate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sellingRate', Sort.asc);
    });
  }

  QueryBuilder<ItemInfoModel, ItemInfoModel, QAfterSortBy>
      thenBySellingRateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sellingRate', Sort.desc);
    });
  }

  QueryBuilder<ItemInfoModel, ItemInfoModel, QAfterSortBy> thenByUnit() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'unit', Sort.asc);
    });
  }

  QueryBuilder<ItemInfoModel, ItemInfoModel, QAfterSortBy> thenByUnitDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'unit', Sort.desc);
    });
  }

  QueryBuilder<ItemInfoModel, ItemInfoModel, QAfterSortBy> thenByVat() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'vat', Sort.asc);
    });
  }

  QueryBuilder<ItemInfoModel, ItemInfoModel, QAfterSortBy> thenByVatDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'vat', Sort.desc);
    });
  }
}

extension ItemInfoModelQueryWhereDistinct
    on QueryBuilder<ItemInfoModel, ItemInfoModel, QDistinct> {
  QueryBuilder<ItemInfoModel, ItemInfoModel, QDistinct> distinctByCode(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'code', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ItemInfoModel, ItemInfoModel, QDistinct>
      distinctByCreditSalesAccount({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'creditSalesAccount',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ItemInfoModel, ItemInfoModel, QDistinct> distinctByCurrentQty() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'currentQty');
    });
  }

  QueryBuilder<ItemInfoModel, ItemInfoModel, QDistinct> distinctByIsActive() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isActive');
    });
  }

  QueryBuilder<ItemInfoModel, ItemInfoModel, QDistinct> distinctByMinQty() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'minQty');
    });
  }

  QueryBuilder<ItemInfoModel, ItemInfoModel, QDistinct> distinctByName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'name', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ItemInfoModel, ItemInfoModel, QDistinct> distinctByOpeningQty() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'openingQty');
    });
  }

  QueryBuilder<ItemInfoModel, ItemInfoModel, QDistinct>
      distinctByPurchaseAccount({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'purchaseAccount',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ItemInfoModel, ItemInfoModel, QDistinct>
      distinctByPurchaseRate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'purchaseRate');
    });
  }

  QueryBuilder<ItemInfoModel, ItemInfoModel, QDistinct> distinctBySalesAccount(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'salesAccount', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ItemInfoModel, ItemInfoModel, QDistinct>
      distinctBySellingRate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'sellingRate');
    });
  }

  QueryBuilder<ItemInfoModel, ItemInfoModel, QDistinct> distinctByUnit(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'unit', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ItemInfoModel, ItemInfoModel, QDistinct> distinctByVat() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'vat');
    });
  }
}

extension ItemInfoModelQueryProperty
    on QueryBuilder<ItemInfoModel, ItemInfoModel, QQueryProperty> {
  QueryBuilder<ItemInfoModel, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<ItemInfoModel, String, QQueryOperations> codeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'code');
    });
  }

  QueryBuilder<ItemInfoModel, String?, QQueryOperations>
      creditSalesAccountProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'creditSalesAccount');
    });
  }

  QueryBuilder<ItemInfoModel, double, QQueryOperations> currentQtyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'currentQty');
    });
  }

  QueryBuilder<ItemInfoModel, bool, QQueryOperations> isActiveProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isActive');
    });
  }

  QueryBuilder<ItemInfoModel, double, QQueryOperations> minQtyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'minQty');
    });
  }

  QueryBuilder<ItemInfoModel, String, QQueryOperations> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'name');
    });
  }

  QueryBuilder<ItemInfoModel, double, QQueryOperations> openingQtyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'openingQty');
    });
  }

  QueryBuilder<ItemInfoModel, String?, QQueryOperations>
      purchaseAccountProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'purchaseAccount');
    });
  }

  QueryBuilder<ItemInfoModel, double, QQueryOperations> purchaseRateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'purchaseRate');
    });
  }

  QueryBuilder<ItemInfoModel, String?, QQueryOperations>
      salesAccountProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'salesAccount');
    });
  }

  QueryBuilder<ItemInfoModel, double, QQueryOperations> sellingRateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'sellingRate');
    });
  }

  QueryBuilder<ItemInfoModel, String, QQueryOperations> unitProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'unit');
    });
  }

  QueryBuilder<ItemInfoModel, double, QQueryOperations> vatProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'vat');
    });
  }
}
