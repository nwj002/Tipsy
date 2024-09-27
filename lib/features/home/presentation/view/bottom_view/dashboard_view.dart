import 'dart:async';

import 'package:all_sensors2/all_sensors2.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:liquor_ordering_system/app/constants/api_endpoint.dart';
import 'package:liquor_ordering_system/core/common/my_product_card.dart';
import 'package:liquor_ordering_system/core/common/my_snack_bar.dart';
import 'package:liquor_ordering_system/features/home/domain/entity/product_entity.dart';
import 'package:liquor_ordering_system/features/home/presentation/viewmodel/cart_viewmodel.dart';
import 'package:liquor_ordering_system/features/home/presentation/viewmodel/home_viewmodel.dart';
import 'package:liquor_ordering_system/features/home/presentation/viewmodel/products_viewmodel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashboardView extends ConsumerStatefulWidget {
  const DashboardView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DashboardViewState();
}

class _DashboardViewState extends ConsumerState<DashboardView> {
  final ScrollController _scrollController = ScrollController();
  bool showYesNoDialog = true;
  bool isDialogShowing = false;

  List<double> _gyroscopeValues = [];
  final List<StreamSubscription<dynamic>> _streamSubscription = [];

  @override
  void dispose() {
    _scrollController.dispose();
    for (final subscription in _streamSubscription) {
      subscription.cancel(); // Cancel all stream subscriptions
    }
    super.dispose();
  }

  @override
  void initState() {
    _streamSubscription.add(gyroscopeEvents!.listen((GyroscopeEvent event) {
      setState(() {
        _gyroscopeValues = <double>[event.x, event.y, event.z];
        _checkGyroscopeValues(_gyroscopeValues);
      });
    }));
    super.initState();
  }

