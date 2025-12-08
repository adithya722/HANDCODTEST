import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hancode/provider/cart_provider.dart';

class CartScreen extends ConsumerWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cart = ref.watch(cartProvider);
    final total = ref.read(cartProvider.notifier).total;

    return Scaffold(
      appBar: AppBar(title: const Text('Cart')),
      body: cart.isEmpty
          ? const Center(child: Text('Your cart is empty'))
          : ListView.builder(
              itemCount: cart.length,
              itemBuilder: (ctx, i) {
                final item = cart[i];
                return ListTile(
                  leading: Image.asset(
                    "assets/images/${item.service.image}.jpg",
                    width: 60,
                    height: 60,
                    fit: BoxFit.cover,
                  ),
                  title: Text(item.service.title),
                  subtitle: Text('₹${item.service.price} × ${item.quantity}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () => ref
                            .read(cartProvider.notifier)
                            .decrease(item.service.id),
                        icon: const Icon(Icons.remove_circle_outline),
                      ),
                      Text('${item.quantity}',
                          style: const TextStyle(fontWeight: FontWeight.bold)),
                      IconButton(
                        onPressed: () => ref
                            .read(cartProvider.notifier)
                            .increase(item.service.id),
                        icon: const Icon(Icons.add_circle_outline),
                      ),
                    ],
                  ),
                );
              },
            ),
      bottomSheet: cart.isNotEmpty
          ? Container(
              padding: const EdgeInsets.all(16),
              color: Colors.white,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('Frequently added services',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  // Add small cards here if you want
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey[300]!),
                        borderRadius: BorderRadius.circular(8)),
                    child: Row(
                      children: [
                        const Expanded(
                            child: TextField(
                                decoration: InputDecoration(
                                    hintText: 'Enter Coupon Code',
                                    border: InputBorder.none))),
                        ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green),
                            child: const Text('Apply')),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Total'),
                        Text('₹898',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold))
                      ]),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        minimumSize: const Size(double.infinity, 56)),
                    child:
                        const Text('Book Slot', style: TextStyle(fontSize: 18)),
                  ),
                ],
              ),
            )
          : null,
    );
  }
}
