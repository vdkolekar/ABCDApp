import 'package:flutter/material.dart';
import 'dart:math' as math;

class ParentalGate extends StatefulWidget {
  final VoidCallback onPassed;

  const ParentalGate({super.key, required this.onPassed});

  static void show(BuildContext context, {required VoidCallback onPassed}) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => ParentalGate(onPassed: onPassed),
    );
  }

  @override
  State<ParentalGate> createState() => _ParentalGateState();
}

class _ParentalGateState extends State<ParentalGate> {
  late int num1;
  late int num2;
  late int result;
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _generateSum();
  }

  void _generateSum() {
    final random = math.Random();
    num1 = random.nextInt(10) + 1;
    num2 = random.nextInt(10) + 1;
    result = num1 + num2;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Parents Only'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('Please solve this math problem to continue:'),
          const SizedBox(height: 16),
          Text(
            '$num1 + $num2 = ?',
            style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _controller,
            keyboardType: TextInputType.number,
            autofocus: true,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Enter answer',
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            if (_controller.text == result.toString()) {
              Navigator.pop(context);
              widget.onPassed();
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Incorrect answer, try again!')),
              );
              setState(() {
                _generateSum();
                _controller.clear();
              });
            }
          },
          child: const Text('Continue'),
        ),
      ],
    );
  }
}
