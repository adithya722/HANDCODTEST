import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hancodtest/screens/auth/auth_screen.dart';
import 'package:hancodtest/screens/main_wrapper.dart';
import 'package:hancodtest/screens/route.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://nxujfykmizedcwrjekmr.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im54dWpmeWttaXplZGN3cmpla21yIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjQ5MjMxOTEsImV4cCI6MjA4MDQ5OTE5MX0.aj9db5BpAqZZ7eUatqva-UiIOejPiMBQFGa-qgIJ7gY',
  );
  runApp(const ProviderScope(child: HancodApp()));
}

class HancodApp extends ConsumerWidget {
  const HancodApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Hancod',
      home: const AuthWrapper(), // ← New wrapper that decides what to show
    );
  }
}

// New Widget: Decides whether to show Auth or MainWrapper
class AuthWrapper extends ConsumerWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = Supabase.instance.client.auth.currentUser;

    // Listen to auth state changes (recommended)
    return StreamBuilder(
      stream: Supabase.instance.client.auth.onAuthStateChange,
      builder: (context, snapshot) {
        final session = snapshot.data?.session;
        final currentUser = session?.user;

        if (currentUser == null) {
          return  AuthScreen();
        } else {
          // This ensures MainWrapper is the ROOT widget with BottomNav
          return MainWrapper(key: MainWrapper.globalKey);
        }
      },
    );
  }
}