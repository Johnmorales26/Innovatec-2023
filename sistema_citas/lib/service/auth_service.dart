import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sistema_citas/models/patient_model.dart';

class AuthService {
  User? getCurrentUser() {
    // Obtén el usuario actual
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      // El usuario está autenticado, puedes acceder a sus datos
      return user;
    }
    return null;
  }

  Future<void> registerUser(
      String email, String password, PatientModel patient, Function callback) async {
    try {
      // Crear un nuevo usuario con correo electrónico y contraseña
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      // Si el registro es exitoso, el usuario estará autenticado automáticamente.
      // Puedes acceder al usuario actual con FirebaseAuth.instance.currentUser.
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        print('Registro exitoso. Usuario ID: ${user.uid}');
        patient.uid = user.uid;
        await FirebaseFirestore.instance
            .collection('patients')
            .doc(user.uid)
            .set(patient.toJson());
        callback();
      } else {
        print('No se pudo obtener el usuario después del registro.');
      }
    } catch (e) {
      // Manejar errores de registro, por ejemplo, mostrar un mensaje de error al usuario.
      print('Error durante el registro: $e');
    }
  }

  Future<void> signInWithEmailAndPassword(
      String email, String password, Function callback) async {
    try {
      // Iniciar sesión con correo electrónico y contraseña
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Si el inicio de sesión es exitoso, el usuario estará autenticado automáticamente.
      // Puedes acceder al usuario actual con FirebaseAuth.instance.currentUser.
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        print('Inicio de sesión exitoso. Usuario ID: ${user.uid}');
        callback();
      } else {
        print('No se pudo obtener el usuario después del inicio de sesión.');
      }
    } catch (e) {
      // Manejar errores de inicio de sesión, por ejemplo, mostrar un mensaje de error al usuario.
      print('Error durante el inicio de sesión: $e');
    }
  }
}
