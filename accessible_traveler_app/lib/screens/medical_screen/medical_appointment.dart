import 'dart:async';

import 'package:accessible_traveler_app/data/questions.dart';
import 'package:accessible_traveler_app/model/response.dart';
import 'package:accessible_traveler_app/utils/constants.dart';
import 'package:accessible_traveler_app/utils/remote.dart';
import 'package:accessible_traveler_app/utils/speech.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:speech_to_text/speech_to_text.dart' as speechToText;

class MedicalAppointmentScreen extends StatelessWidget {
  const MedicalAppointmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return disavility == visualDisavility
        ? _HearingScreen()
        : _VisibilityScreen();
  }
}

class _VisibilityScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _VisibilityState();
}

class _VisibilityState extends State<_VisibilityScreen> {
  final TextEditingController curpController = TextEditingController();
  final TextEditingController rfcController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController motherLastNameController =
      TextEditingController();
  final TextEditingController specialityController = TextEditingController();
  final TextEditingController consultingRoomController =
      TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController hourController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  var hiddenChat = false;
  String resource = 'assets/animations/gif_download.gif';
  String responseText = 'Agendando la cita';

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != selectedDate) {
      dateController.text =
          '${selectedDate.year}-${selectedDate.month}-${selectedDate.day}';
      setState(() {
        selectedDate = picked;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );

    if (picked != null && picked != selectedTime) {
      setState(() {
        selectedTime = picked;
        hourController.text = '${selectedTime.hour}:${selectedTime.minute}';
      });
    }
  }

  Widget _loadingAndSpeakingView() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(resource),
            Text(responseText,
                style:
                    GoogleFonts.lato(fontWeight: FontWeight.w800, fontSize: 20))
          ],
        ),
      ),
    );
  }

  Widget _formChat() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextField(
                controller: curpController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'CURP',
                )),
            const SizedBox(height: 16),
            TextField(
                controller: rfcController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'RFC',
                )),
            const SizedBox(height: 16),
            TextField(
                controller: nameController,
                keyboardType: TextInputType.name,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Nombre(s)',
                )),
            const SizedBox(height: 16),
            TextField(
                controller: lastNameController,
                keyboardType: TextInputType.name,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Apellido Paterno',
                )),
            const SizedBox(height: 16),
            TextField(
                controller: motherLastNameController,
                keyboardType: TextInputType.name,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Apellido Materno',
                )),
            const SizedBox(height: 16),
            /*TextField(
                controller: specialityController,
                keyboardType: TextInputType.name,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Especialidad',
                )),
            const SizedBox(height: 16),*/
            TextField(
                controller: consultingRoomController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Consultorio',
                )),
            const SizedBox(height: 16),
            TextField(
                controller: dateController,
                keyboardType: TextInputType.datetime,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Fecha',
                ),
                onTap: () => _selectDate(context)),
            const SizedBox(height: 16),
            TextField(
                controller: hourController,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Hora',
                ),
                onTap: () => _selectTime(context)),
            TextField(
                controller: specialityController,
                keyboardType: TextInputType.name,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Sintomas',
                )),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Future<void> speak(String text) async {
    setState(() {
      resource = 'assets/animations/gif_animation_speaking.gif';
    });
    speechIndicator(text);
  }

  void _sendData() async {
    var answers = [
      curpController.text,
      rfcController.text,
      nameController.text,
      lastNameController.text,
      motherLastNameController.text,
      consultingRoomController.text,
      dateController.text,
      hourController.text,
      specialityController.text,
    ];
    var data = cleanData(answers);
    var response = await sendDataToServer(data);
    var content = Response.fromJson(response);
    setState(() {
      resource = 'assets/animations/gif_folder.gif';
      responseText = content.content;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Agendar Cita Médica', style: GoogleFonts.lato()),
        backgroundColor: const Color(0xff0ee9c6),
      ),
      body: hiddenChat == false ? _formChat() : _loadingAndSpeakingView(),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          setState(() {
            resource = 'assets/animations/gif_download.gif';
            hiddenChat = true;
          });
          _sendData();
        },
        label: const Text('Enviar datos'),
        icon: const Icon(Icons.chat),
      ),
    );
  }
}

class _HearingScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HearingState();
}

