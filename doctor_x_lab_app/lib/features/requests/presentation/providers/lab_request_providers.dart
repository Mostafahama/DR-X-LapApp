import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/network/dio_provider.dart';
import '../../data/repositories/lab_request_repository_impl.dart';
import '../../domain/repositories/lab_request_repository.dart';

final labRequestRepositoryProvider = Provider<LabRequestRepository>((ref) {
  final dio = ref.watch(dioProvider);
  return LabRequestRepositoryImpl(dio);
});

final pendingRequestsProvider = FutureProvider((ref) async {
  final repository = ref.watch(labRequestRepositoryProvider);
  return repository.getPendingRequests();
});
