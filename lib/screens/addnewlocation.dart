import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import 'package:travelpointer/classes/addanewlocation.dart';
import 'package:travelpointer/components/categorieswithicons.dart';

class AddaNewLocation extends StatefulWidget {
  final Function addlocation;
  AddaNewLocation({this.addlocation});
  @override
  _AddaNewLocationState createState() => _AddaNewLocationState();
}

class _AddaNewLocationState extends State<AddaNewLocation> {
  Completer<GoogleMapController> _controller = Completer();
  AddANewLocation newlocationdata = AddANewLocation();
  var stepperForm = "collect_map_coordinates";
  var zoom = null;
  TextEditingController _nameoftheplacetexfieldController;
  TextEditingController _descriptionoftheplacetexfieldController;

  @override
  void initState() {
    super.initState();
    _nameoftheplacetexfieldController = TextEditingController();
    _descriptionoftheplacetexfieldController = TextEditingController();
    _goToTheLake();
  }

  Set<Marker> _markers = {};
  static const LatLng _center = const LatLng(22.5937, 78.9629);
  static final CameraPosition _kGooglePlex = CameraPosition(
    target: _center,
    zoom: 5,
  );
  static final CameraPosition _kLake = CameraPosition(
    target: LatLng(37.43296265331129, -122.08832357078792),
    zoom: 15.00,
  );
  LatLng _lastMapPosition = _center;

  void _onCameraMove(CameraPosition position) {
    _lastMapPosition = position.target;
    setState(() {
      zoom = position.zoom;
    });
  }

  var category = null;
  void setCategory(String categoryType) {
    setState(() {
      category = categoryType;
    });
  }

  bool titleerror = false;
  bool descriptionerror = false;
  void saveTheNewLocation() async {
    Provider.of<AddANewLocation>(context, listen: false).setTitleDescription(
        _nameoftheplacetexfieldController.text,
        _descriptionoftheplacetexfieldController.text);

    // var token = await FirebaseAuth.instance.currentUser.getIdToken(true);
    // var uid = FirebaseAuth.instance.currentUser.uid;
    var body =
        Provider.of<AddANewLocation>(context, listen: false).newLocationInfo;
    widget.addlocation({
      ...body,
      'optimalZoom': zoom,
      'optimalCoordinates': [
        _lastMapPosition.latitude,
        _lastMapPosition.longitude,
      ]
    });
    Navigator.pop(context);
    // http.Response response =
    //     await RestAPI().postTheRequest('user/$uid/location', body, token);
    // if (response.statusCode == 200) {
    //   var userlocation = jsonDecode(response.body);
    //   print(userlocation['result'][0]['_id']);
    //   print(userlocation['result'][0]['location']['coordinates']);
    //   Provider.of<AllData>(context, listen: false)
    //       .setanotherMarker(userlocation['result']);
    //   Navigator.of(context).pushNamedAndRemoveUntil(
    //       'showthelocations', (Route<dynamic> route) => false,
    //       arguments: {
    //         'latlang': LatLng(
    //           double.parse(
    //               userlocation['result'][0]['location']['coordinates'][0]),
    //           double.parse(
    //               userlocation['result'][0]['location']['coordinates'][1]),
    //         ),
    //         'id': userlocation['result'][0]['_id']
    //       });
    // }
  }

