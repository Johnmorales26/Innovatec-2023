import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sistema_citas/models/patient_model.dart';
import 'package:sistema_citas/service/auth_service.dart';
import 'package:sistema_citas/utils/constants.dart';

class FormSignIn extends StatelessWidget {
  final Function callback;

  FormSignIn({super.key, required this.callback});

  final authService = AuthService();

  // Controladores para los TextField
  final TextEditingController emailController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController birthdayController = TextEditingController();
  final TextEditingController genderController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController phonenumberController = TextEditingController();
  final TextEditingController maritalstatusController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController passwordCopyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 48),
          Text('If you already have an account, register',
              style: GoogleFonts.poppins(fontSize: 16)),
          Row(
            children: [
              Text('You can', style: GoogleFonts.poppins(fontSize: 16)),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, LOGIN_SCREEN);
                },
                child: Text('Login here !',
                    style: GoogleFonts.poppins(fontSize: 16)),
              ),
            ],
          ),
          const SizedBox(height: 48),
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
            controller: nameController,
            keyboardType: TextInputType.text,
            decoration: const InputDecoration(
              labelText: 'Enter your User name',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 24),
          TextField(
            controller: birthdayController,
            keyboardType: TextInputType.text,
            decoration: const InputDecoration(
              labelText: 'Enter your Birth Date',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 24),
          TextField(
            controller: genderController,
            keyboardType: TextInputType.text,
            decoration: const InputDecoration(
              labelText: 'Enter your Gender',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 24),
          TextField(
            controller: addressController,
            keyboardType: TextInputType.text,
            decoration: const InputDecoration(
              labelText: 'Enter your Address',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 24),
          TextField(
            controller: phonenumberController,
            keyboardType: TextInputType.text,
            decoration: const InputDecoration(
              labelText: 'Enter your Phone Number',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 24),
          TextField(
            controller: maritalstatusController,
            keyboardType: TextInputType.text,
            decoration: const InputDecoration(
              labelText: 'Enter your Marital Status',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 24),
          TextField(
            controller: passwordController,
            keyboardType: TextInputType.text,
            obscureText: true,
            decoration: const InputDecoration(
              labelText: 'Enter your Password',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 24),
          TextField(
            controller: passwordCopyController,
            keyboardType: TextInputType.text,
            obscureText: true,
            decoration: const InputDecoration(
              labelText: 'Confirm your Password',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 48),
          FilledButton(
            onPressed: () {
              if (passwordController.text == passwordCopyController.text) {
                authService.registerUser(
                  emailController.text,
                  passwordController.text,
                  PatientModel(
                      uid: "",
                      fullName: nameController.text,
                      birthDate: birthdayController.text,
                      gender: genderController.text,
                      address: addressController.text,
                      phoneNumber: phonenumberController.text,
                      maritalStatus: maritalstatusController.text),
                  () {
                    callback();
                  },
                );
              }
            },
            style: const ButtonStyle(),
            child: const Text('Sign In'),
          ),
        ],
      ),
    );
  }
}
