import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:provider/provider.dart';
import 'package:ndobasmarthomesensormobileapp/components/ThemeProvider.dart';
import 'package:ndobasmarthomesensormobileapp/screens/StepCounter.dart';
import 'package:ndobasmarthomesensormobileapp/screens/compass.dart';
import 'package:ndobasmarthomesensormobileapp/screens/lightsensor.dart';
import 'package:ndobasmarthomesensormobileapp/screens/maps.dart';
import 'package:ndobasmarthomesensormobileapp/screens/proximitysensor.dart';
import 'package:ndobasmarthomesensormobileapp/screens/login.dart';
import 'package:ndobasmarthomesensormobileapp/screens/signup.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:ndobasmarthomesensormobileapp/screens/dashboard.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initNotifications();
  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeNotifier(),
      child: const MyApp(),
    ),
  );
}

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> initNotifications() async {
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');

  final InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
  );

  await flutterLocalNotificationsPlugin.initialize(
    initializationSettings,
    onDidReceiveNotificationResponse:
        (NotificationResponse notificationResponse) async {
      // Handle notification tap
    },
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Smart Home Monitoring App',
      theme: themeNotifier.currentTheme,
      initialRoute: '/login',
      routes: {
        '/login': (context) => LoginPage(),
        '/signup': (context) => SignupPage(),
        '/home': (context) => MyHomePage(
            title: 'Smart Home Monitoring App'), // Main content route
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;
  const MyHomePage({required this.title, Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final themeNotifier = Provider.of<ThemeNotifier>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.hintColor,
        title: Text(
          widget.title,
          style: TextStyle(color: theme.primaryColor),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              child: Text(
                'Smart Home Monitoring',
                style: TextStyle(color: theme.primaryColor, fontSize: 24),
              ),
              decoration: BoxDecoration(color: theme.hintColor),
            ),
            ListTile(
              leading: Icon(Icons.dashboard, color: theme.primaryColor),
              title: Text('Dashboard'),
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => DashboardPage()),
              ),
            ),
            ListTile(
              leading: Icon(Icons.directions, color: theme.primaryColor),
              title: Text('Compass'),
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => CompassPage()),
              ),
            ),
            ListTile(
              leading: Icon(Icons.gps_fixed, color: theme.primaryColor),
              title: Text('Map - Geofencing'),
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => MapPage()),
              ),
            ),
            ListTile(
              leading: Icon(Icons.light_mode, color: theme.primaryColor),
              title: Text('Light Level Sensor'),
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => LightSensorPage()),
              ),
            ),
            ListTile(
              leading: Icon(Icons.run_circle, color: theme.primaryColor),
              title: Text('Footstep Counter'),
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => StepCounterPage()),
              ),
            ),
            ListTile(
              leading: Icon(Icons.sensor_window, color: theme.primaryColor),
              title: Text('Motion Sensor'),
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => ProximityPage()),
              ),
            ),
            ListTile(
              leading: Icon(Icons.brightness_6, color: theme.primaryColor),
              title: Text('Toggle Theme'),
              onTap: () {
                themeNotifier.toggleTheme();
                Navigator.of(context).pop(); // Close the drawer
              },
            ),
          ],
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image:
                AssetImage('lib/assets/desktop-wallpaper-iot-smart-home.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'WELCOME TO MY HOME SMART MONITORING APP',
                    style: TextStyle(
                      color: theme.hintColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 50),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(Icons.dashboard,
                          size: 50, color: theme.hintColor),
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) => DashboardPage()),
                        );
                      },
                    ),
                    Text(
                      'Open Dashboard',
                      style: TextStyle(
                        color: theme.hintColor,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: _buildSpeedDial(context, themeNotifier, theme),
    );
  }

  Widget _buildSpeedDial(
      BuildContext context, ThemeNotifier themeNotifier, ThemeData theme) {
    return SpeedDial(
      icon: Icons.sensors,
      activeIcon: Icons.close,
      backgroundColor: theme.hintColor,
      foregroundColor: theme.primaryColor,
      overlayColor: Colors.transparent,
      children: [
        SpeedDialChild(
          child: Icon(Icons.dashboard, color: theme.primaryColor),
          backgroundColor: theme.hintColor,
          label: 'Dashboard',
          onTap: () => Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => DashboardPage())),
        ),
        SpeedDialChild(
          child: Icon(Icons.mode_night, color: theme.primaryColor),
          backgroundColor: theme.hintColor,
          label: 'Dark Mode',
          onTap: () => themeNotifier.toggleTheme(),
        ),
        SpeedDialChild(
          child: Icon(Icons.directions, color: theme.primaryColor),
          backgroundColor: theme.hintColor,
          label: 'DirectionFinder',
          onTap: () => Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => CompassPage())),
        ),
        SpeedDialChild(
          child: Icon(Icons.gps_fixed, color: theme.primaryColor),
          backgroundColor: theme.hintColor,
          label: 'Map - Geofencing',
          onTap: () => Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => MapPage())),
        ),
        SpeedDialChild(
          child: Icon(Icons.light_mode, color: theme.primaryColor),
          backgroundColor: theme.hintColor,
          label: 'Light Level Sensor',
          onTap: () => Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => LightSensorPage())),
        ),
        SpeedDialChild(
          child: Icon(Icons.run_circle, color: theme.primaryColor),
          backgroundColor: theme.hintColor,
          label: 'Footstep Counter',
          onTap: () => Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => StepCounterPage())),
        ),
        SpeedDialChild(
          child: Icon(Icons.sensor_window, color: theme.primaryColor),
          backgroundColor: theme.hintColor,
          label: 'Motion Sensor',
          onTap: () => Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => ProximityPage())),
        ),
      ],
    );
  }
}
