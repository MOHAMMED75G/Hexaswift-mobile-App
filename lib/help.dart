import 'package:flutter/material.dart';

class HelpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Help'),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
             image: AssetImage('assets/images/d.jpg'), // Replace 'background_image.jpg' with your image path
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          padding: EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.8), // Adjust opacity of the overlay color
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTitle('Welcome to Hexaswift!'),
              SizedBox(height: 20.0),
              Expanded(
                child: ListView(
                  children: [
                    _buildInstruction(
                      '1. Control Page',
                      'The Control Page allows you to interact with Hexaswift in various ways. Here, you can control its movements, adjust its settings, and view real-time data.',
                    ),
                    _buildInstruction(
                      '2. Hexaswift Can Dance',
                      'Experience the joy of watching Hexaswift dance! In this section, you\'ll find pre-programmed dance routines that showcase Hexaswift\'s agility and grace.',
                    ),
                    _buildInstruction(
                      '3. Hexaswift Explore Tunisia',
                      'Embark on a virtual tour of Tunisia with Hexaswift as your guide! Explore famous landmarks, learn about the culture, and discover hidden gems.',
                    ),
                    _buildInstruction(
                      '4. Give Feedback',
                      'Your feedback is invaluable to us! We\'re constantly striving to improve Hexaswift, and your input helps us identify areas for enhancement. Share your thoughts, suggestions, and ideas with us here.',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTitle(String title) {
    return Text(
      title,
      style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold, color: Colors.white),
    );
  }

  Widget _buildInstruction(String title, String description) {
    return Container(
      padding: EdgeInsets.all(16.0),
      margin: EdgeInsets.symmetric(vertical: 8.0),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9), // Adjust opacity of the instruction container
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.blue),
          ),
          SizedBox(height: 8.0),
          Text(
            description,
            style: TextStyle(fontSize: 16.0),
          ),
        ],
      ),
    );
  }
}
