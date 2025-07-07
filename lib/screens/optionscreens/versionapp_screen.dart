import 'package:flutter/material.dart';

import 'package:package_info_plus/package_info_plus.dart';

class VersionAppScreen extends StatefulWidget {
  const VersionAppScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _VersionAppScreenState createState() => _VersionAppScreenState();
}

class _VersionAppScreenState extends State<VersionAppScreen> {
  String appName = '';
  String packageName = '';
  String version = '';
  String buildNumber = '';

  @override
  void initState() {
    super.initState();
    _fetchAppInfo();
  }

  Future<void> _fetchAppInfo() async {
    final packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      appName = packageInfo.appName;
      packageName = packageInfo.packageName;
      version = packageInfo.version;
      buildNumber = packageInfo.buildNumber;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('App Version Info')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('App Name: $appName', style: TextStyle(fontSize: 18)),
            SizedBox(height: 8),
            Text('Package Name: $packageName', style: TextStyle(fontSize: 18)),
            SizedBox(height: 8),
            Text('Version: $version', style: TextStyle(fontSize: 18)),
            SizedBox(height: 8),
            Text('Build Number: $buildNumber', style: TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
