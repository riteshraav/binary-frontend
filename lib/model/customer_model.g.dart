// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer_model.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetCustomerMasterCollection on Isar {
  IsarCollection<CustomerMaster> get customerMasters => this.collection();
}

const CustomerMasterSchema = CollectionSchema(
  name: r'CustomerMaster',
  id: 1830464072967232322,
  properties: {
    r'aadhar': PropertySchema(
      id: 0,
      name: r'aadhar',
      type: IsarType.string,
    ),
    r'accountNo': PropertySchema(
      id: 1,
      name: r'accountNo',
      type: IsarType.string,
    ),
    r'adminCode': PropertySchema(
      id: 2,
      name: r'adminCode',
      type: IsarType.string,
    ),
    r'adminId': PropertySchema(
      id: 3,
      name: r'adminId',
      type: IsarType.string,
    ),
    r'animalCount': PropertySchema(
      id: 4,
      name: r'animalCount',
      type: IsarType.string,
    ),
    r'averageQuantity': PropertySchema(
      id: 5,
      name: r'averageQuantity',
      type: IsarType.string,
    ),
    r'bankAccountNo': PropertySchema(
      id: 6,
      name: r'bankAccountNo',
      type: IsarType.string,
    ),
    r'bankBranch': PropertySchema(
      id: 7,
      name: r'bankBranch',
      type: IsarType.string,
    ),
    r'bankCode': PropertySchema(
      id: 8,
      name: r'bankCode',
      type: IsarType.string,
    ),
    r'branch': PropertySchema(
      id: 9,
      name: r'branch',
      type: IsarType.string,
    ),
    r'caste': PropertySchema(
      id: 10,
      name: r'caste',
      type: IsarType.string,
    ),
    r'classType': PropertySchema(
      id: 11,
      name: r'classType',
      type: IsarType.string,
    ),
    r'code': PropertySchema(
      id: 12,
      name: r'code',
      type: IsarType.string,
    ),
    r'gender': PropertySchema(
      id: 13,
      name: r'gender',
      type: IsarType.string,
    ),
    r'ifsc': PropertySchema(
      id: 14,
      name: r'ifsc',
      type: IsarType.string,
    ),
    r'localRateGroup': PropertySchema(
      id: 15,
      name: r'localRateGroup',
      type: IsarType.string,
    ),
    r'milkOn': PropertySchema(
      id: 16,
      name: r'milkOn',
      type: IsarType.bool,
    ),
    r'milkType': PropertySchema(
      id: 17,
      name: r'milkType',
      type: IsarType.string,
    ),
    r'mobileNo1': PropertySchema(
      id: 18,
      name: r'mobileNo1',
      type: IsarType.string,
    ),
    r'mobileNo2': PropertySchema(
      id: 19,
      name: r'mobileNo2',
      type: IsarType.string,
    ),
    r'name': PropertySchema(
      id: 20,
      name: r'name',
      type: IsarType.string,
    ),
    r'panNo': PropertySchema(
      id: 21,
      name: r'panNo',
      type: IsarType.string,
    ),
    r'rateGroup': PropertySchema(
      id: 22,
      name: r'rateGroup',
      type: IsarType.string,
    ),
    r'sabhasadNo': PropertySchema(
      id: 23,
      name: r'sabhasadNo',
      type: IsarType.string,
    )
  },
  estimateSize: _customerMasterEstimateSize,
  serialize: _customerMasterSerialize,
  deserialize: _customerMasterDeserialize,
  deserializeProp: _customerMasterDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _customerMasterGetId,
  getLinks: _customerMasterGetLinks,
  attach: _customerMasterAttach,
  version: '3.1.0+1',
);

int _customerMasterEstimateSize(
  CustomerMaster object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.aadhar.length * 3;
  bytesCount += 3 + object.accountNo.length * 3;
  bytesCount += 3 + object.adminCode.length * 3;
  bytesCount += 3 + object.adminId.length * 3;
  bytesCount += 3 + object.animalCount.length * 3;
  bytesCount += 3 + object.averageQuantity.length * 3;
  bytesCount += 3 + object.bankAccountNo.length * 3;
  bytesCount += 3 + object.bankBranch.length * 3;
  bytesCount += 3 + object.bankCode.length * 3;
  bytesCount += 3 + object.branch.length * 3;
  bytesCount += 3 + object.caste.length * 3;
  bytesCount += 3 + object.classType.length * 3;
  bytesCount += 3 + object.code.length * 3;
  bytesCount += 3 + object.gender.length * 3;
  bytesCount += 3 + object.ifsc.length * 3;
  bytesCount += 3 + object.localRateGroup.length * 3;
  bytesCount += 3 + object.milkType.length * 3;
  bytesCount += 3 + object.mobileNo1.length * 3;
  bytesCount += 3 + object.mobileNo2.length * 3;
  bytesCount += 3 + object.name.length * 3;
  bytesCount += 3 + object.panNo.length * 3;
  bytesCount += 3 + object.rateGroup.length * 3;
  bytesCount += 3 + object.sabhasadNo.length * 3;
  return bytesCount;
}

