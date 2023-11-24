import 'package:flutter/material.dart';
import 'package:sistema_citas/models/medical_appointment_item.dart';
import 'package:sistema_citas/models/medical_emergency.dart';
import 'package:sistema_citas/screens/appointent_detail_screen.dart';

class ItemMedicalAppointment extends StatelessWidget {
  const ItemMedicalAppointment({
    Key? key,
    required this.medicalAppointmentItem,
  }) : super(key: key);

  final MedicalAppointmentModel medicalAppointmentItem;

  // Mapa para asociar MedicalEmergency con la ruta de la imagen.
  static const Map<MedicalEmergency, String> emergencyImagePaths = {
    MedicalEmergency.Low: 'ic_medical_emergency_low.png',
    MedicalEmergency.Medium: 'ic_medical_emergency_medium.png',
    MedicalEmergency.High: 'ic_medical_emergency_high.png',
  };

  @override
  Widget build(BuildContext context) {
    final String imageEmergency =
        'assets/images/${emergencyImagePaths[medicalAppointmentItem.medicalEmergency] ?? 'default_image.png'}';

    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                AppointmentDetailScreen(uid: medicalAppointmentItem.uid!),
          ),
        );
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('ID Cita: ${medicalAppointmentItem.uid!}'),
                    const SizedBox(height: 16),
                    Text('Status: ${medicalAppointmentItem.status.name}'),
                    const SizedBox(height: 16),
                    Text('Hora: ${medicalAppointmentItem.time}'),
                    const SizedBox(height: 16),
                    Text('Fecha: ${medicalAppointmentItem.date}')
                  ],
                ),
              ),
              const SizedBox(width: 16),
              SizedBox(
                child: Image.asset(imageEmergency, width: 80, height: 80),
              ),
            ],
          ),
        ),
      ),
    );
  }
}