import 'package:flutter/material.dart';
import 'package:sistema_citas/widgets/mobile_signin_layout.dart';
import 'package:sistema_citas/widgets/web_signin_layout.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isTabletLayout = MediaQuery.of(context).size.width >= 600;
    return isTabletLayout
        ? WebSignInLayout(callback: () {
            Navigator.pushReplacementNamed(context, 'medical_appointments');
          })
        : MobileSignInLayout(callback: () {
            Navigator.pushReplacementNamed(context, 'pending_appointments');
          });
  }
}