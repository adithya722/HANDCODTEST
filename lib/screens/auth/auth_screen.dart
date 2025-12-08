import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart' as rp;
import 'package:hancode/screens/auth/otp_screen.dart';
import 'package:hancode/screens/main_wrapper.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

// Provider for Supabase client
final supabaseClientProvider = rp.Provider<SupabaseClient>((ref) {
  return Supabase.instance.client;
});

// Provider for loading state
final authLoadingProvider = rp.StateProvider<bool>((ref) => false);

class AuthScreen extends rp.ConsumerWidget {
  AuthScreen({super.key});

  final _phoneController = TextEditingController();

  @override
  Widget build(BuildContext context, rp.WidgetRef ref) {
    final isLoading = ref.watch(authLoadingProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Image.asset('assets/images/logo.png', height: 80),
              const SizedBox(height: 80),

              // Google Sign-In (unchanged)
              ElevatedButton.icon(
                onPressed: () async {
                  final client = ref.read(supabaseClientProvider);
                  ref.read(authLoadingProvider.notifier).state = true;

                  try {
                    await client.auth.signInWithOAuth(
                     OAuthProvider.google,
                      redirectTo: kIsWeb
                          ? null
                          : 'io.supabase.yourapp://login-callback/',
                    );
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Error: $e')),
                    );
                  } finally {
                    ref.read(authLoadingProvider.notifier).state = false;
                  }
                },
                icon: Image.asset('assets/images/google.png', height: 24),
                label: const Text('Continue with Google'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                  minimumSize: const Size(double.infinity, 56),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
              ),

              const SizedBox(height: 20),

              // Phone input
              TextField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  hintText: 'Enter phone number',
                  prefixText: '+91 ',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
              ),

              const SizedBox(height: 20),

              // OTP Button
              ElevatedButton(
                onPressed: isLoading
                    ? null
                    : () async {
                        String input = _phoneController.text.trim();
                        if (input.isEmpty || input.length != 10) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text("Enter valid 10-digit number")),
                          );
                          return;
                        }

                        final phone = '+91$input';

                        ref.read(authLoadingProvider.notifier).state = true;

                        try {
                          await Supabase.instance.client.auth.signInWithOtp(
                            phone: phone,
                          );

                          // Go to OTP screen
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => OtpScreen(),
                            ),
                          );
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Error: $e")),
                          );
                          print("auth:$e");
                        } finally {
                          ref.read(authLoadingProvider.notifier).state = false;
                        }
                      },
                child: isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text('Continue with Phone',
                        style: TextStyle(color: Colors.white)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  minimumSize: const Size(double.infinity, 56),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
  