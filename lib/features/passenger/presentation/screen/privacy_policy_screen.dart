import 'package:flutter/material.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Privacy Policy"),
      ),
      body: const Padding(
        padding: EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Text(
            '''
Privacy Policy

Bykea Skardu respects your privacy.

We collect:

• Name
• Phone Number
• Ride History
• Current Location (during rides)

We use this information to:

• Book rides
• Connect riders and passengers
• Improve our services
• Provide customer support

We never sell your personal information to third parties.

Your data is stored securely using Firebase services.

By continuing to use this application, you agree to this Privacy Policy.
''',
            style: TextStyle(fontSize: 16),
          ),
        ),
      ),
    );
  }
}