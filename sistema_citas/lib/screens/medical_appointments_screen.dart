import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sistema_citas/models/medical_appointment_item.dart';
import 'package:sistema_citas/models/status.dart';
import 'package:sistema_citas/service/firetore_service.dart';
import 'package:sistema_citas/widgets/item_medical_appointment.dart';

class MedicalAppointmentsScreen extends StatelessWidget {
  const MedicalAppointmentsScreen({super.key});

  Widget buildTab(String title, Status status) {
    FirestoreService firestoreService = FirestoreService();
    return Column(
      children: [
        Expanded(
          child: FutureBuilder<List<MedicalAppointmentModel>>(
            future: firestoreService.getMedicalAppointmentData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              }

              final medicalAppointments = snapshot.data;

              if (medicalAppointments == null || medicalAppointments.isEmpty) {
                return const Text('No hay citas médicas disponibles.');
              }

              final filteredAppointments = medicalAppointments
                  .where((medicalAppointment) =>
                      medicalAppointment.status == status)
                  .toList();

              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount:
                      4, // Puedes ajustar el número de columnas aquí
                ),
                itemCount: filteredAppointments.length,
                itemBuilder: (context, index) {
                  final appointment = filteredAppointments[index];
                  return ItemMedicalAppointment(
                    medicalAppointmentItem: appointment,
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title:
              Text('Citas Médicas', style: GoogleFonts.poppins(fontSize: 30)),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Backlog'),
              Tab(text: 'Espera'),
              Tab(text: 'En Progreso'),
              Tab(text: 'Completado'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            buildTab('Backlog', Status.Backlog),
            buildTab('Espera', Status.Waiting),
            buildTab('En Progreso', Status.InProgress),
            buildTab('Completado', Status.Completed),
          ],
        ),
      ),
    );
  }
}