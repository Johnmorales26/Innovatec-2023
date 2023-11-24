import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UserData extends StatelessWidget {
  final String label;
  final String value;

  const UserData({
    super.key,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          label,
          style:
              GoogleFonts.poppins(color: const Color(0xffdedede), fontSize: 16),
        ),
        const SizedBox(width: 16),
        Text(
          value,
          style:
              GoogleFonts.poppins(color: const Color(0xfff5f5f5), fontSize: 16),
        )
      ],
    );
  }
}
