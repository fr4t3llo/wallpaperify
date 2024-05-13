import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:wallpaperify/views/screens/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wallpaperify',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const WelcomeScreen(), // Set WelcomeScreen as the initial screen
    );
  }
}

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
                'assets/images/back2.png'), // Replace with your image asset
            fit: BoxFit.fill,
          ),
        ),
        child: Stack(
          children: [
            const Spacer(), // Add this Spacer
            Align(
              alignment: const Alignment(0, 0.5), // Center horizontally
              child: Column(
                mainAxisSize: MainAxisSize.min, // Set mainAxisSize to min
                children: [
                  const Text(
                    'Explore the Magic',
                    style: TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 255, 255, 255),
                        fontFamily: 'my'),
                  ),
                  const SizedBox(
                      height:
                          20), // Add some space between the text and the button
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HomeScreen()),
                      );
                    },
                    label: const Text(
                      'Get Started',
                      style: TextStyle(
                          fontFamily: 'my',
                          fontWeight: FontWeight.bold,
                          fontSize: 19),
                    ),
                    icon: const Icon(Iconsax.arrow_right5, size: 24),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(
                          255, 31, 236, 232), // Button background color
                      foregroundColor:
                          Color.fromARGB(255, 6, 6, 6), // Button text color
                      elevation: 5,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
