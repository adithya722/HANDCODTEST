import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hancode/models/services.dart';
import 'package:hancode/screens/cart_screen.dart';
import '../provider/cart_provider.dart';

class ServiceListingScreen extends ConsumerStatefulWidget {
  const ServiceListingScreen({super.key});

  @override
  ConsumerState<ServiceListingScreen> createState() =>
      _ServiceListingScreenState();
}

class _ServiceListingScreenState extends ConsumerState<ServiceListingScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final List<String> tabs = [
    "Deep Cleaning",
    "Maid Services",
    "Car Cleaning",
    "Carpet Cleaning"
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: tabs.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  final List<Service> services = const [
    Service(
        id: '1',
        title: ' kitchen',
        price: 900,
        rating: 4.2,
        orders: 23,
        image: 'kitchen'),
    Service(
        id: '2',
        title: 'Bathroom Cleaning',
        price: 499,
        rating: 4.2,
        orders: 23,
        image: 'bathroom'),
    Service(
        id: '3',
        title: 'carpet',
        price: 360,
        rating: 4.2,
        orders: 23,
        image: 'carpet'),
    Service(
        id: '4',
        title: 'Home ',
        price: 1400,
        rating: 4.2,
        orders: 23,
        image: 'fullhome'),
  ];

  @override
  Widget build(BuildContext context) {
    final cart = ref.watch(cartProvider);
    final totalPrice = ref.read(cartProvider.notifier).total;

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        leading: IconButton(
          icon:
              const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text("Cleaning Services",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 0,
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.green[700],
          labelStyle: const TextStyle(fontWeight: FontWeight.bold),
          indicator: const BoxDecoration(),
          tabs: tabs.map((tab) {
            final isSelected = tabs[_tabController.index] == tab;
            return Tab(
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                  gradient: isSelected
                      ? const LinearGradient(
                          colors: [Color(0xFF00E676), Color(0xFF00C853)])
                      : null,
                  color: isSelected ? null : Colors.green[50],
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: Colors.green, width: 1.5),
                ),
                child: Text(tab),
              ),
            );
          }).toList(),
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 10),
        itemCount: services.length,
        itemBuilder: (ctx, i) {
          final service = services[i];
          final inCart = cart.any((item) => item.service.id == service.id);
          final qty = inCart
              ? cart
                  .firstWhere((item) => item.service.id == service.id)
                  .quantity
              : 0;

          return Card(
            elevation: 8,
            shadowColor: Colors.black12,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            margin: const EdgeInsets.only(bottom: 16),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(
                      "assets/images/${service.image}.jpg",
                      width: 90,
                      height: 90,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          service.title,
                          style: const TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 4),
                        // Text(service.duration, style: TextStyle(color: Colors.grey[600])),
                        const SizedBox(height: 6),
                        Row(
                          children: [
                            const Icon(Icons.star,
                                color: Colors.amber, size: 18),
                            const SizedBox(width: 4),
                            Text("${service.rating} (${service.orders} Orders)",
                                style: const TextStyle(fontSize: 14)),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "₹${service.price}.00",
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 10),
                  inCart
                      ? Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(color: Colors.green, width: 2),
                          ),
                          child: Row(
                            children: [
                              IconButton(
                                onPressed: () => ref
                                    .read(cartProvider.notifier)
                                    .decrease(service.id),
                                icon: const Icon(Icons.remove,
                                    color: Colors.green),
                              ),
                              Text("$qty",
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold)),
                              IconButton(
                                onPressed: () => ref
                                    .read(cartProvider.notifier)
                                    .increase(service.id),
                                icon:
                                    const Icon(Icons.add, color: Colors.green),
                              ),
                            ],
                          ),
                        )
                      : _gradientAddButton(
                          () => ref.read(cartProvider.notifier).add(service)),
                ],
              ),
            ),
          );
        },
      ),
      bottomSheet: cart.isEmpty
          ? null
          : Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(20)),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black26,
                      blurRadius: 20,
                      offset: const Offset(0, -5)),
                ],
              ),
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 30),
              child: Row(
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("${cart.length} items | ₹$totalPrice",
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                      // Text("60 Minutes", style: TextStyle(color: Colors.grey[600])),
                    ],
                  ),
                  const Spacer(),
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const CartScreen()));
                    },
                    icon: const Icon(Icons.shopping_cart),
                    label: const Text("VIEW CART",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 32, vertical: 16),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                      elevation: 10,
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  // Gradient Add Button
  Widget _gradientAddButton(VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF00E676), Color(0xFF00C853)],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: Colors.green.withOpacity(0.4),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Add",
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(width: 4),
            Icon(
              Icons.add,
              color: Colors.white,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }
}
