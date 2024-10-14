import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:matrix_app/core/routes/routes.dart';
import 'package:matrix_app/features/home/view/home_page.dart';

class AppRouter {
  AppRouter._();
  static final GoRouter router = GoRouter(
    initialLocation: Routes.pathHome,
    routes: [
      GoRoute(
        path: Routes.pathHome,
        builder: (context, state) => const HomePage(),
      ),
    ],
    errorBuilder: (context, state) => const SizedBox.shrink(),
  );
}