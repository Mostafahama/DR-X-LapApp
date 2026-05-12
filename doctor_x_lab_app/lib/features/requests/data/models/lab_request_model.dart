class LabRequest {
  final String id;
  final String patientId;
  final String patientName;
  final int patientAge;
  final String patientPhone;
  final String doctorId;
  final String doctorName;
  final DateTime requestedDate;
  final List<String> testNames;
  final String status; // pending, accepted, in_progress, completed
  final String? sampleId;
  final String? sampleQRCode;
  final DateTime? sampleReceivedDate;
  final DateTime? completedDate;
  final bool isUrgent;

  LabRequest({
    required this.id,
    required this.patientId,
    required this.patientName,
    required this.patientAge,
    required this.patientPhone,
    required this.doctorId,
    required this.doctorName,
    required this.requestedDate,
    required this.testNames,
    required this.status,
    this.sampleId,
    this.sampleQRCode,
    this.sampleReceivedDate,
    this.completedDate,
    this.isUrgent = false,
  });

  factory LabRequest.fromJson(Map<String, dynamic> json) => LabRequest(
        id: json['id'],
        patientId: json['patientId'],
        patientName: json['patientName'],
        patientAge: json['patientAge'],
        patientPhone: json['patientPhone'],
        doctorId: json['doctorId'],
        doctorName: json['doctorName'],
        requestedDate: DateTime.parse(json['requestedDate']),
        testNames: List<String>.from(json['testNames']),
        status: json['status'],
        sampleId: json['sampleId'],
        sampleQRCode: json['sampleQRCode'],
        sampleReceivedDate: json['sampleReceivedDate'] != null
            ? DateTime.parse(json['sampleReceivedDate'])
            : null,
        completedDate: json['completedDate'] != null
            ? DateTime.parse(json['completedDate'])
            : null,
        isUrgent: json['isUrgent'] ?? false,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'patientId': patientId,
        'patientName': patientName,
        'patientAge': patientAge,
        'patientPhone': patientPhone,
        'doctorId': doctorId,
        'doctorName': doctorName,
        'requestedDate': requestedDate.toIso8601String(),
        'testNames': testNames,
        'status': status,
        'sampleId': sampleId,
        'sampleQRCode': sampleQRCode,
        'sampleReceivedDate': sampleReceivedDate?.toIso8601String(),
        'completedDate': completedDate?.toIso8601String(),
        'isUrgent': isUrgent,
      };
}
