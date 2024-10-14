import 'dart:convert';

class MessageNativeError {
  final String title;
  final String message;
  final double displayDuration;

  const MessageNativeError({
    required this.title,
    required this.message,
    required this.displayDuration,
  });

  Map<String, dynamic> toJson() =>
      {'title': title, 'description': message, 'displayDuration': displayDuration};

  static String getNativeArguments(String message) => jsonEncode(
      MessageNativeError(title: 'Error', message: message, displayDuration: 5.0).toJson());
}
