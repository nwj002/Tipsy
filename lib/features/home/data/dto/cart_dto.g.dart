// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CartDto _$CartDtoFromJson(Map<String, dynamic> json) => CartDto(
  success: json['success'] as bool,
  message: json['message'] as String,
  products: (json['cart'] as List<dynamic>)  // First cast to List<dynamic>
      .map((e) => CartApiModel.fromJson(e as Map<String, dynamic>))
      .toList(),  // Then map each item to CartApiModel
);

Map<String, dynamic> _$CartDtoToJson(CartDto instance) => <String, dynamic>{
  'success': instance.success,
  'message': instance.message,
  'cart': instance.products,
};

