// settings.dart
import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
        backgroundColor: theme.hintColor,
      ),
      body: Center(
        child: Text(
          'Settings Page Content',
          style: TextStyle(color: theme.primaryColor, fontSize: 24),
        ),
      ),
    );
  }
}
