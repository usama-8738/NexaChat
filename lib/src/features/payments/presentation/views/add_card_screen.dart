import 'package:flutter/material.dart';

class AddCardScreen extends StatelessWidget {
  const AddCardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add New Card')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: ListView(
          children: const [
            TextField(decoration: InputDecoration(labelText: 'Card Holder Name')),
            SizedBox(height: 16),
            TextField(decoration: InputDecoration(labelText: 'Card Number')),
            SizedBox(height: 16),
            TextField(decoration: InputDecoration(labelText: 'Expiry Date (MM/YY)')),
            SizedBox(height: 16),
            TextField(decoration: InputDecoration(labelText: 'CVV')),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(24),
        child: FilledButton(
          onPressed: () {},
          child: const Text('Save Card'),
        ),
      ),
    );
  }
}
