import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:liquor_ordering_system/app/constants/api_endpoint.dart';
import 'package:liquor_ordering_system/features/home/presentation/viewmodel/cart_viewmodel.dart';

class CartView extends ConsumerStatefulWidget {
  const CartView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CartViewState();
}

class _CartViewState extends ConsumerState<CartView> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => ref.read(cartViewModelProvider.notifier).getCarts());
  }

  @override
  Widget build(BuildContext context) {
    final cartState = ref.watch(cartViewModelProvider);

    // Calculate subtotal dynamically based on cart items
    double subtotal = cartState.products.fold(0, (sum, item) {
      return sum + (item.productID.productPrice * item.quantity);
    });
    double total = subtotal; // Add any additional charges if needed

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: cartState.products.length,
                itemBuilder: (context, index) {
                  final item = cartState.products[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                    child: ListTile(
                      leading: Image.network(
                        '${ApiEndpoints.imageUrl}/${item.productID.productImage}',
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            const Icon(Icons.error),
                      ),
                      title: Text(item.productID.productName),
                      subtitle: Text(
                          '\$${item.productID.productPrice.toStringAsFixed(2)}'),
                      trailing: Text('Qty: ${item.quantity}'),
                    ),
                  );
                },
              ),
            ),
            const Divider(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Total: Rs.${total.toStringAsFixed(2)}',
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                _showCheckoutDialog(context);
              },
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                textStyle: const TextStyle(fontSize: 18),
              ),
              child: const Text('Checkout'),
            ),
          ],
        ),
      ),
    );
  }

  void _showCheckoutDialog(BuildContext context) {
    final addressController = TextEditingController();
    String paymentType = 'Cash';

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Checkout'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Address'),
                const SizedBox(height: 8),
                TextFormField(
                  controller: addressController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter your address',
                  ),
                ),
                const SizedBox(height: 16),
                const Text('Payment Type'),
                const SizedBox(height: 8),
                RadioListTile<String>(
                  title: const Text('Cash'),
                  value: 'Cash',
                  groupValue: paymentType,
                  onChanged: (value) {
                    setState(() {
                      paymentType = value!;
                    });
                  },
                ),
                RadioListTile<String>(
                  title: const Text('Khalti'),
                  value: 'Khalti',
                  groupValue: paymentType,
                  onChanged: (value) {
                    setState(() {
                      paymentType = value!;
                    });
                  },
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: const Text('Order'),
              onPressed: () {
                Navigator.of(context).pop();
                _checkoutCart(addressController.text, paymentType);
              },
            ),
          ],
        );
      },
    );
  }

  void _checkoutCart(String address, String paymentType) {
    final total =
        ref.read(cartViewModelProvider).products.fold<double>(0.0, (sum, item) {
      return sum + (item.productID.productPrice * item.quantity);
    });

    ref
        .read(cartViewModelProvider.notifier)
        .checkoutCart(paymentType, total, address);
  }
}
