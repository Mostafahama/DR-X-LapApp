import 'package:flutter_riverpod/flutter_riverpod.dart';

class ShellController extends StateNotifier<int> {
  ShellController() : super(0);

  void setIndex(int index) => state = index;
}

final shellIndexProvider = StateNotifierProvider<ShellController, int>((ref) {
  return ShellController();
});
