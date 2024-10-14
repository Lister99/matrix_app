import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:matrix_app/features/home/presentation/home_cubit.dart';
import 'package:matrix_app/features/home/presentation/home_message_view_model.dart';
import 'package:matrix_app/features/home/presentation/home_view_model.dart';

import '../../test_utils/mock_matrix_input.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late HomeCubit homeCubit;

  setUp(() {
    homeCubit = HomeCubit();
  });

  final eventInitializeResponse = [
    isA<HomeSuccessState>()
        .having((x) => x.viewModel.matrix, 'matrix', isNotNull)
        .having((x) => x.viewModel.rotatedMatrix, 'rotatedMatrix', isNotNull)
        .having((x) => x.viewModel.rotationStatus, 'rotationStatus',
            equals(HomeRotateMatrixStatus.success))
  ];
  group('eventRotateMatrix', () {
    blocTest<HomeCubit, HomeState>(
      'GIVEN cubit initialized'
      'THEN should emit nothing',
      build: () => homeCubit,
      expect: () => <HomeState>[],
    );

    blocTest<HomeCubit, HomeState>(
      'GIVEN no errors '
      'WHEN eventInitialize() called'
      'THEN should emit HomeSuccessState',
      build: () => homeCubit,
      act: (cubit) {
        cubit.eventInitialize();
      },
      expect: () => [isA<HomeSuccessState>().having((x) => x.viewModel.matrix, 'matrix', isNull)],
    );

    blocTest<HomeCubit, HomeState>(
      'GIVEN no errors '
      'WHEN eventRotateMatrix() called with 2x2 Matrix'
      'THEN should emit HomeSuccessState',
      build: () => homeCubit,
      act: (cubit) {
        cubit.eventRotateMatrix(MockMatrixInput.sourceSuccessMatrix2x2);
      },
      expect: () => eventInitializeResponse,
    );

    blocTest<HomeCubit, HomeState>(
      'GIVEN no errors '
      'WHEN eventRotateMatrix() called with 4x4 Matrix'
      'THEN should emit HomeSuccessState',
      build: () => homeCubit,
      act: (cubit) {
        cubit.eventRotateMatrix(MockMatrixInput.sourceSuccessMatrix4x4);
      },
      expect: () => eventInitializeResponse,
    );

    blocTest<HomeCubit, HomeState>(
      'GIVEN no errors '
      'WHEN eventRotateMatrix() called with matrix bad format input'
      'THEN should emit HomeSuccessState with error messages',
      build: () => homeCubit,
      act: (cubit) {
        cubit.eventRotateMatrix(MockMatrixInput.sourceFailFormatMatrix);
      },
      expect: () => [
        isA<HomeSuccessState>()
            .having((x) => x.viewModel.matrix, 'matrix', isNull)
            .having((x) => x.viewModel.rotatedMatrix, 'rotatedMatrix', isNull)
            .having((x) => x.viewModel.overlay, 'overlay', isA<HomeRotateErrorMessage>())
      ],
    );

    blocTest<HomeCubit, HomeState>(
      'GIVEN no errors '
          'WHEN eventRotateMatrix() called with matrix bad count row'
          'THEN should emit HomeSuccessState with error messages',
      build: () => homeCubit,
      act: (cubit) {
        cubit.eventRotateMatrix(MockMatrixInput.sourceFailCountRowMatrix);
      },
      expect: () => [
        isA<HomeSuccessState>()
            .having((x) => x.viewModel.matrix, 'matrix', isNull)
            .having((x) => x.viewModel.rotatedMatrix, 'rotatedMatrix', isNull)
            .having((x) => x.viewModel.overlay, 'overlay', isA<HomeRotateErrorMessage>())
      ],
    );
  });
}
