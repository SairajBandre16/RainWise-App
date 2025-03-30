// import 'package:flutter/material.dart';
// import 'package:flutter_map/flutter_map.dart';
// import 'package:latlong2/latlong.dart';
// import 'dart:math';

// class RainwaterCalculatorPage extends StatefulWidget {
//   const RainwaterCalculatorPage({Key? key}) : super(key: key);

//   @override
//   State<RainwaterCalculatorPage> createState() => _RainwaterCalculatorPageState();
// }

// class _RainwaterCalculatorPageState extends State<RainwaterCalculatorPage> {
//   List<LatLng> points = [];
//   double calculatedArea = 0.0;
//   double predictedRainfall = 536.45;
//   double waterCapacity = 0.0;

//   void _calculateWaterCapacity() {
//     setState(() {
//       waterCapacity = calculatedArea * (predictedRainfall / 1000) * 1000;
//     });
//   }

//   void _resetValues() {
//     setState(() {
//       points.clear();
//       calculatedArea = 0.0;
//       waterCapacity = 0.0;
//     });
//   }

//   void _addPoint(LatLng point) {
//     if (points.length < 4) {
//       setState(() {
//         points.add(point);
//         if (points.length == 4) {
//           calculatedArea = _calculatePolygonArea(points);
//         }
//       });
//     }
//   }

//   double _calculatePolygonArea(List<LatLng> points) {
//     double area = 0.0;
//     int j = points.length - 1;
//     for (int i = 0; i < points.length; i++) {
//       area += (points[j].longitude + points[i].longitude) * (points[j].latitude - points[i].latitude);
//       j = i;
//     }
//     return (area.abs() / 2) * 111320 * 111320;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 Row(
//                   children: [
//                     IconButton(
//                       icon: const Icon(Icons.arrow_back),
//                       color: Color(0xFF023E8A),
//                       onPressed: () => Navigator.pop(context),
//                     ),
//                     const Expanded(
//                       child: Center(
//                         child: Text(
//                           'PLOT AREA',
//                           style: TextStyle(
//                             fontSize: 18,
//                             fontWeight: FontWeight.bold,
//                             color: Color(0xFF023E8A),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 20),
//                 Container(
//                   width: double.infinity,
//                   height: 300,
//                   decoration: BoxDecoration(
//                     color: Colors.grey[200],
//                     borderRadius: BorderRadius.circular(10),
//                     border: Border.all(color: Colors.blue, width: 2),
//                   ),
//                   child: FlutterMap(
//                     options: MapOptions(
//                       center: LatLng(19.0760, 72.8777),
//                       zoom: 13.0,
//                       onTap: (_, point) => _addPoint(point),
//                     ),
//                     children: [
//                       TileLayer(
//                         urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
//                         subdomains: ['a', 'b', 'c'],
//                       ),
//                       MarkerLayer(
//                         markers: points.map((point) => Marker(
//                           width: 30,
//                           height: 30,
//                           point: point,
//                           child: Icon(Icons.location_pin, color: Colors.red, size: 30),
//                         )).toList(),
//                       ),
//                       if (points.length == 4)
//                         PolygonLayer(
//                           polygons: [
//                             Polygon(
//                               points: points,
//                               color: Colors.blue.withOpacity(0.3),
//                               borderColor: Colors.blue,
//                               borderStrokeWidth: 2,
//                             )
//                           ],
//                         ),
//                     ],
//                   ),
//                 ),
//                 const SizedBox(height: 20),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
//                     _buildButton('Submit', Colors.blue, _calculateWaterCapacity),
//                     _buildButton('Reset', Colors.red, _resetValues),
//                   ],
//                 ),
//                 const SizedBox(height: 20),
//                 _buildInfoCard('Calculated Area', '${calculatedArea.toStringAsFixed(0)} m²'),
//                 _buildInfoCard('Predicted Rainfall', '${predictedRainfall.toStringAsFixed(2)}mm'),
//                 _buildInfoCard('Water Capacity', '${waterCapacity.toStringAsFixed(0)} ltr'),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildButton(String text, Color color, VoidCallback onPressed) {
//     return ElevatedButton(
//       onPressed: onPressed,
//       style: ElevatedButton.styleFrom(
//         backgroundColor: color,
//         padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//       ),
//       child: Text(text, style: const TextStyle(color: Colors.white)),
//     );
//   }

//   Widget _buildInfoCard(String title, String value) {
//     return Container(
//       width: double.infinity,
//       margin: const EdgeInsets.only(bottom: 10),
//       padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(10),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.2),
//             spreadRadius: 2,
//             blurRadius: 4,
//             offset: const Offset(0, 2),
//           ),
//         ],
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(
//             title,
//             style: const TextStyle(
//               fontSize: 16,
//               fontWeight: FontWeight.bold,
//               color: Colors.black,
//             ),
//           ),
//           Text(
//             value,
//             style: const TextStyle(
//               fontSize: 16,
//               fontWeight: FontWeight.bold,
//               color: Color(0xFF023E8A),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RainwaterCalculatorPage extends StatefulWidget {
  const RainwaterCalculatorPage({Key? key}) : super(key: key);

  @override
  State<RainwaterCalculatorPage> createState() => _RainwaterCalculatorPageState();
}

