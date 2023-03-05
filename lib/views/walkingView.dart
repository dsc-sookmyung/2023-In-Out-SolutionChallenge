import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:largo/viewmodel/newLocationViewModel.dart';

// Widget
import 'package:largo/widgets/customAppbar.dart';
import 'package:largo/widgets/customSlider.dart';
import 'package:largo/widgets/customButton.dart';

// Colors
import 'package:largo/color/themeColors.dart';
import 'package:largo/widgets/smallTitle.dart';

// API
import 'dart:async';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

//model
import 'package:largo/models/userLocationInfo.dart';

// GPS
import 'package:largo/service/LocationService.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';

class WalkingView extends StatefulWidget {
  @override
  _WalkingView createState() => _WalkingView();
}

class _WalkingView extends State<WalkingView> {
  Completer<GoogleMapController> _controller = Completer();
  final LocationService _positionStream = LocationService();
  late StreamSubscription sub;

  Set<Marker> markers = Set(); //markers for google map
  var mymarkers = [];
  var positionList = [];
  var polylineidx = 1;

  Set<Polyline> _polylines = Set<Polyline>();
  PolylinePoints polylinePoints = PolylinePoints();
  List<LatLng> polylineCoordinates = [];

  double lat = 37.544986;
  double long = 126.964370;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    addMarkers();
    getCurrentLocation();
  }

  @override
  void setState(VoidCallback fn) {
    // TODO: implement setState
    super.setState(fn);
  }

  addMarkers() async {
    markers = {};
    markers.add( //repopulate markers
        Marker(
            markerId: MarkerId("current_user_position"),
            position: LatLng(lat, long), //move to new location
            icon: BitmapDescriptor.defaultMarker
        )
    );

    setState(() {
      //refresh UI
    });
  }

  addPolyline() async {
    setState(() {
      _polylines.add(
          Polyline(
          width: 8,
          polylineId: PolylineId(polylineidx.toString()),
          //color: Color.fromARGB(190, 255, 201, 119),
          color: Color.fromARGB(190, 252, 45, 82),
          points: polylineCoordinates));
      polylineidx++;
    });
  }

  void getCurrentLocation() async {
    GoogleMapController googleMapController = await _controller.future;

     sub = _positionStream.controller.stream.listen((pos){
      lat = pos.latitude;
      long = pos.longitude;
      polylineCoordinates.add(LatLng(lat, long));

      print("location saved : ${positionList.length}, ${polylineCoordinates.length} ******************************************");

      googleMapController.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            zoom: 17.5,
            target: LatLng(lat, long),
          ),
        ),
      );

      markers = {};
      markers.add( //repopulate markers
          Marker(
              markerId: MarkerId("current_user_position"),
              position: LatLng(lat, long), //move to new location
              icon: BitmapDescriptor.defaultMarker
          )
      );

      addPolyline();
      //print("@#$@$#@$@#$@#@#$@#$@#$@ GMCONG2 ______________________________________________________________________");
      setState(() {
        print("GPS updated");
      });

    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    sub.cancel();
  }

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      minimum: EdgeInsets.only(top: 40),
        child: Scaffold(
            appBar: CustomAppBar("걸어 보자!"),
    body: SingleChildScrollView(
        child: Container(
            color: backgroundColor,
            height: 650,
            child: Column(
              children: [
                Container(
                    child: GoogleMap(
                        initialCameraPosition: CameraPosition(
                        target: LatLng(lat!, long!),
                        zoom: 17.5,
                      ),
                      markers: markers,
                      polylines: _polylines,
                      onMapCreated: (mapController) {
                        setState(() {
                          addPolyline();
                          _controller.complete(mapController);
                        });
                      },
                    ),
                    color: mainColor,
                    height: 400,
                    margin: const EdgeInsets.all(8.0)),
                Container(
                  margin: EdgeInsets.only(left: 20, right: 50),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                          margin: EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SmallTitle("걸은 시간"),
                              Text(
                                "00:00:00",
                                style: TextStyle(
                                    color: Colors.black,
                                    letterSpacing: 1,
                                    fontSize: 40,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          )),
                      Container(
                          margin: EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SmallTitle("사진 기록"),
                              Row(
                                children: [
                                  Text(
                                    "00",
                                    style: TextStyle(
                                      color: highlightColor,
                                      letterSpacing: 1,
                                      fontSize: 40,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    "개",
                                    style: TextStyle(
                                        color: greyScale2,
                                        fontSize: 14,
                                        height: 2.7),
                                  ),
                                ],
                              )
                            ],
                          ))
                    ],
                  ),
                ),
                Container(
                  width: 350,
                  child: CustomButton("그만 걷기"),
                )
              ],
            )))),
    );
  }
}
