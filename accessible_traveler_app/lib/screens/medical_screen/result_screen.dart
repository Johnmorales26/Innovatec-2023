import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ResultsScreen extends StatelessWidget {
  const ResultsScreen(
      {super.key, required this.onRestart, required this.result});

  final String result;
  final void Function() onRestart;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: double.infinity,
        child: Container(
          margin: const EdgeInsets.all(24),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(result,
                    style: GoogleFonts.lato(
                        fontSize: 24, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center),
                const SizedBox(height: 30),
                TextButton.icon(
                    onPressed: () {
                      onRestart();
                    },
                    label: const Text('Restart Quiz'),
                    icon: const Icon(Icons.restart_alt),
                    style: TextButton.styleFrom(foregroundColor: Colors.white))
              ]),
        ));
  }
}
