import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/service.dart';

class CartItem {
  final Service service;
  int quantity;
  CartItem({required this.service, this.quantity = 1});
}

class CartNotifier extends StateNotifier<List<CartItem>> {
  CartNotifier() : super([]);

  void add(Service service) {
    final existing = state.where((item) => item.service.id == service.id).firstOrNull;
    if (existing != null) {
      existing.quantity++;
      state = [...state];
    } else {
      state = [...state, CartItem(service: service)];
    }
  }

  void increase(String id) {
    state = state.map((item) {
      if (item.service.id == id) item.quantity++;
      return item;
    }).toList();
  }

  void decrease(String id) {
    state = state.map((item) {
      if (item.service.id == id && item.quantity > 1) {
        item.quantity--;
      }
      return item;
    }).toList();
    state = state.where((i) => i.quantity > 0).toList();
  }

  double get total => state.fold(0, (sum, item) => sum + (item.service.price * item.quantity));
}

final cartProvider = StateNotifierProvider<CartNotifier, List<CartItem>>((ref) => CartNotifier());