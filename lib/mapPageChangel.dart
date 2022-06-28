import 'dart:ui';
import 'dart:math' show cos, sqrt, asin;
import 'package:changel/provider/navigation_provider.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_map_marker_popup/flutter_map_marker_popup.dart';
import 'package:geolocator/geolocator.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import 'package:location/location.dart' as loc;

import 'Models/changel.dart';
import 'Models/user.dart';


/// get response from OSM
class NetworkHelper {
  NetworkHelper({required this.sLat, required this.sLng, required this.eLat, required this.eLng});

  final String url = 'https://api.openrouteservice.org/v2/directions/';
  final String apiKey = '5b3ce3597851110001cf6248cc1a4f9513c240db9f9b1752093f1ddc';
  final String journeyMode = 'driving-car'; // Change it if you want or make it variable
  final double sLat;
  final double sLng;
  final double eLat;
  final double eLng;

  /// send request to osm
  Future getData() async {
    http.Response response = await http.get(Uri.parse('$url$journeyMode?api_key=$apiKey&start=$sLng,$sLat&end=$eLng,$eLat'));
    print("### Url used ==> $url$journeyMode?$apiKey&start=$sLat,$sLng&end=$eLat,$eLng");
    if (response.statusCode == 200) {
      //succed
      String data = response.body;

      return jsonDecode(data);
    } else {
      print('respons code => ${response.statusCode}');
    }
  }
}


///OSM
class ChangelMap extends StatefulWidget {
  @override
  _ChangelMapState createState() => _ChangelMapState();
}

class _ChangelMapState extends State<ChangelMap> {
  AppUser currUser = AppUser();


  List<MonumentMarker> clients =[];
  bool isSharing=false;
  bool drawPoly=false;
  /// polylines
  var data;
  final List<LatLng> routePolys = [];
  final PopupController _popupLayerController = PopupController();
  // Location location = Location();//explicit reference to the Location class
  // Future _checkGps() async {
  //   if (!await location.serviceEnabled()) {
  //     location.requestService();
  //   }
  // }
  bool trackUser = false;
  Timer _timerUser = Timer.periodic(Duration(seconds: 1), (_) {});
  /// path li mcheh (awl pt => gps) green
  double distanceToWalk = 0.0;

  ///dest
  double destLat = 35.9362813;
  double destLng = 10.6118399;
  ///Client
  double userLat = 0.0;
  double userLng = 0.0;
  String phone = '98568456';
  String name = 'hsan';

  // refresh path
  int TimeToUpdatePath = 5;
  int secToUpdatePath = 0;
  // refresh curr loc
  int TimeToUpdateCurrLoc = 2;
  int secToUpdateCurrLoc = 0;
  int gpsIsActive = 0;
  final MapController _mapController = MapController();
  double initZoom = 10.0;
  Timer _timer = Timer.periodic(Duration(seconds: 1), (_) {});

  /// dest Marker  decla
  Marker destMarker = Marker(
    rotate: true,
    width: 0.0,
    height: 0.0,
    point: LatLng(35.835569, 10.595069),
    builder: (ctx) => Container(),
  );

  /// user marker decla
  Marker userMarker = Marker(
    rotate: true,
    width: 0.0,
    height: 0.0,
    point: LatLng(0.0, 0.0),
    builder: (ctx) => Container(),
  );

  Future<void> requestPermissionLoc() async {
    LocationPermission permission;
    permission = await Geolocator.requestPermission();
  }
  @override
  void initState() {
    super.initState();
    /// get curr user from provider
    final provider = Provider.of<NavigationProviderUser>(context,listen: false);
    currUser = provider.user;

    requestPermissionLoc();
    checkGpsUser();
    // _timerUser = Timer.periodic(Duration(seconds: 1), (t) {
    //   checkGpsUser();
    // });
  }


  /// btn track=>true & track=>false
  checkGpsUser()async{
    loc.Location location =  loc.Location();
    bool isOn = await location.serviceEnabled();
    if (!isOn) { //if defvice is off
      bool isturnedon = await location.requestService();
      if (isturnedon) {
        print("GPS device is turned ON");
      }else{
        print("GPS Device is still OFF");
      }
    }
    // var isGpsEnabled = await Geolocator.isLocationServiceEnabled();
    // if (trackUser ) {
    //   locateUser();
    // }
  }


