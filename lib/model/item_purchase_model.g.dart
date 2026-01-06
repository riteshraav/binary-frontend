// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_purchase_model.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetItemPurchaseCollection on Isar {
  IsarCollection<ItemPurchase> get itemPurchases => this.collection();
}

const ItemPurchaseSchema = CollectionSchema(
  name: r'ItemPurchase',
  id: -1609982208094539549,
  properties: {
    r'amount': PropertySchema(
      id: 0,
      name: r'amount',
      type: IsarType.string,
    ),
    r'billAmount': PropertySchema(
      id: 1,
      name: r'billAmount',
      type: IsarType.string,
    ),
    r'commission': PropertySchema(
      id: 2,
      name: r'commission',
      type: IsarType.string,
    ),
    r'date': PropertySchema(
      id: 3,
      name: r'date',
      type: IsarType.dateTime,
    ),
    r'details': PropertySchema(
      id: 4,
      name: r'details',
      type: IsarType.string,
    ),
    r'hamali': PropertySchema(
      id: 5,
      name: r'hamali',
      type: IsarType.string,
    ),
    r'itemName': PropertySchema(
      id: 6,
      name: r'itemName',
      type: IsarType.string,
    ),
    r'paymentType': PropertySchema(
      id: 7,
      name: r'paymentType',
      type: IsarType.string,
    ),
    r'qty': PropertySchema(
      id: 8,
      name: r'qty',
      type: IsarType.string,
    ),
    r'rate': PropertySchema(
      id: 9,
      name: r'rate',
      type: IsarType.string,
    ),
    r'seqNo': PropertySchema(
      id: 10,
      name: r'seqNo',
      type: IsarType.string,
    ),
    r'totalAmount': PropertySchema(
      id: 11,
      name: r'totalAmount',
      type: IsarType.string,
    ),
    r'vat': PropertySchema(
      id: 12,
      name: r'vat',
      type: IsarType.string,
    ),
    r'voucherNo': PropertySchema(
      id: 13,
      name: r'voucherNo',
      type: IsarType.string,
    ),
    r'voucherNum': PropertySchema(
      id: 14,
      name: r'voucherNum',
      type: IsarType.string,
    )
  },
  estimateSize: _itemPurchaseEstimateSize,
  serialize: _itemPurchaseSerialize,
  deserialize: _itemPurchaseDeserialize,
  deserializeProp: _itemPurchaseDeserializeProp,
  idName: r'id',
  indexes: {
    r'voucherNo': IndexSchema(
      id: -5535874237218804506,
      name: r'voucherNo',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'voucherNo',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    )
  },
  links: {
    r'item': LinkSchema(
      id: -5560327029376650662,
      name: r'item',
      target: r'ItemInfoModel',
      single: true,
    ),
    r'supplier': LinkSchema(
      id: 1317773287170215513,
      name: r'supplier',
      target: r'Supplier',
      single: true,
    )
  },
  embeddedSchemas: {},
  getId: _itemPurchaseGetId,
  getLinks: _itemPurchaseGetLinks,
  attach: _itemPurchaseAttach,
  version: '3.1.0+1',
);

int _itemPurchaseEstimateSize(
  ItemPurchase object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.amount.length * 3;
  bytesCount += 3 + object.billAmount.length * 3;
  bytesCount += 3 + object.commission.length * 3;
  bytesCount += 3 + object.details.length * 3;
  bytesCount += 3 + object.hamali.length * 3;
  bytesCount += 3 + object.itemName.length * 3;
  bytesCount += 3 + object.paymentType.length * 3;
  bytesCount += 3 + object.qty.length * 3;
  bytesCount += 3 + object.rate.length * 3;
  bytesCount += 3 + object.seqNo.length * 3;
  bytesCount += 3 + object.totalAmount.length * 3;
  bytesCount += 3 + object.vat.length * 3;
  bytesCount += 3 + object.voucherNo.length * 3;
  bytesCount += 3 + object.voucherNum.length * 3;
  return bytesCount;
}

void _itemPurchaseSerialize(
  ItemPurchase object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.amount);
  writer.writeString(offsets[1], object.billAmount);
  writer.writeString(offsets[2], object.commission);
  writer.writeDateTime(offsets[3], object.date);
  writer.writeString(offsets[4], object.details);
  writer.writeString(offsets[5], object.hamali);
  writer.writeString(offsets[6], object.itemName);
  writer.writeString(offsets[7], object.paymentType);
  writer.writeString(offsets[8], object.qty);
  writer.writeString(offsets[9], object.rate);
  writer.writeString(offsets[10], object.seqNo);
  writer.writeString(offsets[11], object.totalAmount);
  writer.writeString(offsets[12], object.vat);
  writer.writeString(offsets[13], object.voucherNo);
  writer.writeString(offsets[14], object.voucherNum);
}

