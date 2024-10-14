part of 'home_cubit.dart';

sealed class HomeState {}

class HomeInitialState extends HomeState {}

class HomeSuccessState extends HomeState {
  final HomeViewModel viewModel;

  HomeSuccessState({
    required this.viewModel,
  });
}
