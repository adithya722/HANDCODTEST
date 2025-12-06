import 'package:flutter/material.dart';
import 'package:hancodtest/screens/auth/auth_screen.dart';
import 'package:hancodtest/screens/cart_screen.dart';
import 'package:hancodtest/screens/home_screen.dart';
import 'package:hancodtest/screens/profile_screen.dart';
import 'package:hancodtest/screens/service_listing_screen.dart';
import 'package:go_router/go_router.dart';

import 'package:supabase_flutter/supabase_flutter.dart';

final GoRouter router = GoRouter(
  routes: [
    GoRoute(path: '/', builder: (context, state) => AuthScreen()),
    GoRoute(path: '/home', builder: (context, state) =>  HomeScreen()),
    GoRoute(path: '/services', builder: (context, state) => const ServiceListingScreen()),
    GoRoute(path: '/cart', builder: (context, state) => const CartScreen()),
    GoRoute(path: '/profile', builder: (context, state) => const ProfileScreen()),
  ],
  redirect: (context, state) {
    final user = Supabase.instance.client.auth.currentUser;
    final isAuth = user != null;
    final isOnAuth = state.uri.toString() == '/home';

    if (!isAuth && !isOnAuth) return '/home';
    if (isAuth && isOnAuth) return '/home';
    return null;
  },
);