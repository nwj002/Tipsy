import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:liquor_ordering_system/core/failure/failure.dart';
import 'package:liquor_ordering_system/features/orders/data/data_source/remote/order_remote_data_source.dart';
import 'package:liquor_ordering_system/features/orders/domain/entity/order_entity.dart';
import 'package:liquor_ordering_system/features/orders/domain/repository/i_order_repository.dart';

final orderRemoteRepositoryProvider = Provider<IOrderRepository>((ref) {
  final orderRemoteDataSource = ref.watch(orderRemoteDataSourceProvider);
  return OrderRemoteRepository(orderRemoteDataSource: orderRemoteDataSource);
});

class OrderRemoteRepository implements IOrderRepository {
  final OrderRemoteDataSource orderRemoteDataSource;

  OrderRemoteRepository({required this.orderRemoteDataSource});

  @override
  Future<Either<Failure, bool>> createOrder(OrderEntity orderEntity) {
    return orderRemoteDataSource.createOrder(orderEntity);
  }

  @override
  Future<Either<Failure, List<OrderEntity>>> getOrder() {
    return orderRemoteDataSource.getOrder();
  }
}
