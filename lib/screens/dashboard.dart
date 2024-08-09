import 'package:flutter/material.dart';
import 'compass.dart';
import 'maps.dart';
import 'lightsensor.dart';
import 'StepCounter.dart';
import 'proximitysensor.dart';
import 'package:provider/provider.dart';
import 'package:ndobasmarthomesensormobileapp/components/ThemeProvider.dart';

class DashboardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final themeNotifier = Provider.of<ThemeNotifier>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
        backgroundColor: theme.hintColor,
        actions: [
          IconButton(
            icon: Icon(Icons.brightness_6, color: theme.primaryColor),
            onPressed: () => themeNotifier.toggleTheme(),
          ),
        ],
      ),
      body: GridView.count(
        crossAxisCount: 2,
        padding: EdgeInsets.all(10),
        children: [
          _buildDashboardItem(
            context,
            'Compass',
            Icons.directions,
            () => Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => CompassPage()),
            ),
          ),
          _buildDashboardItem(
            context,
            'Map - Geofencing',
            Icons.gps_fixed,
            () => Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => MapPage()),
            ),
          ),
          _buildDashboardItem(
            context,
            'Light Sensor',
            Icons.light_mode,
            () => Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => LightSensorPage()),
            ),
          ),
          _buildDashboardItem(
            context,
            'Footstep Counter',
            Icons.run_circle,
            () => Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => StepCounterPage()),
            ),
          ),
          _buildDashboardItem(
            context,
            'Motion Sensor',
            Icons.sensor_window,
            () => Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => ProximityPage()),
            ),
          ),
          _buildDashboardItem(
            context,
            'WiFi',
            Icons.wifi,
            () {
              // Add functionality for WiFi
            },
          ),
          _buildDashboardItem(
            context,
            'Screen Sharing',
            Icons.screen_share,
            () {
              // Add functionality for Screen Sharing
            },
          ),
          _buildDashboardItem(
            context,
            'Bluetooth',
            Icons.bluetooth,
            () {
              // Add functionality for Bluetooth
            },
          ),
        ],
      ),
    );
  }

  Widget _buildDashboardItem(
    BuildContext context,
    String title,
    IconData icon,
    VoidCallback onTap,
  ) {
    final theme = Theme.of(context);

    return Card(
      margin: EdgeInsets.all(8),
      elevation: 4,
      child: InkWell(
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 50, color: theme.primaryColor),
            SizedBox(height: 10),
            Text(
              title,
              style: TextStyle(fontSize: 16, color: theme.primaryColor),
            ),
          ],
        ),
      ),
    );
  }
}
