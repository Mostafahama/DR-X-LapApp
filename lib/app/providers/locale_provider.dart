import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final localeProvider = StateProvider<Locale>((ref) {
  // Default to Arabic as it's a "Doctor X" requirement, or system locale
  return const Locale('ar');
});
