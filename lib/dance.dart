import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HexaswiftCanDancePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hexaswift Can Dance'),
      ),
      body: ListView(
        children: [
          DanceOption(
            name: 'Disco Fever',
            command: 'A',
            imagePath: 'assets/images/disco_image.jpg',
          ),
          DanceOption(
            name: 'Samba Sensation',
            command: 'B',
            imagePath: 'assets/images/samba_image.jpg',
          ),
          DanceOption(
            name: 'Hip Hop Groove',
            command: 'C',
            imagePath: 'assets/images/hiphop_image.jpg',
          ),
        ],
      ),
    );
  }
}

class DanceOption extends StatelessWidget {
  final String name;
  final String command;
  final String imagePath;

  const DanceOption({
    required this.name,
    required this.command,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _sendDanceCommand(context, command);
      },
      child: Card(
        elevation: 5.0,
        margin: EdgeInsets.all(8.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(15.0)),
              child: Image.asset(
                imagePath,
                fit: BoxFit.cover,
                height: 200.0,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(12.0),
              child: Text(
                name,
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _sendDanceCommand(BuildContext context, String command) async {
    final response = await http.post(
      Uri.parse('http://raspberrypi.local:5000/dance'),
      body: {'command': command},
    );

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Dance command $command sent!'),
          duration: Duration(seconds: 2),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to send dance command'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }
}