  @override
  Widget build(BuildContext context) {
    Widget selectedElements() {
      if (stepperForm == "collect_map_coordinates") {
        return Column(
          children: [
            Expanded(
              child: Stack(
                children: [
                  GoogleMap(
                    mapType: MapType.normal,
                    myLocationEnabled: true,
                    initialCameraPosition: _kGooglePlex,
                    onMapCreated: (GoogleMapController controller) {
                      _controller.complete(controller);
                    },
                    onCameraMove: _onCameraMove,
                    markers: _markers,
                  ),
                  Center(
                    child: Image.asset(
                      'assets/locationmarker.png',
                      width: 40.0,
                    ),
                  )
                ],
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: FlatButton(
                    color: Colors.lightBlueAccent,
                    textColor: Colors.white,
                    disabledColor: Colors.grey,
                    disabledTextColor: Colors.black,
                    splashColor: Colors.blueAccent,
                    height: 50.0,
                    onPressed: () => Navigator.pop(context),
                    child: Text(
                      'Cancel',
                      style: TextStyle(fontSize: 13.0),
                    ),
                  ),
                ),
                Expanded(
                  child: FlatButton(
                    color: Colors.green,
                    textColor: Colors.white,
                    disabledColor: Colors.grey,
                    disabledTextColor: Colors.black,
                    splashColor: Colors.blueAccent,
                    height: 50.0,
                    onPressed: () async {
                      Provider.of<AddANewLocation>(context, listen: false)
                          .setSaveCurrentLocation([
                        _lastMapPosition.latitude,
                        _lastMapPosition.longitude,
                      ]);
                      setState(() {
                        stepperForm = "select_category";
                      });

                      //Navigator.of(context).pushNamed('selectlocationcategory');
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (BuildContext context) =>
                      //         SelectLocationCategory(),
                      //   ),
                      // );
                      // final coordinates = new Coordinates(
                      //     newlocationdata.currentLocationData[1],
                      //     newlocationdata.currentLocationData[0]);
                      // var address = await Geocoder.local
                      //     .findAddressesFromCoordinates(coordinates);
                      // newlocationdata.city = address.first.locality;
                    },
                    child: Text(
                      'Next',
                      style: TextStyle(fontSize: 13.0),
                    ),
                  ),
                ),
              ],
            )
          ],
        );
      } else if (stepperForm == "select_category") {
        return Padding(
          padding: EdgeInsets.only(left: 16, right: 16, top: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Category",
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),
              Divider(),
              SizedBox(
                height: 30.0,
              ),
              Expanded(
                child: Wrap(
                  spacing: 20.0,
                  runSpacing: 20.0,
                  children: [
                    CategoriesWithIcons(
                      imgurl: 'assets/icons8-beach-100.png',
                      title: 'Beach',
                      setCategoryFunc: setCategory,
                      category: category,
                    ),
                    CategoriesWithIcons(
                      imgurl: 'assets/icons8-restaurant-100.png',
                      title: 'Restaurant',
                      setCategoryFunc: setCategory,
                      category: category,
                    ),
                    CategoriesWithIcons(
                      imgurl: 'assets/icons8-hindu-temple-96.png',
                      title: 'Temple',
                      setCategoryFunc: setCategory,
                      category: category,
                    ),
                    CategoriesWithIcons(
                      imgurl: 'assets/icons8-national-park-100.png',
                      title: 'Park',
                      setCategoryFunc: setCategory,
                      category: category,
                    ),
                    CategoriesWithIcons(
                      imgurl: 'assets/icons8-theme-park-96.png',
                      title: 'Theme Park',
                      setCategoryFunc: setCategory,
                      category: category,
                    ),
                  ],
                ),
              ),
              category == null
                  ? Container(
                      child: Center(
                        child: Text(
                          'Please choose a category',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      color: Color(0xFFff6666),
                      width: MediaQuery.of(context).size.width,
                      height: 50.0,
                    )
                  : Text(""),
              SizedBox(
                height: 10.0,
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 5.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextButton(
                        child: Text(
                          'Cancel',
                          style: TextStyle(color: Colors.black),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: TextButton.styleFrom(
                          primary: Colors.white,
                          minimumSize:
                              Size(MediaQuery.of(context).size.width, 60),
                          padding: EdgeInsets.symmetric(horizontal: 16.0),
                          shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(5.0)),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: TextButton(
                        child: Text(
                          'Next',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () {
                          if (category == null) {
                          } else {
                            Provider.of<AddANewLocation>(context, listen: false)
                                .setCategory(category);
                            setState(() {
                              stepperForm = "add_description";
                            });
                          }
                        },
                        style: TextButton.styleFrom(
                          primary: Colors.white,
                          minimumSize:
                              Size(MediaQuery.of(context).size.width, 60),
                          padding: EdgeInsets.symmetric(horizontal: 16.0),
                          shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(5.0)),
                          ),
                          backgroundColor: Colors.blue,
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      } else if (stepperForm == "add_description") {
        return Container(
          padding: EdgeInsets.only(left: 10.0, right: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Description",
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),
              Divider(),
              SizedBox(
                height: 30.0,
              ),
              TextField(
                controller: _nameoftheplacetexfieldController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Name of the place (required)',
                  errorText: titleerror ? "Cannot be empty" : null,
                ),
              ),
              SizedBox(
                height: 30.0,
              ),
              TextField(
                controller: _descriptionoftheplacetexfieldController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Description of the place (required)',
                  errorText: descriptionerror ? "Cannot be empty" : null,
                ),
              ),
              SizedBox(
                height: 30.0,
              ),
              TextButton(
                child: Text(
                  'Save the location',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  if (_nameoftheplacetexfieldController.text.isEmpty) {
                    setState(() {
                      titleerror = true;
                    });
                    return;
                  }
                  if (_descriptionoftheplacetexfieldController.text.isEmpty) {
                    setState(() {
                      descriptionerror = true;
                    });
                    return;
                  }
                  setState(() {
                    titleerror = false;
                    descriptionerror = false;
                  });
                  saveTheNewLocation();
                },
                style: TextButton.styleFrom(
                  primary: Colors.white,
                  minimumSize: Size(MediaQuery.of(context).size.width, 60),
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  ),
                  backgroundColor: Colors.blue,
                ),
              ),
            ],
          ),
        );
      }
    }

    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Color(0xFF05a859),
      //   leading: IconButton(
      //     icon: Icon(Icons.arrow_back, color: Colors.black),
      //     onPressed: () => Navigator.pop(context),
      //   ),
      //   title: Text('Add a new location'),
      //   actions: <Widget>[
      //     IconButton(
      //       icon: Icon(Icons.search),
      //       onPressed: () {
      //         showSearch(
      //           context: context,
      //           delegate: LocationSearch(),
      //         );
      //       },
      //     ),
      //   ],
      // ),
      body: SafeArea(child: selectedElements()),
      floatingActionButton: stepperForm == "collect_map_coordinates"
          ? FloatingActionButton(
              onPressed: () => _goToTheLake(),
              child: Icon(Icons.my_location),
            )
          : null,
    );
  }

  Future<void> _goToTheLake() async {
    Location location = new Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _locationData = await location.getLocation();
    // newlocationdata.currentLocationData = [
    //   _locationData.longitude,
    //   _locationData.latitude
    // ];
    // print(_locationData.longitude);
    // print(_locationData.latitude);

    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target: LatLng(_locationData.latitude, _locationData.longitude),
      zoom: 17.00,
    )));
  }
}
