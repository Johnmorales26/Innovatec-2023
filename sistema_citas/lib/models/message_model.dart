import 'package:sistema_citas/models/sender_rol.dart';

class MessageModel {
  int messageId;
  String messageContent;
  SenderRol senderId;

  MessageModel({
    required this.messageId,
    required this.messageContent,
    required this.senderId,
  });
}