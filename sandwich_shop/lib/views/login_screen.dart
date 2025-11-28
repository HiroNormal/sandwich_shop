import 'package:flutter/material.dart';
import 'package:sandwich_shop/views/app_styles.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login', style: heading1)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 8),
            const Text('Sign in', style: heading2, textAlign: TextAlign.left),
            const SizedBox(height: 16),
            TextField(
              style: normalText,
              decoration: InputDecoration(
                labelText: 'Email',
                labelStyle: normalText,
                border: const OutlineInputBorder(),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 12),
            TextField(
              style: normalText,
              decoration: InputDecoration(
                labelText: 'Password',
                labelStyle: normalText,
                border: const OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                textStyle: normalText,
                backgroundColor: Theme.of(context).primaryColor,
                foregroundColor: Colors.white,
              ),
              onPressed: () {
                // perform login or navigate back
                Navigator.of(context).pop();
              },
              child: const Text('Sign in', style: normalText),
            ),
          ],
        ),
      ),
    );
  }
}