  void _checkGyroscopeValues(List<double> values) async {
    const double threshold = 3; // Example threshold value, adjust as needed
    if (values.any((value) => value.abs() > threshold)) {
      if (showYesNoDialog && !isDialogShowing) {
        isDialogShowing = true;
        final result = await AwesomeDialog(
          context: context,
          dialogType: DialogType.warning,
          title: 'Logout',
          desc: 'Are You Sure You Want To Logout?',
          btnOkOnPress: () {
            ref.read(homeViewModelProvider.notifier).logout();
          },
          btnCancelOnPress: () {},
        ).show();

        isDialogShowing = false;
        if (result) {
          mySnackBar(
            message: 'Logged Out Successfully!',
            color: Colors.green,
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(productViewModelProvider);
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // Getting the CartViewModel instance from the provider
    final cartViewModel = ref.read(cartViewModelProvider.notifier);

    return Scaffold(
      body: NotificationListener<ScrollNotification>(
        onNotification: (notification) {
          if (notification is ScrollEndNotification &&
              _scrollController.position.extentAfter == 0) {
            ref.read(productViewModelProvider.notifier).getProducts();
          }
          return true;
        },
        child: SingleChildScrollView(
          controller: _scrollController,
          child: Column(
            children: [
              // Banner Carousel
              CarouselSlider(
                items: [
                  Image.asset('assets/images/s1.jpg', fit: BoxFit.cover),
                  Image.asset('assets/images/s2.jpg', fit: BoxFit.cover),
                  Image.asset('assets/images/s3.jpg', fit: BoxFit.cover),
                ],
                options: CarouselOptions(
                  height: screenHeight * 0.25,
                  autoPlay: true,
                  viewportFraction: 1.0,
                ),
              ),
              const SizedBox(height: 10),
              // Explore Categories Section
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Explore Categories',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            // Navigate to the Categories page
                          },
                          child: const Text(
                            'Show all',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    // Category Icons
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: 4, // Number of categories
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                      ),
                      itemBuilder: (context, index) {
                        // List of category images
                        final List<String> categoryImages = [
                          'assets/images/category1.png', // Ensure these paths are correct
                          'assets/images/category1.png',
                          'assets/images/category1.png',
                          'assets/images/category1.png',
                        ];

                        return GestureDetector(
                          onTap: () {
                            // Handle category click
                          },
                          child: Container(
                            width: 40, // 70% of 100
                            height: 40, // 70% of 100
                            decoration: BoxDecoration(
                              shape: BoxShape.circle, // Circular shape

                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey
                                      .withOpacity(0.15), // Shadow color
                                  spreadRadius: 20, // Spread radius
                                  blurRadius: 10, // Blur radius
                                  offset: const Offset(0, 4), // Shadow offset
                                ),
                              ],
                              image: DecorationImage(
                                image: AssetImage(categoryImages[index]),
                                fit: BoxFit
                                    .cover, // Ensure the image covers the container
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Featured Products',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 10),
              // List of Products
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: state.products.length,
                itemBuilder: (context, index) {
                  final product = state.products[index];
                  return GestureDetector(
                    onTap: () {
                      // Navigate to the product details page when the card is pressed
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              ProductDetailView(product: product, ref: ref),
                        ),
                      );
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal:
                            screenWidth * 0.05, // Responsive horizontal padding
                        vertical:
                            screenHeight * 0.01, // Responsive vertical padding
                      ),
                      child: MyProductCard(
                        data: product,
                        onAddToCart: () async {
                          await cartViewModel.addCart(
                            product.id
                                .toString(), // Convert product ID to string
                            1, // Assuming quantity is 1
                          );

                          mySnackBar(
                            message: 'Product added to cart',
                            color: Colors.green,
                          );
                        },
                      ),
                    ),
                  );
                },
              ),
              if (state.isLoading)
                const Center(
                  child: CircularProgressIndicator(
                    color: Colors.red,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProductDetailView extends StatefulWidget {
  final ProductEntity product;
  final WidgetRef ref;

  const ProductDetailView({
    required this.product,
    required this.ref,
    super.key,
  });

  @override
  _ProductDetailViewState createState() => _ProductDetailViewState();
}

class _ProductDetailViewState extends State<ProductDetailView> {
  int quantity = 1; // Default quantity
  final TextEditingController _reviewController = TextEditingController();
  String? userReview;

  void incrementQuantity() {
    setState(() {
      quantity++;
    });
  }

  void decrementQuantity() {
    if (quantity > 1) {
      setState(() {
        quantity--;
      });
    }
  }

  void submitReview() {
    setState(() {
      userReview = _reviewController.text;
      _reviewController.clear(); // Clear the text field after submission
    });
  }

  Future<void> addToCart() async {
    final prefs = await SharedPreferences.getInstance();
    final cartItems = prefs.getStringList('cart') ?? [];
    final newItem = '${widget.product.id}:$quantity';
    cartItems.add(newItem);
    await prefs.setStringList('cart', cartItems);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.product.productName),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.network(
              '${ApiEndpoints.imageUrl}${widget.product.productImage}',
              fit: BoxFit.contain,
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.35,
            ),
            const SizedBox(height: 16),
            Text(
              widget.product.productName,
              style: const TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              widget.product.productCategory,
              style: const TextStyle(
                fontSize: 15,
                color: Colors.grey,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Text(
              widget.product.productDescription,
              style: const TextStyle(
                fontSize: 15,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Text(
              'Rs. ${widget.product.productPrice}',
              style: const TextStyle(
                fontSize: 29,
                fontWeight: FontWeight.bold,
                color: Color(0xFFD29062),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: decrementQuantity,
                  icon: const Icon(Icons.remove),
                ),
                Text(
                  quantity.toString(),
                  style: const TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  onPressed: incrementQuantity,
                  icon: const Icon(Icons.add),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                await addToCart(); // Call the new addToCart method

                mySnackBar(
                  message: 'Product added to cart',
                  color: Colors.green,
                );
              },
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 40),
                backgroundColor: const Color(0xFFD29062),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text('Add to Cart'),
            ),
            const SizedBox(height: 16),
            const Text(
              'Add Your Review',
              style: TextStyle(
                fontSize: 29,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: _reviewController,
              maxLines: 2,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Write your review...',
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              ),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: submitReview,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFD29062),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text('Submit Review'),
            ),
            const SizedBox(height: 16),
            if (userReview != null)
              ListTile(
                title: const Text(
                  'Your Review',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(userReview!),
              ),
          ],
        ),
      ),
    );
  }
}
