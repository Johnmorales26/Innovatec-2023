import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sistema_citas/widgets/form_login.dart';
import 'package:sistema_citas/widgets/web_complement.dart';

class WebLogInLayout extends StatelessWidget {
  final Function callback;

  const WebLogInLayout({super.key, required this.callback});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Sign in', style: GoogleFonts.poppins(fontSize: 30))),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 24),
                  FormLogin(callback: () {
                    callback();
                  })
                ],
              ),
            ),
            const SizedBox(width: 24),
            Expanded(
              flex: 1,
              child: Column(
                children: [
                  Expanded(
                    child: Container(
                      width: 735,
                      decoration: BoxDecoration(
                          color: const Color(0xff000842),
                          borderRadius: BorderRadius.circular(16)),
                      child: const WebComplement(),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}