ItemPurchase _itemPurchaseDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = ItemPurchase();
  object.amount = reader.readString(offsets[0]);
  object.billAmount = reader.readString(offsets[1]);
  object.commission = reader.readString(offsets[2]);
  object.date = reader.readDateTime(offsets[3]);
  object.details = reader.readString(offsets[4]);
  object.hamali = reader.readString(offsets[5]);
  object.id = id;
  object.itemName = reader.readString(offsets[6]);
  object.paymentType = reader.readString(offsets[7]);
  object.qty = reader.readString(offsets[8]);
  object.rate = reader.readString(offsets[9]);
  object.seqNo = reader.readString(offsets[10]);
  object.totalAmount = reader.readString(offsets[11]);
  object.vat = reader.readString(offsets[12]);
  object.voucherNo = reader.readString(offsets[13]);
  object.voucherNum = reader.readString(offsets[14]);
  return object;
}

P _itemPurchaseDeserializeProp<P>(
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
      return (reader.readDateTime(offset)) as P;
    case 4:
      return (reader.readString(offset)) as P;
    case 5:
      return (reader.readString(offset)) as P;
    case 6:
      return (reader.readString(offset)) as P;
    case 7:
      return (reader.readString(offset)) as P;
    case 8:
      return (reader.readString(offset)) as P;
    case 9:
      return (reader.readString(offset)) as P;
    case 10:
      return (reader.readString(offset)) as P;
    case 11:
      return (reader.readString(offset)) as P;
    case 12:
      return (reader.readString(offset)) as P;
    case 13:
      return (reader.readString(offset)) as P;
    case 14:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _itemPurchaseGetId(ItemPurchase object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _itemPurchaseGetLinks(ItemPurchase object) {
  return [object.item, object.supplier];
}

void _itemPurchaseAttach(
    IsarCollection<dynamic> col, Id id, ItemPurchase object) {
  object.id = id;
  object.item.attach(col, col.isar.collection<ItemInfoModel>(), r'item', id);
  object.supplier.attach(col, col.isar.collection<Supplier>(), r'supplier', id);
}

extension ItemPurchaseQueryWhereSort
    on QueryBuilder<ItemPurchase, ItemPurchase, QWhere> {
  QueryBuilder<ItemPurchase, ItemPurchase, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension ItemPurchaseQueryWhere
    on QueryBuilder<ItemPurchase, ItemPurchase, QWhereClause> {
  QueryBuilder<ItemPurchase, ItemPurchase, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<ItemPurchase, ItemPurchase, QAfterWhereClause> idNotEqualTo(
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

  QueryBuilder<ItemPurchase, ItemPurchase, QAfterWhereClause> idGreaterThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<ItemPurchase, ItemPurchase, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<ItemPurchase, ItemPurchase, QAfterWhereClause> idBetween(
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

  QueryBuilder<ItemPurchase, ItemPurchase, QAfterWhereClause> voucherNoEqualTo(
      String voucherNo) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'voucherNo',
        value: [voucherNo],
      ));
    });
  }

  QueryBuilder<ItemPurchase, ItemPurchase, QAfterWhereClause>
      voucherNoNotEqualTo(String voucherNo) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'voucherNo',
              lower: [],
              upper: [voucherNo],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'voucherNo',
              lower: [voucherNo],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'voucherNo',
              lower: [voucherNo],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'voucherNo',
              lower: [],
              upper: [voucherNo],
              includeUpper: false,
            ));
      }
    });
  }
}

