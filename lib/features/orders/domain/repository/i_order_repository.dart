import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:liquor_ordering_system/core/failure/failure.dart';
import 'package:liquor_ordering_system/features/orders/data/repository/order_remote_repository.dart';
import 'package:liquor_ordering_system/features/orders/domain/entity/order_entity.dart';

final orderRepositoryProvider = Provider<IOrderRepository>(
    (ref) => ref.read(orderRemoteRepositoryProvider));

abstract class IOrderRepository {
  Future<Either<Failure, bool>> createOrder(OrderEntity orderEntity);
  Future<Either<Failure, List<OrderEntity>>> getOrder();
}