void _customerMasterSerialize(
  CustomerMaster object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.aadhar);
  writer.writeString(offsets[1], object.accountNo);
  writer.writeString(offsets[2], object.adminCode);
  writer.writeString(offsets[3], object.adminId);
  writer.writeString(offsets[4], object.animalCount);
  writer.writeString(offsets[5], object.averageQuantity);
  writer.writeString(offsets[6], object.bankAccountNo);
  writer.writeString(offsets[7], object.bankBranch);
  writer.writeString(offsets[8], object.bankCode);
  writer.writeString(offsets[9], object.branch);
  writer.writeString(offsets[10], object.caste);
  writer.writeString(offsets[11], object.classType);
  writer.writeString(offsets[12], object.code);
  writer.writeString(offsets[13], object.gender);
  writer.writeString(offsets[14], object.ifsc);
  writer.writeString(offsets[15], object.localRateGroup);
  writer.writeBool(offsets[16], object.milkOn);
  writer.writeString(offsets[17], object.milkType);
  writer.writeString(offsets[18], object.mobileNo1);
  writer.writeString(offsets[19], object.mobileNo2);
  writer.writeString(offsets[20], object.name);
  writer.writeString(offsets[21], object.panNo);
  writer.writeString(offsets[22], object.rateGroup);
  writer.writeString(offsets[23], object.sabhasadNo);
}

CustomerMaster _customerMasterDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = CustomerMaster(
    aadhar: reader.readString(offsets[0]),
    accountNo: reader.readString(offsets[1]),
    adminCode: reader.readString(offsets[2]),
    adminId: reader.readString(offsets[3]),
    animalCount: reader.readString(offsets[4]),
    averageQuantity: reader.readString(offsets[5]),
    bankAccountNo: reader.readString(offsets[6]),
    bankBranch: reader.readString(offsets[7]),
    bankCode: reader.readString(offsets[8]),
    branch: reader.readString(offsets[9]),
    caste: reader.readString(offsets[10]),
    classType: reader.readString(offsets[11]),
    code: reader.readString(offsets[12]),
    gender: reader.readString(offsets[13]),
    id: id,
    ifsc: reader.readString(offsets[14]),
    localRateGroup: reader.readString(offsets[15]),
    milkOn: reader.readBool(offsets[16]),
    milkType: reader.readString(offsets[17]),
    mobileNo1: reader.readString(offsets[18]),
    mobileNo2: reader.readString(offsets[19]),
    name: reader.readString(offsets[20]),
    panNo: reader.readString(offsets[21]),
    rateGroup: reader.readString(offsets[22]),
    sabhasadNo: reader.readString(offsets[23]),
  );
  return object;
}

