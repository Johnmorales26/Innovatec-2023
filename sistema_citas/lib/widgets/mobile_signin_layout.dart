import 'package:flutter/material.dart';
import 'package:sistema_citas/widgets/form_signin.dart';

class MobileSignInLayout extends StatelessWidget {
  final Function callback;

  const MobileSignInLayout({super.key, required this.callback});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: FormSignIn(callback: () {
          callback();
        }),
      ),
    );
  }
}