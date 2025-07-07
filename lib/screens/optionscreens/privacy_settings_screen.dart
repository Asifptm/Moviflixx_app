import 'package:flutter/material.dart';

class PrivacySettingsScreen extends StatelessWidget {
  const PrivacySettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Privacy Settings'),
        backgroundColor: const Color.fromARGB(255, 81, 82, 119),
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          SwitchListTile(
            title: Text('Allow Location Access'),
            subtitle: Text('Enable to allow the app to access your location.'),
            value: true,
            onChanged: (bool value) {
              // Handle toggle logic
            },
          ),
          Divider(),
          SwitchListTile(
            title: Text('Enable Notifications'),
            subtitle: Text('Receive notifications about updates and offers.'),
            value: false,
            onChanged: (bool value) {
              // Handle toggle logic
            },
          ),
          Divider(),
          SwitchListTile(
            title: Text('Share Usage Data'),
            subtitle: Text('Help us improve by sharing anonymous usage data.'),
            value: true,
            onChanged: (bool value) {
              // Handle toggle logic
            },
          ),
          Divider(),
          ListTile(
            title: Text('Manage Blocked Users'),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {
              // Navigate to blocked users screen
            },
          ),
          Divider(),
          ListTile(
            title: Text('Privacy Policy'),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {
              // Navigate to privacy policy screen
            },
          ),
        ],
      ),
    );
  }
}
