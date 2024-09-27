import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:liquor_ordering_system/core/failure/failure.dart';
import 'package:liquor_ordering_system/features/home/data/repository/product_remote_repository.dart';
import 'package:liquor_ordering_system/features/home/domain/entity/product_entity.dart';

final productRepositoryProvider = 
Provider<IProductRepository>((ref) => ref.read(productRemoteRepository));

abstract class IProductRepository{
  Future<Either<Failure, List<ProductEntity>>> pagination(int page, int limit);
}