import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:liquor_ordering_system/features/home/data/model/product_api_model.dart';
import 'package:liquor_ordering_system/features/home/domain/entity/cart_entity.dart';

part 'cart_api_model.g.dart';

//provider
final cartApiModelProvider =
    Provider<CartApiModel>((ref) => const CartApiModel.empty());

@JsonSerializable()
class CartApiModel extends Equatable {
  @JsonKey(name: '_id')
  final String? id;
  final String? userID;
  final ProductApiModel? productID;
  final int quantity;
  final String status;

  const CartApiModel({
    required this.id,
    required this.userID,
    required this.productID,
    required this.quantity,
    required this.status,
  });

  const CartApiModel.empty()
      : id = '',
        userID = '',
        productID = null,
        quantity = 0,
        status = '';

  factory CartApiModel.fromJson(Map<String, dynamic> json) =>
      _$CartApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$CartApiModelToJson(this);

  // To Entity
  CartEntity toEntity() {
    return CartEntity(
        id: id,
        userID: userID,
        productID: productID!.toEntity(),
        quantity: quantity,
        status: status);
  }

  // Covert Entity to Api Object
  factory CartApiModel.fromEntity(CartEntity entity) {
    return CartApiModel(
        id: entity.id,
        userID: entity.userID,
        productID: ProductApiModel.fromEntity(entity.productID),
        quantity: entity.quantity,
        status: entity.status);
  }

  //Convert Api List to Entity List
  List<CartEntity> toEntityList(List<CartApiModel> carts) {
    return carts.map((cart) => cart.toEntity()).toList();
  }

  List<CartApiModel> fromEntityList(List<CartEntity> carts) {
    return carts.map((cart) => CartApiModel.fromEntity(cart)).toList();
  }

  @override
  List<Object?> get props => [
        id,
        userID,
        productID,
        quantity,
        status,
      ];
}
