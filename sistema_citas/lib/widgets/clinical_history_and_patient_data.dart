import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sistema_citas/models/patient_model.dart';
import 'package:sistema_citas/widgets/user_data.dart';

class ClinicalHistoryAndPatientData extends StatelessWidget {
  const ClinicalHistoryAndPatientData({super.key, required this.patient});

  final PatientModel patient;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: const Color(0xff000842),
          borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Información Personal del Paciente:',
                style: GoogleFonts.poppins(
                    fontSize: 20, color: const Color(0xfff5f5f5))),
            Padding(
                padding: const EdgeInsets.all(16),
                child: Column(children: [
                  UserData(label: "Nombre: ", value: patient.fullName),
                  UserData(
                      label: "Fecha de Nacimiento: ",
                      value: patient.birthDate.toString()),
                  UserData(label: "Género: ", value: patient.gender),
                  UserData(
                      label: "Dirección de Contacto: ", value: patient.address),
                  UserData(
                      label: "Número de Teléfono: ",
                      value: patient.phoneNumber),
                  UserData(
                      label: "Estado Civil: ", value: patient.maritalStatus),
                ])),
            Text('Historia Medica:',
                style: GoogleFonts.poppins(
                    fontSize: 20, color: const Color(0xfff5f5f5))),
            Text('Registro de Enfermedades Actuales:',
                style: GoogleFonts.poppins(
                    fontSize: 20, color: const Color(0xfff5f5f5))),
            Text('Examen Fisico:',
                style: GoogleFonts.poppins(
                    fontSize: 20, color: const Color(0xfff5f5f5))),
            Text('Resultado de Pruebas Diagnósticas:',
                style: GoogleFonts.poppins(
                    fontSize: 20, color: const Color(0xfff5f5f5))),
            Text('Diagnostico Médico:',
                style: GoogleFonts.poppins(
                    fontSize: 20, color: const Color(0xfff5f5f5))),
            Text('Resultado de Pruebas Diagnósticas:',
                style: GoogleFonts.poppins(
                    fontSize: 20, color: const Color(0xfff5f5f5))),
            Text('Plan de Tratamiento:',
                style: GoogleFonts.poppins(
                    fontSize: 20, color: const Color(0xfff5f5f5))),
            Text('Seguimiento y Recomendaciones:',
                style: GoogleFonts.poppins(
                    fontSize: 20, color: const Color(0xfff5f5f5))),
            Text('Notas del Medico:',
                style: GoogleFonts.poppins(
                    fontSize: 20, color: const Color(0xfff5f5f5)))
          ],
        ),
      ),
    );
  }
}
