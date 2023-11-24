import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sistema_citas/models/medical_appointment_item.dart';
import 'package:sistema_citas/models/patient_model.dart';
import 'package:sistema_citas/service/appointment_detail_service.dart';
import 'package:sistema_citas/widgets/clinical_history_and_patient_data.dart';

class AppointmentDetailScreen extends StatelessWidget {
  const AppointmentDetailScreen({super.key, required this.uid});

  final String uid;

  @override
  Widget build(BuildContext context) {
    AppointmentDetailService service = AppointmentDetailService();
    return FutureBuilder<MedicalAppointmentModel?>(
      future: service.obtenerCitaMedicaPorId(
          uid), // Llama a la función para obtener los datos
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Muestra una pantalla de carga mientras se obtienen los datos
          return Scaffold(
            appBar: AppBar(title: Text(uid)),
            body: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (snapshot.hasError) {
          // Muestra un mensaje de error si ocurre un error
          return Scaffold(
            appBar: AppBar(title: Text(uid)),
            body: const Center(
              child: Text('Error al obtener la cita médica'),
            ),
          );
        } else if (!snapshot.hasData || snapshot.data == null) {
          // Si no se encuentran datos, muestra un mensaje de que no existe la cita
          return Scaffold(
            appBar: AppBar(title: Text(uid)),
            body: Center(
              child: Text('La cita médica con ID $uid no existe.'),
            ),
          );
        } else {
          // Si se obtienen datos exitosamente, muestra la información en la pantalla
          final appointment = snapshot.data!;

          return Scaffold(
            appBar: AppBar(title: Text(appointment.uid!)),
            body: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Fecha:',
                            style: GoogleFonts.poppins(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                        Text(appointment.date,
                            style: GoogleFonts.poppins(fontSize: 16)),
                        Text('Hora:',
                            style: GoogleFonts.poppins(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                        Text(appointment.time,
                            style: GoogleFonts.poppins(fontSize: 16)),
                        Text('Ubicación:',
                            style: GoogleFonts.poppins(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                        Text(appointment.ubication,
                            style: GoogleFonts.poppins(fontSize: 16)),
                        Text('Síntomas:',
                            style: GoogleFonts.poppins(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                        Text(appointment.symptoms,
                            style: GoogleFonts.poppins(fontSize: 16)),
                        Text('Emergencia Médica:',
                            style: GoogleFonts.poppins(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                        Text(appointment.medicalEmergency.name,
                            style: GoogleFonts.poppins(fontSize: 16)),
                        Text('Número de Oficina:',
                            style: GoogleFonts.poppins(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                        Text(appointment.officeNumber.toString(),
                            style: GoogleFonts.poppins(fontSize: 16)),
                        Text('Especialidad Médica:',
                            style: GoogleFonts.poppins(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                        Text(appointment.medicalSpeciality.name,
                            style: GoogleFonts.poppins(fontSize: 16)),
                        Text('Estado:',
                            style: GoogleFonts.poppins(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                        Text(appointment.status.name,
                            style: GoogleFonts.poppins(fontSize: 16)),
                        Text('Id Pasciente:',
                            style: GoogleFonts.poppins(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                        Text(appointment.idPatient,
                            style: GoogleFonts.poppins(fontSize: 16)),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: FutureBuilder<PatientModel?>(
                      // ignore: unnecessary_null_comparison
                      future: appointment.idPatient != null
                          ? service.getPatientData(appointment.idPatient)
                          : null,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const CircularProgressIndicator();
                        } else if (snapshot.hasError) {
                          return const Text(
                              'Error al cargar los datos del paciente');
                        } else {
                          final paciente = snapshot.data;
                          if (paciente != null) {
                            print('---> ${paciente.fullName}');
                            return ClinicalHistoryAndPatientData(
                              patient: paciente,
                            );
                          } else {
                            return const Text('Paciente no encontrado');
                          }
                        }
                      },
                    ),
                  ),
                )
              ],
            ),
          );
        }
      },
    );
  }
}
