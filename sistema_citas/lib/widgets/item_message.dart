import 'package:flutter/material.dart';
import 'package:sistema_citas/models/message_model.dart';
import 'package:sistema_citas/models/sender_rol.dart';

class ItemMessage extends StatelessWidget {
  final MessageModel messageEntity;

  const ItemMessage({Key? key, required this.messageEntity}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (messageEntity.senderId == SenderRol.User) {
      return Container(
        alignment: Alignment.centerRight,
        margin: const EdgeInsets.only(top: 8.0, left: 80.0),
        child: Container(
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Text(
            messageEntity.messageContent,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16.0,
            ),
          ),
        ),
      );
    }
    return Container(
      alignment: Alignment.centerLeft,
      margin: const EdgeInsets.only(top: 8.0, right: 80.0),
      child: Container(
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Text(
          messageEntity.messageContent,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 16.0,
          ),
        ),
      ),
    );
  }
}