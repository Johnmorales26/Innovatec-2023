import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ResponseAIScreen extends StatelessWidget {
  const ResponseAIScreen({super.key, 
    required this.messageResponse,
    required this.color,
  });

  final String messageResponse;
  final String color;

  List<Color> _defineGradientColors(String color) {
    switch (color.toLowerCase()) {
      case 'roja':
        return [const Color(0xffffa38c), const Color(0xffff593a)];
      case 'amarilla':
        return [const Color(0xfff6f294), const Color(0xffefe942)];
      default:
        return [const Color(0xffadfa9e), const Color(0xff84f671)];
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<Color> colors = _defineGradientColors(color);

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: colors),
        ),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Center(
            child: Text(
              messageResponse,
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