P _customerMasterDeserializeProp<P>(
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
    case 15:
      return (reader.readString(offset)) as P;
    case 16:
      return (reader.readBool(offset)) as P;
    case 17:
      return (reader.readString(offset)) as P;
    case 18:
      return (reader.readString(offset)) as P;
    case 19:
      return (reader.readString(offset)) as P;
    case 20:
      return (reader.readString(offset)) as P;
    case 21:
      return (reader.readString(offset)) as P;
    case 22:
      return (reader.readString(offset)) as P;
    case 23:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _customerMasterGetId(CustomerMaster object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _customerMasterGetLinks(CustomerMaster object) {
  return [];
}

void _customerMasterAttach(
    IsarCollection<dynamic> col, Id id, CustomerMaster object) {
  object.id = id;
}

extension CustomerMasterQueryWhereSort
    on QueryBuilder<CustomerMaster, CustomerMaster, QWhere> {
  QueryBuilder<CustomerMaster, CustomerMaster, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension CustomerMasterQueryWhere
    on QueryBuilder<CustomerMaster, CustomerMaster, QWhereClause> {
  QueryBuilder<CustomerMaster, CustomerMaster, QAfterWhereClause> idEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterWhereClause> idNotEqualTo(
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

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterWhereClause> idGreaterThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterWhereClause> idLessThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterWhereClause> idBetween(
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

extension CustomerMasterQueryFilter
    on QueryBuilder<CustomerMaster, CustomerMaster, QFilterCondition> {
  QueryBuilder<CustomerMaster, CustomerMaster, QAfterFilterCondition>
      aadharEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'aadhar',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterFilterCondition>
      aadharGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'aadhar',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterFilterCondition>
      aadharLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'aadhar',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterFilterCondition>
      aadharBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'aadhar',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterFilterCondition>
      aadharStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'aadhar',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterFilterCondition>
      aadharEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'aadhar',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterFilterCondition>
      aadharContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'aadhar',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterFilterCondition>
      aadharMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'aadhar',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterFilterCondition>
      aadharIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'aadhar',
        value: '',
      ));
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterFilterCondition>
      aadharIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'aadhar',
        value: '',
      ));
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterFilterCondition>
      accountNoEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'accountNo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterFilterCondition>
      accountNoGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'accountNo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterFilterCondition>
      accountNoLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'accountNo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterFilterCondition>
      accountNoBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'accountNo',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterFilterCondition>
      accountNoStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'accountNo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterFilterCondition>
      accountNoEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'accountNo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterFilterCondition>
      accountNoContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'accountNo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterFilterCondition>
      accountNoMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'accountNo',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterFilterCondition>
      accountNoIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'accountNo',
        value: '',
      ));
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterFilterCondition>
      accountNoIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'accountNo',
        value: '',
      ));
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterFilterCondition>
      adminCodeEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'adminCode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterFilterCondition>
      adminCodeGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'adminCode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterFilterCondition>
      adminCodeLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'adminCode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterFilterCondition>
      adminCodeBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'adminCode',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterFilterCondition>
      adminCodeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'adminCode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterFilterCondition>
      adminCodeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'adminCode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterFilterCondition>
      adminCodeContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'adminCode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterFilterCondition>
      adminCodeMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'adminCode',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterFilterCondition>
      adminCodeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'adminCode',
        value: '',
      ));
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterFilterCondition>
      adminCodeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'adminCode',
        value: '',
      ));
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterFilterCondition>
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

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterFilterCondition>
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

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterFilterCondition>
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

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterFilterCondition>
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

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterFilterCondition>
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

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterFilterCondition>
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

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterFilterCondition>
      adminIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'adminId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterFilterCondition>
      adminIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'adminId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterFilterCondition>
      adminIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'adminId',
        value: '',
      ));
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterFilterCondition>
      adminIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'adminId',
        value: '',
      ));
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterFilterCondition>
      animalCountEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'animalCount',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterFilterCondition>
      animalCountGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'animalCount',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterFilterCondition>
      animalCountLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'animalCount',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterFilterCondition>
      animalCountBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'animalCount',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterFilterCondition>
      animalCountStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'animalCount',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterFilterCondition>
      animalCountEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'animalCount',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterFilterCondition>
      animalCountContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'animalCount',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterFilterCondition>
      animalCountMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'animalCount',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterFilterCondition>
      animalCountIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'animalCount',
        value: '',
      ));
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterFilterCondition>
      animalCountIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'animalCount',
        value: '',
      ));
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterFilterCondition>
      averageQuantityEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'averageQuantity',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterFilterCondition>
      averageQuantityGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'averageQuantity',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterFilterCondition>
      averageQuantityLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'averageQuantity',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterFilterCondition>
      averageQuantityBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'averageQuantity',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterFilterCondition>
      averageQuantityStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'averageQuantity',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterFilterCondition>
      averageQuantityEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'averageQuantity',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterFilterCondition>
      averageQuantityContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'averageQuantity',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterFilterCondition>
      averageQuantityMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'averageQuantity',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterFilterCondition>
      averageQuantityIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'averageQuantity',
        value: '',
      ));
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterFilterCondition>
      averageQuantityIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'averageQuantity',
        value: '',
      ));
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterFilterCondition>
      bankAccountNoEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'bankAccountNo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterFilterCondition>
      bankAccountNoGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'bankAccountNo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterFilterCondition>
      bankAccountNoLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'bankAccountNo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterFilterCondition>
      bankAccountNoBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'bankAccountNo',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterFilterCondition>
      bankAccountNoStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'bankAccountNo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterFilterCondition>
      bankAccountNoEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'bankAccountNo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterFilterCondition>
      bankAccountNoContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'bankAccountNo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterFilterCondition>
      bankAccountNoMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'bankAccountNo',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterFilterCondition>
      bankAccountNoIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'bankAccountNo',
        value: '',
      ));
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterFilterCondition>
      bankAccountNoIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'bankAccountNo',
        value: '',
      ));
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterFilterCondition>
      bankBranchEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'bankBranch',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterFilterCondition>
      bankBranchGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'bankBranch',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterFilterCondition>
      bankBranchLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'bankBranch',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterFilterCondition>
      bankBranchBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'bankBranch',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterFilterCondition>
      bankBranchStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'bankBranch',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterFilterCondition>
      bankBranchEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'bankBranch',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterFilterCondition>
      bankBranchContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'bankBranch',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterFilterCondition>
      bankBranchMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'bankBranch',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterFilterCondition>
      bankBranchIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'bankBranch',
        value: '',
      ));
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterFilterCondition>
      bankBranchIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'bankBranch',
        value: '',
      ));
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterFilterCondition>
      bankCodeEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'bankCode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterFilterCondition>
      bankCodeGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'bankCode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterFilterCondition>
      bankCodeLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'bankCode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterFilterCondition>
      bankCodeBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'bankCode',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterFilterCondition>
      bankCodeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'bankCode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterFilterCondition>
      bankCodeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'bankCode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterFilterCondition>
      bankCodeContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'bankCode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterFilterCondition>
      bankCodeMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'bankCode',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterFilterCondition>
      bankCodeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'bankCode',
        value: '',
      ));
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterFilterCondition>
      bankCodeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'bankCode',
        value: '',
      ));
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterFilterCondition>
      branchEqualTo(
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

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterFilterCondition>
      branchGreaterThan(
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

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterFilterCondition>
      branchLessThan(
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

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterFilterCondition>
      branchBetween(
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

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterFilterCondition>
      branchStartsWith(
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

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterFilterCondition>
      branchEndsWith(
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

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterFilterCondition>
      branchContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'branch',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterFilterCondition>
      branchMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'branch',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterFilterCondition>
      branchIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'branch',
        value: '',
      ));
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterFilterCondition>
      branchIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'branch',
        value: '',
      ));
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterFilterCondition>
      casteEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'caste',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterFilterCondition>
      casteGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'caste',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterFilterCondition>
      casteLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'caste',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterFilterCondition>
      casteBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'caste',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterFilterCondition>
      casteStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'caste',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterFilterCondition>
      casteEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'caste',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterFilterCondition>
      casteContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'caste',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterFilterCondition>
      casteMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'caste',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterFilterCondition>
      casteIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'caste',
        value: '',
      ));
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterFilterCondition>
      casteIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'caste',
        value: '',
      ));
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterFilterCondition>
      classTypeEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'classType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterFilterCondition>
      classTypeGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'classType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterFilterCondition>
      classTypeLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'classType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterFilterCondition>
      classTypeBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'classType',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterFilterCondition>
      classTypeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'classType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterFilterCondition>
      classTypeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'classType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterFilterCondition>
      classTypeContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'classType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterFilterCondition>
      classTypeMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'classType',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterFilterCondition>
      classTypeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'classType',
        value: '',
      ));
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterFilterCondition>
      classTypeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'classType',
        value: '',
      ));
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterFilterCondition>
      codeEqualTo(
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

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterFilterCondition>
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

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterFilterCondition>
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

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterFilterCondition>
      codeBetween(
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

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterFilterCondition>
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

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterFilterCondition>
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

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterFilterCondition>
      codeContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'code',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterFilterCondition>
      codeMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'code',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterFilterCondition>
      codeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'code',
        value: '',
      ));
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterFilterCondition>
      codeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'code',
        value: '',
      ));
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterFilterCondition>
      genderEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'gender',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterFilterCondition>
      genderGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'gender',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterFilterCondition>
      genderLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'gender',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterFilterCondition>
      genderBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'gender',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterFilterCondition>
      genderStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'gender',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterFilterCondition>
      genderEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'gender',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterFilterCondition>
      genderContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'gender',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterFilterCondition>
      genderMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'gender',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterFilterCondition>
      genderIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'gender',
        value: '',
      ));
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterFilterCondition>
      genderIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'gender',
        value: '',
      ));
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterFilterCondition>
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

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterFilterCondition>
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

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterFilterCondition> idBetween(
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

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterFilterCondition>
      ifscEqualTo(
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

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterFilterCondition>
      ifscGreaterThan(
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

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterFilterCondition>
      ifscLessThan(
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

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterFilterCondition>
      ifscBetween(
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

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterFilterCondition>
      ifscStartsWith(
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

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterFilterCondition>
      ifscEndsWith(
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

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterFilterCondition>
      ifscContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'ifsc',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterFilterCondition>
      ifscMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'ifsc',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterFilterCondition>
      ifscIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'ifsc',
        value: '',
      ));
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterFilterCondition>
      ifscIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'ifsc',
        value: '',
      ));
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterFilterCondition>
      localRateGroupEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'localRateGroup',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterFilterCondition>
      localRateGroupGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'localRateGroup',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterFilterCondition>
      localRateGroupLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'localRateGroup',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterFilterCondition>
      localRateGroupBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'localRateGroup',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterFilterCondition>
      localRateGroupStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'localRateGroup',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterFilterCondition>
      localRateGroupEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'localRateGroup',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterFilterCondition>
      localRateGroupContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'localRateGroup',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterFilterCondition>
      localRateGroupMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'localRateGroup',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterFilterCondition>
      localRateGroupIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'localRateGroup',
        value: '',
      ));
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterFilterCondition>
      localRateGroupIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'localRateGroup',
        value: '',
      ));
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterFilterCondition>
      milkOnEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'milkOn',
        value: value,
      ));
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterFilterCondition>
      milkTypeEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'milkType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterFilterCondition>
      milkTypeGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'milkType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterFilterCondition>
      milkTypeLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'milkType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterFilterCondition>
      milkTypeBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'milkType',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterFilterCondition>
      milkTypeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'milkType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterFilterCondition>
      milkTypeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'milkType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterFilterCondition>
      milkTypeContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'milkType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterFilterCondition>
      milkTypeMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'milkType',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterFilterCondition>
      milkTypeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'milkType',
        value: '',
      ));
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterFilterCondition>
      milkTypeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'milkType',
        value: '',
      ));
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterFilterCondition>
      mobileNo1EqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'mobileNo1',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterFilterCondition>
      mobileNo1GreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'mobileNo1',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterFilterCondition>
      mobileNo1LessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'mobileNo1',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterFilterCondition>
      mobileNo1Between(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'mobileNo1',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterFilterCondition>
      mobileNo1StartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'mobileNo1',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterFilterCondition>
      mobileNo1EndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'mobileNo1',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterFilterCondition>
      mobileNo1Contains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'mobileNo1',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterFilterCondition>
      mobileNo1Matches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'mobileNo1',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterFilterCondition>
      mobileNo1IsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'mobileNo1',
        value: '',
      ));
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterFilterCondition>
      mobileNo1IsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'mobileNo1',
        value: '',
      ));
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterFilterCondition>
      mobileNo2EqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'mobileNo2',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterFilterCondition>
      mobileNo2GreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'mobileNo2',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterFilterCondition>
      mobileNo2LessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'mobileNo2',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterFilterCondition>
      mobileNo2Between(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'mobileNo2',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterFilterCondition>
      mobileNo2StartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'mobileNo2',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterFilterCondition>
      mobileNo2EndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'mobileNo2',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterFilterCondition>
      mobileNo2Contains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'mobileNo2',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterFilterCondition>
      mobileNo2Matches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'mobileNo2',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterFilterCondition>
      mobileNo2IsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'mobileNo2',
        value: '',
      ));
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterFilterCondition>
      mobileNo2IsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'mobileNo2',
        value: '',
      ));
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterFilterCondition>
      nameEqualTo(
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

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterFilterCondition>
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

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterFilterCondition>
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

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterFilterCondition>
      nameBetween(
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

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterFilterCondition>
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

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterFilterCondition>
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

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterFilterCondition>
      nameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterFilterCondition>
      nameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'name',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterFilterCondition>
      nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterFilterCondition>
      nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterFilterCondition>
      panNoEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'panNo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterFilterCondition>
      panNoGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'panNo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterFilterCondition>
      panNoLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'panNo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterFilterCondition>
      panNoBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'panNo',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterFilterCondition>
      panNoStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'panNo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterFilterCondition>
      panNoEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'panNo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterFilterCondition>
      panNoContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'panNo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterFilterCondition>
      panNoMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'panNo',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterFilterCondition>
      panNoIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'panNo',
        value: '',
      ));
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterFilterCondition>
      panNoIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'panNo',
        value: '',
      ));
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterFilterCondition>
      rateGroupEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'rateGroup',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterFilterCondition>
      rateGroupGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'rateGroup',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterFilterCondition>
      rateGroupLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'rateGroup',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterFilterCondition>
      rateGroupBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'rateGroup',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterFilterCondition>
      rateGroupStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'rateGroup',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterFilterCondition>
      rateGroupEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'rateGroup',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterFilterCondition>
      rateGroupContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'rateGroup',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterFilterCondition>
      rateGroupMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'rateGroup',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterFilterCondition>
      rateGroupIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'rateGroup',
        value: '',
      ));
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterFilterCondition>
      rateGroupIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'rateGroup',
        value: '',
      ));
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterFilterCondition>
      sabhasadNoEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'sabhasadNo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterFilterCondition>
      sabhasadNoGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'sabhasadNo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterFilterCondition>
      sabhasadNoLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'sabhasadNo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterFilterCondition>
      sabhasadNoBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'sabhasadNo',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterFilterCondition>
      sabhasadNoStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'sabhasadNo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterFilterCondition>
      sabhasadNoEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'sabhasadNo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterFilterCondition>
      sabhasadNoContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'sabhasadNo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterFilterCondition>
      sabhasadNoMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'sabhasadNo',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterFilterCondition>
      sabhasadNoIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'sabhasadNo',
        value: '',
      ));
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterFilterCondition>
      sabhasadNoIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'sabhasadNo',
        value: '',
      ));
    });
  }
}