extension ItemPurchaseQueryFilter
    on QueryBuilder<ItemPurchase, ItemPurchase, QFilterCondition> {
  QueryBuilder<ItemPurchase, ItemPurchase, QAfterFilterCondition> amountEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'amount',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ItemPurchase, ItemPurchase, QAfterFilterCondition>
      amountGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'amount',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ItemPurchase, ItemPurchase, QAfterFilterCondition>
      amountLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'amount',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ItemPurchase, ItemPurchase, QAfterFilterCondition> amountBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'amount',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ItemPurchase, ItemPurchase, QAfterFilterCondition>
      amountStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'amount',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ItemPurchase, ItemPurchase, QAfterFilterCondition>
      amountEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'amount',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ItemPurchase, ItemPurchase, QAfterFilterCondition>
      amountContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'amount',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ItemPurchase, ItemPurchase, QAfterFilterCondition> amountMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'amount',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ItemPurchase, ItemPurchase, QAfterFilterCondition>
      amountIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'amount',
        value: '',
      ));
    });
  }

  QueryBuilder<ItemPurchase, ItemPurchase, QAfterFilterCondition>
      amountIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'amount',
        value: '',
      ));
    });
  }

  QueryBuilder<ItemPurchase, ItemPurchase, QAfterFilterCondition>
      billAmountEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'billAmount',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ItemPurchase, ItemPurchase, QAfterFilterCondition>
      billAmountGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'billAmount',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ItemPurchase, ItemPurchase, QAfterFilterCondition>
      billAmountLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'billAmount',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ItemPurchase, ItemPurchase, QAfterFilterCondition>
      billAmountBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'billAmount',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ItemPurchase, ItemPurchase, QAfterFilterCondition>
      billAmountStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'billAmount',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ItemPurchase, ItemPurchase, QAfterFilterCondition>
      billAmountEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'billAmount',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ItemPurchase, ItemPurchase, QAfterFilterCondition>
      billAmountContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'billAmount',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ItemPurchase, ItemPurchase, QAfterFilterCondition>
      billAmountMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'billAmount',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ItemPurchase, ItemPurchase, QAfterFilterCondition>
      billAmountIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'billAmount',
        value: '',
      ));
    });
  }

  QueryBuilder<ItemPurchase, ItemPurchase, QAfterFilterCondition>
      billAmountIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'billAmount',
        value: '',
      ));
    });
  }

  QueryBuilder<ItemPurchase, ItemPurchase, QAfterFilterCondition>
      commissionEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'commission',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ItemPurchase, ItemPurchase, QAfterFilterCondition>
      commissionGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'commission',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ItemPurchase, ItemPurchase, QAfterFilterCondition>
      commissionLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'commission',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ItemPurchase, ItemPurchase, QAfterFilterCondition>
      commissionBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'commission',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ItemPurchase, ItemPurchase, QAfterFilterCondition>
      commissionStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'commission',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ItemPurchase, ItemPurchase, QAfterFilterCondition>
      commissionEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'commission',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ItemPurchase, ItemPurchase, QAfterFilterCondition>
      commissionContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'commission',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ItemPurchase, ItemPurchase, QAfterFilterCondition>
      commissionMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'commission',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ItemPurchase, ItemPurchase, QAfterFilterCondition>
      commissionIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'commission',
        value: '',
      ));
    });
  }

  QueryBuilder<ItemPurchase, ItemPurchase, QAfterFilterCondition>
      commissionIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'commission',
        value: '',
      ));
    });
  }

  QueryBuilder<ItemPurchase, ItemPurchase, QAfterFilterCondition> dateEqualTo(
      DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'date',
        value: value,
      ));
    });
  }

  QueryBuilder<ItemPurchase, ItemPurchase, QAfterFilterCondition>
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

  QueryBuilder<ItemPurchase, ItemPurchase, QAfterFilterCondition> dateLessThan(
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

  QueryBuilder<ItemPurchase, ItemPurchase, QAfterFilterCondition> dateBetween(
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

  QueryBuilder<ItemPurchase, ItemPurchase, QAfterFilterCondition>
      detailsEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'details',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ItemPurchase, ItemPurchase, QAfterFilterCondition>
      detailsGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'details',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ItemPurchase, ItemPurchase, QAfterFilterCondition>
      detailsLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'details',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ItemPurchase, ItemPurchase, QAfterFilterCondition>
      detailsBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'details',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ItemPurchase, ItemPurchase, QAfterFilterCondition>
      detailsStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'details',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ItemPurchase, ItemPurchase, QAfterFilterCondition>
      detailsEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'details',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ItemPurchase, ItemPurchase, QAfterFilterCondition>
      detailsContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'details',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ItemPurchase, ItemPurchase, QAfterFilterCondition>
      detailsMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'details',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ItemPurchase, ItemPurchase, QAfterFilterCondition>
      detailsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'details',
        value: '',
      ));
    });
  }

  QueryBuilder<ItemPurchase, ItemPurchase, QAfterFilterCondition>
      detailsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'details',
        value: '',
      ));
    });
  }

  QueryBuilder<ItemPurchase, ItemPurchase, QAfterFilterCondition> hamaliEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'hamali',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ItemPurchase, ItemPurchase, QAfterFilterCondition>
      hamaliGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'hamali',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ItemPurchase, ItemPurchase, QAfterFilterCondition>
      hamaliLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'hamali',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ItemPurchase, ItemPurchase, QAfterFilterCondition> hamaliBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'hamali',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ItemPurchase, ItemPurchase, QAfterFilterCondition>
      hamaliStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'hamali',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ItemPurchase, ItemPurchase, QAfterFilterCondition>
      hamaliEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'hamali',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ItemPurchase, ItemPurchase, QAfterFilterCondition>
      hamaliContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'hamali',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ItemPurchase, ItemPurchase, QAfterFilterCondition> hamaliMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'hamali',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ItemPurchase, ItemPurchase, QAfterFilterCondition>
      hamaliIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'hamali',
        value: '',
      ));
    });
  }

  QueryBuilder<ItemPurchase, ItemPurchase, QAfterFilterCondition>
      hamaliIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'hamali',
        value: '',
      ));
    });
  }

  QueryBuilder<ItemPurchase, ItemPurchase, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<ItemPurchase, ItemPurchase, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<ItemPurchase, ItemPurchase, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<ItemPurchase, ItemPurchase, QAfterFilterCondition> idBetween(
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

  QueryBuilder<ItemPurchase, ItemPurchase, QAfterFilterCondition>
      itemNameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'itemName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ItemPurchase, ItemPurchase, QAfterFilterCondition>
      itemNameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'itemName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ItemPurchase, ItemPurchase, QAfterFilterCondition>
      itemNameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'itemName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ItemPurchase, ItemPurchase, QAfterFilterCondition>
      itemNameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'itemName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ItemPurchase, ItemPurchase, QAfterFilterCondition>
      itemNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'itemName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ItemPurchase, ItemPurchase, QAfterFilterCondition>
      itemNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'itemName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ItemPurchase, ItemPurchase, QAfterFilterCondition>
      itemNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'itemName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ItemPurchase, ItemPurchase, QAfterFilterCondition>
      itemNameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'itemName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ItemPurchase, ItemPurchase, QAfterFilterCondition>
      itemNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'itemName',
        value: '',
      ));
    });
  }

  QueryBuilder<ItemPurchase, ItemPurchase, QAfterFilterCondition>
      itemNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'itemName',
        value: '',
      ));
    });
  }

  QueryBuilder<ItemPurchase, ItemPurchase, QAfterFilterCondition>
      paymentTypeEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'paymentType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ItemPurchase, ItemPurchase, QAfterFilterCondition>
      paymentTypeGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'paymentType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ItemPurchase, ItemPurchase, QAfterFilterCondition>
      paymentTypeLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'paymentType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ItemPurchase, ItemPurchase, QAfterFilterCondition>
      paymentTypeBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'paymentType',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ItemPurchase, ItemPurchase, QAfterFilterCondition>
      paymentTypeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'paymentType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ItemPurchase, ItemPurchase, QAfterFilterCondition>
      paymentTypeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'paymentType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ItemPurchase, ItemPurchase, QAfterFilterCondition>
      paymentTypeContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'paymentType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ItemPurchase, ItemPurchase, QAfterFilterCondition>
      paymentTypeMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'paymentType',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ItemPurchase, ItemPurchase, QAfterFilterCondition>
      paymentTypeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'paymentType',
        value: '',
      ));
    });
  }

  QueryBuilder<ItemPurchase, ItemPurchase, QAfterFilterCondition>
      paymentTypeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'paymentType',
        value: '',
      ));
    });
  }

  QueryBuilder<ItemPurchase, ItemPurchase, QAfterFilterCondition> qtyEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'qty',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ItemPurchase, ItemPurchase, QAfterFilterCondition>
      qtyGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'qty',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ItemPurchase, ItemPurchase, QAfterFilterCondition> qtyLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'qty',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ItemPurchase, ItemPurchase, QAfterFilterCondition> qtyBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'qty',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ItemPurchase, ItemPurchase, QAfterFilterCondition> qtyStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'qty',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ItemPurchase, ItemPurchase, QAfterFilterCondition> qtyEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'qty',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ItemPurchase, ItemPurchase, QAfterFilterCondition> qtyContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'qty',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ItemPurchase, ItemPurchase, QAfterFilterCondition> qtyMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'qty',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ItemPurchase, ItemPurchase, QAfterFilterCondition> qtyIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'qty',
        value: '',
      ));
    });
  }

  QueryBuilder<ItemPurchase, ItemPurchase, QAfterFilterCondition>
      qtyIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'qty',
        value: '',
      ));
    });
  }

  QueryBuilder<ItemPurchase, ItemPurchase, QAfterFilterCondition> rateEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'rate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ItemPurchase, ItemPurchase, QAfterFilterCondition>
      rateGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'rate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ItemPurchase, ItemPurchase, QAfterFilterCondition> rateLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'rate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ItemPurchase, ItemPurchase, QAfterFilterCondition> rateBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'rate',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ItemPurchase, ItemPurchase, QAfterFilterCondition>
      rateStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'rate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ItemPurchase, ItemPurchase, QAfterFilterCondition> rateEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'rate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ItemPurchase, ItemPurchase, QAfterFilterCondition> rateContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'rate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ItemPurchase, ItemPurchase, QAfterFilterCondition> rateMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'rate',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ItemPurchase, ItemPurchase, QAfterFilterCondition>
      rateIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'rate',
        value: '',
      ));
    });
  }

  QueryBuilder<ItemPurchase, ItemPurchase, QAfterFilterCondition>
      rateIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'rate',
        value: '',
      ));
    });
  }

  QueryBuilder<ItemPurchase, ItemPurchase, QAfterFilterCondition> seqNoEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'seqNo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ItemPurchase, ItemPurchase, QAfterFilterCondition>
      seqNoGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'seqNo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ItemPurchase, ItemPurchase, QAfterFilterCondition> seqNoLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'seqNo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ItemPurchase, ItemPurchase, QAfterFilterCondition> seqNoBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'seqNo',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ItemPurchase, ItemPurchase, QAfterFilterCondition>
      seqNoStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'seqNo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ItemPurchase, ItemPurchase, QAfterFilterCondition> seqNoEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'seqNo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ItemPurchase, ItemPurchase, QAfterFilterCondition> seqNoContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'seqNo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ItemPurchase, ItemPurchase, QAfterFilterCondition> seqNoMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'seqNo',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ItemPurchase, ItemPurchase, QAfterFilterCondition>
      seqNoIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'seqNo',
        value: '',
      ));
    });
  }

  QueryBuilder<ItemPurchase, ItemPurchase, QAfterFilterCondition>
      seqNoIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'seqNo',
        value: '',
      ));
    });
  }

  QueryBuilder<ItemPurchase, ItemPurchase, QAfterFilterCondition>
      totalAmountEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'totalAmount',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ItemPurchase, ItemPurchase, QAfterFilterCondition>
      totalAmountGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'totalAmount',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ItemPurchase, ItemPurchase, QAfterFilterCondition>
      totalAmountLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'totalAmount',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ItemPurchase, ItemPurchase, QAfterFilterCondition>
      totalAmountBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'totalAmount',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ItemPurchase, ItemPurchase, QAfterFilterCondition>
      totalAmountStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'totalAmount',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ItemPurchase, ItemPurchase, QAfterFilterCondition>
      totalAmountEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'totalAmount',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ItemPurchase, ItemPurchase, QAfterFilterCondition>
      totalAmountContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'totalAmount',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ItemPurchase, ItemPurchase, QAfterFilterCondition>
      totalAmountMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'totalAmount',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ItemPurchase, ItemPurchase, QAfterFilterCondition>
      totalAmountIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'totalAmount',
        value: '',
      ));
    });
  }

  QueryBuilder<ItemPurchase, ItemPurchase, QAfterFilterCondition>
      totalAmountIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'totalAmount',
        value: '',
      ));
    });
  }

  QueryBuilder<ItemPurchase, ItemPurchase, QAfterFilterCondition> vatEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'vat',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ItemPurchase, ItemPurchase, QAfterFilterCondition>
      vatGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'vat',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ItemPurchase, ItemPurchase, QAfterFilterCondition> vatLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'vat',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ItemPurchase, ItemPurchase, QAfterFilterCondition> vatBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'vat',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ItemPurchase, ItemPurchase, QAfterFilterCondition> vatStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'vat',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ItemPurchase, ItemPurchase, QAfterFilterCondition> vatEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'vat',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ItemPurchase, ItemPurchase, QAfterFilterCondition> vatContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'vat',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ItemPurchase, ItemPurchase, QAfterFilterCondition> vatMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'vat',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ItemPurchase, ItemPurchase, QAfterFilterCondition> vatIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'vat',
        value: '',
      ));
    });
  }

  QueryBuilder<ItemPurchase, ItemPurchase, QAfterFilterCondition>
      vatIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'vat',
        value: '',
      ));
    });
  }

  QueryBuilder<ItemPurchase, ItemPurchase, QAfterFilterCondition>
      voucherNoEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'voucherNo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ItemPurchase, ItemPurchase, QAfterFilterCondition>
      voucherNoGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'voucherNo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ItemPurchase, ItemPurchase, QAfterFilterCondition>
      voucherNoLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'voucherNo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ItemPurchase, ItemPurchase, QAfterFilterCondition>
      voucherNoBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'voucherNo',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ItemPurchase, ItemPurchase, QAfterFilterCondition>
      voucherNoStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'voucherNo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ItemPurchase, ItemPurchase, QAfterFilterCondition>
      voucherNoEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'voucherNo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ItemPurchase, ItemPurchase, QAfterFilterCondition>
      voucherNoContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'voucherNo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ItemPurchase, ItemPurchase, QAfterFilterCondition>
      voucherNoMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'voucherNo',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ItemPurchase, ItemPurchase, QAfterFilterCondition>
      voucherNoIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'voucherNo',
        value: '',
      ));
    });
  }

  QueryBuilder<ItemPurchase, ItemPurchase, QAfterFilterCondition>
      voucherNoIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'voucherNo',
        value: '',
      ));
    });
  }

  QueryBuilder<ItemPurchase, ItemPurchase, QAfterFilterCondition>
      voucherNumEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'voucherNum',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ItemPurchase, ItemPurchase, QAfterFilterCondition>
      voucherNumGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'voucherNum',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ItemPurchase, ItemPurchase, QAfterFilterCondition>
      voucherNumLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'voucherNum',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ItemPurchase, ItemPurchase, QAfterFilterCondition>
      voucherNumBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'voucherNum',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ItemPurchase, ItemPurchase, QAfterFilterCondition>
      voucherNumStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'voucherNum',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ItemPurchase, ItemPurchase, QAfterFilterCondition>
      voucherNumEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'voucherNum',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ItemPurchase, ItemPurchase, QAfterFilterCondition>
      voucherNumContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'voucherNum',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ItemPurchase, ItemPurchase, QAfterFilterCondition>
      voucherNumMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'voucherNum',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ItemPurchase, ItemPurchase, QAfterFilterCondition>
      voucherNumIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'voucherNum',
        value: '',
      ));
    });
  }

  QueryBuilder<ItemPurchase, ItemPurchase, QAfterFilterCondition>
      voucherNumIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'voucherNum',
        value: '',
      ));
    });
  }
}

