import 'package:json_annotation/json_annotation.dart';
import 'package:liquor_ordering_system/features/home/data/model/product_api_model.dart';

part 'product_pagination_dto.g.dart';

@JsonSerializable()
class ProductPaginationDto {
  final bool success;
  final String message;
  final List<ProductApiModel> data;

  ProductPaginationDto({
    required this.success,
    required this.message,
    required this.data,
  });

  Map<String, dynamic> toJson() => _$ProductPaginationDtoToJson(this);

  factory ProductPaginationDto.fromJson(Map<String, dynamic> json) =>
      _$ProductPaginationDtoFromJson(json);
}
