//import 'dart:ffi';
import 'dart:io';
import 'dart:ui' as ui;
import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
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
import 'package:path/path.dart' show join;
import 'package:path_provider/path_provider.dart';

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

  final picker = ImagePicker();
  Set<File> images = Set<File>();

  // 비동기 처리를 통해 카메라와 갤러리에서 이미지를 가져온다.
  Future getImage(ImageSource imageSource) async {
    final image = await picker.pickImage(source: imageSource);
    final bytes = await image!.readAsBytes();

    markers.add( //repopulate markers
        Marker(
            markerId: MarkerId("${image.hashCode}"),
            position: LatLng(lat, long), //move to new location
            icon: await getMarkerIcon(File(image!.path), 150.0)
        )
    );

    setState(() {
      images.add(File(image!.path)); // 가져온 이미지를 _image에 저장
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    addMarkers();
    getCurrentLocation();

    // Camera
    //getCamera();
  }

  @override
  void setState(VoidCallback fn) {
    // TODO: implement setState
    super.setState(fn);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    sub.cancel();
    _controller.complete();
  }

  Future<ui.Image> getImageFromPath(File image) async {

    Uint8List imageBytes = image.readAsBytesSync();

    final Completer<ui.Image> completer = new Completer();

    ui.decodeImageFromList(imageBytes, (ui.Image img) {
      return completer.complete(img);
    });

    return completer.future;
  }

  Future<BitmapDescriptor> getMarkerIcon(File imageFile, double size) async {
    final ui.PictureRecorder pictureRecorder = ui.PictureRecorder();
    final Canvas canvas = Canvas(pictureRecorder);

    final Radius radius = Radius.circular(size/2.0);

    final Paint tagPaint = Paint()..color = Colors.blue;
    final double tagWidth = 40.0;

    final Paint shadowPaint = Paint()..color = Colors.blue.withAlpha(100);
    final double shadowWidth = 15.0;

    final Paint borderPaint = Paint()..color = Colors.white;
    final double borderWidth = 3.0;

    final double imageOffset = shadowWidth + borderWidth;

    // Add shadow circle
    canvas.drawRRect(
        RRect.fromRectAndCorners(
          Rect.fromLTWH(
              0.0,
              0.0,
              size,
              size
          ),
          topLeft: radius,
          topRight: radius,
          bottomLeft: radius,
          bottomRight: radius,
        ),
        shadowPaint);

    // Add border circle
    canvas.drawRRect(
        RRect.fromRectAndCorners(
          Rect.fromLTWH(
              shadowWidth,
              shadowWidth,
              size - (shadowWidth * 2),
              size - (shadowWidth * 2)
          ),
          topLeft: radius,
          topRight: radius,
          bottomLeft: radius,
          bottomRight: radius,
        ),
        borderPaint);

    // Add tag circle
    canvas.drawRRect(
        RRect.fromRectAndCorners(
          Rect.fromLTWH(
              size - tagWidth,
              0.0,
              tagWidth,
              tagWidth
          ),
          topLeft: radius,
          topRight: radius,
          bottomLeft: radius,
          bottomRight: radius,
        ),
        tagPaint);

    // Add tag text
    TextPainter textPainter = TextPainter(textDirection: TextDirection.ltr);
    textPainter.text = TextSpan(
      text: '1',
      style: TextStyle(fontSize: 20.0, color: Colors.white),
    );

    textPainter.layout();
    textPainter.paint(
        canvas,
        Offset(
            size - tagWidth / 2 - textPainter.width / 2,
            tagWidth / 2 - textPainter.height / 2
        )
    );

    // Oval for the image
    Rect oval = Rect.fromLTWH(
        imageOffset,
        imageOffset,
        size - (imageOffset * 2),
        size - (imageOffset * 2)
    );

    // Add path for oval image
    canvas.clipPath(Path()
      ..addOval(oval));

    // Add image // Alternatively use your own method to get the image
    ui.Image image = await getImageFromPath(imageFile); // Alternatively use your own method to get the image
    paintImage(canvas: canvas, rect: oval, image: image, fit: BoxFit.fitWidth);

    // Convert canvas to image
    final ui.Image markerAsImage = await pictureRecorder.endRecording().toImage(
        size.toInt(),
        size.toInt()
    );

    // Convert image to bytes
    final ByteData? byteData = await markerAsImage.toByteData(format: ui.ImageByteFormat.png);
    final Uint8List? uint8List = byteData?.buffer.asUint8List();

    return BitmapDescriptor.fromBytes(uint8List!);
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
                Stack(
                  children: [
                    Container(
                        child: GoogleMap(
                          initialCameraPosition: CameraPosition(
                            target: LatLng(lat!, long!),
                            zoom: 16.5,
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
                    Positioned(
                      bottom: 30,
                      left:20,
                      child: Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: backgroundColor,
                          borderRadius: BorderRadius.circular(50),
                          boxShadow: [BoxShadow(
                            color: Colors.grey.withOpacity(0.7),
                            blurRadius: 6.0,
                            spreadRadius: 0.0,
                            offset: const Offset(0,2),
                          ),],
                        ),
                        child: IconButton(
                          icon: Icon(Icons.camera_alt),
                          iconSize: 20,
                          color: greyScale6,
                          onPressed: ()  {
                            getImage(ImageSource.camera);
                          }
                        ),
                      ),
                    ),
                  ],
                ),
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

// 사용자가 촬영한 사진을 보여주는 위젯
class DisplayPictureScreen extends StatelessWidget {
  final String imagePath;

  const DisplayPictureScreen(this.imagePath);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Display the Picture')),
      // 이미지는 디바이스에 파일로 저장됩니다. 이미지를 보여주기 위해 주어진
      // 경로로 `Image.file`을 생성하세요.
      body: Image.file(File(imagePath)),
    );
  }
}
