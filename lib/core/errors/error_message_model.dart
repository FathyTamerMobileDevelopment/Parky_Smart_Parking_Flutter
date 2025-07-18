// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:equatable/equatable.dart';

import '../utils/functions/kprint.dart';

class ErrorMessageModel extends Equatable {
  final String message;
  final num? statusCode;
  final bool? isVerified;
  final int forbiddingReason;

  const ErrorMessageModel(
      {required this.message,
      this.statusCode,
      this.isVerified,
      this.forbiddingReason = 0});
  @override
  List<Object?> get props => [message, statusCode, isVerified];

  factory ErrorMessageModel.fromJson(Map<String, dynamic> map) {
    return ErrorMessageModel(
        message: map['data'] == null || map['data'] is! Map
            ? map['message'] as String
            : handleError(map['data']),
        statusCode: map['code'] != null ? map['code'] as num : null,
        isVerified: map['verified'] != null ? map['isVerified'] as bool : null,
        forbiddingReason: map['forbidding_reason'] ?? 0);
  }
}

String handleError(Map<String, dynamic> map) {
  kprint(map);
  List<String> error = [];
  error = map.keys.first.split('.');
  if (error.length > 1) {
    if (error[0] == "drivers") {
      int driverNumber = int.parse(error[1]) + 1;
      return "Driver $driverNumber ${(map).values.first}";
    } else if (error[0] == "cars") {
      return "Car ${error[1]}${(map).values.first}";
    } else if (error[0] == "students") {
      int studentNumber = int.parse(error[1]) + 1;
      return "Student $studentNumber ${(map).values.first}";
    } else {
      return "Error: ${(map).values.first}";
    }
  } else {
    if (error[0] == 'handle') {
      return "Handle ${(map).values.first}";
    }

    return "Error: ${(map).values.first}";
  }
}
