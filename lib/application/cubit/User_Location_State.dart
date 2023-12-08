
import '../../domain/models/UserLocation.dart';
import 'package:equatable/equatable.dart';

class UserLocationState extends Equatable {
  final List<UserLocation> currentLocation;
  final List<UserLocation> locationHistory;
  final bool isLoading;

  const UserLocationState({
    required this.currentLocation,
    required this.locationHistory,
    required this.isLoading,
  });

  factory UserLocationState.initial() => UserLocationState(
    currentLocation: [],
    locationHistory: [],
    isLoading: false,
  );

  UserLocationState copyWith({
    List<UserLocation>? currentLocation,
    List<UserLocation>? locationHistory,
    bool? isLoading,
  }) {
    return UserLocationState(
      currentLocation: currentLocation ?? this.currentLocation,
      locationHistory: locationHistory ?? this.locationHistory,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object?> get props => [currentLocation, locationHistory, isLoading];
}
