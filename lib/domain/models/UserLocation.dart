import 'package:json_annotation/json_annotation.dart';
part 'UserLocation.g.dart';

@JsonSerializable()
class UserLocation {
  final String? lat;
  final String? lng;
  final String? name ;
  final String? timestamp;
  final String? imageavatar;

  UserLocation({required this.lat, required this.lng,required this.name, required this.timestamp,required this.imageavatar});

  factory UserLocation.fromJson(Map<String, dynamic> json) =>
      _$UserLocationFromJson(json);
  Map<String, dynamic> toJson() => _$UserLocationToJson(this);
}