extension CustomerMasterQueryObject
    on QueryBuilder<CustomerMaster, CustomerMaster, QFilterCondition> {}

extension CustomerMasterQueryLinks
    on QueryBuilder<CustomerMaster, CustomerMaster, QFilterCondition> {}

extension CustomerMasterQuerySortBy
    on QueryBuilder<CustomerMaster, CustomerMaster, QSortBy> {
  QueryBuilder<CustomerMaster, CustomerMaster, QAfterSortBy> sortByAadhar() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'aadhar', Sort.asc);
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterSortBy>
      sortByAadharDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'aadhar', Sort.desc);
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterSortBy> sortByAccountNo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'accountNo', Sort.asc);
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterSortBy>
      sortByAccountNoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'accountNo', Sort.desc);
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterSortBy> sortByAdminCode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'adminCode', Sort.asc);
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterSortBy>
      sortByAdminCodeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'adminCode', Sort.desc);
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterSortBy> sortByAdminId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'adminId', Sort.asc);
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterSortBy>
      sortByAdminIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'adminId', Sort.desc);
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterSortBy>
      sortByAnimalCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'animalCount', Sort.asc);
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterSortBy>
      sortByAnimalCountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'animalCount', Sort.desc);
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterSortBy>
      sortByAverageQuantity() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'averageQuantity', Sort.asc);
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterSortBy>
      sortByAverageQuantityDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'averageQuantity', Sort.desc);
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterSortBy>
      sortByBankAccountNo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bankAccountNo', Sort.asc);
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterSortBy>
      sortByBankAccountNoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bankAccountNo', Sort.desc);
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterSortBy>
      sortByBankBranch() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bankBranch', Sort.asc);
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterSortBy>
      sortByBankBranchDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bankBranch', Sort.desc);
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterSortBy> sortByBankCode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bankCode', Sort.asc);
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterSortBy>
      sortByBankCodeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bankCode', Sort.desc);
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterSortBy> sortByBranch() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'branch', Sort.asc);
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterSortBy>
      sortByBranchDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'branch', Sort.desc);
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterSortBy> sortByCaste() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'caste', Sort.asc);
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterSortBy> sortByCasteDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'caste', Sort.desc);
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterSortBy> sortByClassType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'classType', Sort.asc);
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterSortBy>
      sortByClassTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'classType', Sort.desc);
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterSortBy> sortByCode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'code', Sort.asc);
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterSortBy> sortByCodeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'code', Sort.desc);
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterSortBy> sortByGender() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'gender', Sort.asc);
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterSortBy>
      sortByGenderDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'gender', Sort.desc);
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterSortBy> sortByIfsc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ifsc', Sort.asc);
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterSortBy> sortByIfscDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ifsc', Sort.desc);
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterSortBy>
      sortByLocalRateGroup() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'localRateGroup', Sort.asc);
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterSortBy>
      sortByLocalRateGroupDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'localRateGroup', Sort.desc);
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterSortBy> sortByMilkOn() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'milkOn', Sort.asc);
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterSortBy>
      sortByMilkOnDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'milkOn', Sort.desc);
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterSortBy> sortByMilkType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'milkType', Sort.asc);
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterSortBy>
      sortByMilkTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'milkType', Sort.desc);
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterSortBy> sortByMobileNo1() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mobileNo1', Sort.asc);
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterSortBy>
      sortByMobileNo1Desc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mobileNo1', Sort.desc);
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterSortBy> sortByMobileNo2() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mobileNo2', Sort.asc);
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterSortBy>
      sortByMobileNo2Desc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mobileNo2', Sort.desc);
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterSortBy> sortByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterSortBy> sortByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterSortBy> sortByPanNo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'panNo', Sort.asc);
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterSortBy> sortByPanNoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'panNo', Sort.desc);
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterSortBy> sortByRateGroup() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rateGroup', Sort.asc);
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterSortBy>
      sortByRateGroupDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rateGroup', Sort.desc);
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterSortBy>
      sortBySabhasadNo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sabhasadNo', Sort.asc);
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterSortBy>
      sortBySabhasadNoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sabhasadNo', Sort.desc);
    });
  }
}

