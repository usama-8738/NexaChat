import 'package:flutter/material.dart';

class VerifyCodeScreen extends StatefulWidget {
  const VerifyCodeScreen({super.key, this.isPhoneFlow = true});

  final bool isPhoneFlow;

  @override
  State<VerifyCodeScreen> createState() => _VerifyCodeScreenState();
}

class _VerifyCodeScreenState extends State<VerifyCodeScreen> {
  final List<FocusNode> _focusNodes = List.generate(6, (_) => FocusNode());
  final List<TextEditingController> _controllers =
      List.generate(6, (_) => TextEditingController());

  @override
  void dispose() {
    for (final controller in _controllers) {
      controller.dispose();
    }
    for (final node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final prompt = widget.isPhoneFlow
        ? 'Enter the 6 digit code we sent to your phone.'
        : 'Enter the 6 digit code we emailed you.';

    return Scaffold(
      appBar: AppBar(title: const Text('Enter Verification Code')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(prompt, style: Theme.of(context).textTheme.bodyLarge),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(_controllers.length, (index) {
                return SizedBox(
                  width: 48,
                  child: TextField(
                    controller: _controllers[index],
                    focusNode: _focusNodes[index],
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    maxLength: 1,
                    decoration: const InputDecoration(counterText: ''),
                    onChanged: (value) {
                      if (value.isNotEmpty && index < _focusNodes.length - 1) {
                        _focusNodes[index + 1].requestFocus();
                      }
                    },
                  ),
                );
              }),
            ),
            const Spacer(),
            FilledButton(
              onPressed: () {},
              child: const Text('Verify'),
            ),
          ],
        ),
      ),
    );
  }
}
