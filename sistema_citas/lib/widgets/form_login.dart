import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sistema_citas/service/auth_service.dart';
import 'package:sistema_citas/utils/constants.dart';
import 'package:sistema_citas/utils/utils.dart';

class FormLogin extends StatelessWidget {
  final Function callback;

  FormLogin({super.key, required this.callback});

  final authService = AuthService();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text('If you don’t have an account register',
            style: GoogleFonts.poppins(fontSize: 16)),
        Row(children: [
          Text('You can', style: GoogleFonts.poppins(fontSize: 16)),
          const SizedBox(width: 4),
          TextButton(
              onPressed: () {
                Navigator.pushNamed(context, SIGN_IN_SCREEN);
              },
              child: Text('Login here !',
                  style: GoogleFonts.poppins(fontSize: 16))),
        ]),
        const SizedBox(height: 24),
        TextField(
          controller: emailController,
          keyboardType: TextInputType.emailAddress,
          decoration: const InputDecoration(
            labelText: 'Enter your email address',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 24),
        TextField(
          controller: passwordController,
          obscureText: true,
          keyboardType: TextInputType.text,
          decoration: const InputDecoration(
            labelText: 'Enter your Password',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 48),
        FilledButton(
          onPressed: () {
            if (isValidEmail(emailController.text)) {
              authService.signInWithEmailAndPassword(
                emailController.text,
                passwordController.text,
                () {
                  callback();
                },
              );
            } else {
              print('Invalid email');
            }
          },
          style: const ButtonStyle(),
          child: const Text('Sign In'),
        )
      ],
    );
  }
}
