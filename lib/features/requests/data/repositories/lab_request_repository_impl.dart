import '../../data/models/lab_request_model.dart';
import '../../domain/repositories/lab_request_repository.dart';
import 'package:dio/dio.dart';

class LabRequestRepositoryImpl implements LabRequestRepository {
  final Dio _dio;

  LabRequestRepositoryImpl(this._dio);

  @override
  Future<List<LabRequest>> getPendingRequests() async {
    // Simulated delay for network
    await Future.delayed(const Duration(seconds: 1));
    
    // Returning mock data
    return [
      LabRequest(
        id: 'REQ-49201',
        patientId: 'PT-1001',
        patientName: 'Sarah Ahmed',
        patientAge: 28,
        patientPhone: '+123456789',
        doctorId: 'DR-001',
        doctorName: 'Dr. Julian Vance',
        requestedDate: DateTime.now().subtract(const Duration(minutes: 2)),
        testNames: ['CBC', 'Lipid Profile', 'HbA1c'],
        status: 'pending',
        isUrgent: true,
      ),
      LabRequest(
        id: 'REQ-49195',
        patientId: 'PT-1002',
        patientName: 'Marcus Knight',
        patientAge: 45,
        patientPhone: '+123456780',
        doctorId: 'DR-002',
        doctorName: 'Dr. Emily Stone',
        requestedDate: DateTime.now().subtract(const Duration(minutes: 25)),
        testNames: ['Lipid Profile'],
        status: 'in_progress',
        isUrgent: false,
      ),
    ];
  }

  @override
  Future<LabRequest> getRequestDetails(String id) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return LabRequest(
      id: id,
      patientId: 'PT-1001',
      patientName: 'Sarah Ahmed',
      patientAge: 28,
      patientPhone: '+123456789',
      doctorId: 'DR-001',
      doctorName: 'Dr. Julian Vance',
      requestedDate: DateTime.now().subtract(const Duration(minutes: 2)),
      testNames: ['CBC', 'Lipid Profile', 'HbA1c'],
      status: 'pending',
      isUrgent: true,
    );
  }

  @override
  Future<void> updateRequestStatus(String id, String status) async {
    await Future.delayed(const Duration(milliseconds: 500));
    // In real app: await _dio.patch('/requests/$id', data: {'status': status});
  }
}
