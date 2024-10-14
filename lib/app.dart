import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matrix_app/core/routes/app_router.dart';
import 'package:matrix_app/features/home/presentation/home_cubit.dart';

class MatrixApp extends StatelessWidget {
  const MatrixApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HomeCubit(),
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'Matrix App',
        theme: ThemeData.light(),
        routerConfig: AppRouter.router,
      ),
    );
  }
}