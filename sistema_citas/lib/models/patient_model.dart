// crear registro paciente
import 'package:cloud_firestore/cloud_firestore.dart';

class PatientModel {
  String uid;
  String fullName;
  String birthDate;
  String gender;
  String address;
  String phoneNumber;
  String maritalStatus;
  Map<String, dynamic>? emergencyContact;
  Map<String, dynamic>? medicalHistory;
  Map<String, dynamic>? currentIllness;
  Map<String, dynamic>? physicalExam;
  Map<String, dynamic>? testResults;
  String? diagnosis;
  Map<String, dynamic>? treatmentPlan;
  Map<String, dynamic>? followUp;

  PatientModel({
    required this.uid,
    required this.fullName,
    required this.birthDate,
    required this.gender,
    required this.address,
    required this.phoneNumber,
    required this.maritalStatus,
    this.emergencyContact,
    this.medicalHistory,
    this.currentIllness,
    this.physicalExam,
    this.testResults,
    this.diagnosis,
    this.treatmentPlan,
    this.followUp,
  });

  // Método para convertir el objeto Patient en un mapa (JSON)
  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'fullName': fullName,
      'birthDate': birthDate,
      'gender': gender,
      'address': address,
      'phoneNumber': phoneNumber,
      'maritalStatus': maritalStatus,
      'emergencyContact': emergencyContact,
      'medicalHistory': medicalHistory,
      'currentIllness': currentIllness,
      'physicalExam': physicalExam,
      'testResults': testResults,
      'diagnosis': diagnosis,
      'treatmentPlan': treatmentPlan,
      'followUp': followUp,
    };
  }

  factory PatientModel.fromJson(Map<String, dynamic> json) {
    print('Json ----> ${json}');
    return PatientModel(
      uid: json['uid'] as String,
      fullName: json['fullName'] as String? ?? '',
      birthDate: json['birthDate'] as String? ?? '',
      gender: json['gender'] as String? ?? '',
      address: json['address'] as String? ?? '',
      phoneNumber: json['phoneNumber'] as String? ?? '',
      maritalStatus: json['maritalStatus'] as String? ?? '',
      emergencyContact: json['emergencyContact'] as Map<String, dynamic>? ?? {},
      medicalHistory: json['medicalHistory'] as Map<String, dynamic>? ?? {},
      currentIllness: json['currentIllness'] as Map<String, dynamic>? ?? {},
      physicalExam: json['physicalExam'] as Map<String, dynamic>? ?? {},
      testResults: json['testResults'] as Map<String, dynamic>? ?? {},
      diagnosis: json['diagnosis'] as String?,
      treatmentPlan: json['treatmentPlan'] as Map<String, dynamic>? ?? {},
      followUp: json['followUp'] as Map<String, dynamic>? ?? {},
    );
  }
}



Future<void> updatePatientData(PatientModel patient) async {
  try {
    final patientReference = FirebaseFirestore.instance
        .collection('patients')
        .doc(patient.uid);

    await patientReference.update(patient.toJson());
    print('Datos del paciente actualizados con éxito');
  } catch (e) {
    print('Error al actualizar los datos del paciente: $e');
  }
}

