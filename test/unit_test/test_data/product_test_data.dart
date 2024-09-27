import 'package:liquor_ordering_system/features/home/domain/entity/product_entity.dart';

class ProductTestData {
  ProductTestData._();

  static List<ProductEntity> getProductsTestData() {
    List<ProductEntity> lstProducts = [
      const ProductEntity(
        productName: "test",
        productPrice: 11,
        productImage: "1719666640924-brandy.png",
        productDescription: "this is test product",
        productCategory: "beer",
      ),
      const ProductEntity(
        productName: "test 2",
        productPrice: 111,
        productImage: "1719677053594-wine.png",
        productDescription: "this is test 2 description.",
        productCategory: "wine",
      ),
      const ProductEntity(
        productName: "test 3",
        productPrice: 111,
        productImage: "1719677074428-vodka.png",
        productDescription: "This is test 3 description.",
        productCategory: "vodka",
      ),
      const ProductEntity(
        productName: "test 4",
        productPrice: 111,
        productImage: "1719677100222-t.png",
        productDescription: "This is the test 4 description.",
        productCategory: "rum",
      ),
      const ProductEntity(
        productName: "test 5",
        productPrice: 111,
        productImage: "1719677116661-cha.png",
        productDescription: "This is the test 5 description.",
        productCategory: "whiskey",
      ),
      const ProductEntity(
        productName: "test 6",
        productPrice: 111,
        productImage: "1719679202629-vodka.png",
        productDescription: "This is Product 6 Description.",
        productCategory: "vodka",
      ),
      const ProductEntity(
        productName: "test 7",
        productPrice: 111,
        productImage: "1719679214526-cha.png",
        productDescription: "This is Product 7 Description.",
        productCategory: "beer",
      ),
      const ProductEntity(
        productName: "test 8",
        productPrice: 111,
        productImage: "1719679228975-wine.png",
        productDescription: "This is Product 8 Description.",
        productCategory: "wine",
      ),
      const ProductEntity(
        productName: "test 9",
        productPrice: 111,
        productImage: "1719679260388-brandy.png",
        productDescription: "This is Product 9 Description.",
        productCategory: "whiskey",
      ),
      const ProductEntity(
        productName: "test 10",
        productPrice: 1111,
        productImage: "1720024622066-t.png",
        productDescription: "this is test 10",
        productCategory: "vodka",
      ),
      const ProductEntity(
        productName: "test 11",
        productPrice: 11111,
        productImage: "1720025201990-vodka.png",
        productDescription: "this is test 11 description",
        productCategory: "rum",
      ),
    ];
    return lstProducts;
  }
}
