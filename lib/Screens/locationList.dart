import 'dart:convert';
// import 'package:fluttertoast/fluttertoast.dart';
import 'package:activmind_app/Screens/Calendar.dart';
import 'package:activmind_app/Screens/HomeForm.dart';
import 'package:activmind_app/Screens/profilepage.dart';
import 'package:activmind_app/Screens/tasklist.dart';
import 'package:activmind_app/Screens/appsettingpage.dart';
import 'package:activmind_app/common/defftappages.dart';
import 'package:activmind_app/common/taskform.dart';
import 'package:flutter/material.dart';
import 'package:activmind_app/common/appandfooterbar.dart';
import 'package:activmind_app/common/csrf.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:geolocator/geolocator.dart';
import 'package:url_launcher/url_launcher.dart';

class LocationList extends StatefulWidget {
  const LocationList({super.key});

  @override
  State<LocationList> createState() => _LocationListState();
}

class _LocationListState extends State<LocationList> {
  Map<String, dynamic>? currentLocation;
  final TextEditingController _locationNameController = TextEditingController();

  String locationMessage = 'votre localisation actuelle';
  late String lat;
  late String long;
  @override
  void dispose() {
    _locationNameController.dispose();
    super.dispose();
  }

 


  Future<void> _getCurrentLocation(String locationName) async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);

      final Map<String, dynamic> locationData = {
        'latitude': position.latitude,
        'longitude': position.longitude,
        'location_name': locationName,
      };

    // Send a POST request to your server
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    const String apiUrl = 'http://10.0.2.2:8000/locations/';

    final http.Response response = await http.post(
      Uri.parse(apiUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Token $token',

      },
      body: jsonEncode(locationData),
    );
    print(jsonEncode(locationData));
    if (response.statusCode == 201) {
      // Location saved successfully
      print('Location saved successfully');
      Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) => const LocationList(),
                                        ),
                                        (Route<dynamic> route) => false);
    } else {
      // Location save failed
      print('Failed to save location. Status code: ${response.statusCode}');
    }
  } catch (error) {
    // Exception occurred while getting current location or sending request
    print('Error: $error');
  }
}



  // Future<void> _openMap(String lat, String long) async {
  Future<void> _openMap(String lat, String long) async {

    final Uri googleURL =
        Uri.parse('https://www.google.com/maps/search/?api=1&query=$lat,$long');
    if (await launchUrl(googleURL)) {
      throw Exception('impossible de lancer URL de Google Map');
    }
  }

   void _liveLocation() {
    LocationSettings locationSettings = const LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 100,
    );
    Geolocator.getPositionStream(locationSettings: locationSettings)
        .listen((Position position) {
      lat = position.latitude.toString();
      long = position.longitude.toString();

      setState(() {
        locationMessage = 'Latitude : $lat, Longitude: $long';
      });
    });
  }





  void modifyLocation(Map<String, dynamic> location) {
    setState(() {
      currentLocation = Map.from(location); // Make a copy of the location data
    });
    // Open the form dialog to modify the location
    _openFormDialog(context, _formKey, currentLocation, false);
  }

  void addlocation({Map<String, dynamic>? location}) {
    Map<String, dynamic> initialLocationData =
        location ?? {}; // Use provided location, or empty map if location is null
    setState(() {
      currentLocation = Map.from(initialLocationData); // Make a copy of the location data
    });
    // Open the form dialog to modify the location
    _openFormDialog(context, _formKey, currentLocation, true);
  }

  Future<void> updatelocation(Map<String, dynamic>? locationData) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');
      final csrfToken = await fetchCSRFToken();
      final String apiUrl = 'http://10.0.2.2:8000/locations/${locationData?["id"]}/';

      final response = await http.put(
        Uri.parse(apiUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Token $token',
          'X-CSRFToken': csrfToken,
        },
        body: jsonEncode(locationData), // Convert task data to JSON format
      );

      if (response.statusCode == 200) {
        // Task updated successfully
        print('Task updated successfully');
        MaterialPageRoute(builder: (context) => const LocationList());
      } else {
        // Task update failed
        print('Failed to update task. Status code: ${response.statusCode}');
      }
    } catch (error) {
      // Exception occurred while updating task
      print('Error updating task: $error');
    }
  }

  Future<void> deleteLocation(Map<String, dynamic>? locationData) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');
      // final csrfToken = await fetchCSRFToken();
      final String apiUrl = 'http://10.0.2.2:8000/locations/${locationData?["id"]}/';
      print(locationData);

      final response = await http.delete(
        Uri.parse(apiUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Token $token',
          // 'X-CSRFToken': csrfToken,
        },
        // body: jsonEncode(taskData), // Convert task data to JSON format
      );

      if (response.statusCode == 204) {
        // Task delete successfully
        print('Task delete successfully');
        Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) => const LocationList(),
                                        ),
                                        (Route<dynamic> route) => false);
   
      } else {
        // Task update failed
        print('Failed to delete task. Status code: ${response.statusCode}');
      }
    } catch (error) {
      // Exception occurred while updating task
      print('Error delete task: $error');
    }
  }

  Future<List<dynamic>> fetchData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    // final csrfToken = await fetchCSRFToken();
    // print(csrfToken);
    final response = await http.get(
      Uri.parse("http://10.0.2.2:8000/locations/"),
      headers: <String, String>{
        'Authorization': 'Token $token',
        // 'X-CSRFToken': csrfToken,
      },
    );

    if (response.statusCode == 200) {
      // If the server returns a 200 OK response, parse the JSON
      List<dynamic> data = json.decode(response.body);
      // print(data);
      return data;
    } else {
      // If the server did not return a 200 OK response, throw an exception.
      throw Exception('Failed to load data');
    }
  }

  void _openFormDialog(BuildContext context, GlobalKey<FormState> formKey,
      Map<String, dynamic>? locationData, bool create) {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return MyFormDialog(
            formKey: formKey, locationData: locationData, create: create);
      },
    );
  }

  final _formKey = GlobalKey<FormState>();

  int _currentIndex = 3;

  void _onItemTapped(int index) {
    if (index == 0) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const TaskList()),
      );
      return; 
    }
    if (index == 1) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const Calendar()),
      );
      return; 
    }
    if (index == 2) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeForm()),
      );
      return; 
    }
    if (index == 3) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LocationList()),
      );
      return; 
    }
    if (index == 4) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const ProfilePage()),
      );
      return; 
    }
    setState(() {
      _currentIndex = index;
    });
  }

  late Future<List<dynamic>> _futureData;

  @override
  void initState() {
    super.initState();
    _futureData = fetchData();
    // print(_futureData);
  }

  @override
  Widget build(BuildContext context) {
    Widget currentPage;
    switch (_currentIndex) {
      case 0:
        currentPage = const TaskList();
        break;
      case 1:
        currentPage = const Calendar();
        break;
      case 2:
        currentPage = const HomeForm();
        break;
      case 3:
        currentPage = const LocationList();
        break;
      case 4:
        currentPage = const SettingsPage();
        break;
      default:
        currentPage = const TaskList(); // Default to the first page
    }

    return Scaffold(
      appBar: const MyAppBar(),
      body: FutureBuilder<List<dynamic>>(
        future: _futureData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child:
                  CircularProgressIndicator(), // Show a loading indicator while waiting for data
            );
          } else if (snapshot.data == null) {
            return const Center(
              child: Text(
                  'Error: Failed to load data'), //// Show an error message if data is null
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                  'Error: ${snapshot.error}'), // Show an error message if data fetching fails
            );
          } else {
            // Data fetched successfully, display it
            List<dynamic> items = snapshot.data!;
            return SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  const SizedBox(height: 20),
                  Text(
                    'Liste des localisations',
                    style: GoogleFonts.nunito(
                      fontSize: 25,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      var location = items[index];
                      return Card(
                        elevation: 5,
                        margin: const EdgeInsets.all(5),
                        child: ListTile(
                          title: Text(location["location_name"] ?? "No title"),
                          subtitle:
                              Text(location["latitude"] + " , " + location["longitude"] ?? "No description"),
                              
                          onTap: () => showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: Text(location["location_name"] ?? "No title"),
                              // content: Text(task["discription"] ?? "No description"),
                              content: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                      "latitude: ${location["latitude"] ?? "No latitude"}"),
                                  
                                  Text(
                                      "longitude: ${location["longitude"] ?? "No longitude"}"),
                                  
                                ],
                              ),
                              actions: <Widget>[
                                TextButton(
                                  child: const Text('Direction'),
                                  onPressed: () => _openMap(location["latitude"],location["longitude"]),
                                ),
                                TextButton(
                                  child: const Text('Supprimer'),
                                  onPressed: () => deleteLocation(location),
                                ),
                                TextButton(
                                  child: const Text('ّFermer'),
                                  onPressed: () => Navigator.of(context).pop(),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),

                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: TextField(
                      controller: _locationNameController,
                      decoration: const InputDecoration(
                        hintText: 'Nom de la localisation',
                      ),
                    ),
                  ),

                 
                      Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: ElevatedButton(
                      onPressed: () {
                        _getCurrentLocation(
                            _locationNameController.text.trim());
                      },
                      child: const Text('Obtenir la localisation actuelle'),
                    ),
                    ),
                  
                ],
              ),
            );
          }
        },
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: _currentIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
