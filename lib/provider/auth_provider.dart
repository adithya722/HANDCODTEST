// lib/provider/auth_provider.dart

import 'package:flutter_riverpod/flutter_riverpod.dart' as riverpod; // ← Add alias here
import 'package:supabase_flutter/supabase_flutter.dart';

final authProvider = riverpod.Provider<AuthNotifier>((ref) => AuthNotifier());

class AuthNotifier {
  Future<void> verifyOtp(String phone, String otp) async {
    try {
      final response = await Supabase.instance.client.auth.verifyOTP(
        phone: phone,
        token: otp,
        type: OtpType.sms,
      );

      if (response.session != null) {
        final userId = Supabase.instance.client.auth.currentUser?.id;
        if (userId != null) {
          // Save phone number to your custom profiles table
          await Supabase.instance.client
              .from('profiles')
              .upsert(
                {'user_id': userId, 'phone': phone},
                onConflict: 'user_id', // prevents duplicate entries on re-login
              );
        }
      } else {
        throw Exception('Invalid or expired OTP');
      }
    } catch (e) {
      rethrow;
    }
  }

  // Optional: Add resend OTP method
  Future<void> resendOtp(String phone) async {
    await Supabase.instance.client.auth.signInWithOtp(
      phone: phone,

    );
  }
}