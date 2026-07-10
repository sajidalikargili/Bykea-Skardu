import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("About"),
      ),
      body: const Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [

            Icon(
              Icons.directions_bike,
              size: 100,
              color: Colors.green,
            ),

            SizedBox(height: 20),

            Text(
              "Bykea Skardu",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 10),

            Text("Version 1.0.0"),

            SizedBox(height: 30),

            Text(
              "Bykea Skardu is a ride booking application that connects passengers with nearby riders quickly and safely.",
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }
}