part of 'home_cubit.dart';

abstract class HomeState {}

class HomeInitial extends HomeState {}

class LocationLoaded extends HomeState {}

class LocationUpdated extends HomeState {}

class ParkingLoading extends HomeState {}

class ParkingSuccess extends HomeState {}

class ParkingError extends HomeState {
  final String message;

  ParkingError(this.message);
}
