import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/service.dart';
import '../provider/cart_provider.dart';

class ServiceListingScreen extends ConsumerWidget {
  const ServiceListingScreen({super.key});

  final List<Service> services = const [
    Service(
        id: '1',
        title: 'Bathroom Cleaning',
        price: 499,
        duration: '60 Minutes',
        rating: 4.2,
        orders: 23,
        image: 'bathroom'),
    Service(
        id: '2',
        title: 'Kitchen Cleaning',
        price: 599,
        duration: '80 Minutes',
        rating: 4.3,
        orders: 45,
        image: 'kitchen'),
    Service(
        id: '3',
        title: 'Full Home Cleaning',
        price: 1299,
        duration: '180 Minutes',
        rating: 4.8,
        orders: 112,
        image: 'fullhome'),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cart = ref.watch(cartProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Cleaning Services"),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: services.length,
        itemBuilder: (ctx, i) {
          final service = services[i];
          final inCart =
              cart.any((item) => item.service.id == service.id);
          final qty = inCart
              ? cart.firstWhere((item) => item.service.id == service.id).quantity
              : 0;

          return Card(
            margin: const EdgeInsets.only(bottom: 16),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      "assets/images/${service.image}.jpg",
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(service.title,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16)),
                        Text(service.duration),
                        Row(
                          children: [
                            const Icon(Icons.star,
                                color: Colors.amber, size: 16),
                            const SizedBox(width: 4),
                            Text("${service.rating} (${service.orders} Orders)"),
                          ],
                        ),
                        Text("₹${service.price}",
                            style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.green)),
                      ],
                    ),
                  ),
                  inCart
                      ? Row(
                          children: [
                            IconButton(
                              onPressed: () => ref
                                  .read(cartProvider.notifier)
                                  .decrease(service.id),
                              icon: const Icon(Icons.remove_circle_outline),
                            ),
                            Text("$qty",
                                style: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold)),
                            IconButton(
                              onPressed: () => ref
                                  .read(cartProvider.notifier)
                                  .increase(service.id),
                              icon: const Icon(Icons.add_circle_outline),
                            ),
                          ],
                        )
                      : ElevatedButton(
                          onPressed: () =>
                              ref.read(cartProvider.notifier).add(service),
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green),
                          child: const Text("Add +"),
                        ),
                ],
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: cart.isEmpty
          ? const SizedBox()
          : Container(
              padding: const EdgeInsets.all(16),
              color: Colors.orange,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "${cart.length} items | ₹${ref.read(cartProvider.notifier).total}",
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                    child: const Text("VIEW CART",
                        style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
            ),
    );
  }
}
