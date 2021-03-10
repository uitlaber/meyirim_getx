import 'package:flutter/material.dart';

@immutable
class MessageFirebase {
  final String title;
  final String body;

  const MessageFirebase({
    @required this.title,
    @required this.body,
  });
}
