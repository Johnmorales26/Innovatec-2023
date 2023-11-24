import 'package:flutter/material.dart';

class WebComplement extends StatelessWidget {
  const WebComplement({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Container(
      decoration: BoxDecoration(
          color: const Color(0xff000842),
          borderRadius: BorderRadius.circular(16)),
      height: double.infinity,
      child: Expanded(child: Image.asset('assets/images/img_singin.png')),
    ));
  }
}