import 'dart:async';

import 'package:final_year_project/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_api_headers/google_api_headers.dart';

class LocationMap extends StatefulWidget {
  const LocationMap({Key? key}) : super(key: key);

  @override
  _LocationMapState createState() => _LocationMapState();
}

const kGoogleApiKey = 'AIzaSyCoho5rQrIjW0KGmJXpwZmuo_dgJXCgTTs';
final homeScaffoldKey = GlobalKey<ScaffoldState>();

class _LocationMapState extends State<LocationMap> {
  late GoogleMapController mapController;

  final Mode _mode = Mode.overlay;

  final LatLng _center = const LatLng(3.140853, 101.693207);
  double? lat;
  double? long;
  String address = "";

  Set<Marker> markers = {};

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: homeScaffoldKey,
        body: Stack(
          children: [
            SizedBox(
                height: MediaQuery.of(context).size.height,
                width: double.infinity,
                child: GoogleMap(
                  markers: markers,
                  mapType: MapType.normal,
                  //myLocationEnabled: true,
                  onMapCreated: (GoogleMapController controller) {
                    mapController = controller;
                  },
                  initialCameraPosition:
                      CameraPosition(target: _center, zoom: 10),
                )),
            Padding(
              padding: const EdgeInsets.fromLTRB(5, 9, 70, 0),
              child: SizedBox(
                height: 40,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                        flex: 1,
                        child: IconButton(
                          icon: const Icon(Icons.arrow_back_ios),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        )),
                    Expanded(
                      flex: 9,
                      child: Material(
                        elevation: 3.0,
                        borderRadius: BorderRadius.circular(5),
                        child: TextField(
                          decoration: const InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              hintText: 'Enter Your Location',
                              hintStyle: primaryFontStyle,
                              suffixIcon: Icon(Icons.search),
                              contentPadding: EdgeInsets.only(
                                  left: 20, bottom: 0, right: 0),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide.none),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide.none)),
                          onTap: _handleSearchPlaces,
                          // onChanged: (add) {
                          //   address = add;
                          //   setState(() {
                          //     Text(add);
                          //   });
                          // },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 5,
              right: 10,
              child: FloatingActionButton(
                onPressed: () async {
                  Position position = await _determinePosition();

                  mapController.animateCamera(CameraUpdate.newCameraPosition(
                      CameraPosition(
                          target: LatLng(position.latitude, position.longitude),
                          zoom: 17.0)));

                  markers.clear();

                  markers.add(Marker(
                      markerId: const MarkerId('currentLocation'),
                      position: LatLng(position.latitude, position.longitude)));

                  setState(() {});
                },
                backgroundColor: Colors.white,
                child: const Icon(
                  Icons.location_searching,
                  color: secondaryColor,
                ),
                mini: true,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      return Future.error('Location services are disabled');
    }

    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.denied) {
        return Future.error('Location permission denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location permissions are permanently denied');
    }

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
        forceAndroidLocationManager: true);
    return position;
  }

  // getLatLong() {
  //   Future<Position> data = _determinePosition();

  //   data.then((value) {
  //     print("value $value");
  //     setState(() {
  //       lat = value.latitude;
  //       long = value.longitude;
  //     });

  //     getAddress(value.latitude, value.longitude);
  //   }).catchError((error) {
  //     print("Error $error");
  //   });
  // }

  // getAddress(lat, long) async {
  //   List<Placemark> placemarks = await placemarkFromCoordinates(lat, long);
  //   setState(() {
  //     address = placemarks[0].street! + " " + placemarks[0].country!;
  //   });

  //   for (int i = 0; i < placemarks.length; i++) {
  //     print("Indec $i ${placemarks[i]}");
  //   }
  // }

  Future<void> _handleSearchPlaces() async {
    Prediction? p = await PlacesAutocomplete.show(
        context: context,
        apiKey: kGoogleApiKey,
        onError: onError,
        mode: _mode,
        language: 'en',
        strictbounds: false,
        types: [],
        decoration: InputDecoration(
            hintText: 'Search',
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: const BorderSide(color: Colors.white),
            )),
        components: [Component(Component.country, 'my')]);

    displayPrediction(p!, homeScaffoldKey.currentState);
  }

  void onError(PlacesAutocompleteResponse response) {
    homeScaffoldKey.currentState!.showSnackBar(SnackBar(
      content: Text(response.errorMessage!),
    ));
  }

  Future<void> displayPrediction(
      Prediction p, ScaffoldState? currentState) async {
    GoogleMapsPlaces places = GoogleMapsPlaces(
        apiKey: kGoogleApiKey,
        apiHeaders: await const GoogleApiHeaders().getHeaders());

    PlacesDetailsResponse detail = await places.getDetailsByPlaceId(p.placeId!);

    final lat = detail.result.geometry!.location.lat;
    final lng = detail.result.geometry!.location.lng;
    String address = '';

    markers.clear();
    markers.add(Marker(
        markerId: const MarkerId("0"),
        position: LatLng(lat, lng),
        infoWindow: InfoWindow(title: detail.result.name)));

    setState(() {});

    mapController
        .animateCamera(CameraUpdate.newLatLngZoom(LatLng(lat, lng), 14.0));
  }
}
