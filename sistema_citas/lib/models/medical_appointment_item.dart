import 'package:sistema_citas/models/medical_emergency.dart';
import 'package:sistema_citas/models/medical_speciality.dart';
import 'package:sistema_citas/models/status.dart';

class MedicalAppointmentModel {
  String? uid;
  final String date;
  final String time;
  final String ubication;
  final String symptoms;
  final MedicalEmergency medicalEmergency;
  final int officeNumber;
  final MedicalSpeciality medicalSpeciality;
  final Status status;
  final String idPatient;

  MedicalAppointmentModel(
      {required this.uid,
      required this.date,
      required this.time,
      required this.ubication,
      required this.symptoms,
      required this.medicalEmergency,
      required this.officeNumber,
      required this.medicalSpeciality,
      required this.status,
      required this.idPatient});

  factory MedicalAppointmentModel.fromJson(Map<String, dynamic> json) {
    final medicalEmergencyValue = getMedicalEmergency(json["medicalEmergency"]);
    final medicalSpecialityValue =
        getMedicalSpeciality(json["medicalSpeciality"]);
    final status = getStatusFromString(json['status']);
    return MedicalAppointmentModel(
        uid: null,
        date: json["date"],
        time: json["time"],
        ubication: json["ubication"],
        symptoms: json["symptoms"],
        medicalEmergency: medicalEmergencyValue,
        officeNumber: json["officeNumber"],
        medicalSpeciality: medicalSpecialityValue,
        status: status,
        idPatient: json['idPatient']);
  }

  Map<String, dynamic> toJson() {
    return {
      'date': date,
      'time': time,
      'ubication': ubication,
      'symptoms': symptoms,
      'medicalEmergency': medicalEmergency.name,
      'officeNumber': officeNumber,
      'medicalSpeciality': medicalSpeciality.name,
      'status': status.name,
      'idPatient': idPatient
    };
  }

  static MedicalEmergency getMedicalEmergency(String value) {
    switch (value) {
      case 'Low':
        return MedicalEmergency.Low;
      case 'Medium':
        return MedicalEmergency.Medium;
      default:
        return MedicalEmergency.High;
    }
  }

  static Status getStatusFromString(String statusString) {
    switch (statusString) {
      case 'Backlog':
        return Status.Backlog;
      case 'Waiting':
        return Status.Waiting;
      case 'InProgress':
        return Status.InProgress;
      case 'Completed':
        return Status.Completed;
      default:
        throw Exception('Estado no válido: $statusString');
    }
  }

  static MedicalSpeciality getMedicalSpeciality(String value) {
    switch (value) {
      case 'General_Medicine':
        return MedicalSpeciality.General_Medicine;
      case 'Pediatrics':
        return MedicalSpeciality.Pediatrics;
      case 'Gynecology':
        return MedicalSpeciality.Gynecology;
      case 'Obstetrics':
        return MedicalSpeciality.Obstetrics;
      case 'General_Surgery':
        return MedicalSpeciality.General_Surgery;
      case 'Cardiology':
        return MedicalSpeciality.Cardiology;
      case 'Dermatology':
        return MedicalSpeciality.Dermatology;
      case 'Ophthalmology':
        return MedicalSpeciality.Ophthalmology;
      case 'Otorhinolaryngology':
        return MedicalSpeciality.Otorhinolaryngology;
      case 'Neurology':
        return MedicalSpeciality.Neurology;
      case 'Psychiatry':
        return MedicalSpeciality.Psychiatry;
      case 'Orthopedics':
        return MedicalSpeciality.Orthopedics;
      case 'Urology':
        return MedicalSpeciality.Urology;
      case 'Endocrinology':
        return MedicalSpeciality.Endocrinology;
      case 'Gastroenterology':
        return MedicalSpeciality.Gastroenterology;
      case 'Nephrology':
        return MedicalSpeciality.Nephrology;
      case 'Rheumatology':
        return MedicalSpeciality.Rheumatology;
      case 'Hematology':
        return MedicalSpeciality.Hematology;
      case 'Infectology':
        return MedicalSpeciality.Infectology;
      case 'Radiology':
        return MedicalSpeciality.Radiology;
      case 'Anesthesiology':
        return MedicalSpeciality.Anesthesiology;
      case 'Physical_Medicine_Rehabilitation':
        return MedicalSpeciality.Physical_Medicine_Rehabilitation;
      case 'Oncology':
        return MedicalSpeciality.Oncology;
      case 'Emergency_Medicine':
        return MedicalSpeciality.Emergency_Medicine;
      case 'Internal_Medicine':
        return MedicalSpeciality.Internal_Medicine;
      default:
        return MedicalSpeciality.General_Medicine;
    }
  }
}