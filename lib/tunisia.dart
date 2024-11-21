import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HexaswiftExploreTunisiaPage extends StatefulWidget {
  @override
  _HexaswiftExploreTunisiaPageState createState() => _HexaswiftExploreTunisiaPageState();
}

class _HexaswiftExploreTunisiaPageState extends State<HexaswiftExploreTunisiaPage> {
  List<dynamic> locations = [];

  @override
  void initState() {
    super.initState();
    _fetchLocations();
  }

  Future<void> _fetchLocations() async {
    final response = await http.get(Uri.parse('http://raspberrypi.local:5000/locations'));
    if (response.statusCode == 200) {
      setState(() {
        locations = json.decode(response.body);
      });
    } else {
      throw Exception('Failed to load locations');
    }
  }

  Future<void> _addNewLocation(String name, String description) async {
    final newLocation = {
      'name': name,
      'description': description,
    };

    final response = await http.post(
      Uri.parse('http://raspberrypi.local:5000/locations'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(newLocation),
    );

    if (response.statusCode == 201) {
      await _fetchLocations();
    } else {
      throw Exception('Failed to add location');
    }
  }

  Future<void> _updateLocation(int id, String description) async {
    final updatedData = {
      'description': description,
    };

    final response = await http.put(
      Uri.parse('http://raspberrypi.local:5000/locations/$id'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(updatedData),
    );

    if (response.statusCode == 200) {
      await _fetchLocations();
    } else {
      throw Exception('Failed to update location');
    }
  }

  Future<void> _deleteLocation(int id) async {
    final response = await http.delete(
      Uri.parse('http://raspberrypi.local:5000/locations/$id'),
    );

    if (response.statusCode == 204) {
      await _fetchLocations();
    } else {
      throw Exception('Failed to delete location');
    }
  }

  void _showAddLocationDialog() {
    String name = '';
    String description = '';

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add New Location'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                onChanged: (value) {
                  name = value;
                },
                decoration: InputDecoration(hintText: "City Name"),
              ),
              TextField(
                onChanged: (value) {
                  description = value;
                },
                decoration: InputDecoration(hintText: "Description"),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Add'),
              onPressed: () {
                _addNewLocation(name, description);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showEditLocationDialog(int id, String currentDescription) {
    String description = currentDescription;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit Location'),
          content: TextField(
            onChanged: (value) {
              description = value;
            },
            decoration: InputDecoration(hintText: "Description"),
            controller: TextEditingController(text: currentDescription),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Save'),
              onPressed: () {
                _updateLocation(id, description);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hexaswift Explore Tunisia'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: locations.map((location) {
            return LocationCard(
              id: location['id'],
              name: location['name'],
              description: location['description'],
              imageUrl: location['imageUrl'],
              onEdit: () => _showEditLocationDialog(location['id'], location['description']),
              onDelete: () => _deleteLocation(location['id']),
            );
          }).toList(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddLocationDialog,
        child: Icon(Icons.add),
      ),
    );
  }
}

class LocationCard extends StatelessWidget {
  final int id;
  final String name;
  final String description;
  final String imageUrl;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const LocationCard({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () {
          _showLocationDetails(context);
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.asset(
              imageUrl,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8.0),
                  Text(description),
                  SizedBox(height: 8.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: onEdit,
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: onDelete,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showLocationDetails(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Exploring $name'),
        duration: Duration(seconds: 2),
      ),
    );
  }
}
