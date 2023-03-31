//import 'dart:ffi';
import 'dart:io';
import 'dart:ui' as ui;
import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:largo/models/MarkerInfo.dart';
import 'package:largo/service/APIService.dart';
import 'package:largo/viewmodel/newLocationViewModel.dart';

// 라우터
import 'package:largo/router/router.dart';
import 'package:largo/views/walkingDoneView.dart';

// Widget
import 'package:largo/widgets/customAppbar.dart';
import 'package:largo/widgets/customSlider.dart';
import 'package:largo/widgets/customButton.dart';

// Colors
import 'package:largo/color/themeColors.dart';
import 'package:largo/widgets/smallTitle.dart';

// API
import 'dart:async';

import 'package:google_maps_flutter/google_maps_flutter.dart';

//model
import 'package:largo/models/userLocationInfo.dart';

// GPS
import 'package:largo/service/LocationService.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:path/path.dart' show join;
import 'package:path_provider/path_provider.dart';

//
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'dart:math' show cos, sqrt, asin;
import 'package:http/http.dart' as http;

import '../models/PlaceInfo.dart';
import '../screen/screen_detail.dart';

enum TtsState { ready, playing, stopped, paused, continued, complited}

class WalkingView extends StatefulWidget {
  @override
  _WalkingView createState() => _WalkingView();
}

class _WalkingView extends State<WalkingView> {
  Completer<GoogleMapController> _controller = Completer();
  final LocationService _positionStream = LocationService();
  late StreamSubscription sub;

  final FlutterTts tts = FlutterTts();
  final TextEditingController textEditingController =
  TextEditingController(text: 'Hello world');
  var isSpeaking = TtsState.ready;

  Set<Marker> markers = Set(); //markers for google map
  var mymarkers = [];
  var positionList = [];
  List<int> explainExlusive = [];
  var polylineidx = 1;

  Set<Polyline> _polylines = Set<Polyline>();
  PolylinePoints polylinePoints = PolylinePoints();
  List<LatLng> polylineCoordinates = [];
  late PlaceInfo explain;

  double lat = 37.544986;
  double long = 126.964370;
  String timeString = "00:00:00";
  String imageString = "00";

  late Timer timer;
  var second = 0; // 초
  var min = 0; // 분
  var hour = 0; // 시간
  double totalDistance = 0.0; // 총거리

  final picker = ImagePicker();
  List<Uint8List> images = [];
  var globalKey = new GlobalKey();

  Stopwatch stopwatch = Stopwatch();

  String mapImageUrl = "";
  List<String> userImageUrl = [];

  Uint8List? map_snapshot;

  void start() {
    stopwatch.start();
    timer = Timer.periodic(Duration(seconds: 1), update);
  }

  void update(Timer t) {
    if (stopwatch.isRunning) {
      setState(() {
        timeString =
            (stopwatch.elapsed.inHours % 60).toString().padLeft(2, "0") +
                ":" +
                (stopwatch.elapsed.inMinutes % 60).toString().padLeft(2, "0") +
                ":" +
                (stopwatch.elapsed.inSeconds % 60).toString().padLeft(2, "0");
      });
    }
  }

  void stop() {
    setState(() {
      timer.cancel();
      stopwatch.stop();
    });
  }