class _HearingState extends State<_HearingScreen> {
  late speechToText.SpeechToText speech;
  bool isListening = false;
  List<String> answers = [];
  int currentQuestionIndex = 0;
  String imageResource = 'assets/animations/gif_animation_speaking.gif';
  String textIndicator = 'Desliza hacia abajo para cerrar el micrófono';

  @override
  void initState() {
    super.initState();
    speech = speechToText.SpeechToText();
    startWelcomeMessage();
  }

  Future<void> speak(String text) async {
    setState(() {
      imageResource = 'assets/animations/gif_animation_speaking.gif';
    });
    speechIndicator(text);
  }

  Future<String?> listen() async {
    setState(() {
      imageResource = 'assets/animations/gif_listening.gif';
    });
    bool available = await speech.initialize();
    if (available) {
      Completer<String?> completer = Completer<String?>();
      speech.listen(
        onResult: (result) {
          if (result.finalResult) {
            textIndicator = result.recognizedWords;
            completer.complete(result.recognizedWords);
          }
        },
      );
      return completer.future;
    } else {
      print('Reconocimiento de voz no disponible');
      return null;
    }
  }

  Future<void> startWelcomeMessage() async {
    String welcomeMessage =
        'Te damos la bienvenida al sistema de agenda de citas, donde el reconocimiento de voz te guiará para programar tu cita médica. '
        'Simplemente realiza un doble toque para comenzar a agendar tu consulta, desliza hacia la izquierda para salir al menú principal, '
        'desliza a la derecha para avanzar a la siguiente pregunta.';
    await speak(welcomeMessage);
  }

  Future<void> nextQuestion() async {
    if (currentQuestionIndex < questions.length) {
      String question = questions[currentQuestionIndex].question;
      setState(() {
        isListening = true;
        speak(question);
        Future.delayed(const Duration(milliseconds: 5000), () {
          listenAndSaveAnswer();
        });
      });
    } else {
      print('Todas las preguntas han sido respondidas');
      setState(() {
        isListening = false;
      });
      onQuestionsCompleted(); // Llamada a la función al finalizar las preguntas
    }
  }

  Future<void> listenAndSaveAnswer() async {
    String? answer = await listen();
    setState(() {
      isListening = false;
    });

    if (answer != null) {
      answers.add(answer);
      print('Respuesta capturada: $answer');
      currentQuestionIndex++;
      await nextQuestion();
    } else {
      print('No se reconoció ninguna respuesta.');
    }
  }

  Future<void> onQuestionsCompleted() async {
    // Lógica a realizar al finalizar todas las preguntas
    speak('Generando petición, espere un momento');
    setState(() {
      imageResource = 'assets/animations/gif_loading.gif';
      textIndicator = 'Generando petición, espere un momento';
    });
    var data = cleanData(answers);
    var response = await sendDataToServer(data);
    var content = Response.fromJson(response);
    textIndicator = content.content;
    await speak(content.content);
    // Puedes agregar más lógica aquí según tus necesidades
  }

  String formatAnswers(List<String> answers) {
    // Formatear las respuestas en un solo String
    String formattedAnswers = answers.join(', ');
    return formattedAnswers;
  }

  @override
  void dispose() {
    speech.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Agendar Cita Médica', style: GoogleFonts.lato()),
          backgroundColor: const Color(0xff0ee9c6)),
      body: GestureDetector(
        onDoubleTap: () async {
          await nextQuestion();
        },
        onVerticalDragUpdate: (details) {
          if (details.primaryDelta! > 0) {
            // Deslizamiento hacia abajo, cerrar el micrófono
            speech.stop();
          }
        },
        child: _Content(
            isListening: isListening,
            resource: imageResource,
            indicatorText: textIndicator),
      ),
    );
  }
}

class _Content extends StatelessWidget {
  final bool isListening;
  final String resource;
  final String indicatorText;

  const _Content(
      {required this.isListening,
      required this.resource,
      required this.indicatorText});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(resource),
              const SizedBox(height: 16),
              Text(indicatorText,
                  style: GoogleFonts.lato(
                      fontWeight: FontWeight.w500, fontSize: 20),
                  textAlign: TextAlign.justify)
            ],
          ),
        ),
      ),
    );
  }
}
