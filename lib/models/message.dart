import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart' show immutable;

@immutable
class Message {
  final String messageText;
  final String fromId;
  final String messageId;

  const Message({
    required this.messageText,
    required this.fromId,
    required this.messageId,
  });

  Message.fromSnapshot(QueryDocumentSnapshot<Map<String, dynamic>> snapshot)
      : messageId = snapshot.id,
        fromId = snapshot.data()['fromId'] as String,
        messageText = snapshot.data()['messageText'] as String;

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'messageText': messageText});
    result.addAll({'fromId': fromId});
    result.addAll({'messageId': messageId});

    return result;
  }
}