  Future<void> locateUser({bool? cameraFollow}) async {
    Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.best,
      //forceAndroidLocationManager: true,
    ).then((Position position) {
      setState(()  {
        userLat = position.latitude;
        userLng = position.longitude;
        print('### user pos ==> $userLat - $userLng');
        userMarker = Marker(
          rotate: true,
          width: 140.0,
          height: 140.0,
          point: LatLng(userLat, userLng),
          builder: (ctx) => Container(
            child: Icon(
              Icons.place,
              color: Colors.blue,
              size: 25,
            ),
          ),
        );
        /// add position to realTime
         addCurrLocToDB();


      });
    }).catchError((e) {
      print('## cant locate user => $e');
    });
  }

  Future addCurrLocToDB()async{

    DatabaseReference clients = FirebaseDatabase.instance.ref("/changels");
    final snapshot = await clients.get();
    /// get this from curr user
    Map<String, dynamic> client = {
      'phone': currUser.phone,
      'name':currUser.name,
      'pos' : {
        "lat": '$userLat',
        "lng": '$userLng',
      }
    };
    try{
      var data = Map<String, dynamic>.from(snapshot.value as Map);
      print('changels number : ${data.length}');

      await clients.update({
        currUser.id : client,
      }).then((value){

        // show snack
        Get.snackbar(
          "your location is visible now",
          "you can see changels markers",
        );
        /// load changelMarkers
        loadClientsMarkers();

      } );

    }catch(e){
      print('### $e');
      print('clients number : NULL}');

      await clients.update({
        currUser.id: client,
      }).then((value){
        // show snack
        Get.snackbar(
          "your location is visible now",
          "you can see changels markers",
        );
        /// load changelMarkers
        loadClientsMarkers();

      } );
    }
  }

  ///Timer
  void startTimer() {
    // if gps stopped
    if (!isSharing) {

      Fluttertoast.showToast(
          msg: "le suivi a commencé",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black38,
          textColor: Colors.white,
          fontSize: 16.0);

      /// each X(1) sec update_gps >> TimeToUpdateGps
      _timer = Timer.periodic(Duration(seconds: 1), (t) {

        setState((){
          distanceToWalk = calculDist(routePolys);
        });
       // print(('/// dis to walk = $distanceToWalk'));

        ///camera follow gps
        //_mapController.move(LatLng(gpsLat, gpsLng), 16.0);
        /// each X(5) sec update_path >> TimeToUpdatePath
        if (secToUpdatePath >= TimeToUpdatePath) {
          if(drawPoly){
            drawPath(userLat,userLng,destLat,destLng);
          }
          secToUpdatePath = 0;
        } else {
          secToUpdatePath++;
        }
        /// each X(2) sec update_curr_loc >> TimeToUpdatePath
        if (secToUpdateCurrLoc >= TimeToUpdateCurrLoc) {


          locateUser();

          secToUpdateCurrLoc = 0;
        } else {
          secToUpdateCurrLoc++;
        }

        print('### Timer Running ....');
      });
    }
    else {

      Fluttertoast.showToast(
          msg: "le suivi a déjà commencé",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black38,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  void endTimer() {
    if (isSharing) {
      Fluttertoast.showToast(
          msg: "le suivi arrêté",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black38,
          textColor: Colors.white,
          fontSize: 16.0);

      print('### End Timer');
      _timer.cancel();
    } else {
      Fluttertoast.showToast(
          msg: "le suivi a déjà arrêté",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black38,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  @override
  void dispose() {
    print('### End Timer');

    _timer.cancel();
    super.dispose();
  }

  //calcul disatance
  double calculDist(List<LatLng> polyline) {
    double totalDistance = 0;

    if (polyline.isNotEmpty) {
      print('##########" routePolys passing');
      print('poly= $polyline');

      double calculateDistance(lat1, lon1, lat2, lon2) {
        var p = 0.017453292519943295;
        var c = cos;
        var a = 0.5 - c((lat2 - lat1) * p) / 2 + c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
        return 12742 * asin(sqrt(a));
      }

      for (var i = 0; i < polyline.length - 1; i++) {
        totalDistance += calculateDistance(polyline[i].latitude, polyline[i].longitude, polyline[i + 1].latitude, polyline[i + 1].longitude);
      }

      print('#### distance= $totalDistance');
    }

    return totalDistance;
  }

  loadClientsMarkers()async{
    clients.clear();

    DatabaseReference gpsRef = FirebaseDatabase.instance.ref('/clients');
    final snapshot = await gpsRef.get();
    var data = Map<String, dynamic>.from(snapshot.value as Map);


    data.forEach((key, value) {
      if (this.mounted) {
        setState(() {
          var lat = double.parse(data[key]['pos']['lat']);
          var lng = double.parse(data[key]['pos']['lng']);

          /// for getting changels markers
          AppUsr  usrMarker =AppUsr(
            name: data[key]['name'],
            phone: data[key]['phone'],
            lat: lat,
            lng: lng,
          );
          clients.add(
            MonumentMarker(
                monument: usrMarker
            ),
          );
        });
      }
    });

    print('### changel marker number: ${clients.length}');
  }

  void drawPath(gpsLat,gpsLng,endLat,endLng) async {
    NetworkHelper network = NetworkHelper(
      sLat: gpsLat,
      sLng: gpsLng,
      eLat: endLat,
      eLng: endLng,
    );

    try {
      //print('###### TRY getting network data');
      /// save all point between (gps-dest) to Raw Data
      data = await network.getData(); //json Decoded data

      ///  routePolys => list of type <Latlng> holding point betwwen (gps-dest)
      routePolys.clear();

      // We can reach to our desired JSON data manually as following
      //LineString ls = LineString(data['features'][0]['geometry']['coordinates']);
      List<dynamic> lineString = (data['features'][0]['geometry']['coordinates']);

      /// depends on json forma //coordinates=lat & lng of all point

      // list of coordinates of all points
      /// save all points to from Json Row Data to routePolys List
      for (int i = 0; i < lineString.length; i++) {
        routePolys.add(LatLng(lineString[i][1],lineString[i][0]));
      }
      print('###### routePolys length => ${routePolys.length}');

      // if (routePolys.length == ls.lineString.length) {
      //   //print('#### lineString = $ls');
      //   //print(routePolys);
      // }
    } catch (e) {
      print('### EXEP: $e');
      //print(routePolys);
    }
  } // if 404 check the dest & gps markers they should be in readable positions

  ///################################################################

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          /// display map
          FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              interactiveFlags: InteractiveFlag.pinchZoom | InteractiveFlag.drag | InteractiveFlag.pinchMove | InteractiveFlag.flingAnimation,

              center: LatLng(0.0, 0.0),
              zoom: initZoom,

              maxZoom: 17,
              //close
              minZoom: 1,
              //far
              onTap: (_, __) =>
              {
                drawPoly = false,
                routePolys.clear(),
                _popupLayerController.hideAllPopups(),
              }

        


            ),

            children: <Widget>[
              /// map_display
              TileLayerWidget(
                options: TileLayerOptions(
                  urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                  subdomains: ['a', 'b', 'c'],
                  tileProvider: NonCachingNetworkTileProvider(),
                ),
              ),

              /// path to dest (purple) changable each 5 sec
              PolylineLayerWidget(
                options: PolylineLayerOptions(
                  polylines: [
                    Polyline(points: routePolys, strokeWidth: 4.0, color: Colors.purple),
                  ],
                ),
              ),

              ///markers /// user marker
              MarkerLayerWidget(
                  options: MarkerLayerOptions(
                    markers: <Marker>[
                      userMarker,
                    ],
                  )),

              ///markers /// clients marker
              PopupMarkerLayerWidget(
                options: PopupMarkerLayerOptions(
                  markers: clients,
                  popupController: _popupLayerController,
                  popupBuilder: (_, Marker marker) {
                    if (marker is MonumentMarker) {
                    destLat = marker.point.latitude;
                      destLng = marker.point.longitude;
                      drawPoly = true;
                      print('draw to << $destLat , $destLng >>');
                      return MonumentMarkerPopup(monument: marker.monument);
                    }
                    return const Card(child: Text(''));
                  },
                ),
              ),
            ],
          ),
          
          ///refresh
          Positioned(
            bottom: 30,
            left: 10,
            child: isSharing ?
            FloatingActionButton.extended(
              heroTag: "partagé",
              label: Row(
                children:  const [
                   Icon(
                    Icons.gps_fixed,
                    size: 24.0,
                    color: Colors.white,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 10.0),
                    child: Text('Partagé',
                      textAlign: TextAlign.center,),
                  ),
                ],
              ),
              backgroundColor: Colors.grey[500] ,

              onPressed: () async{
                endTimer();


                  setState((){
                    isSharing =false;

                  });
                    },
            ) 
                :FloatingActionButton.extended(
              heroTag: "partager",
              label: Row(
                children:  const [
                   Icon(
                    Icons.gps_fixed,
                    size: 24.0,
                    color: Colors.white,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 10.0),
                    child: Text('Partager',
                      textAlign: TextAlign.center,),
                  ),
                ],
              ),
              backgroundColor: Colors.blue ,

              onPressed: () async{
                startTimer();
                setState((){
                  isSharing =true;

                });
              },
            ),
          ),

          ///Distace rest
          Positioned(
            bottom: 170,
            left: 10,
            child: Container(
              child: Text('distance: ${(distanceToWalk * 1000).ceil()} m'),
            ),
          ),



        ],
      ),
    );
  }
}
