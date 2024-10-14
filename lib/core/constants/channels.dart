import 'package:flutter/services.dart';

class NativeChannel {
  //Channels
  static const matrixMethodChannel =
  MethodChannel("platform_channel_methods/matrix");
  //Methods
  static const showOriginalMatrix = 'showOriginalMatrix';
  static const showErrorMessageMatrix = 'showErrorMessageMatrix';
}