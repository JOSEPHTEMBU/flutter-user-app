import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import '../../domain/models/UserLocation.dart';
class ApiService {
  Future<List<UserLocation>> fetchCurrentLocation() async {
    try{
      final response = await http.get(Uri.parse('https://6572cd38192318b7db410776.mockapi.io/locations'));
      if (response.statusCode == 200) {

       debugPrint(response.body.toString());
        final List<dynamic> data = json.decode(response.body) as List<dynamic>;
        final List<UserLocation> locations = data.map((json) => UserLocation.fromJson(json as Map<String, dynamic>)).toList();
        return locations;
      } else {
        throw Exception('Failed to load current location');
      }
    }catch (e,s){
      debugPrint(e.toString());
      debugPrint(s.toString());
      throw e;
    }

  }
  Future<List<UserLocation>> fetchLocationHistory() async {
    final response = await http.get(Uri.parse('https://6572cd38192318b7db410776.mockapi.io/locationhistory'));
    if (response.statusCode == 200) {

      final List<dynamic> data = json.decode(response.body) as List<dynamic>;
      final List<UserLocation> locations = data.map((json) => UserLocation.fromJson(json as Map<String, dynamic>)).toList();
      return locations;
    } else {
      throw Exception('Failed to load location history');
    }
  }
}
