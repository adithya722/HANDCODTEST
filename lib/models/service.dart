// models/service.dart

class Service {
  final String id;
  final String title;
  final double price;
  final String duration;
  final double rating;
  final int orders;
  final String image;

  const Service({
    required this.id,
    required this.title,
    required this.price,
    required this.duration,
    required this.rating,
    required this.orders,
    required this.image,
  });
}