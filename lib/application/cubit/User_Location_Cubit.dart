import 'package:bloc/bloc.dart';
import '../../infrastructure/ApiService/Api_Service.dart';
import 'User_Location_State.dart';

class UserLocationCubit extends Cubit<UserLocationState> {
  final ApiService _apiService;
  UserLocationCubit(this._apiService)
      : super(UserLocationState.initial());

  Future<void> fetchUserLocations() async {
    emit(state.copyWith(isLoading: true));
    try {
      final currentLocation = await _apiService.fetchCurrentLocation();
    //  final locationHistory = await _apiService.fetchLocationHistory();
      emit(state.copyWith(
        currentLocation: currentLocation,
        locationHistory: [],
        isLoading: false,
      ));
    } catch (e) {
      emit(state.copyWith(isLoading: false));
    }
  }
}
