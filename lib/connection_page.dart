import 'package:flutter/material.dart';

class ConnectionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Connect to Hexpod'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // WiFi SSID Field
            TextField(
              decoration: InputDecoration(
                labelText: 'WiFi SSID',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20), // Spacer

            // WiFi Password Field
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'WiFi Password',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20), // Spacer

            // Connect Button
            ElevatedButton(
              onPressed: () {
                // Add code to initiate connection process
              },
              child: Text('Connect'),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: ConnectionPage(),
  ));
}
