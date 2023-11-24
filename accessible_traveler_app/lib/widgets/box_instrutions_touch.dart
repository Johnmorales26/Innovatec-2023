import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BoxInstructionsTouch extends StatelessWidget {
  final String resource;
  final String instruction;
  final Function action;

  const BoxInstructionsTouch(
      {super.key, required this.resource, required this.instruction, required this.action});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => action(),
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(24)),
          gradient: LinearGradient(
            colors: [
              Color(0xff44c4b6),
              Color(0xff0097cc),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ), // Color de fondo del elemento
        height: 150, // Altura del elemento
        width: double.infinity, // Ancho del elemento
        child: Center(
            child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(resource, height: 50, width: 50),
              const SizedBox(height: 16),
              Text(instruction, textAlign: TextAlign.center,style: GoogleFonts.lato(
                fontSize: 16,
                fontWeight: FontWeight.w800
              ))
            ],
          ),
        )),
      ),
    );
  }
}
