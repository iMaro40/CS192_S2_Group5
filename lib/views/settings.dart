import 'package:flutter/material.dart';
import 'package:super_planner/constants.dart';
import 'package:super_planner/components/settings_tabs.dart';
import 'package:super_planner/services/auth.dart';
class Settings extends StatefulWidget {
  @override
  _Settings createState() => _Settings();
}


class _Settings extends State<Settings> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(height: 100.0),
            Padding(
              padding: const EdgeInsets.all(40.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'My Profile',
                    style: header_text,
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                  SettingsTab(icon: Icons.account_circle_outlined, name: 'Personal Information'),
                  SettingsTab(icon: Icons.lock_outline, name: 'Security'),
                  SettingsTab(icon: Icons.wifi_outlined, name: 'Synced Apps'),
                  GestureDetector(
                    onTap: () async {
                      await AuthService().logOut();
                    },
                    child:  SettingsTab(icon: Icons.logout, name: 'Logout'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

