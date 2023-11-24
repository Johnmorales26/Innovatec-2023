import 'dart:io';

import 'package:accessible_traveler_app/model/main_menu.dart';
import 'package:accessible_traveler_app/utils/speech.dart';
import 'package:accessible_traveler_app/widgets/box_instrutions.dart';
import 'package:accessible_traveler_app/widgets/box_instrutions_touch.dart';
import 'package:flutter/material.dart';
import 'package:accessible_traveler_app/utils/constants.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vibration/vibration.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<StatefulWidget> createState() => HomeState();
}

class HomeState extends State<HomeScreen> {
  List<MapEntry<String, String>> instructions = [
    const MapEntry(
        'assets/images/ic_long_press.png', 'Tap es para Agendar Cita'),
    const MapEntry('assets/images/ic_double_tap.png',
        'Doble tap es para ingresar al perfil'),
    const MapEntry('assets/images/ic_long_press.png',
        'Pellizca la pantalla para ayuda y soporte'),
    const MapEntry('assets/images/ic_long_press.png',
        'Arrastra hacia arriba cerrar sesión'),
    const MapEntry('assets/images/ic_long_press.png',
        'Arrastra hacia abajo para repetir las instrucciones'),
  ];

  List<MainMenu> instructionsHearing = [
    MainMenu(
        icon: 'assets/icons/ic_calendar.png',
        name: 'Agendar Cita',
        route: generateMedicalAppointment),
    MainMenu(
        icon: 'assets/icons/ic_profile.png',
        name: 'Perfil',
        route: profileScreen),
    MainMenu(
        icon: 'assets/icons/ic_support.png',
        name: 'Ayuda y Soporte',
        route: generateMedicalAppointment),
    MainMenu(
        icon: 'assets/icons/ic_logout.png',
        name: 'Cerrar Sesión',
        route: generateMedicalAppointment),
  ];

  void listen(int milliseconds) async {
    var hasVibrator = await Vibration.hasVibrator();
    var startVibrator = hasVibrator != null ? true : false;
    if (startVibrator) {
      Vibration.vibrate(duration: milliseconds);
    }
  }

  speechIndications() async {
    var instructionsSpeech = '';
    for (var instruction in instructions) {
      instructionsSpeech += '${instruction.value}, ';
    }
    speechIndicator(instructionsSpeech);
  }

  @override
  Widget build(BuildContext context) {
    Widget? presentedView;
    if (disavility == visualDisavility) {
      presentedView = visualDisavilityView();
    } else {
      presentedView = hearingDisavilityView();
    }
    return Scaffold(
      appBar: AppBar(
          title: Text('Home', style: GoogleFonts.lato()),
          backgroundColor: const Color(0xFF0EE9C6)),
      body: presentedView,
    );
  }

  Widget hearingDisavilityView() {
    return ListView.builder(
      itemCount: instructionsHearing.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: BoxInstructionsTouch(
              resource: instructionsHearing[index].icon,
              instruction: instructionsHearing[index].name,
              action: () => Navigator.of(context)
                  .pushNamed(instructionsHearing[index].route)),
        );
      },
    );
  }

  Widget visualDisavilityView() {
    speechIndications();
    return Center(
      child: GestureDetector(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // Número de columnas
                  mainAxisSpacing: 10.0, // Espacio vertical entre los elementos
                  crossAxisSpacing:
                      10.0, // Espacio horizontal entre los elementos
                ),
                itemCount:
                    instructions.length, // Cantidad de elementos en el grid
                itemBuilder: (context, index) {
                  return BoxInstructions(
                      resource: instructions[index].key,
                      instruction: instructions[index].value);
                },
              ),
            ),
          ),
          onTap: () =>
              Navigator.of(context).pushNamed(generateMedicalAppointment),
          onDoubleTap: () => listen(1000),
          onLongPress: () => speechIndications(),
          onScaleUpdate: (ScaleUpdateDetails details) =>
              speechIndicator('Te dirijes a ayuda y soporte'),
          onTertiaryTapUp: (TapUpDetails details) {
            speechIndicator('Nos vemos la próxima, maldito invalido');
            exit(0);
          },
          onHorizontalDragUpdate: (DragUpdateDetails details) {
            speechIndications();
          }),
    );
  }
}
