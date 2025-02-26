import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:wallpaperify/views/screens/home.dart';
import 'package:wallpaperify/views/screens/privacy.dart';
import 'package:webview_flutter/webview_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Wallpaperify',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const WelcomeScreen(), // Set WelcomeScreen as the initial screen
    );
  }
}

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/back2.png'),
            fit: BoxFit.fill,
          ),
        ),
        child: Center(
          // Replace Stack with Center
          child: Column(
            mainAxisAlignment:
                MainAxisAlignment.center, // Center the content vertically
            children: [
              const Spacer(), // This pushes content down
              const Spacer(), // This pushes content down
              const Text(
                'Explore the Magic',
                style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 255, 255, 255),
                  fontFamily: 'my',
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const HomeScreen(),
                    ),
                  );
                },
                label: const Text(
                  'Get Started',
                  style: TextStyle(
                    fontFamily: 'my',
                    fontWeight: FontWeight.bold,
                    fontSize: 19,
                  ),
                ),
                icon: const Icon(Iconsax.arrow_right5, size: 24),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 31, 236, 232),
                  foregroundColor: const Color.fromARGB(255, 6, 6, 6),
                  elevation: 5,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 15,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PrivacyPolicyScreen(),
                    ),
                  );
                },
                label: const Text(
                  'Privacy Policy',
                  style: TextStyle(
                    fontFamily: 'my',
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
                icon: const Icon(Icons
                    .privacy_tip_outlined), // Added an icon for consistency
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.amber,
                  foregroundColor: const Color.fromARGB(255, 6, 6, 6),
                  elevation: 5,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 15,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const Spacer(), // This pushes content up from bottom
            ],
          ),
        ),
      ),
    );
  }
}
