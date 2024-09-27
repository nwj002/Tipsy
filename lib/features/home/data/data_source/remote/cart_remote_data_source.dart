import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:liquor_ordering_system/app/constants/api_endpoint.dart';
import 'package:liquor_ordering_system/core/failure/failure.dart';
import 'package:liquor_ordering_system/core/networking/remote/http_service.dart';
import 'package:liquor_ordering_system/core/shared_prefs/user_shared_prefs.dart';
import 'package:liquor_ordering_system/features/home/data/dto/cart_dto.dart';
import 'package:liquor_ordering_system/features/home/data/model/cart_api_model.dart';
import 'package:liquor_ordering_system/features/home/domain/entity/cart_entity.dart';

final cartRemoteDataSourceProvider = Provider<CartRemoteDataSource>((ref) {
  final dio = ref.watch(httpServiceProvider);
  final userSharedPrefs = ref.watch(userSharedPrefsProvider);
  final cartApiModel = ref.watch(cartApiModelProvider);
  return CartRemoteDataSource(
    dio: dio,
    userSharedPrefs: userSharedPrefs,
    cartApiModel: cartApiModel,
  );
});

class CartRemoteDataSource {
  final Dio dio;
  final UserSharedPrefs userSharedPrefs;
  final CartApiModel cartApiModel;

  CartRemoteDataSource({
    required this.dio,
    required this.userSharedPrefs,
    required this.cartApiModel,
  });

  Future<Either<Failure, bool>> addToCart({
    required String productID,
    required int quantity,
  }) async {
    try {
      String? token;
      var data = await userSharedPrefs.getUserId();
      data.fold(
        (l) => token = null,
        (r) => token = r,
      );

      print('Token: $token');
      var response = await dio.post(
        ApiEndpoints.addToCart,
        data: {
          'userID': token,
          'productID': productID,
          'quantity': quantity,
        },
      );
      if (response.statusCode == 200) {
        return const Right(true);
      } else {
        return Left(
          Failure(
            error: response.data['message'],
            statusCode: response.statusCode.toString(),
          ),
        );
      }
    } on DioException catch (e) {
      return Left(
        Failure(
          error: e.message.toString(),
        ),
      );
    }
  }

  Future<Either<Failure, List<CartEntity>>> getCarts() async {
    try {
      String? token;
      var data = await userSharedPrefs.getUserId();
      data.fold(
        (l) => token = null,
        (r) => token = r,
      );

      print('Token: $token');
      var response = await dio.get(
        "${ApiEndpoints.getCart}/$token",
      );

      // print('Response status code: ${response.statusCode}');
      // print('Response data: ${response.data}');

      if (response.statusCode == 200) {
        final cartDto = CartDto.fromJson(response.data);

        return Right(cartApiModel.toEntityList(cartDto.products));
      } else {
        return Left(
          Failure(
            error: response.data['message'],
            statusCode: response.statusCode.toString(),
          ),
        );
      }
    } on DioException catch (e) {
      return Left(
        Failure(
          error: e.message.toString(),
        ),
      );
    }
  }

  Future<Either<Failure, bool>> clearCart() async {
    try {
      String? token;
      final data = await userSharedPrefs.getUserToken();
      data.fold(
        (l) => token = null,
        (r) => token = r,
      );
      Response response = await dio.post(
        ApiEndpoints.clearCart,
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );

      if (response.statusCode == 200) {
        return const Right(true);
      }
      return Left(
        Failure(
            error: response.data['message'],
            statusCode: response.statusCode.toString()),
      );
    } on DioException catch (e) {
      return Left(Failure(error: e.error.toString()));
    } catch (e) {
      return Left(Failure(error: e.toString()));
    }
  }

  Future<Either<Failure, bool>> changeStatus() async {
    try {
      String? token;
      final data = await userSharedPrefs.getUserToken();
      data.fold(
        (l) => token = null,
        (r) => token = r,
      );
      Response response = await dio.put(
        ApiEndpoints.changeStatus,
        data: {'status': 'ordered'},
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );

      if (response.statusCode == 200) {
        return const Right(true);
      }
      return Left(
        Failure(
            error: response.data['message'],
            statusCode: response.statusCode.toString()),
      );
    } on DioException catch (e) {
      return Left(Failure(error: e.error.toString()));
    } catch (e) {
      return Left(Failure(error: e.toString()));
    }
  }
}
