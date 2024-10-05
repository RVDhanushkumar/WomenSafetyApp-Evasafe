import 'package:flutter/material.dart';
import 'package:login_page/pages/home_page.dart';

void main() {
  runApp(DeviceInfoApp());
}

class DeviceInfoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DeviceInfoScreen(),
    );
  }
}

class DeviceInfoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Device Info', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black87,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HomePage()),
                    );
          },
        ),
      ),
      backgroundColor: Colors.black87,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Connected Devices
            Text(
              'Connected devices',
              style: TextStyle(
                color: Colors.greenAccent,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            deviceCard(
              deviceName: 'Pineapple 9 Pro',
              status: 'Connected',
              deviceId: 'HRX12234-789-CB8908',
              isConnected: true,
              imagePath: 'assets/watch_connected.png', // Add image asset path here
            ),
            SizedBox(height: 20),
            // Paired Devices
            Text(
              'Paired devices',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            deviceCard(
              deviceName: 'Pineapple 8 Pro',
              status: 'Disconnected',
              deviceId: null,
              isConnected: false,
              imagePath: 'assets/watch_disconnected1.png', // Add image asset path here
            ),
            SizedBox(height: 10),
            deviceCard(
              deviceName: 'Pineapple 7 Pro',
              status: 'Disconnected',
              deviceId: null,
              isConnected: false,
              imagePath: 'assets/watch_disconnected2.png', // Add image asset path here
            ),
          ],
        ),
      ),
    );
  }

  Widget deviceCard({
    required String deviceName,
    required String status,
    String? deviceId,
    required bool isConnected,
    required String imagePath,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: isConnected ? Colors.black54 : Colors.black38,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isConnected ? Colors.green : Colors.red,
          width: 2,
        ),
      ),
      padding: EdgeInsets.all(16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            imagePath,
            width: 60,
            height: 60,
          ),
          SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Device name: $deviceName',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Status: $status',
                style: TextStyle(
                  color: isConnected ? Colors.greenAccent : Colors.redAccent,
                  fontSize: 14,
                ),
              ),
              if (deviceId != null) ...[
                SizedBox(height: 8),
                Text(
                  'Device id: $deviceId',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}
