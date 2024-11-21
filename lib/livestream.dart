import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'control_page.dart';

class CameraApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Raspberry Pi Camera Stream',
      theme: ThemeData(
        primaryColor: Colors.blue,
        fontFamily: 'Roboto',
      ),
      home: MyScreen(),
    );
  }
}

class MyScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Hexaswift Camera Page',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      backgroundColor: Colors.transparent, // Set background color to transparent
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/a.jpg'), // Replace 'background.jpg' with your actual image path
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildContainer(
              2,
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CameraScreen()),
                  );
                },
                child: Text('Open Camera Stream'),
              ),
            ),
            SizedBox(height: 10.0),
            _buildContainer(1, ControlPage()),
          ],
        ),
      ),
    );
  }

  Widget _buildContainer(int flex, Widget child) {
    return Expanded(
      flex: flex,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.8), // Adjust opacity if needed
            borderRadius: BorderRadius.circular(20.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 5,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Center(child: child),
        ),
      ),
    );
  }
}

class CameraScreen extends StatefulWidget {
  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  final String _cameraUrl = 'http://raspberrypi.local:5000/camera-feed';

  Future<void> _fetchCameraFeed() async {
    try {
      final response = await http.get(Uri.parse(_cameraUrl));
      if (response.statusCode == 200) {
        print('Successfully connected to camera feed');
      } else {
        throw Exception('Failed to load camera feed');
      }
    } catch (e) {
      print('Error fetching camera feed: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchCameraFeed();  // Optional: Check the connection initially
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Camera Stream'),
      ),
      body: Center(
        child: Image.network(
          _cameraUrl,
          headers: {'Accept': 'multipart/x-mixed-replace; boundary=frame'},
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) {
              return child;
            } else {
              return CircularProgressIndicator();
            }
          },
          errorBuilder: (context, error, stackTrace) {
            return Text('Error loading camera feed: $error');
          },
        ),
      ),
    );
  }
}