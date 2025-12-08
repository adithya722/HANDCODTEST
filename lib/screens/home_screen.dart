import 'package:flutter/material.dart';
import 'package:hancode/screens/cart_screen.dart';
import 'package:hancode/screens/servicelisting_screen.dart';
import 'package:hancode/screens/profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  late final List<Widget> _pages = [
    HomeContent(onSeeAllPressed: () => setState(() => _currentIndex = 1)),
    // const ServiceListingScreen(),
    const CartScreen(),
    const ProfileScreen(),
  ];

  // Public method to switch tab from anywhere (used by "See All")
  void switchToServices() {
    setState(() => _currentIndex = 1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
        backgroundColor: Colors.white,
        elevation: 20,
        selectedFontSize: 12,
        unselectedFontSize: 11,
        onTap: (index) => setState(() => _currentIndex = index),
        items: [
          _navItem(Icons.home, Icons.home_outlined, 'Home', _currentIndex == 0),
          // _navItem(Icons.cleaning_services, Icons.cleaning_services_outlined, 'Services', _currentIndex == 1),
          _navItem(Icons.shopping_cart, Icons.shopping_cart_outlined, 'Cart',
              _currentIndex == 1),
          _navItem(Icons.person, Icons.person_outline, 'Account',
              _currentIndex == 2),
        ],
      ),
    );
  }

  BottomNavigationBarItem _navItem(
      IconData active, IconData inactive, String label, bool isActive) {
    return BottomNavigationBarItem(
      icon: ShaderMask(
        shaderCallback: (bounds) => const LinearGradient(
          colors: [Color(0xFF00E676), Color(0xFF00C853)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ).createShader(bounds),
        child: Icon(
          isActive ? active : inactive,
          size: 28,
          color: isActive ? Colors.white : Colors.grey,
        ),
      ),
      label: label,
    );
  }
}

class HomeContent extends StatelessWidget {
  final VoidCallback onSeeAllPressed;

  const HomeContent({super.key, required this.onSeeAllPressed});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            // Top Section
            Container(
            //  padding: EdgeInsets.all(value),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(30)),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black12,
                      blurRadius: 15,
                      offset: Offset(0, 8)),
                ],
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.location_on,
                                  color: Colors.green[600], size: 18),
                              const SizedBox(width: 6),
                              Text(
                                "400, Skyline Park, Dubai, UAE",
                                style: TextStyle(
                                    color: Colors.grey[700], fontSize: 14),
                              ),
                            ],
                          ),
                        ],
                      ),
                      IconButton(
                        icon: const Icon(Icons.notifications_none, size: 28),
                        onPressed: () {},
                      ),
                    ],
                  ),
                  const SizedBox(height: 18),

                  // Banner Image
                  Container(
                    width: double.infinity,
                    height: 170,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      image: const DecorationImage(
                        image: AssetImage("assets/images/banner.png"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),

                  const SizedBox(height: 14),

                  // Search Bar with Gradient Icon
                  TextField(
                    decoration: InputDecoration(
                      hintText: "Search for a service",
                      hintStyle: TextStyle(color: Colors.grey[600]),
                      filled: true,
                      fillColor: Colors.grey[50],
                      prefixIcon: ShaderMask(
                        shaderCallback: (bounds) => const LinearGradient(
                          colors: [Color(0xFF00E676), Color(0xFF00C853)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ).createShader(bounds),
                        child: const Icon(Icons.search,
                            size: 19, color: Colors.white),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                            BorderSide(color: Colors.green.shade200, width: 2),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                            const BorderSide(color: Colors.green, width: 3),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 18, horizontal: 10),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Available Services
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Available Services",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 4,
                    mainAxisSpacing: 20,
                    crossAxisSpacing: 12,
                    childAspectRatio: 0.9,
                    children: [
                      _serviceIcon("Cleaning", Icons.cleaning_services),
                      _serviceIcon("Waste Disposal", Icons.delete_outline),
                      _serviceIcon("Plumbing", Icons.plumbing),
                      _serviceIcon("Painting", Icons.format_paint),
                      _serviceIcon("AC Service", Icons.ac_unit),
                      _serviceIcon("Electrical", Icons.electrical_services),
                      _serviceIcon("Pest Control", Icons.bug_report),
                      _serviceIcon("More", Icons.apps),
                    ],
                  ),

                  const SizedBox(height: 30),

                  // Cleaning Services Section
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Cleaning Services",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      TextButton(
                        onPressed: () {
                         Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ServiceListingScreen()));
                        },
                        child: const Text(
                          "See All >",
                          style: TextStyle(
                              color: Colors.green, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  SizedBox(
                    height: 190,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        _cleaningCard(
                            "Home Cleaning", "assets/images/home_clean.jpg"),
                        _cleaningCard(
                            "Carpet Cleaning", "assets/images/carpet.jpg"),
                        _cleaningCard(
                            "Sofa Cleaning", "assets/images/sofa.jpg"),
                        _cleaningCard(
                            "Office Cleaning", "assets/images/office.jpg"),
                      ],
                    ),
                  ),
                  const SizedBox(height: 100), // Space for bottom nav
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _serviceIcon(String label, IconData icon) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(17),
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 242, 242, 242),
            shape: BoxShape.circle,
            // border: Border.all(color: Colors.green.shade200, width: 2),
          ),
          child: Icon(icon, size: 19, color: Colors.green[700]),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w500),
          textAlign: TextAlign.center,
          maxLines: 2,
        ),
      ],
    );
  }

  Widget _cleaningCard(String title, String image) => Container(
        width: 140,
        margin: const EdgeInsets.only(right: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          image: DecorationImage(image: AssetImage(image), fit: BoxFit.cover),
        ),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(8),
            decoration: const BoxDecoration(
              color: Colors.black54,
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(12)),
            ),
            child: Text(
              title,
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      );
}

/**
 * 
 * 
 * import 'package:flutter/material.dart';
import 'package:hancode/screens/servicelisting_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  // Create a GlobalKey to access the state from anywhere
  static final GlobalKey<_HomeScreenState> homeKey = GlobalKey<_HomeScreenState>();

  static final List<Widget> _pages = [
    const HomeContent(),
    const ServiceListingScreen(),
    const Center(child: Text("Bookings", style: TextStyle(fontSize: 24))),
    const Center(child: Text("Account", style: TextStyle(fontSize: 24))),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: homeKey, // ← Add this line
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey[400],
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.cleaning_services), label: "Services"),
          BottomNavigationBarItem(icon: Icon(Icons.receipt_long), label: "Bookings"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Account"),
        ],
      ),
    );
  }
}

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          // ... your top bar, search, etc.

          // Cleaning Services Section
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Cleaning Services",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              TextButton(
                onPressed: () {
                  // This will work perfectly now
                  HomeScreen.homeKey.currentState?.setState(() {
                    HomeScreen.homeKey.currentState?._currentIndex = 1;
                  });
                },
                child: const Text(
                  "See All >",
                  style: TextStyle(color: Colors.green, fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
          // ... rest of your UI
        ],
      ),
    );
  }

  // Keep your _serviceItem and _cleaningCard methods here
}
 */