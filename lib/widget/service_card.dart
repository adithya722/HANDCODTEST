import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hancodtest/provider/cart_provider.dart';
import '../models/service.dart';

class ServiceCard extends ConsumerWidget {
  final Service service;
  final bool showQuantity;

  const ServiceCard({required this.service, this.showQuantity = false, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cart = ref.watch(cartProvider);
    final item = cart.where((i) => i.service.id == service.id).firstOrNull;

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(service.image, width: 80, height: 80, fit: BoxFit.cover),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(service.title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.amber, size: 16),
                      Text('${service.rating} (${service.orders} Orders)'),
                    ],
                  ),
                  Text(service.duration, style: const TextStyle(color: Colors.grey)),
                  Text('₹${service.price.toStringAsFixed(0)}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                ],
              ),
            ),
            if (item == null)
              ElevatedButton(
                onPressed: () => ref.read(cartProvider.notifier).add(service),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                child: const Text('Add +'),
              )
            else
              Container(
                decoration: BoxDecoration(border: Border.all(color: Colors.green), borderRadius: BorderRadius.circular(8)),
                child: Row(
                  children: [
                    IconButton(onPressed: () => ref.read(cartProvider.notifier).decrease(service.id), icon: const Icon(Icons.remove, size: 18)),
                    Text('${item.quantity}', style: const TextStyle(fontWeight: FontWeight.bold)),
                    IconButton(onPressed: () => ref.read(cartProvider.notifier).increase(service.id), icon: const Icon(Icons.add, size: 18)),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}