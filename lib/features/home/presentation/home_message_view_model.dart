sealed class HomeMessageViewModel {}

class HomeRotateErrorMessage extends HomeMessageViewModel {
  final String message;

  HomeRotateErrorMessage({
    required this.message,
  });
}