class _RainwaterCalculatorPageState extends State<RainwaterCalculatorPage> {
  List<LatLng> points = [];
  double calculatedArea = 0.0;
  double predictedRainfall = 0.0;
  double waterCapacity = 0.0;
  final String apiUrl = "http://192.168.55.145:5000/predict";
  final String geocodingApiKey = "YOUR_GEOCODING_API_KEY"; // Replace with your API key
  MapController mapController = MapController();
  LatLng mapCenter = LatLng(19.0760, 72.8777); // Default location: Mumbai
  TextEditingController searchController = TextEditingController();

  /// Fetch latitude & longitude from Geocoding API based on search query
  Future<void> _searchLocation() async {
    String query = searchController.text;
    if (query.isEmpty) return;

    final url = Uri.parse("https://nominatim.openstreetmap.org/search?format=json&q=$query");

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        if (data.isNotEmpty) {
          double lat = double.parse(data[0]["lat"]);
          double lon = double.parse(data[0]["lon"]);

          setState(() {
            mapCenter = LatLng(lat, lon);
            mapController.move(mapCenter, 14.0); // Move map to searched location
          });
        } else {
          print("No location found");
        }
      } else {
        print("Error fetching location: ${response.body}");
      }
    } catch (e) {
      print("Failed to fetch location: $e");
    }
  }
  void _calculateWaterCapacity() {
    setState(() {
      waterCapacity = calculatedArea * (predictedRainfall / 1000) * 1000; 
    });
  }

  void _resetValues() {
    setState(() {
      points.clear();
      calculatedArea = 0.0;
      predictedRainfall = 0.0;
      waterCapacity = 0.0;
    });
  }

  void _addPoint(LatLng point) {
    if (points.length < 4) {
      setState(() {
        points.add(point);
        if (points.length == 4) {
          calculatedArea = _calculatePolygonArea(points);
        }
      });
    }
  }

  double _calculatePolygonArea(List<LatLng> points) {
    double area = 0.0;
    int j = points.length - 1;
    for (int i = 0; i < points.length; i++) {
      area += (points[j].longitude + points[i].longitude) * (points[j].latitude - points[i].latitude);
      j = i;
    }
    return (area.abs() / 2) * 111320 * 111320;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back),
                      color: Color(0xFF023E8A),
                      onPressed: () => Navigator.pop(context),
                    ),
                    const Expanded(
                      child: Center(
                        child: Text(
                          'PLOT AREA',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF023E8A),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // Search Bar
                TextField(
                  controller: searchController,
                  decoration: InputDecoration(
                    labelText: "Search Location",
                    suffixIcon: IconButton(
                      icon: Icon(Icons.search, color: Colors.blue),
                      onPressed: _searchLocation,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: Colors.blue, width: 2),
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Map Widget
                Container(
                  width: double.infinity,
                  height: 300,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.blue, width: 2),
                  ),
                  child: FlutterMap(
                    mapController: mapController,
                    options: MapOptions(
                      center: mapCenter,
                      zoom: 13.0,
                      onTap: (_, point) => _addPoint(point),
                    ),
                    children: [
                      TileLayer(
                        urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                        subdomains: ['a', 'b', 'c'],
                      ),
                      MarkerLayer(
                        markers: points.map((point) => Marker(
                          width: 30,
                          height: 30,
                          point: point,
                          child: Icon(Icons.location_pin, color: Colors.red, size: 30),
                        )).toList(),
                      ),
                      if (points.length == 4)
                        PolygonLayer(
                          polygons: [
                            Polygon(
                              points: points,
                              color: Colors.blue.withOpacity(0.3),
                              borderColor: Colors.blue,
                              borderStrokeWidth: 2,
                            )
                          ],
                        ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                // Buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildButton('Submit', Colors.blue, _calculateWaterCapacity),
                    _buildButton('Reset', Colors.red, _resetValues),
                  ],
                ),
                const SizedBox(height: 20),

                // Information Cards
                _buildInfoCard('Calculated Area', '${calculatedArea.toStringAsFixed(0)} m²'),
                _buildInfoCard('Predicted Rainfall', '${predictedRainfall.toStringAsFixed(2)} mm'),
                _buildInfoCard('Water Capacity', '${waterCapacity.toStringAsFixed(0)} ltr'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget _buildButton(String text, Color color, VoidCallback onPressed) {
  return ElevatedButton(
    onPressed: onPressed,
    style: ElevatedButton.styleFrom(
      backgroundColor: color,
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    ),
    child: Text(text, style: const TextStyle(color: Colors.white)),
  );
}

Widget _buildInfoCard(String title, String value) {
  return Container(
    width: double.infinity,
    margin: const EdgeInsets.only(bottom: 10),
    padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
      boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.2), spreadRadius: 2, blurRadius: 4, offset: const Offset(0, 2))],
    ),
    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text(title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)), Text(value)]),
  );
}
