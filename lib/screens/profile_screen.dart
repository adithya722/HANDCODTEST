import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:go_router/go_router.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Supabase.instance.client.auth.currentUser;

    return Scaffold(
      appBar: AppBar(title: const Text('My Account')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          CircleAvatar(
            radius: 40,
            backgroundColor: Colors.green[100],
            child: Text(
              user?.email?[0].toUpperCase() ?? 'U',
              style: const TextStyle(fontSize: 40),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            user?.email ?? 'User',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            textAlign: TextAlign.center,
          ),
          Text(
            user?.phone ?? '+91 XXXXX XXXXX',
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.green[50],
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Wallet', style: TextStyle(fontWeight: FontWeight.bold)),
                Text('Balance : ₹125', style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          const Divider(height: 40),
          _buildMenuItem(Icons.person, 'Edit Profile'),
          _buildMenuItem(Icons.location_on, 'Saved Address'),
          _buildMenuItem(Icons.description, 'Terms & Conditions'),
          _buildMenuItem(Icons.privacy_tip, 'Privacy Policy'),
          _buildMenuItem(Icons.card_giftcard, 'Refer a friend'),
          _buildMenuItem(Icons.headset_mic, 'Customer Support'),
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.red),
            title: const Text('Log Out', style: TextStyle(color: Colors.red)),
            onTap: () async {
              await Supabase.instance.client.auth.signOut();
              context.go('/auth'); // Navigate to AuthScreen
            },
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem(IconData icon, String title) {
    return ListTile(leading: Icon(icon), title: Text(title));
  }
}
