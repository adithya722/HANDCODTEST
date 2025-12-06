import '../models/service.dart';

final List<Service> dummyServices = [
  Service(
    id: '1',
    title: 'Bathroom Cleaning',
    price: 499,
    duration: '60 Minutes',
    rating: 4.2,
    orders: 23,
    image: 'assets/images/bathroom.jpg', // use local asset
  ),
  Service(
    id: '2',
    title: 'Kitchen Cleaning',
    price: 599,
    duration: '90 Minutes',
    rating: 4.5,
    orders: 41,
    image: 'assets/images/kitchen.jpg', // use local asset
  ),
  Service(
    id: '3',
    title: 'Full Home Cleaning',
    price: 1499,
    duration: '180 Minutes',
    rating: 4.8,
    orders: 89,
    image: 'assets/images/full_home.jpg', // use local asset
  ),
];
