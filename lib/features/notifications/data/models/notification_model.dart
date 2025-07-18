import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

class NotificationModel {
  int? id;
  DateTime? time;
  bool? read;
  int? user;
  int? message;

  NotificationModel({
    this.id,
    this.time,
    this.read,
    this.user,
    this.message,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id'] as int?,
      time: json['notification_time'] == null
          ? null
          : DateTime.parse(json['notification_time'] as String),
      read: json['read'] as bool?,
      user: json['user'] as int?,
      message: json['message'] as int?,
    );
  }
}

String formateDate(DateTime date, BuildContext context) {
  final timeAgo = timeago.format(
    date,
    locale: context.locale.languageCode == 'en' ? 'en' : 'ar',
  );

  return timeAgo;
}
