import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:largo/models/MarkerInfo.dart';

// 라우터
import 'package:largo/router/router.dart';

// Widget
import 'package:largo/widgets/customAppbar.dart';
import 'package:largo/widgets/customSlider.dart';
import 'package:largo/widgets/customButton.dart';
import 'package:largo/widgets/smallTitle.dart';

// Colors
import 'package:largo/color/themeColors.dart';

// Slider Controller
import 'package:largo/models/sliderController.dart';

// API
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';

// API
import 'package:largo/service/APIService.dart';

// GPS
import 'package:geolocator/geolocator.dart';

// Colors
import 'package:largo/color/themeColors.dart';

import '../screen/screen_detail.dart';

class WalkingSettingView extends StatefulWidget {
  @override
  _WalkingSettingView createState() => _WalkingSettingView();
}

class _WalkingSettingView extends State<WalkingSettingView> {
  Completer<GoogleMapController> _controller = Completer();
  late Future<List<MarkerInfo>> markersInfo;
  Set<Marker> markers = Set(); //markers for google map

  var sliderContoller = SliderController(2);
  List<double> sliderVals = [17.5, 16, 16.3, 14.5, 13, 11];
  List<String> sliderValIndicators = [
    "10m",
    "100m",
    "500m",
    "1Km",
    "5Km",
    "10Km"
  ];

  double lat = 37.544986;
  double long = 126.964370;
  double zoom = 17.5;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    addPlaceMarkers();
    addMarkers();
    getCurrentLocation();
    zoom = sliderVals[sliderContoller.sliderValue];
  }

  @override
  void setState(VoidCallback fn) {
    // TODO: implement setState
    super.setState(fn);
  }

  addPlaceMarkers() async {
    APIService().fetchMarkers().then((val) {
      print("Marker info ${val.length}");
      val.forEach((element) {
        markers.add(//repopulate markers
            Marker(
                markerId: MarkerId("marker_position_${element.id}"),
                position: LatLng(element.latitude, element.longitude),
                draggable: true,//move to new locatio
                icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
                onTap: () async{
                  final result = await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ScreenDetail(element.id))
                  );
                },
            ),
        );
      });
    });

    setState(() { });

  }

  addMarkers() async {
    //markers = {};
    markers.add(//repopulate markers
        Marker(
            markerId: MarkerId("current_user_position"),
            position: LatLng(lat, long), //move to new location
            icon: BitmapDescriptor.defaultMarker));
  }

  mapReDraw() async {
    GoogleMapController googleMapController = await _controller.future;
    zoom = sliderVals[sliderContoller.sliderValue];

    googleMapController.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          zoom: zoom,
          target: LatLng(lat, long),
        ),
      ),
    );
  }

  Future<Position> getCurrentLocation() async {
    GoogleMapController googleMapController = await _controller.future;
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    lat = position.latitude;
    long = position.longitude;

    googleMapController.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          zoom: zoom,
          target: LatLng(lat, long),
        ),
      ),
    );

    //markers = {};
    markers.add(//repopulate markers
        Marker(
            markerId: MarkerId("current_user_position"),
            position: LatLng(lat, long), //move to new location
            icon: BitmapDescriptor.defaultMarker));
    //print("@#$@$#@$@#$@#@#$@#$@#$@ GMCONG2 ______________________________________________________________________");
    setState(() {});

    return position;
  }

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    double _height = MediaQuery.of(context).size.height - (statusBarHeight * 2);
    double _width = MediaQuery.of(context).size.width;
    double _cardHeight = _height * 0.72;
    double _cardWidth = _width * 0.52;
    double _innerImageHeight = _cardHeight * 0.83;
    double _innerImageWidth = _cardWidth * 0.95;

    // TODO: implement build
    return SafeArea(
        minimum: EdgeInsets.only(top: 40),
        child: Scaffold(
            appBar: CustomAppBar("걸어 볼까?"),
            body: SingleChildScrollView(
                child: Container(
                    color: backgroundColor,
                    height: 670,
                    child: Column(
                      children: [
                        Container(
                            child: GoogleMap(
                              mapType: MapType.normal,
                              myLocationButtonEnabled: false,
                              initialCameraPosition: CameraPosition(
                                target: LatLng(lat!, long!),
                                zoom: zoom,
                              ),
                              markers: markers,
                              onMapCreated: (GoogleMapController controller) {
                                _controller.complete(controller);
                              },
                            ),
                            color: mainColor,
                            height: 400,
                            margin: const EdgeInsets.all(8.0)),
                        Container(
                          width: 350,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                height: 10,
                              ),
                              Container(
                                width: 350,
                                child: Text(
                                  "    장소 검색 거리 반경",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: greyScale5,
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                              ),
                              Container(
                                height: 40,
                              ),
                              Container(
                                  child: SliderTheme(
                                data: SliderTheme.of(context).copyWith(
                                    activeTrackColor: mainColor,
                                    inactiveTrackColor: grayScale1,
                                    thumbColor: mainColor,
                                    activeTickMarkColor: mainColor,
                                    valueIndicatorColor: mainColor,
                                    showValueIndicator:
                                        ShowValueIndicator.always,
                                    trackHeight: 5,
                                    overlayColor: mainColor.withOpacity(0.2),
                                    overlayShape: RoundSliderOverlayShape(
                                        overlayRadius: 20.0),
                                    valueIndicatorShape:
                                        PaddleSliderValueIndicatorShape(),
                                    thumbShape: RoundSliderThumbShape(
                                        enabledThumbRadius: 10)),
                                child: Slider(
                                  value: sliderContoller.sliderValue.toDouble(),
                                  min: 0,
                                  max: 5,
                                  divisions: 5,
                                  label: sliderValIndicators[sliderContoller
                                      .sliderValue
                                      .toInt()], //'${contoller.sliderValue.round()}',
                                  onChanged: (double newValue) {
                                    setState(
                                      () {
                                        sliderContoller.sliderValue =
                                            newValue.toInt();
                                        mapReDraw();
                                      },
                                    );
                                  },
                                ),
                              )),
                              Container(
                                height: 10,
                              ),
                              Container(
                                width: 325,
                                child: Row(
                                  children: [
                                    Text(
                                      "10m",
                                      style: TextStyle(color: greyScale2),
                                    ),
                                    Text("10Km",
                                        style: TextStyle(color: greyScale2))
                                  ],
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                ),
                              ),
                              CustomButton(
                                GestureDetector(
                                  child: Text(
                                    "걷기 시작",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: greyScale4),
                                  ),
                                  onTap: () => Navigator.pushNamed(
                                      context, '/walking/walking'),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    )))));
  }
}
