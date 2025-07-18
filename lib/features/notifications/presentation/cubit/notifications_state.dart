part of 'notifications_cubit.dart';

abstract class NotificationsState {}

class NotificationsInitial extends NotificationsState {}

class NotificationsLoading extends NotificationsState {}

class NotificationSuccess extends NotificationsState {}

class NotificationError extends NotificationsState {
  final String message;

  NotificationError({required this.message});
}

class NotificationDeleted extends NotificationsState {}
