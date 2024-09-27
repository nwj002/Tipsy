import 'package:flutter/material.dart';
import 'package:liquor_ordering_system/app/constants/api_endpoint.dart';
import 'package:liquor_ordering_system/features/home/domain/entity/product_entity.dart';

class ProductGrid extends StatelessWidget {
  final List<ProductEntity> products;
  final Function(ProductEntity) onAddToCart;

  const ProductGrid({
    required this.products,
    required this.onAddToCart,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(8),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        childAspectRatio: 0.7,
      ),
      itemCount: products.length,
      itemBuilder: (context, index) {
        return MyProductCard(
          data: products[index],
          onAddToCart: () => onAddToCart(products[index]),
        );
      },
    );
  }
}

class MyProductCard extends StatelessWidget {
  final ProductEntity data;
  final VoidCallback onAddToCart;

  const MyProductCard({
    required this.data,
    required this.onAddToCart,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final imageUrl = '${ApiEndpoints.imageUrl}${data.productImage}';
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: screenHeight * 0.01, // Spacing between cards
      ),
      child: Container(
        width: screenWidth * 0.45, // Adjusted width for two cards per row
        padding: const EdgeInsets.all(8), // Internal padding
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          shadows: const [
            BoxShadow(
              color: Color(0x3F000000),
              blurRadius: 4,
              offset: Offset(0, 0),
              spreadRadius: 0,
            ),
          ],
        ),
        child: Column(
          children: [
            Container(
              width: screenWidth * 0.4, // Responsive image width
              height: screenHeight * 0.2, // Responsive image height
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  imageUrl,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            SizedBox(
                height: screenHeight * 0.02), // Spacing between image and text
            Text(
              data.productName,
              style: TextStyle(
                color: Colors.black,
                fontSize: screenWidth * 0.04, // Responsive font size
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w500,
                height: 1.2,
              ),
            ),
            SizedBox(height: screenHeight * 0.01),
            Text(
              data.productCategory,
              style: TextStyle(
                color: const Color.fromARGB(255, 237, 0, 0),
                fontSize: screenWidth * 0.03, // Responsive font size
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w500,
                height: 1.2,
              ),
            ),
            SizedBox(height: screenHeight * 0.01),

            Text(
              data.productDescription.split(' ').take(18).join(' ') +
                  (data.productDescription.split(' ').length > 200
                      ? '...'
                      : ''),
              style: TextStyle(
                color: const Color(0xFF979797),
                fontSize: screenWidth * 0.03, // Responsive font size
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w500,
                height: 1.2,
              ),
            ),

            SizedBox(height: screenHeight * 0.02),
            Row(
              children: [
                Text(
                  'Rs.',
                  style: TextStyle(
                    color: const Color(0xFFD29062),
                    fontSize: screenWidth * 0.04, // Responsive font size
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                    height: 1.2,
                  ),
                ),
                SizedBox(width: screenWidth * 0.01),
                Text(
                  data.productPrice.toString(),
                  style: TextStyle(
                    color: const Color(0xFFD29062),
                    fontSize: screenWidth * 0.04, // Responsive font size
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                    height: 1.2,
                  ),
                ),
                const Spacer(),
                ElevatedButton(
                  onPressed: onAddToCart,
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.orange,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text('Add to Cart'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