extension ItemPurchaseQueryObject
    on QueryBuilder<ItemPurchase, ItemPurchase, QFilterCondition> {}

extension ItemPurchaseQueryLinks
    on QueryBuilder<ItemPurchase, ItemPurchase, QFilterCondition> {
  QueryBuilder<ItemPurchase, ItemPurchase, QAfterFilterCondition> item(
      FilterQuery<ItemInfoModel> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'item');
    });
  }

  QueryBuilder<ItemPurchase, ItemPurchase, QAfterFilterCondition> itemIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'item', 0, true, 0, true);
    });
  }

  QueryBuilder<ItemPurchase, ItemPurchase, QAfterFilterCondition> supplier(
      FilterQuery<Supplier> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'supplier');
    });
  }

  QueryBuilder<ItemPurchase, ItemPurchase, QAfterFilterCondition>
      supplierIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'supplier', 0, true, 0, true);
    });
  }
}

extension ItemPurchaseQuerySortBy
    on QueryBuilder<ItemPurchase, ItemPurchase, QSortBy> {
  QueryBuilder<ItemPurchase, ItemPurchase, QAfterSortBy> sortByAmount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'amount', Sort.asc);
    });
  }

  QueryBuilder<ItemPurchase, ItemPurchase, QAfterSortBy> sortByAmountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'amount', Sort.desc);
    });
  }

  QueryBuilder<ItemPurchase, ItemPurchase, QAfterSortBy> sortByBillAmount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'billAmount', Sort.asc);
    });
  }

  QueryBuilder<ItemPurchase, ItemPurchase, QAfterSortBy>
      sortByBillAmountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'billAmount', Sort.desc);
    });
  }

  QueryBuilder<ItemPurchase, ItemPurchase, QAfterSortBy> sortByCommission() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'commission', Sort.asc);
    });
  }

  QueryBuilder<ItemPurchase, ItemPurchase, QAfterSortBy>
      sortByCommissionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'commission', Sort.desc);
    });
  }

  QueryBuilder<ItemPurchase, ItemPurchase, QAfterSortBy> sortByDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.asc);
    });
  }

  QueryBuilder<ItemPurchase, ItemPurchase, QAfterSortBy> sortByDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.desc);
    });
  }

  QueryBuilder<ItemPurchase, ItemPurchase, QAfterSortBy> sortByDetails() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'details', Sort.asc);
    });
  }

  QueryBuilder<ItemPurchase, ItemPurchase, QAfterSortBy> sortByDetailsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'details', Sort.desc);
    });
  }

  QueryBuilder<ItemPurchase, ItemPurchase, QAfterSortBy> sortByHamali() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hamali', Sort.asc);
    });
  }

  QueryBuilder<ItemPurchase, ItemPurchase, QAfterSortBy> sortByHamaliDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hamali', Sort.desc);
    });
  }

  QueryBuilder<ItemPurchase, ItemPurchase, QAfterSortBy> sortByItemName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'itemName', Sort.asc);
    });
  }

  QueryBuilder<ItemPurchase, ItemPurchase, QAfterSortBy> sortByItemNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'itemName', Sort.desc);
    });
  }

  QueryBuilder<ItemPurchase, ItemPurchase, QAfterSortBy> sortByPaymentType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'paymentType', Sort.asc);
    });
  }

  QueryBuilder<ItemPurchase, ItemPurchase, QAfterSortBy>
      sortByPaymentTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'paymentType', Sort.desc);
    });
  }

  QueryBuilder<ItemPurchase, ItemPurchase, QAfterSortBy> sortByQty() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'qty', Sort.asc);
    });
  }

  QueryBuilder<ItemPurchase, ItemPurchase, QAfterSortBy> sortByQtyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'qty', Sort.desc);
    });
  }

  QueryBuilder<ItemPurchase, ItemPurchase, QAfterSortBy> sortByRate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rate', Sort.asc);
    });
  }

  QueryBuilder<ItemPurchase, ItemPurchase, QAfterSortBy> sortByRateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rate', Sort.desc);
    });
  }

  QueryBuilder<ItemPurchase, ItemPurchase, QAfterSortBy> sortBySeqNo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'seqNo', Sort.asc);
    });
  }

  QueryBuilder<ItemPurchase, ItemPurchase, QAfterSortBy> sortBySeqNoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'seqNo', Sort.desc);
    });
  }

  QueryBuilder<ItemPurchase, ItemPurchase, QAfterSortBy> sortByTotalAmount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalAmount', Sort.asc);
    });
  }

  QueryBuilder<ItemPurchase, ItemPurchase, QAfterSortBy>
      sortByTotalAmountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalAmount', Sort.desc);
    });
  }

  QueryBuilder<ItemPurchase, ItemPurchase, QAfterSortBy> sortByVat() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'vat', Sort.asc);
    });
  }

  QueryBuilder<ItemPurchase, ItemPurchase, QAfterSortBy> sortByVatDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'vat', Sort.desc);
    });
  }

  QueryBuilder<ItemPurchase, ItemPurchase, QAfterSortBy> sortByVoucherNo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'voucherNo', Sort.asc);
    });
  }

  QueryBuilder<ItemPurchase, ItemPurchase, QAfterSortBy> sortByVoucherNoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'voucherNo', Sort.desc);
    });
  }

  QueryBuilder<ItemPurchase, ItemPurchase, QAfterSortBy> sortByVoucherNum() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'voucherNum', Sort.asc);
    });
  }

  QueryBuilder<ItemPurchase, ItemPurchase, QAfterSortBy>
      sortByVoucherNumDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'voucherNum', Sort.desc);
    });
  }
}

