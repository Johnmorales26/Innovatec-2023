import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sistema_citas/models/medical_appointment_item.dart';

class MedicalAppointmentService {

  Future<List<MedicalAppointmentModel>> obtenerDatosNuevo() async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('medical_appointment')
          .get();
      final medicalAppointments = querySnapshot.docs
          .map((doc) {
            if (doc.exists) {
              final json = doc.data() as Map<String, dynamic>;
              // Validar que los campos requeridos no sean nulos
              if (json['date'] != null &&
                  json['time'] != null &&
                  json['ubication'] != null &&
                  json['symptoms'] != null &&
                  json['medicalEmergency'] != null &&
                  json['officeNumber'] != null &&
                  json['medicalSpeciality'] != null &&
                  json['status'] != null &&
                  json['idPatient'] != null) {
                final appointment = MedicalAppointmentModel.fromJson(json);
                appointment.uid = doc.id;
                return appointment;
              } else {
                print(
                    'Los datos de la cita médica con ID ${doc.id} son incompletos o nulos.');
                return null;
              }
            } else {
              print('Los datos de la cita médica con ID ${doc.id} son nulos.');
              return null;
            }
          })
          .where((appointment) => appointment != null)
          .toList();

      return medicalAppointments.cast<MedicalAppointmentModel>();
    } catch (e) {
      print('Error al obtener datos: $e');
      return [];
    }
  }
}
