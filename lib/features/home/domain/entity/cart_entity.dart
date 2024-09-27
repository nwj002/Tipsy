import 'package:equatable/equatable.dart';
import 'package:liquor_ordering_system/features/home/domain/entity/product_entity.dart';

class CartEntity extends Equatable {
  final String? id;
  final String? userID;
  final ProductEntity productID;
  final int quantity;
  final String status;

  const CartEntity({
    this.id,
    this.userID,
    required this.productID,
    required this.quantity,
    required this.status,
  });

  @override
  List<Object?> get props => [id, userID, productID, quantity, status];
}