extension ItemPurchaseQuerySortThenBy
    on QueryBuilder<ItemPurchase, ItemPurchase, QSortThenBy> {
  QueryBuilder<ItemPurchase, ItemPurchase, QAfterSortBy> thenByAmount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'amount', Sort.asc);
    });
  }

  QueryBuilder<ItemPurchase, ItemPurchase, QAfterSortBy> thenByAmountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'amount', Sort.desc);
    });
  }

  QueryBuilder<ItemPurchase, ItemPurchase, QAfterSortBy> thenByBillAmount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'billAmount', Sort.asc);
    });
  }

  QueryBuilder<ItemPurchase, ItemPurchase, QAfterSortBy>
      thenByBillAmountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'billAmount', Sort.desc);
    });
  }

  QueryBuilder<ItemPurchase, ItemPurchase, QAfterSortBy> thenByCommission() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'commission', Sort.asc);
    });
  }

  QueryBuilder<ItemPurchase, ItemPurchase, QAfterSortBy>
      thenByCommissionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'commission', Sort.desc);
    });
  }

  QueryBuilder<ItemPurchase, ItemPurchase, QAfterSortBy> thenByDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.asc);
    });
  }

  QueryBuilder<ItemPurchase, ItemPurchase, QAfterSortBy> thenByDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.desc);
    });
  }

  QueryBuilder<ItemPurchase, ItemPurchase, QAfterSortBy> thenByDetails() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'details', Sort.asc);
    });
  }

  QueryBuilder<ItemPurchase, ItemPurchase, QAfterSortBy> thenByDetailsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'details', Sort.desc);
    });
  }

  QueryBuilder<ItemPurchase, ItemPurchase, QAfterSortBy> thenByHamali() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hamali', Sort.asc);
    });
  }

  QueryBuilder<ItemPurchase, ItemPurchase, QAfterSortBy> thenByHamaliDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hamali', Sort.desc);
    });
  }

  QueryBuilder<ItemPurchase, ItemPurchase, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<ItemPurchase, ItemPurchase, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<ItemPurchase, ItemPurchase, QAfterSortBy> thenByItemName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'itemName', Sort.asc);
    });
  }

  QueryBuilder<ItemPurchase, ItemPurchase, QAfterSortBy> thenByItemNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'itemName', Sort.desc);
    });
  }

  QueryBuilder<ItemPurchase, ItemPurchase, QAfterSortBy> thenByPaymentType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'paymentType', Sort.asc);
    });
  }

  QueryBuilder<ItemPurchase, ItemPurchase, QAfterSortBy>
      thenByPaymentTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'paymentType', Sort.desc);
    });
  }

  QueryBuilder<ItemPurchase, ItemPurchase, QAfterSortBy> thenByQty() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'qty', Sort.asc);
    });
  }

  QueryBuilder<ItemPurchase, ItemPurchase, QAfterSortBy> thenByQtyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'qty', Sort.desc);
    });
  }

  QueryBuilder<ItemPurchase, ItemPurchase, QAfterSortBy> thenByRate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rate', Sort.asc);
    });
  }

  QueryBuilder<ItemPurchase, ItemPurchase, QAfterSortBy> thenByRateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rate', Sort.desc);
    });
  }

  QueryBuilder<ItemPurchase, ItemPurchase, QAfterSortBy> thenBySeqNo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'seqNo', Sort.asc);
    });
  }

  QueryBuilder<ItemPurchase, ItemPurchase, QAfterSortBy> thenBySeqNoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'seqNo', Sort.desc);
    });
  }

  QueryBuilder<ItemPurchase, ItemPurchase, QAfterSortBy> thenByTotalAmount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalAmount', Sort.asc);
    });
  }

  QueryBuilder<ItemPurchase, ItemPurchase, QAfterSortBy>
      thenByTotalAmountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalAmount', Sort.desc);
    });
  }

  QueryBuilder<ItemPurchase, ItemPurchase, QAfterSortBy> thenByVat() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'vat', Sort.asc);
    });
  }

  QueryBuilder<ItemPurchase, ItemPurchase, QAfterSortBy> thenByVatDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'vat', Sort.desc);
    });
  }

  QueryBuilder<ItemPurchase, ItemPurchase, QAfterSortBy> thenByVoucherNo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'voucherNo', Sort.asc);
    });
  }

  QueryBuilder<ItemPurchase, ItemPurchase, QAfterSortBy> thenByVoucherNoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'voucherNo', Sort.desc);
    });
  }

  QueryBuilder<ItemPurchase, ItemPurchase, QAfterSortBy> thenByVoucherNum() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'voucherNum', Sort.asc);
    });
  }

  QueryBuilder<ItemPurchase, ItemPurchase, QAfterSortBy>
      thenByVoucherNumDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'voucherNum', Sort.desc);
    });
  }
}

