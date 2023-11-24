import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sistema_citas/models/patient_model.dart';
import 'package:sistema_citas/service/appointment_detail_service.dart';
import 'package:sistema_citas/service/auth_service.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _birthDateController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _maritalStatusController =
      TextEditingController();
  Future<PatientModel?>? _patientFuture;
  var appointmentDetailService = AppointmentDetailService();
  var authService = AuthService();

  @override
  void initState() {
    super.initState();
    _loadPatientData();
  }

  void _loadPatientData() {
    User? currentUser = authService.getCurrentUser();
    if (currentUser != null) {
      _patientFuture = appointmentDetailService.getPatientData(currentUser.uid);
    }
  }

  void _clearControllers() {
    _fullNameController.clear();
    _birthDateController.clear();
    _genderController.clear();
    _addressController.clear();
    _phoneNumberController.clear();
    _maritalStatusController.clear();
  }

  void _showEditDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Editar Datos'),
          content: const Text(
              'Estás a punto de editar los datos. ¿Deseas continuar?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Cierra el diálogo
              },
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                updatePatientData(PatientModel(
                  uid: authService.getCurrentUser()!.uid,
                  fullName: _fullNameController.text,
                  birthDate: _birthDateController.text,
                  gender: _genderController.text,
                  address: _addressController.text,
                  phoneNumber: _phoneNumberController.text,
                  maritalStatus: _maritalStatusController.text,
                  emergencyContact: null,
                  medicalHistory: null,
                  currentIllness: null,
                  physicalExam: null,
                  testResults: null,
                  diagnosis: null,
                  treatmentPlan: null,
                  followUp: null,
                ));
                Navigator.of(context).pop(); // Cierra el diálogo
              },
              child: const Text('Editar'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<PatientModel?>(
        future: _patientFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(
              child: Text('Error al cargar los datos del paciente'),
            );
          } else {
            final patient = snapshot.data;

            if (patient == null) {
              return const Center(
                child: Text('No se encontraron datos del paciente'),
              );
            }

            // Limpia los controladores cuando se actualizan los datos
            _clearControllers();

            // Llena los controladores con los datos del paciente
            _fullNameController.text = patient.fullName;
            _birthDateController.text = patient.birthDate;
            _genderController.text = patient.gender;
            _addressController.text = patient.address;
            _phoneNumberController.text = patient.phoneNumber;
            _maritalStatusController.text = patient.maritalStatus;

            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  TextField(
                    controller: _fullNameController,
                    decoration: const InputDecoration(
                        labelText: 'Nombre Completo',
                        border: OutlineInputBorder()),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _birthDateController,
                    decoration: const InputDecoration(
                      labelText: 'Fecha de Nacimiento',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _genderController,
                    decoration: const InputDecoration(
                      labelText: 'Género',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _addressController,
                    decoration: const InputDecoration(
                      labelText: 'Dirección de Contacto',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _phoneNumberController,
                    decoration: const InputDecoration(
                      labelText: 'Número de Teléfono',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _maritalStatusController,
                    decoration: const InputDecoration(
                      labelText: 'Estado Civil',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _showEditDialog,
                    child: const Text('Editar Datos'),
                  )
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
