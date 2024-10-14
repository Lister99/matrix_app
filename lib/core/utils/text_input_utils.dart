import 'package:flutter/services.dart';

class TextInputUtil {
  static TextInputFormatter get allowMatrixInput =>
      FilteringTextInputFormatter.allow(RegExp(r'[0-9.,\[\]]'));
}
