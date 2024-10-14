import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:matrix_app/core/utils/matrix_utils.dart';
import 'package:matrix_app/features/home/presentation/home_message_view_model.dart';
import 'package:matrix_app/features/home/presentation/home_view_model.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitialState());

  void eventInitialize() {
    _emitSuccess();
  }

  List<List<dynamic>>? _stringToMatrix(String source) {
    try {
      final List<dynamic> dynamicList = json.decode(source);
      final matrix = dynamicList
          .map((fila) => List<dynamic>.from(fila).map((item) => item.toString()).toList())
          .toList();
      return matrix;
    } on FormatException catch (_) {
      _emitSuccess(
          overlay: HomeRotateErrorMessage(
              message: 'El formato ingresado no es válido para ser una matriz'));
    } catch (e) {
      _emitSuccess(
          overlay: HomeRotateErrorMessage(message: 'Hubo un error al transformar a matriz'));
    }
    return null;
  }

  void eventRotateMatrix(String source) {
    final matrix = _stringToMatrix(source);
    if (matrix != null) {
      final rotatedMatrix = _stringToMatrix(source);
      if (MatrixAppUtils.isValidMatrix(matrix, 0)) {
        MatrixAppUtils.rotateMatrix(rotatedMatrix!);
        _emitSuccess(
          matrix: matrix,
          rotatedMatrix: rotatedMatrix,
          rotationStatus: HomeRotateMatrixStatus.success,
        );
      } else {
        _emitSuccess(
          overlay: HomeRotateErrorMessage(
              message: 'La matriz debe tener ${matrix.length} filas y ${matrix.length} columnas'),
        );
      }
    }
  }

  void _emitSuccess({
    List<List<dynamic>>? matrix,
    List<List<dynamic>>? rotatedMatrix,
    HomeMessageViewModel? overlay,
    HomeRotateMatrixStatus? rotationStatus,
  }) {
    emit(
      HomeSuccessState(
        viewModel: HomeViewModel.fromSuccessState(
          matrix: matrix,
          rotatedMatrix: rotatedMatrix,
          overlay: overlay,
          rotationStatus: rotationStatus,
        ),
      ),
    );
  }
}
