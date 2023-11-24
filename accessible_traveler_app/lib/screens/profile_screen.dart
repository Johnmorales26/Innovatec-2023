import 'package:accessible_traveler_app/utils/constants.dart';
import 'package:accessible_traveler_app/widgets/card_data.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class ProfileScreen extends StatelessWidget {
  Map<String, dynamic> profileData = {
    'photo': 'assets/images/img_photo.jpg',
    'nombre': 'Eddy Valdo Ruiz Bernal',
    'edad': 22,
    'ciudad': 'Ciudad de Mexico',
    'discapacidad': disavility
  };

  ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Perfil', style: GoogleFonts.lato()),
          backgroundColor: const Color(0xff0ee9c6)),
      body: disavility == visualDisavility
          ? _HearingScreen()
          : _VisibleScreen(profileData: profileData),
    );
  }
}

class _HearingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text('Hearing');
  }
}

class _VisibleScreen extends StatelessWidget {
  final Map<String, dynamic> profileData;

  const _VisibleScreen({required this.profileData});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(
            backgroundImage: AssetImage(profileData['photo']),
            radius: 80,
          ),
          CardData('Nombre', profileData['nombre']),
          CardData('Edad', profileData['edad'].toString()),
          CardData('Ciudad', profileData['ciudad']),
          CardData('Discapacidad', profileData['discapacidad']),
        ],
      ),
    );
  }
}
