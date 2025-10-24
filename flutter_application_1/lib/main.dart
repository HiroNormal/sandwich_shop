import 'package:flutter/material.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sandwich Shop App',
      home: Scaffold(
        appBar: AppBar(title: const Text('Sandwich Counter')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const OrderItemDisplay(5, 'Footlong'),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () => print('Add button pressed!'),
                    child: const Text('Add'),
                  ),
                  const SizedBox(width: 10), // small space between buttons
                  ElevatedButton(
                    onPressed: () => print('Remove button pressed!'),
                    child: const Text('Remove'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class OrderScreen extends StatefulWidget {
  final int maxQuantity;

  const OrderScreen({super.key, this.maxQuantity = 10});

  @override
  State<OrderScreen> createState() {
    return _OrderScreenState();
  }
}

class _OrderScreenState extends State<OrderScreen> {
  int _quantity = 0;

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}


class OrderItemDisplay extends StatelessWidget {
  final int count;
  final String itemName;

  const OrderItemDisplay(this.count, this.itemName, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      '$count x $itemName',
      style: const TextStyle(fontSize: 24),
    );
  }
}

