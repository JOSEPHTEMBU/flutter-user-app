import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../application/cubit/User_Location_Cubit.dart';
import '../../application/cubit/User_Location_State.dart';
import '../../domain/models/UserLocation.dart';
import '../../infrastructure/ApiService/Api_Service.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Location App',
      home: BlocProvider(
        create: (_) => UserLocationCubit(ApiService())..fetchUserLocations(),
        child: HomePage(),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'User Locations',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: BlocBuilder<UserLocationCubit, UserLocationState>(
        builder: (context, state) {
          return _buildBody(context, state);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          BlocProvider.of<UserLocationCubit>(context).fetchUserLocations();
        },
        child: Icon(Icons.location_on),
      ),
    );
  }

  Widget _buildBody(BuildContext context, UserLocationState state) {
    if (state.isLoading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else if (state.currentLocation.isEmpty && state.locationHistory.isEmpty) {
      return Center(
        child: Text('No data available'),
      );
    } else {
      return Column(
        children: [
          Expanded(
            flex: 3,
            child: _buildMap(context, state),
          ),
          Expanded(
            flex: 2,
            child: _buildLocationList(context, state),
          ),
        ],
      );
    }
  }

  Widget _buildMap(BuildContext context, UserLocationState state) {
    Set<Marker> markers = Set();

    state.currentLocation.forEach((location) {
      markers.add(
        Marker(
          markerId: MarkerId(location.lat.toString() + location.lng.toString()),
          // position: LatLng(location.lat as double, location.lng as double),
          position: LatLng( double.parse(location.lat ?? "0.0",  ), double.parse(location.lng ?? "0.2")),

          infoWindow: InfoWindow(
            title: 'Location',
            snippet: 'Lat: ${location.lat}, Lng: ${location.lng}',
          ),
        ),
      );
    });

    state.locationHistory.forEach((location) {
      markers.add(
        Marker(
          markerId: MarkerId(location.lat.toString() + location.lng.toString()),
          position: LatLng( double.parse(location.lat ?? "0.0",  ), double.parse(location.lng ?? "0.2")),
          infoWindow: InfoWindow(
            title: 'Location',
            snippet: 'Lat: ${location.lat}, Lng: ${location.lng}',
          ),
        ),
      );
    });

    return GoogleMap(
      initialCameraPosition: CameraPosition(
        target: markers.isNotEmpty
            ? LatLng(
          markers.first.position.latitude,
          markers.first.position.longitude,
        )
            : LatLng(0.0, 0.0),
        zoom: 10.0,
      ),
      markers: markers,
    );
  }

  Widget _buildLocationList(BuildContext context, UserLocationState state) {
    return ListView.builder(
      itemCount: state.currentLocation.length + state.locationHistory.length,
      itemBuilder: (context, index) {
        if (index < state.currentLocation.length) {
          return _buildLocationTile(context, state.currentLocation[index]);
        } else {
          return _buildLocationTile(
            context,
            state.locationHistory[index - state.currentLocation.length],
          );
        }
      },
    );
  }

  Widget _buildLocationTile(BuildContext context, UserLocation location) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: ListTile(
        title: Text(
          'Latitude: ${location.lat}, Longitude: ${location.lng}',
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}