  // 비동기 처리를 통해 카메라와 갤러리에서 이미지를 가져온다.
  Future getImage(ImageSource imageSource) async {
    final image = await picker.pickImage(source: imageSource);

    markers.add(//repopulate markers
        Marker(
            markerId: MarkerId("${image.hashCode}"),
            position: LatLng(lat, long), //move to new location,
            icon: await getMarkerIcon(File(image!.path), 150.0)));

    setState(() {

    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    addPlaceMarkers();
    addMarkers();
    getCurrentLocation();
    start();
    tts.setLanguage('kr');
    tts.setSpeechRate(0.6);
    tts.setVolume(1.4);
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
    sub?.cancel();
    stop();
    _stop();
    _controller.complete();
    super.dispose();
  }

  Future<ui.Image> getImageFromPath(File image) async {
    Uint8List imageBytes = image.readAsBytesSync();
    //String a = await APIService().uploadImage("test.jpg", imageBytes!);
    //userImageUrl.add(a);

    final Completer<ui.Image> completer = new Completer();

    ui.decodeImageFromList(imageBytes, (ui.Image img) {
      return completer.complete(img);
    });

    setState(() {
      images.add(imageBytes); // 가져온 이미지를 _image에 저장
      imageString = images.length.toString().padLeft(2, "0");
    });

    return completer.future;
  }

  Future<BitmapDescriptor> getMarkerIcon(File imageFile, double size) async {
    final ui.PictureRecorder pictureRecorder = ui.PictureRecorder();
    final Canvas canvas = Canvas(pictureRecorder);

    final Radius radius = Radius.circular(size / 2.0);

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
          Rect.fromLTWH(0.0, 0.0, size, size),
          topLeft: radius,
          topRight: radius,
          bottomLeft: radius,
          bottomRight: radius,
        ),
        shadowPaint);

    // Add border circle
    canvas.drawRRect(
        RRect.fromRectAndCorners(
          Rect.fromLTWH(shadowWidth, shadowWidth, size - (shadowWidth * 2),
              size - (shadowWidth * 2)),
          topLeft: radius,
          topRight: radius,
          bottomLeft: radius,
          bottomRight: radius,
        ),
        borderPaint);

    // Add tag circle
    canvas.drawRRect(
        RRect.fromRectAndCorners(
          Rect.fromLTWH(size - tagWidth, 0.0, tagWidth, tagWidth),
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
        Offset(size - tagWidth / 2 - textPainter.width / 2,
            tagWidth / 2 - textPainter.height / 2));

    // Oval for the image
    Rect oval = Rect.fromLTWH(imageOffset, imageOffset,
        size - (imageOffset * 2), size - (imageOffset * 2));

    // Add path for oval image
    canvas.clipPath(Path()..addOval(oval));

    // Add image // Alternatively use your own method to get the image
    ui.Image image = await getImageFromPath(
        imageFile); // Alternatively use your own method to get the image
    paintImage(canvas: canvas, rect: oval, image: image, fit: BoxFit.fitWidth);

    // Convert canvas to image
    final ui.Image markerAsImage = await pictureRecorder
        .endRecording()
        .toImage(size.toInt(), size.toInt());

    // Convert image to bytes
    final ByteData? byteData =
        await markerAsImage.toByteData(format: ui.ImageByteFormat.png);
    final Uint8List? uint8List = byteData?.buffer.asUint8List();

    return BitmapDescriptor.fromBytes(uint8List!);
  }

  addPlaceMarkers() async {
    APIService().fetchMarkers().then((val){
      print("Marker info ${val[0].longitude}");
      val.forEach((element) {
        print(element);
        markers.add(//repopulate markers
            Marker(
                markerId: MarkerId("marker_position_${element.id}"),
                position: LatLng(element.latitude, element.longitude), //move to new location
                draggable: true,
                onTap: () async{
                  final result = await Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ScreenDetail(element.id))
                  );},
                icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen)));
      });
    });

    setState(() { });
  }

  addMarkers() async {
    markers.add(//repopulate markers
        Marker(
            markerId: MarkerId("current_user_position"),
            position: LatLng(lat, long), //move to new location
            icon: BitmapDescriptor.defaultMarker));

    setState(() {
      //refresh UI
    });
  }

  addPolyline() async {
    setState(() {
      _polylines.add(Polyline(
          width: 8,
          polylineId: PolylineId(polylineidx.toString()),
          //color: Color.fromARGB(190, 255, 201, 119),
          color: Color.fromARGB(190, 252, 45, 82),
          points: polylineCoordinates));
      polylineidx++;
    });
  }

  Future _speak(String text) async{
    if(isSpeaking != TtsState.stopped) {
      var result = await tts.speak(text);
      print("TTS Result : ${result}, ${isSpeaking}");
      if (result == 1) setState(() => isSpeaking = TtsState.playing);
    }
  }

  Future _stop() async{
    var result = await tts.stop();
    if (result == 1) setState(() => isSpeaking = TtsState.stopped);
  }



  void getCurrentLocation() async {
    GoogleMapController googleMapController = await _controller.future;

    sub = _positionStream.controller.stream.listen((pos) async {
      lat = pos.latitude;
      long = pos.longitude;

      polylineCoordinates.add(LatLng(lat, long));
      positionList.add(LatLng(lat, long));

      print(
          "location saved : ${positionList.length}, ${polylineCoordinates.length} ******************************************");

      googleMapController.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            zoom: 17.5,
            target: LatLng(lat, long),
          ),
        ),
      );

      markers.add(//repopulate markers
          Marker(
            markerId: MarkerId("current_user_position"),
            position: LatLng(lat, long), //move to new location
            icon: BitmapDescriptor.defaultMarker),
        );
      addPolyline();

      print("isSpeaking ${isSpeaking}");

      tts.setCompletionHandler(() {
        setState(() {
          isSpeaking = TtsState.complited;
        });
      });

      if(isSpeaking != TtsState.stopped){
        explain = await APIService().fetchPlaceInfo(lat, long, explainExlusive);
        _speak(explain.info);
        explainExlusive.add(explain.id);
      }
      //print("@#$@$#@$@#$@#@#$@#$@#$@ GMCONG2 ______________________________________________________________________");
      setState(() {
        print("GPS updated");
      });
    });
  }

  double calculateDistance(lat1, lon1, lat2, lon2){
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 - c((lat2 - lat1) * p)/2 +
        c(lat1 * p) * c(lat2 * p) *
            (1 - c((lon2 - lon1) * p))/2;
    return 12742 * asin(sqrt(a));
  }

  var mid_lat = 0.0;
  var mid_lon = 0.0;

  void calcTotalDistance() {
    for(var i = 0; i < positionList.length-1; i++){
      totalDistance += calculateDistance(positionList[i].latitude, positionList[i].longitude, positionList[i+1].latitude, positionList[i+1].longitude);
      mid_lat += positionList[i].latitude;
      mid_lon += positionList[i].longitude;
    }
    mid_lat += positionList.last.latitude;
    mid_lon += positionList.last.longitude;

    mid_lat = mid_lat / positionList.length;
    mid_lon = mid_lon / positionList.length;

  }



  void takeSnapShot() async {

    GoogleMapController controller = await _controller.future;
    controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          zoom: 17.5 - (totalDistance * 1.5),
          target: LatLng(mid_lat, mid_lon),
        ),
      ),
    );
    snapShot();
  }

  Future<void> snapShot() async {
    final directory = (await getApplicationDocumentsDirectory()).path;
    File imgFile = new File('$directory/screenshot.png');

    GoogleMapController controller = await _controller.future;
    await controller.takeSnapshot().then((value) => map_snapshot = value);
    imgFile.writeAsBytes(map_snapshot!);

    print("FINISH CAPTURE ${imgFile.path}");

    // await APIService().uploadImage("test_map.jpg", map_snapshot!).then((value) => {
    //   mapImageUrl = value
    // });
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
                          RepaintBoundary(
                          key: globalKey,
                            child: Container(
                                child:  GoogleMap(
                                  initialCameraPosition: CameraPosition(
                                    target: LatLng(lat!, long!),
                                    zoom: 16.5,
                                  ),
                                  myLocationButtonEnabled: false,
                                  markers: markers,
                                  polylines: _polylines,
                                  onMapCreated: (mapController) {
                                    setState(() {
                                      addPolyline();
                                      _controller.complete(mapController);
                                    });
                                  },
                                ),
                                height: 400,
                                margin: const EdgeInsets.all(8.0)),
                          ),
                          Positioned(
                            bottom: 30,
                            left: 20,
                            child: Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                color: backgroundColor,
                                borderRadius: BorderRadius.circular(50),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.7),
                                    blurRadius: 6.0,
                                    spreadRadius: 0.0,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: IconButton(
                                  icon: Icon(Icons.camera_alt),
                                  iconSize: 20,
                                  color: greyScale6,
                                  onPressed: () {
                                    getImage(ImageSource.camera);
                                  }),
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
                                      timeString,
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
                                          imageString,
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
                          child: CustomButton(
                            GestureDetector(
                              child: Text(
                                "그만 걷기",
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: greyScale4),
                              ),
                              onTap: () {
                                print("그만 걷기 ");
                                _stop();
                                stop();
                                calcTotalDistance();
                                takeSnapShot();

                                sub?.cancel();

                                Future.delayed(Duration(seconds: 2), () {
                                print("total Distance ${totalDistance} ${map_snapshot} ${timeString} ${totalDistance} ${polylineCoordinates} ${images}");
                                Navigator.pushNamedAndRemoveUntil(
                                    context, '/walking/walkingDone',
                                        (route) => false,
                                    arguments: WalkingDoneViewArguments(
                                        map_snapshot,
                                        timeString,
                                        totalDistance,
                                        polylineCoordinates,
                                        images
                                    )
                                );
                                });
                              },
                            ),
                          ))
                    ],
                  )))),
    );
  }
}