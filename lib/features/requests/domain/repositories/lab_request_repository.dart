import '../../data/models/lab_request_model.dart';

abstract class LabRequestRepository {
  Future<List<LabRequest>> getPendingRequests();
  Future<LabRequest> getRequestDetails(String id);
  Future<void> updateRequestStatus(String id, String status);
}
