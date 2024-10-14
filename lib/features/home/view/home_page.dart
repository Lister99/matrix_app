import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matrix_app/core/constants/channels.dart';
import 'package:matrix_app/core/constants/spacing.dart';
import 'package:matrix_app/core/utils/text_input_utils.dart';
import 'package:matrix_app/data/models/matrix_native_result.dart';
import 'package:matrix_app/data/models/message_native_error.dart';
import 'package:matrix_app/features/home/presentation/home_cubit.dart';
import 'package:matrix_app/features/home/presentation/home_message_view_model.dart';
import 'package:matrix_app/features/home/presentation/home_view_model.dart';
import 'package:matrix_app/features/widgets/matrix_container.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _matrixTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsFlutterBinding.ensureInitialized();
    context.read<HomeCubit>().eventInitialize();
  }

  Future<void> _showOriginalMatrix(HomeViewModel viewModel) async {
    try {
      await NativeChannel.matrixMethodChannel.invokeMethod(NativeChannel.showOriginalMatrix,
          MatrixNativeResult.getNativeArguments(viewModel.matrix!));
    } on PlatformException catch (_) {}
  }

  Future<void> _showErrorMessage(String message) async {
    try {
      await NativeChannel.matrixMethodChannel.invokeMethod(
          NativeChannel.showErrorMessageMatrix,
          MessageNativeError.getNativeArguments(message));
    } on PlatformException catch (_) {}
  }

  void _overlay(HomeMessageViewModel overlay, BuildContext context) {
    switch (overlay) {
      case HomeRotateErrorMessage(:final message):
        _showErrorMessage(message);
    }
  }

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<HomeCubit>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Matrix App'),
      ),
      body: BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {
          if (state case HomeSuccessState(:final viewModel)) {
            if (viewModel.overlay != null) {
              _overlay(viewModel.overlay!, context);
            }
            if (viewModel.rotationStatus == HomeRotateMatrixStatus.success) {
              _showOriginalMatrix(viewModel);
            }
          }
        },
        builder: (context, state) {
          return switch (state) {
            HomeInitialState() => Container(),
            HomeSuccessState(:final viewModel) => SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: Spacing.spacing2x),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text('Ingresar matriz'),
                      const SizedBox(height: Spacing.spacing1Dot25x),
                      TextFormField(
                        controller: _matrixTextController,
                        inputFormatters: [TextInputUtil.allowMatrixInput],
                        keyboardType: TextInputType.text,
                        maxLines: 3,
                        minLines: 1,
                      ),
                      const SizedBox(height: Spacing.spacing1Dot25x),
                      FilledButton(
                        onPressed: () {
                          cubit.eventRotateMatrix(_matrixTextController.text);
                        },
                        style: ButtonStyle(
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        child: const Text('Rotar'),
                      ),
                      if (viewModel.rotatedMatrix != null) ...[
                        const SizedBox(height: Spacing.spacing1Dot25x),
                        const Text('Matriz rotada 90° en sentido antihorario'),
                        const SizedBox(height: Spacing.spacing1Dot25x),
                        MatrixContainer(matrix: viewModel.rotatedMatrix!),
                      ],
                    ],
                  ),
                ),
              )
          };
        },
      ),
    );
  }
}