extension CustomerMasterQuerySortThenBy
    on QueryBuilder<CustomerMaster, CustomerMaster, QSortThenBy> {
  QueryBuilder<CustomerMaster, CustomerMaster, QAfterSortBy> thenByAadhar() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'aadhar', Sort.asc);
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterSortBy>
      thenByAadharDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'aadhar', Sort.desc);
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterSortBy> thenByAccountNo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'accountNo', Sort.asc);
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterSortBy>
      thenByAccountNoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'accountNo', Sort.desc);
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterSortBy> thenByAdminCode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'adminCode', Sort.asc);
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterSortBy>
      thenByAdminCodeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'adminCode', Sort.desc);
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterSortBy> thenByAdminId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'adminId', Sort.asc);
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterSortBy>
      thenByAdminIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'adminId', Sort.desc);
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterSortBy>
      thenByAnimalCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'animalCount', Sort.asc);
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterSortBy>
      thenByAnimalCountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'animalCount', Sort.desc);
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterSortBy>
      thenByAverageQuantity() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'averageQuantity', Sort.asc);
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterSortBy>
      thenByAverageQuantityDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'averageQuantity', Sort.desc);
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterSortBy>
      thenByBankAccountNo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bankAccountNo', Sort.asc);
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterSortBy>
      thenByBankAccountNoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bankAccountNo', Sort.desc);
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterSortBy>
      thenByBankBranch() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bankBranch', Sort.asc);
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterSortBy>
      thenByBankBranchDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bankBranch', Sort.desc);
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterSortBy> thenByBankCode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bankCode', Sort.asc);
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterSortBy>
      thenByBankCodeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bankCode', Sort.desc);
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterSortBy> thenByBranch() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'branch', Sort.asc);
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterSortBy>
      thenByBranchDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'branch', Sort.desc);
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterSortBy> thenByCaste() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'caste', Sort.asc);
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterSortBy> thenByCasteDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'caste', Sort.desc);
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterSortBy> thenByClassType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'classType', Sort.asc);
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterSortBy>
      thenByClassTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'classType', Sort.desc);
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterSortBy> thenByCode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'code', Sort.asc);
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterSortBy> thenByCodeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'code', Sort.desc);
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterSortBy> thenByGender() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'gender', Sort.asc);
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterSortBy>
      thenByGenderDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'gender', Sort.desc);
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterSortBy> thenByIfsc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ifsc', Sort.asc);
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterSortBy> thenByIfscDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ifsc', Sort.desc);
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterSortBy>
      thenByLocalRateGroup() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'localRateGroup', Sort.asc);
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterSortBy>
      thenByLocalRateGroupDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'localRateGroup', Sort.desc);
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterSortBy> thenByMilkOn() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'milkOn', Sort.asc);
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterSortBy>
      thenByMilkOnDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'milkOn', Sort.desc);
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterSortBy> thenByMilkType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'milkType', Sort.asc);
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterSortBy>
      thenByMilkTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'milkType', Sort.desc);
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterSortBy> thenByMobileNo1() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mobileNo1', Sort.asc);
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterSortBy>
      thenByMobileNo1Desc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mobileNo1', Sort.desc);
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterSortBy> thenByMobileNo2() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mobileNo2', Sort.asc);
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterSortBy>
      thenByMobileNo2Desc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mobileNo2', Sort.desc);
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterSortBy> thenByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterSortBy> thenByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterSortBy> thenByPanNo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'panNo', Sort.asc);
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterSortBy> thenByPanNoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'panNo', Sort.desc);
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterSortBy> thenByRateGroup() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rateGroup', Sort.asc);
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterSortBy>
      thenByRateGroupDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rateGroup', Sort.desc);
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterSortBy>
      thenBySabhasadNo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sabhasadNo', Sort.asc);
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QAfterSortBy>
      thenBySabhasadNoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sabhasadNo', Sort.desc);
    });
  }
}

