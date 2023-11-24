import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:sistema_citas/models/medical_appointment_item.dart';
import 'package:sistema_citas/service/auth_service.dart';

class FirestoreService {
  Future<List<MedicalAppointmentModel>> fetchMedicalAppointments(String? uid) async {
    var authService = AuthService();
    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection('medical_appointment')
          .where('idPatient',
              isEqualTo: authService
                  .getCurrentUser()
                  ?.uid) // Filtrar por el parámetro uid
          .get();

      final medicalAppointments = querySnapshot.docs.map((doc) {
        final json = doc.data();
        final appointment = MedicalAppointmentModel.fromJson(json);
        appointment.uid = doc.id;
        return appointment;
      }).toList();

      return medicalAppointments;
    } catch (e) {
      return [];
    }
  }

  Future<void> uploadMedicalAppointmentToFirebase(
    MedicalAppointmentModel citaMedica) async {
  CollectionReference medicalAppointment =
      FirebaseFirestore.instance.collection('medical_appointment');
  await Firebase.initializeApp();
  return medicalAppointment
      .add(citaMedica.toJson())
      .then((value) => print("User Added"))
      .catchError((error) => print("Failed to add user: $error"));
}

Future<List<MedicalAppointmentModel>> getMedicalAppointmentData() async {
  try {
    final querySnapshot = await FirebaseFirestore.instance
        .collection('medical_appointment')
        .get();
    final medicalAppointments = querySnapshot.docs.map((doc) {
      final json = doc.data();
      final appointment = MedicalAppointmentModel.fromJson(json);
      appointment.uid = doc.id;
      print(appointment.toJson().toString());
      return appointment;
    }).toList();
    return medicalAppointments;
  } catch (e) {
    print('Error al obtener datos: $e');
    return [];
  }
}
}
