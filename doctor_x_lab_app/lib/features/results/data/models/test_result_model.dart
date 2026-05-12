class TestResult {
  final String id;
  final String labRequestId;
  final String testName;
  final DateTime resultDate;
  final List<TestParameter> parameters;
  final bool hasAbnormalValues;
  final String? aiInterpretation;

  TestResult({
    required this.id,
    required this.labRequestId,
    required this.testName,
    required this.resultDate,
    required this.parameters,
    required this.hasAbnormalValues,
    this.aiInterpretation,
  });

  factory TestResult.fromJson(Map<String, dynamic> json) => TestResult(
        id: json['id'],
        labRequestId: json['labRequestId'],
        testName: json['testName'],
        resultDate: DateTime.parse(json['resultDate']),
        parameters: (json['parameters'] as List)
            .map((p) => TestParameter.fromJson(p))
            .toList(),
        hasAbnormalValues: json['hasAbnormalValues'],
        aiInterpretation: json['aiInterpretation'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'labRequestId': labRequestId,
        'testName': testName,
        'resultDate': resultDate.toIso8601String(),
        'parameters': parameters.map((p) => p.toJson()).toList(),
        'hasAbnormalValues': hasAbnormalValues,
        'aiInterpretation': aiInterpretation,
      };
}

class TestParameter {
  final String name;
  final dynamic value;
  final String unit;
  final dynamic minReference;
  final dynamic maxReference;
  final bool isAbnormal;
  final String? flag; // High, Low, Critical

  TestParameter({
    required this.name,
    required this.value,
    required this.unit,
    required this.minReference,
    required this.maxReference,
    required this.isAbnormal,
    this.flag,
  });

  factory TestParameter.fromJson(Map<String, dynamic> json) => TestParameter(
        name: json['name'],
        value: json['value'],
        unit: json['unit'],
        minReference: json['minReference'],
        maxReference: json['maxReference'],
        isAbnormal: json['isAbnormal'],
        flag: json['flag'],
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'value': value,
        'unit': unit,
        'minReference': minReference,
        'maxReference': maxReference,
        'isAbnormal': isAbnormal,
        'flag': flag,
      };
}
