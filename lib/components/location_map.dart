import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_year_project/components/button.dart';
import 'package:final_year_project/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:geocoder2/geocoder2.dart' as geoCo;
import 'package:google_maps_webservice/places.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_api_headers/google_api_headers.dart';

class LocationMap extends StatefulWidget {
  const LocationMap({Key? key}) : super(key: key);

  @override
  _LocationMapState createState() => _LocationMapState();
}

const kGoogleApiKey = '';
final homeScaffoldKey = GlobalKey<ScaffoldState>();

class _LocationMapState extends State<LocationMap> {
  late GoogleMapController mapController;
  final Mode _mode = Mode.overlay;
  final LatLng _center = const LatLng(3.140853, 101.693207);
  String addressLocation = "";
  String addressLatitude = "";
  String addressLongtitude = "";
  String addressCity = "";
  String addressState = "";
  List<Marker> markers = [];
  TextEditingController myController = TextEditingController();

  @override
  void initState() {
    initialize();
    super.initState();
  }

  Future initialize() async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('store').get();
    final name =
        querySnapshot.docs.map((doc) => doc.get('businessName')).toList();
    final latitude =
        querySnapshot.docs.map((doc) => doc.get('latitude')).toList();
    final longtitude =
        querySnapshot.docs.map((doc) => doc.get('longtitude')).toList();

    for (int i = 0; i < querySnapshot.docs.length; i++) {
      markers.add(Marker(
          markerId: MarkerId(name[i]),
          position:
              LatLng(double.parse(latitude[i]), double.parse(longtitude[i])),
          infoWindow: InfoWindow(
              title: name[i],
              onTap: () => getFormattedAddressFromCoordinates(
                  double.parse(latitude[i]), double.parse(longtitude[i]))),
          icon: BitmapDescriptor.defaultMarkerWithHue(
              BitmapDescriptor.hueViolet)));

      setState(() {});
    }
  }

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
                onTap: (tapped) {
                  markers.add(
                    Marker(
                      markerId: const MarkerId("MarkerId"),
                      position: LatLng(tapped.latitude, tapped.longitude),
                    ),
                  );

                  setState(() {});

                  getFormattedAddressFromCoordinates(
                      tapped.latitude, tapped.longitude);
                },
                markers: Set<Marker>.of(markers),
                mapType: MapType.normal,
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
                    flex: 10,
                    child: Row(
                      children: [
                        Container(
                          width: 35,
                          height: 35,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(color: Colors.grey),
                          ),
                          child: IconButton(
                            icon: const Icon(Icons.search),
                            padding: const EdgeInsets.all(5),
                            iconSize: 20,
                            onPressed: _handleSearchPlaces,
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Expanded(
                          child: Container(
                              //height: 40,
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(color: Colors.grey),
                              ),
                              child: Text(
                                addressLocation,
                                style: ratingLabelStyle,
                                overflow: TextOverflow.ellipsis,
                              )),
                        )
                      ],
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

                markers.add(Marker(
                    markerId: const MarkerId('currentLocation'),
                    position: LatLng(position.latitude, position.longitude),
                    infoWindow: InfoWindow(
                        title: "My current location",
                        onTap: () => getFormattedAddressFromCoordinates(
                            position.latitude, position.longitude)),
                    icon: BitmapDescriptor.defaultMarkerWithHue(
                        BitmapDescriptor.hueYellow)));

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
          ),
          Positioned(
              bottom: 10,
              left: 20,
              child: SizedBox(
                width: 100,
                child: PurpleTextButton(
                  buttonText: 'Save',
                  onClick: () {
                    _sendBackMapResult(context);
                  },
                ),
              )),
        ],
      ),
    ));
  }

  void _sendBackMapResult(BuildContext context) {
    String address = addressLocation;
    String latitude = addressLatitude;
    String longtitude = addressLongtitude;
    String state = addressState;
    String city = addressCity;
    Navigator.pop(context, [address, latitude, longtitude, city, state]);
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

    Position currentPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
        forceAndroidLocationManager: true);

    return currentPosition;
  }

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

    markers.add(Marker(
        markerId: const MarkerId("0"),
        position: LatLng(lat, lng),
        infoWindow: InfoWindow(
          title: detail.result.name,
          onTap: () => getFormattedAddressFromCoordinates(lat, lng),
        ),
        icon:
            BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen)));

    setState(() {});

    mapController
        .animateCamera(CameraUpdate.newLatLngZoom(LatLng(lat, lng), 14.0));
  }

  getFormattedAddressFromCoordinates(double latitude, double longtitude) async {
    var address = await geoCo.Geocoder2.getDataFromCoordinates(
        latitude: latitude,
        longitude: longtitude,
        googleMapApiKey: kGoogleApiKey);
    var firstAddress = address.address;
    var locationLatitude = address.latitude;
    var locationLongtitude = address.longitude;
    var locationCity = address.postalCode;
    var locationState = address.state;
    setState(() {
      addressLocation = firstAddress;
      addressLatitude = locationLatitude.toString();
      addressLongtitude = locationLongtitude.toString();
      addressCity = locationCity;
      addressState = locationState;
    });
  }
}
