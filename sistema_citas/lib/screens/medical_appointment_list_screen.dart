import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sistema_citas/models/medical_appointment_item.dart';
import 'package:sistema_citas/service/auth_service.dart';
import 'package:sistema_citas/service/firetore_service.dart';

class MedicalAppointmentListScreen extends StatefulWidget {
  const MedicalAppointmentListScreen({Key? key}) : super(key: key);

  @override
  _MedicalAppointmentListScreenState createState() =>
      _MedicalAppointmentListScreenState();
}

class _MedicalAppointmentListScreenState
    extends State<MedicalAppointmentListScreen> {
  final AuthService authService = AuthService();
  final FirestoreService firestoreService = FirestoreService();

  User? currentUser;

  @override
  void initState() {
    super.initState();
    currentUser = authService.getCurrentUser();
  }

  Future<List<MedicalAppointmentModel>> fetchMedicalAppointments() async {
    if (currentUser != null) {
      try {
        return await firestoreService
            .fetchMedicalAppointments(currentUser?.uid);
      } catch (e) {
        print('Error al obtener las citas médicas: $e');
      }
    }
    return [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<MedicalAppointmentModel>>(
        future: fetchMedicalAppointments(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(
                child: Text('Error al cargar las citas médicas'));
          } else {
            final medicalAppointments = snapshot.data;
            if (medicalAppointments!.isEmpty) {
              return const Center(
                  child: Text(
                      'No se encontraron citas médicas para este usuario.'));
            } else {
              return ListView.builder(
                itemCount: medicalAppointments.length,
                itemBuilder: (context, index) {
                  final appointment = medicalAppointments[index];
                  return ListTile(
                    title: Text(
                        'Fecha: ${appointment.date} - Hora: ${appointment.time}'),
                    subtitle: Text(
                        'Especialidad: ${appointment.medicalSpeciality.name}'),
                  );
                },
              );
            }
          }
        },
      ),
    );
  }
}
