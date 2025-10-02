import 'package:flutter/material.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Forgot Password')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Enter your registered email address to receive reset instructions.',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 24),
            const TextField(decoration: InputDecoration(labelText: 'Email')),
            const Spacer(),
            FilledButton(
              onPressed: () => Navigator.of(context).pushNamed('/reset-password'),
              child: const Text('Send Reset Link'),
            ),
          ],
        ),
      ),
    );
  }
}
