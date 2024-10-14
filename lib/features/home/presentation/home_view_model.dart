import 'package:matrix_app/features/home/presentation/home_message_view_model.dart';

enum HomeRotateMatrixStatus { success }

class HomeViewModel {
  final List<List<dynamic>>? matrix;
  final List<List<dynamic>>? rotatedMatrix;
  final HomeMessageViewModel? overlay;
  final HomeRotateMatrixStatus? rotationStatus;

  HomeViewModel.fromSuccessState({
    this.matrix,
    this.rotatedMatrix,
    this.overlay,
    this.rotationStatus,
  });
}
