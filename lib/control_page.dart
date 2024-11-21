import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ControlPage extends StatefulWidget {
  @override
  _ControlPageState createState() => _ControlPageState();
}

class _ControlPageState extends State<ControlPage> {
  final String hostname = 'raspberrypi.local'; // Replace with the actual IP address or hostname of your Raspberry Pi

  Future<void> sendControlCommand(String command) async {
    try {
      final response = await http.post(
        Uri.parse('http://$hostname:5000/control'),
        body: {'command': command},
      );
      if (response.statusCode == 200) {
        print('Command sent successfully: $command');
      } else {
        print('Failed to send command: $command');
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to send command: $command')),
          );
        }
      }
    } catch (e) {
      print('Error: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Server not connected: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Controls'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            IconButton(
              onPressed: () {
                sendControlCommand('F');
              },
              icon: Icon(Icons.arrow_upward),
              iconSize: 24,
            ),
            SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                IconButton(
                  onPressed: () {
                    sendControlCommand('R');
                  },
                  icon: Icon(Icons.arrow_back),
                  iconSize: 24,
                ),
                SizedBox(width: 5),
                IconButton(
                  onPressed: () {
                    sendControlCommand('U');
                  },
                  icon: Icon(Icons.arrow_forward),
                  iconSize: 24,
                ),
              ],
            ),
            SizedBox(height: 5),
            IconButton(
              onPressed: () {
                sendControlCommand('backward');
              },
              icon: Icon(Icons.arrow_downward),
              iconSize: 24,
            ),
          ],
        ),
      ),
    );
  }
}
