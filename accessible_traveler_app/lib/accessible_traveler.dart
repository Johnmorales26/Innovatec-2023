import 'package:accessible_traveler_app/screens/home_screen.dart';
import 'package:accessible_traveler_app/screens/medical_screen/medical_appointment.dart';
import 'package:accessible_traveler_app/screens/profile_screen.dart';
import 'package:accessible_traveler_app/utils/constants.dart';
import 'package:flutter/material.dart';

class AccessibleTraveler extends StatelessWidget {
  const AccessibleTraveler({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AccessibleTraveler',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xff0ee9c6)),
        useMaterial3: true,
      ),
      initialRoute: homeScreen,
      routes: {
        homeScreen: (_) => const HomeScreen(),
        generateMedicalAppointment: (_) => const MedicalAppointmentScreen(),
        profileScreen: (_) => ProfileScreen(),
      },
    );
  }
}