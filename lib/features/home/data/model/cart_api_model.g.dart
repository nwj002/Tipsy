// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CartApiModel _$CartApiModelFromJson(Map<String, dynamic> json) => CartApiModel(
      id: json['_id'] as String?,
      userID: json['userID'] as String?,
      productID: json['productID'] == null
          ? null
          : ProductApiModel.fromJson(json['productID'] as Map<String, dynamic>),
      quantity: (json['quantity'] as num).toInt(),
      status: json['status'] as String,
    );

Map<String, dynamic> _$CartApiModelToJson(CartApiModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'userID': instance.userID,
      'productID': instance.productID,
      'quantity': instance.quantity,
      'status': instance.status,
    };
