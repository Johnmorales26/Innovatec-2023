import 'package:flutter/material.dart';
import 'package:sistema_citas/utils/constants.dart';
import 'package:sistema_citas/widgets/mobile_login_layout.dart';
import 'package:sistema_citas/widgets/web_login_layout.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isTabletLayout = MediaQuery.of(context).size.width >= 600;
    return isTabletLayout
        ? WebLogInLayout(callback: () {
            Navigator.pushReplacementNamed(context,MEDICAL_APPOINTMENTS_SCREEN);
          })
        : MobileLoginLayout(callback: () {
            Navigator.pushReplacementNamed(context, PENDING_APPOINTMENTS_SCREEN);
          });
  }
}
