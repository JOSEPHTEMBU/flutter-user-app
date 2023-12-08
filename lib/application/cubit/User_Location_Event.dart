import 'package:equatable/equatable.dart';

abstract class UserLocationEvent extends Equatable {
  const UserLocationEvent();

  @override
  List<Object?> get props => [];
}

class FetchUserLocations extends UserLocationEvent {}
