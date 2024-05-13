import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: const TextSpan(
        text: 'Wallpaper',
        style: TextStyle(
          color: Colors.black,
          fontSize: 20,
          fontWeight: FontWeight.w600,
          fontFamily: 'my',
        ),
        children: [
          TextSpan(
            text: 'ify',
            style: TextStyle(
              color: Color(0xFFFF007B),
              fontSize: 20,
              fontWeight: FontWeight.w600,
              fontFamily: 'my',
            ),
          ),
        ],
      ),
    );
  }
}
