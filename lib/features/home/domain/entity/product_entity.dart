import 'package:equatable/equatable.dart';

class ProductEntity extends Equatable {
  final String? id;
  final String productName;
  final int productPrice;
  final String productImage;
  final String productDescription;
  final String productCategory;

  const ProductEntity({
    this.id,
    required this.productName,
    required this.productPrice,
    required this.productImage,
    required this.productDescription,
    required this.productCategory,
  });

  @override
  List<Object?> get props => [
        id,
        productName,
        productPrice,
        productImage,
        productDescription,
      ];
}
