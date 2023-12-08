// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'UserLocation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserLocation _$UserLocationFromJson(Map<String, dynamic> json) => UserLocation(
      lat: json['lat'] as String?,
      lng: json['lng'] as String?,
      name: json['name'] as String?,
      timestamp: json['timestamp'] as String?,
      imageavatar: json['imageavatar'] as String?,
    );

Map<String, dynamic> _$UserLocationToJson(UserLocation instance) =>
    <String, dynamic>{
      'lat': instance.lat,
      'lng': instance.lng,
      'name': instance.name,
      'timestamp': instance.timestamp,
      'imageavatar': instance.imageavatar,
    };
