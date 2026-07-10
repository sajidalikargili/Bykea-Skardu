import 'package:flutter/material.dart';

class TermsConditionScreen extends StatelessWidget {
  const TermsConditionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Terms & Conditions"),
      ),
      body: const Padding(
        padding: EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Text(
            '''
Welcome to Bykea Skardu.

By using this application, you agree to the following terms:

1. Riders and passengers must provide accurate information.

2. Every booking is subject to rider availability.

3. Passengers must pay the agreed fare after ride completion.

4. Riders must follow traffic rules and drive safely.

5. Misuse of the application may result in account suspension.

6. Bykea Skardu is not responsible for personal belongings left during rides.

7. Users are responsible for maintaining the confidentiality of their accounts.

Thank you for using Bykea Skardu.
''',
            style: TextStyle(fontSize: 16),
          ),
        ),
      ),
    );
  }
}