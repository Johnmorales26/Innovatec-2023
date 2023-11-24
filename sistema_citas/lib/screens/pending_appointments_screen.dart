import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sistema_citas/screens/medical_appointment_list_screen.dart';
import 'package:sistema_citas/screens/profile_screen.dart';
import 'package:sistema_citas/utils/constants.dart';

class PendingAppointmentsScreen extends StatefulWidget {
  const PendingAppointmentsScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _PendingAppointmentsState();
}

class _PendingAppointmentsState extends State<PendingAppointmentsScreen> {
  int screenIndex = 0;

  void handleScreenChanged(int selectedScreen) {
    setState(() {
      screenIndex = selectedScreen;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.pushNamed(context,
              CHAT_SCREEN); // Utiliza la ruta desde el archivo de rutas
        },
      ),
      body: IndexedStack(
        index: screenIndex,
        children: const [
          MedicalAppointmentListScreen(), // Usa el widget MedicalAppointmentListScreen
          ProfileScreen(), // Usa el widget ProfileScreen
        ],
      ),
      bottomNavigationBar: buildNavigationBar(),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      title: Text(
        'Citas Pendientes',
        style: GoogleFonts.poppins(fontSize: 30),
      ),
    );
  }

  Widget buildNavigationBar() {
    return BottomNavigationBar(
      currentIndex: screenIndex,
      onTap: handleScreenChanged,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.alarm_outlined),
          label: 'Citas',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_2_outlined),
          label: 'Perfil',
        ),
      ],
    );
  }
}
