import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sistema_citas/widgets/form_login.dart';

class MobileLoginLayout extends StatelessWidget {
  final Function callback;

  const MobileLoginLayout({super.key, required this.callback});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Sign up',
              style: GoogleFonts.poppins(
                  fontSize: 30, fontWeight: FontWeight.normal)),
        ),
        body: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Center(
            child: FormLogin(callback: () {
              callback();
            }),
          ),
        ));
  }
}
