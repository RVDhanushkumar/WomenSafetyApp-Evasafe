import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'marker_data.dart';
import 'package:http/http.dart' as http;

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final MapController _mapController = MapController();
  List<MarkerData> _markerData = [];
  List<Marker> _markers = [];
  LatLng? _selectedPosition;
  LatLng? _myLocation;
  LatLng? _draggedPosition;
  bool _isDragging = false;
  TextEditingController _searchController = TextEditingController();
  List<dynamic> _searchResults = [];
  bool _isSearching = false;

  List<LatLng> _policeStations = [
     LatLng(18.3531, 83.8727), // Ponduru
    LatLng(18.6020, 83.9173), // Palasa
    LatLng(18.3016, 83.8724), // Ichapuram
    LatLng(18.4172, 83.9101), // Pathapatnam Rural

    // Vizianagaram District (Continued)
    LatLng(18.1692, 83.4560), // Srungavarapukota
    LatLng(18.0756, 83.3345), // Gajularega
    LatLng(18.0933, 83.4162), // Cheepurupalli
    LatLng(18.1674, 83.4505), // Bondapalli

    // Visakhapatnam District (Continued)
    LatLng(17.8595, 83.2386), // Bheemili
    LatLng(17.6562, 83.1765), // Maddilapalem
    LatLng(17.6451, 83.1774), // Dwarakanagar
    LatLng(17.7460, 83.2250), // Kancherapalem
    LatLng(17.8107, 83.2274), // Pendurthi
    LatLng(17.6602, 83.2400), // Gopalapatnam
    LatLng(17.7896, 83.1406), // Pedagantyada
    LatLng(17.9440, 83.2131), // Arilova

    // East Godavari District (Continued)
    LatLng(16.9600, 82.2387), // Peddapuram
    LatLng(17.0592, 82.2165), // Samalkot Rural
    LatLng(16.9772, 82.2474), // Kadiyam
    LatLng(17.0890, 82.2030), // Anaparthi
    LatLng(17.0332, 81.7591), // Rajanagaram
    LatLng(17.0026, 82.2135), // Kothapeta
    LatLng(16.9836, 81.7291), // Mandapeta

    // West Godavari District (Continued)
    LatLng(16.6501, 81.6911), // Nidadavole
    LatLng(16.5591, 81.6192), // Denduluru
    LatLng(16.5944, 81.6021), // Kovvur
    LatLng(16.5236, 81.5267), // Narsapuram Rural
    LatLng(16.7220, 81.5945), // Devarapalli

    // Krishna District (Continued)
    LatLng(16.5921, 80.6561), // Patamata
    LatLng(16.5321, 80.6232), // Penamaluru Rural
    LatLng(16.5430, 80.5196), // Gannavaram
    LatLng(16.4782, 80.7744), // Mylavaram Rural

    // Guntur District (Continued)
    LatLng(16.3111, 80.4245), // Guntur West
    LatLng(16.2989, 80.4245), // Phirangipuram
    LatLng(16.4826, 80.4811), // Tenali Rural
    LatLng(16.5107, 80.6156), // Sattenapalle

    // Prakasam District (Continued)
    LatLng(15.8268, 79.8584), // Vetapalem
    LatLng(15.7695, 79.9087), // Inkollu
    LatLng(15.8137, 79.8504), // Addanki
    LatLng(15.7685, 79.8943), // Singarayakonda

    LatLng(17.7024, 83.2846), // Tagarapuvalasa
    LatLng(17.6878, 83.2075), // Bheemunipatnam Police Station
    LatLng(17.8942, 83.4240), // Anandapuram Police Station
    LatLng(17.6868, 83.2185), // Visakhapatnam Police Station
    LatLng(17.7264, 83.3220), // Gajuwaka Police Station
    // Srikakulam District
    LatLng(18.3026, 83.8910), // Srikakulam Town
    LatLng(18.3482, 83.8684), // Amadalavalasa
    LatLng(18.3634, 83.8716), // Palakonda
    LatLng(18.3095, 83.9154), // Etcherla
    LatLng(18.3158, 83.8745), // Tekkali
    LatLng(18.2841, 83.8877), // Narasannapeta
    LatLng(18.2262, 83.8600), // Rajam
    LatLng(18.3680, 83.8695), // Hiramandalam
    LatLng(18.3051, 83.8831), // Pathapatnam
    LatLng(18.3274, 83.8689), // Veeragattam

    // Vizianagaram District
    LatLng(17.9292, 83.3961), // Vizianagaram Town
    LatLng(18.2174, 83.2864), // Parvathipuram
    LatLng(17.9651, 83.4128), // Nellimarla
    LatLng(18.0655, 83.3665), // Bobbili
    LatLng(17.9870, 83.2900), // Salur
    LatLng(18.1434, 83.2684), // Jiyyammavalasa
    LatLng(18.0984, 83.2453), // Kota
    LatLng(18.0954, 83.3077), // Mentada
    LatLng(18.0625, 83.2998), // Lakkavarapukota
    LatLng(18.0446, 83.2921), // Gajapathinagaram

    // Visakhapatnam District
    LatLng(17.6868, 83.2185), // Visakhapatnam City
    LatLng(17.7194, 83.3235), // Gajuwaka
    LatLng(17.6390, 83.2248), // Anakapalle
    LatLng(17.7432, 83.4177), // Peddaganjam
    LatLng(17.4055, 83.2261), // Narsipatnam
    LatLng(17.7282, 83.2511), // Chodavaram
    LatLng(17.4733, 82.2505), // Kakinada Rural
    LatLng(17.1454, 82.8727), // Yelamanchili
    LatLng(17.6420, 82.7947), // Tuni
    LatLng(17.7024, 83.2846), // Tagarapuvalasa

    // East Godavari District
    LatLng(16.9898, 82.2464), // Kakinada
    LatLng(17.3318, 81.7791), // Rajamahendravaram
    LatLng(16.6122, 81.8177), // Amalapuram
    LatLng(17.0951, 81.7106), // Jaggampeta
    LatLng(17.0573, 81.7824), // Gokavaram
    LatLng(16.8800, 81.7416), // Mummidivaram
    LatLng(17.0640, 81.7311), // Samalkot
    LatLng(17.0710, 81.7851), // Prathipadu
    LatLng(17.0784, 81.7745), // Ramachandrapuram

    // West Godavari District
    LatLng(16.7101, 81.6211), // Eluru
    LatLng(16.5660, 81.5238), // Bhimavaram
    LatLng(16.3781, 81.5308), // Narsapur
    LatLng(16.7091, 81.5937), // Tadepalligudem
    LatLng(16.4851, 81.7880), // Palakollu
    LatLng(16.9395, 81.5704), // Jangareddygudem
    LatLng(16.8595, 81.5728), // Yelamanchili
    LatLng(16.8367, 81.6248), // Polavaram
    LatLng(16.7601, 81.6318), // Achanta
    LatLng(16.6230, 81.6992), // Kalla

    // Krishna District
    LatLng(16.5062, 80.6480), // Vijayawada
    LatLng(16.1766, 81.2336), // Machilipatnam
    LatLng(16.5181, 80.9813), // Gudivada
    LatLng(16.5188, 80.6540), // Kankipadu
    LatLng(16.5762, 80.6498), // Penamaluru
    LatLng(16.5270, 80.8603), // Nuzvid
    LatLng(16.4904, 80.7457), // Ibrahimpatnam
    LatLng(16.3300, 80.7907), // Krishna
    LatLng(16.5810, 80.5500), // Mylavaram
    LatLng(16.5830, 80.6164), // Vijayawada (Rural)

    // Guntur District
    LatLng(16.3067, 80.4365), // Guntur City
    LatLng(16.2500, 80.1732), // Narasaraopet
    LatLng(16.1816, 80.5505), // Tenali
    LatLng(15.9998, 80.4795), // Bapatla
    LatLng(16.2128, 80.5761), // Sattenapalli
    LatLng(16.0980, 80.5302), // Macherla
    LatLng(16.3096, 80.4376), // Peddaganjam
    LatLng(16.5270, 80.5692), // Amaravathi
    LatLng(16.5270, 80.5550), // Mangalagiri
    LatLng(16.0645, 80.6491), // Repalle

    // Prakasam District
    LatLng(15.8273, 79.9256), // Ongole
    LatLng(15.8271, 79.7786), // Markapur
    LatLng(15.8257, 79.9551), // Chirala
    LatLng(15.7460, 79.9722), // Kandukur
    LatLng(15.7415, 79.9727), // Giddalur
    LatLng(15.6908, 79.9851), // Peddaganjam
    LatLng(15.7252, 79.8725), // Mundlamuru
    LatLng(15.7587, 79.7914), // Kanigiri
    LatLng(15.7178, 79.9184), // Santhanuthalapadu
    LatLng(15.7390, 79.9350), // Koppolu

    // Nellore District
    LatLng(14.4436, 79.9864), // Nellore City
    LatLng(14.2842, 79.9807), // Gudur
    LatLng(14.6202, 79.9707), // Kavali
    LatLng(14.5923, 80.0001), // Atmakur
    LatLng(14.4160, 79.9820), // Venkatachalam
    LatLng(14.2060, 79.8836), // Udayagiri
    LatLng(14.4661, 79.9940), // Nellore Rural
    LatLng(14.2844, 79.9274), // Podalakur
    LatLng(14.2276, 79.9000), // Sullurpeta
    LatLng(14.2030, 79.9936), // Rapur

    // Chittoor District
    LatLng(13.6288, 79.4192), // Tirupati
    LatLng(13.2167, 79.0890), // Chittoor
    LatLng(13.2954, 78.9436), // Madanapalle
    LatLng(13.2293, 79.0716), // Puttur
    LatLng(13.6260, 79.3906), // Tirupati Rural
    LatLng(13.4528, 78.7278), // Kuppam
    LatLng(13.3458, 78.8628), // Palamaner
    LatLng(13.4047, 78.6649), // Baireddipalle
    LatLng(13.3225, 78.8445), // Bhakarapet
    LatLng(13.3622, 79.2558), // Chandragiri

    // Anantapur District
    LatLng(14.6778, 77.5909), // Anantapur
    LatLng(14.3297, 77.7036), // Hindupur
    LatLng(14.2464, 77.9802), // Dharmavaram
    LatLng(14.3334, 77.8033), // Kadiri
    LatLng(14.2114, 77.7517), // Rayadurg
    LatLng(15.0702, 77.3045), // Guntakal
    LatLng(14.3660, 77.6574), // Penukonda
    LatLng(14.1482, 77.7393), // Puttaparthi
    LatLng(14.5274, 77.7663), // Kalyandurg
    LatLng(14.0927, 77.7563), // Madakasira

    // Kurnool District
    LatLng(15.8281, 78.0373), // Kurnool
    LatLng(15.4474, 78.5480), // Nandyal
    LatLng(15.7192, 77.9782), // Adoni
    LatLng(15.3978, 77.7854), // Dhone
    LatLng(15.2762, 77.6233), // Yemmiganur
    LatLng(15.5721, 77.8936), // Panyam
    LatLng(15.7135, 77.9424), // Nandikotkur
    LatLng(15.8540, 77.4176), // Alur
    LatLng(15.4722, 77.7245), // Banaganapalle
    LatLng(15.3584, 77.5871), // Atmakur

    // Y.S.R. Kadapa District
    LatLng(14.4711, 78.8237), // Kadapa
    LatLng(14.7348, 77.8281), // Proddatur
    LatLng(14.4642, 78.5564), // Rajampet
    LatLng(14.5518, 78.5673), // Jammalamadugu
    LatLng(14.4446, 78.5597), // Pulivendula
    LatLng(14.5178, 78.7900), // Mydukur
    LatLng(14.4690, 78.8950), // Kadapa Rural
    LatLng(14.5968, 78.8251), // Kamalapuram
    LatLng(14.7776, 78.7564), // Devarkadra
    LatLng(14.4725, 78.8816), // Chennur

    // Bapatla District
    LatLng(15.9152, 80.4872), // Bapatla
    LatLng(15.8812, 80.5818), // Peddaganjam
    LatLng(15.7956, 80.5044), // Addanki
    LatLng(15.8785, 80.4468), // Ponnur
    LatLng(15.9530, 80.5000), // Narsaraopet
    LatLng(15.9351, 80.5142), // Sattenapalli
    LatLng(15.8980, 80.5952), // Macherla
    LatLng(15.8936, 80.5910), // Duggirala
    LatLng(16.3067, 80.4376), // Guntur
    LatLng(15.9530, 80.5000), // Narasaraopet
];



  // Get current location
  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error("Location Services are disabled");
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error("Location permissions are denied");
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error("Location permissions are permanently denied");
    }

    return await Geolocator.getCurrentPosition();
  }

  // Show current location
  void _showCurrentLocation() async {
    try {
      Position position = await _determinePosition();
      LatLng currentLatLng = LatLng(position.latitude, position.longitude);
      _mapController.move(currentLatLng, 15.0);
      setState(() {
        _myLocation = currentLatLng;
        _updatePoliceStations();
      });
    } catch (e) {
      print(e);
    }
  }

  // Update police stations within 50km
  void _updatePoliceStations() {
    if (_myLocation == null) return;

    final double radiusInKm = 50.0; // 50 km radius
    final List<LatLng> nearbyStations = _policeStations.where((station) {
      final distance = Geolocator.distanceBetween(
        _myLocation!.latitude,
        _myLocation!.longitude,
        station.latitude,
        station.longitude,
      ) / 1000; // Convert to km
      print('Distance to station (${station.latitude}, ${station.longitude}): $distance km'); // Debug print
      return distance <= radiusInKm;
    }).toList();

    print('Number of nearby stations: ${nearbyStations.length}'); // Debug print

    setState(() {
      _policeStations = nearbyStations;
    });
  }

  // Add marker on selected location
  void _addMarker(LatLng position, String title, String description) {
    setState(() {
      final markerData =
          MarkerData(position: position, title: title, description: description);
      _markerData.add(markerData);
      _markers.add(Marker(
        point: position,
        width: 80,
        height: 80,
        child: GestureDetector(
          onTap: () => _showMarkerInfo(markerData),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(4),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 4,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Text(
                  title,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Icon(
                Icons.location_on,
                color: Colors.redAccent,
                size: 40,
              ),
            ],
          ),
        ),
      ));
    });
  }

  // Show marker dialog
  void _showMakerDialog(BuildContext context, LatLng position) {
    final TextEditingController titleController = TextEditingController();
    final TextEditingController descController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(labelText: "Title"),
            ),
            TextField(
              controller: descController,
              decoration: InputDecoration(labelText: "Description"),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              _addMarker(position, titleController.text, descController.text);
              Navigator.pop(context);
            },
            child: Text("Save"),
          ),
        ],
      ),
    );
  }

  // Show marker info when tapped
  void _showMarkerInfo(MarkerData markerData) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(markerData.title),
        content: Text(markerData.description),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.close),
          ),
        ],
      ),
    );
  }

  // Search feature
  Future<void> _searchPlaces(String query) async {
    if (query.isEmpty) {
      setState(() {
        _searchResults = [];
      });
      return;
    }

    final url = 'http://nominatim.openstreetmap.org/search?q=$query&format=json&limit=5&countrycodes=IN';
    final response = await http.get(Uri.parse(url));
    final data = json.decode(response.body);

    if (data.isNotEmpty) {
      setState(() {
        _searchResults = data;
      });
    } else {
      setState(() {
        _searchResults = [];
      });
    }
  }

  // Move to specific location
  void _moveToLocation(double lat, double lon) {
    LatLng location = LatLng(lat, lon);
    _mapController.move(location, 15.0);
    setState(() {
      _selectedPosition = location;
      _searchResults = [];
      _isSearching = false;
      _searchController.clear();
    });
  }

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      _searchPlaces(_searchController.text);
    });
    // Show current location when the screen is opened
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _showCurrentLocation();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              initialZoom: 13.0,
              onTap: (tapPosition, LatLng) {
                setState(() {
                  _selectedPosition = LatLng;
                  _draggedPosition = _selectedPosition;
                });
              },
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
              ),
              MarkerLayer(markers: _markers),
              if (_isDragging && _draggedPosition != null)
                MarkerLayer(
                  markers: [
                    Marker(
                      point: _draggedPosition!,
                      width: 80,
                      height: 80,
                      child: Icon(
                        Icons.location_on,
                        color: Colors.indigo,
                        size: 40,
                      ),
                    )
                  ],
                ),
              if (_myLocation != null)
                MarkerLayer(
                  markers: [
                    Marker(
                      point: _myLocation!,
                      width: 80,
                      height: 80,
                      child: Icon(
                        Icons.location_on,
                        color: Colors.green,
                        size: 40,
                      ),
                    )
                  ],
                ),
              // Floating Police Stations
              MarkerLayer(
                markers: _policeStations.map((station) => Marker(
                  point: station,
                  width: 80,
                  height: 80,
                  child: Icon(
                    Icons.local_police,
                    color: Colors.blue,
                    size: 40,
                  ),
                )).toList(),
              ),
            ],
          ),
          // Search Widget
          Positioned(
            top: 40,
            left: 15,
            right: 15,
            child: Column(
              children: [
                SizedBox(
                  height: 55,
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: "Search Place...",
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                        borderSide: BorderSide.none,
                      ),
                      prefixIcon: Icon(Icons.search),
                    ),
                  ),
                ),
                if (_isSearching && _searchResults.isNotEmpty)
                  Container(
                    height: 200,
                    child: ListView.builder(
                      itemCount: _searchResults.length,
                      itemBuilder: (context, index) {
                        final place = _searchResults[index];
                        final lat = place['lat'];
                        final lon = place['lon'];
                        final displayName = place['display_name'] ?? 'No Name';

                        return ListTile(
                          title: Text(displayName),
                          onTap: () {
                            _moveToLocation(double.parse(lat), double.parse(lon));
                          },
                        );
                      },
                    ),
                  ),
              ],
            ),
          ),
          // Button to add marker
          Positioned(
            bottom: 60,
            right: 15,
            child: FloatingActionButton(
              onPressed: () {
                if (_selectedPosition != null) {
                  _showMakerDialog(context, _selectedPosition!);
                }
              },
              child: Icon(Icons.add_location),
            ),
          ),
          // Button to show current location
          Positioned(
            bottom: 15,
            right: 15,
            child: FloatingActionButton(
              onPressed: _showCurrentLocation,
              child: Icon(Icons.my_location),
            ),
          ),
        ],
      ),
    );
  }
}