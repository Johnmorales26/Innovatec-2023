import 'package:flutter/material.dart';
import 'package:sistema_citas/widgets/form_signin.dart';

class WebSignInLayout extends StatelessWidget {
  final Function callback;

  const WebSignInLayout({super.key, required this.callback});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign In'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: _Body(callback: () {
          callback();
        }),
      ),
    );
  }
}

class _Body extends StatelessWidget {
  final Function callback;

  const _Body({required this.callback});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: FormSignIn(callback: () {
          callback();
        })),
        const SizedBox(width: 24),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: const Color(0xff000842),
              borderRadius: BorderRadius.circular(16),
            ),
            height: double.infinity,
            child: Image.asset('assets/images/img_singin.png'),
          ),
        ),
      ],
    );
  }
}