extension ItemPurchaseQueryWhereDistinct
    on QueryBuilder<ItemPurchase, ItemPurchase, QDistinct> {
  QueryBuilder<ItemPurchase, ItemPurchase, QDistinct> distinctByAmount(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'amount', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ItemPurchase, ItemPurchase, QDistinct> distinctByBillAmount(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'billAmount', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ItemPurchase, ItemPurchase, QDistinct> distinctByCommission(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'commission', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ItemPurchase, ItemPurchase, QDistinct> distinctByDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'date');
    });
  }

  QueryBuilder<ItemPurchase, ItemPurchase, QDistinct> distinctByDetails(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'details', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ItemPurchase, ItemPurchase, QDistinct> distinctByHamali(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'hamali', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ItemPurchase, ItemPurchase, QDistinct> distinctByItemName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'itemName', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ItemPurchase, ItemPurchase, QDistinct> distinctByPaymentType(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'paymentType', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ItemPurchase, ItemPurchase, QDistinct> distinctByQty(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'qty', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ItemPurchase, ItemPurchase, QDistinct> distinctByRate(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'rate', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ItemPurchase, ItemPurchase, QDistinct> distinctBySeqNo(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'seqNo', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ItemPurchase, ItemPurchase, QDistinct> distinctByTotalAmount(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'totalAmount', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ItemPurchase, ItemPurchase, QDistinct> distinctByVat(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'vat', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ItemPurchase, ItemPurchase, QDistinct> distinctByVoucherNo(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'voucherNo', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ItemPurchase, ItemPurchase, QDistinct> distinctByVoucherNum(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'voucherNum', caseSensitive: caseSensitive);
    });
  }
}

extension ItemPurchaseQueryProperty
    on QueryBuilder<ItemPurchase, ItemPurchase, QQueryProperty> {
  QueryBuilder<ItemPurchase, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<ItemPurchase, String, QQueryOperations> amountProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'amount');
    });
  }

  QueryBuilder<ItemPurchase, String, QQueryOperations> billAmountProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'billAmount');
    });
  }

  QueryBuilder<ItemPurchase, String, QQueryOperations> commissionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'commission');
    });
  }

  QueryBuilder<ItemPurchase, DateTime, QQueryOperations> dateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'date');
    });
  }

  QueryBuilder<ItemPurchase, String, QQueryOperations> detailsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'details');
    });
  }

  QueryBuilder<ItemPurchase, String, QQueryOperations> hamaliProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'hamali');
    });
  }

  QueryBuilder<ItemPurchase, String, QQueryOperations> itemNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'itemName');
    });
  }

  QueryBuilder<ItemPurchase, String, QQueryOperations> paymentTypeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'paymentType');
    });
  }

  QueryBuilder<ItemPurchase, String, QQueryOperations> qtyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'qty');
    });
  }

  QueryBuilder<ItemPurchase, String, QQueryOperations> rateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'rate');
    });
  }

  QueryBuilder<ItemPurchase, String, QQueryOperations> seqNoProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'seqNo');
    });
  }

  QueryBuilder<ItemPurchase, String, QQueryOperations> totalAmountProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'totalAmount');
    });
  }

  QueryBuilder<ItemPurchase, String, QQueryOperations> vatProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'vat');
    });
  }

  QueryBuilder<ItemPurchase, String, QQueryOperations> voucherNoProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'voucherNo');
    });
  }

  QueryBuilder<ItemPurchase, String, QQueryOperations> voucherNumProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'voucherNum');
    });
  }
}
