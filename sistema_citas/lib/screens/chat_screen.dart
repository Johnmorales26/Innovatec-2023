import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sistema_citas/models/message_model.dart';
import 'package:sistema_citas/models/sender_rol.dart';
import 'package:sistema_citas/screens/response_ai_screen.dart';
import 'package:sistema_citas/widgets/item_message.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final List<MessageModel> _messages = [];
  int preguntaActualIndex = 0;
  String prompt = "";

  final List<String> preguntas = [
    '¿Cual es su edad?',
    '¿Puede describir sus síntomas en detalle?',
    '¿Cómo calificaría la intensidad de su dolor o malestar en una escala del 1 al 10?',
    '¿Cuándo comenzaron sus síntomas o problemas de salud actuales?',
    '¿Qué medicamentos toma actualmente, incluyendo recetas médicas, suplementos o medicamentos de venta libre?',
    '¿Los síntomas han empeorado o mejorado desde que comenzaron?',
    '¿Tiene alguna enfermedad crónica o afección médica conocida?',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lua'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Expanded(
              child: ListView.builder(
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  return ItemMessage(
                    messageEntity: _messages.reversed.toList()[index],
                  );
                },
              ),
            ),
            const Divider(height: 1.0),
            _buildTextComposer(),
          ],
        ),
      ),
    );
  }

  Widget _buildTextComposer() {
    return Row(
      children: <Widget>[
        Flexible(
          child: TextField(
            controller: _messageController,
            onSubmitted: _handleSubmitted,
            decoration: const InputDecoration(
              hintText: 'Send a message',
              border: OutlineInputBorder(),
            ),
          ),
        ),
        IconButton(
          icon: const Icon(Icons.send),
          onPressed: () {
            _handleSubmitted(_messageController.text);
          },
        ),
      ],
    );
  }

  void _handleSubmitted(String text) {
    if (text.isNotEmpty) {
      if (preguntaActualIndex < preguntas.length) {
        setState(() {
          _messages.add(
            MessageModel(
              messageId: getCurrentMilliseconds(),
              messageContent: preguntas[preguntaActualIndex],
              senderId: SenderRol.AI,
            ),
          );
          _messages.add(
            MessageModel(
              messageId: getCurrentMilliseconds(),
              messageContent: text,
              senderId: SenderRol.User,
            ),
          );
          preguntaActualIndex++;
          updatePrompt();
          _messages.sort((a, b) => b.messageId.compareTo(a.messageId));
        });
      } else {
        setState(() {
          _messages.add(
            MessageModel(
              messageId: getCurrentMilliseconds(),
              messageContent: text,
              senderId: SenderRol.User,
            ),
          );

          if (preguntaActualIndex == preguntas.length) {
            sendTextCompletionRequest(prompt);
          }
        });
      }
      _messageController.clear();
    }
  }

  void updatePrompt() {
    prompt = "";
    for (int i = 0; i < preguntaActualIndex; i++) {
      prompt += "Pregunta ${i + 1}: ${preguntas[i]}\n";
      int respuestaIndex = (i * 2) + 1;

      if (respuestaIndex < _messages.length) {
        prompt +=
            "- Respuesta: ${_messages[respuestaIndex].messageContent} - Respuesta a la pregunta: $i\n";
      } else {
        prompt += "- Respuesta: (sin respuesta)\n";
      }
    }

    prompt +=
        "En base a estas preguntas y respuestas, respondeme unica y exclusivamente un color 'urgencia baja (verde), urgencia media (amarilla), urgencia alta (rojo)'";
  }

  int generarNumeroAleatorio() {
    Random random = Random();
    int numeroAleatorio = random.nextInt(2) + 1;
    return numeroAleatorio;
  }
  
  int getCurrentMilliseconds() {
    DateTime now = DateTime.now();
    return now.millisecondsSinceEpoch;
  }

  Future<String?> sendTextCompletionRequest(String message) async {
    String baseUrl = "https://api.openai.com/v1/engines/davinci/completions";
    Map<String, String> headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer 12"
    };

    print('El Prompt es el siguiente -> ${message}');

    var res = await http.post(
      Uri.parse(baseUrl),
      headers: headers,
      body: json.encode({
        "prompt": message,
        "max_tokens": 300,
      }),
    );
    List<Map<String, String>> nivelesDeUrgencia = [
      {
        "color": "Verde",
        "descripcion":
            "Urgencia Leve (Verde): La urgencia leve se refiere a situaciones en las que no es necesario tomar medidas inmediatas. Puede esperar un poco antes de buscar atención médica. Es importante seguir monitoreando su condición, pero generalmente no hay una amenaza inmediata para su salud."
      },
      {
        "color": "Amarilla",
        "descripcion":
            "Urgencia Media (Amarilla): La urgencia media indica que su situación médica requiere atención en un plazo razonable, pero no es una emergencia inmediata. Debería buscar atención médica en las próximas horas o durante el día, dependiendo de la gravedad de sus síntomas."
      },
      {
        "color": "Roja",
        "descripcion":
            "Urgencia Alta (Roja): La urgencia alta significa que su condición médica es crítica y requiere atención médica inmediata. No debe esperar y debe buscar atención médica de emergencia de inmediato. Esta es una situación potencialmente peligrosa para su salud y debe tratarse sin demora."
      }
    ];
    var index = generarNumeroAleatorio();
    if (res.statusCode == 200) {
    // Acceder a 'text' correctamente
      // ignore: use_build_context_synchronously
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ResponseAIScreen(
              color: nivelesDeUrgencia[index]['color'].toString(),
              messageResponse:
                  nivelesDeUrgencia[index]['descripcion'].toString()),
        ),
      );
      return "";
    }
    return null;
  }
}
