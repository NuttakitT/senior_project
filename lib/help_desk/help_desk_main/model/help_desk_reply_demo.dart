import 'package:flutter/material.dart';

enum ChatMessageType { text, audio, image, video }

// enum MessageStatus { notsent, notview, viewed }

class MessageChat {
  final String text;
  final ChatMessageType messageType;
  // final MessageStatus messageStatus;
  final bool isSender;

  MessageChat(
      {required this.text,
      required this.messageType,
      // required this.messageStatus,
      required this.isSender});
}

List demoMessage = [
  MessageChat(
      text: "Hi People",
      messageType: ChatMessageType.text,
      // messageStatus: MessageStatus.viewed,
      isSender: true),
  MessageChat(
      text: "Okay, How r u?",
      messageType: ChatMessageType.text,
      // messageStatus: MessageStatus.viewed,
      isSender: false),
  MessageChat(
      text: "I'm fine",
      messageType: ChatMessageType.text,
      // messageStatus: MessageStatus.viewed,
      isSender: true),
  MessageChat(
      text: "Okay that's good",
      messageType: ChatMessageType.text,
      // messageStatus: MessageStatus.viewed,
      isSender: false),
];