extension CustomerMasterQueryWhereDistinct
    on QueryBuilder<CustomerMaster, CustomerMaster, QDistinct> {
  QueryBuilder<CustomerMaster, CustomerMaster, QDistinct> distinctByAadhar(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'aadhar', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QDistinct> distinctByAccountNo(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'accountNo', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QDistinct> distinctByAdminCode(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'adminCode', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QDistinct> distinctByAdminId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'adminId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QDistinct> distinctByAnimalCount(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'animalCount', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QDistinct>
      distinctByAverageQuantity({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'averageQuantity',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QDistinct>
      distinctByBankAccountNo({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'bankAccountNo',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QDistinct> distinctByBankBranch(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'bankBranch', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QDistinct> distinctByBankCode(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'bankCode', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QDistinct> distinctByBranch(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'branch', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QDistinct> distinctByCaste(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'caste', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QDistinct> distinctByClassType(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'classType', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QDistinct> distinctByCode(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'code', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QDistinct> distinctByGender(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'gender', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QDistinct> distinctByIfsc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'ifsc', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QDistinct>
      distinctByLocalRateGroup({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'localRateGroup',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QDistinct> distinctByMilkOn() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'milkOn');
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QDistinct> distinctByMilkType(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'milkType', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QDistinct> distinctByMobileNo1(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'mobileNo1', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QDistinct> distinctByMobileNo2(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'mobileNo2', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QDistinct> distinctByName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'name', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QDistinct> distinctByPanNo(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'panNo', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QDistinct> distinctByRateGroup(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'rateGroup', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CustomerMaster, CustomerMaster, QDistinct> distinctBySabhasadNo(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'sabhasadNo', caseSensitive: caseSensitive);
    });
  }
}

extension CustomerMasterQueryProperty
    on QueryBuilder<CustomerMaster, CustomerMaster, QQueryProperty> {
  QueryBuilder<CustomerMaster, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<CustomerMaster, String, QQueryOperations> aadharProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'aadhar');
    });
  }

  QueryBuilder<CustomerMaster, String, QQueryOperations> accountNoProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'accountNo');
    });
  }

  QueryBuilder<CustomerMaster, String, QQueryOperations> adminCodeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'adminCode');
    });
  }

  QueryBuilder<CustomerMaster, String, QQueryOperations> adminIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'adminId');
    });
  }

  QueryBuilder<CustomerMaster, String, QQueryOperations> animalCountProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'animalCount');
    });
  }

  QueryBuilder<CustomerMaster, String, QQueryOperations>
      averageQuantityProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'averageQuantity');
    });
  }

  QueryBuilder<CustomerMaster, String, QQueryOperations>
      bankAccountNoProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'bankAccountNo');
    });
  }

  QueryBuilder<CustomerMaster, String, QQueryOperations> bankBranchProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'bankBranch');
    });
  }

  QueryBuilder<CustomerMaster, String, QQueryOperations> bankCodeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'bankCode');
    });
  }

  QueryBuilder<CustomerMaster, String, QQueryOperations> branchProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'branch');
    });
  }

  QueryBuilder<CustomerMaster, String, QQueryOperations> casteProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'caste');
    });
  }

  QueryBuilder<CustomerMaster, String, QQueryOperations> classTypeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'classType');
    });
  }

  QueryBuilder<CustomerMaster, String, QQueryOperations> codeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'code');
    });
  }

  QueryBuilder<CustomerMaster, String, QQueryOperations> genderProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'gender');
    });
  }

  QueryBuilder<CustomerMaster, String, QQueryOperations> ifscProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'ifsc');
    });
  }

  QueryBuilder<CustomerMaster, String, QQueryOperations>
      localRateGroupProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'localRateGroup');
    });
  }

  QueryBuilder<CustomerMaster, bool, QQueryOperations> milkOnProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'milkOn');
    });
  }

  QueryBuilder<CustomerMaster, String, QQueryOperations> milkTypeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'milkType');
    });
  }

  QueryBuilder<CustomerMaster, String, QQueryOperations> mobileNo1Property() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'mobileNo1');
    });
  }

  QueryBuilder<CustomerMaster, String, QQueryOperations> mobileNo2Property() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'mobileNo2');
    });
  }

  QueryBuilder<CustomerMaster, String, QQueryOperations> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'name');
    });
  }

  QueryBuilder<CustomerMaster, String, QQueryOperations> panNoProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'panNo');
    });
  }

  QueryBuilder<CustomerMaster, String, QQueryOperations> rateGroupProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'rateGroup');
    });
  }

  QueryBuilder<CustomerMaster, String, QQueryOperations> sabhasadNoProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'sabhasadNo');
    });
  }
}
