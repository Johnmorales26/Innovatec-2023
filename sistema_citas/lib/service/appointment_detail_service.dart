import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sistema_citas/models/medical_appointment_item.dart';
import 'package:sistema_citas/models/patient_model.dart';

class AppointmentDetailService {
  Future<MedicalAppointmentModel?> obtenerCitaMedicaPorId(String citaId) async {
    try {
      final doc = await FirebaseFirestore.instance
          .collection('medical_appointment')
          .doc(citaId)
          .get();
      final json = doc.data();
      final appointment = MedicalAppointmentModel.fromJson(json!);
      appointment.uid = doc.id;
      return appointment;
    } catch (e) {
      return null;
    }
  }

  Future<PatientModel?> getPatientData(String pacienteId) async {
    try {
      final doc = await FirebaseFirestore.instance
          .collection('patients')
          .doc(pacienteId)
          .get();
      final json = doc.data();
      final appointment = PatientModel.fromJson(json!);
      appointment.uid = doc.id;
      return appointment;
    } catch (e) {
      return null;
    }
  }
}
