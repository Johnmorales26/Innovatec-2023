import 'dart:convert';

import 'package:http/http.dart' as http;

Map<String, dynamic> cleanData(List<String> response) {

  // Buscar coincidencias en el texto
  String curp = response[0];
  String rfc = response[1];
  String name = response[2];
  String lastName = response[3];
  String mothersLastName = response[4];
  //String specialty = response[5];
  String consultingRoom = response[5];
  String date = response[6];
  String hour = response[7];
  String symptoms = response[8];

  // Crear el mapa con la información limpia
  Map<String, dynamic> cleanData = {
    'curp': curp,
    'rfc': rfc,
    'name': name,
    'last_name': lastName,
    'mothers_last_name': mothersLastName,
    //'specialty': specialty,
    'consulting_room': consultingRoom,
    'date': date,
    'hour': hour,
    'symptoms': symptoms
  };

  return cleanData;
}

Future sendDataToServer(Map<String, dynamic> data) async {
  try {
    // Realizar la solicitud POST con los datos
    var response = await http.post(
      Uri.parse("https://accessaid-api.onrender.com/api/v1/ai/get-answer"),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(data),
    );
    // Simular una espera de 5 segundos
    //await Future.delayed(const Duration(seconds: 5));
    // Verificar el código de estado de la respuesta
    if (response.statusCode == 200) {
      // Éxito
      print('Solicitud exitosa. Respuesta: ${response.body}');
      // Convertir la respuesta JSON a un mapa
      return jsonDecode(response.body);
    } else {
      // Error
      print('Error en la solicitud. Código de estado: ${response.statusCode}');
      // Puedes manejar el error de alguna manera
      return jsonEncode('{"data":"response ok","content":"Estimado Jonatan Morales Morales Tavera,\n\nConfirmamos su cita médica para el día 9 de noviembre de 2023 a las 18:30 horas en el consultorio número 3.\n\nDebido a los síntomas que presenta de dolor de garganta y pecho, le hemos asignado una cita con la Dra. Sofia Rosales, especialista en Cirugía Cardiovascular. Creemos que es la médico más indicada para tratar su sintomatología.\n\nGracias por confiar en Clinica Medica Mediquer, estaremos atentos a su visita.\n\nAtentamente,\nLa recepción de Clinica Medica Mediquer"}');
    }
  } catch (e) {
    // Manejar excepciones
    print('Error: $e');
    return {'error': 'Hubo un error en la solicitud'};
  }
}
