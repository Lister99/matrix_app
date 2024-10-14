import 'dart:convert';

class MatrixNativeResult {
  final String title;
  final List<List<dynamic>> matrix;
  final String buttonText;

  const MatrixNativeResult({
    required this.title,
    required this.matrix,
    required this.buttonText,
  });

  Map<String, dynamic> toJson() => {'title': title, 'matrix': matrix, 'buttonText': buttonText};

  static String getNativeArguments(List<List<dynamic>> matrix) => jsonEncode(
      MatrixNativeResult(title: 'Matriz Original', matrix: matrix, buttonText: 'Cerrar').toJson());
}
