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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [
              OrderItemDisplay(5, 'Footlong'),
              OrderItemDisplay(3, 'Half'),
              OrderItemDisplay(2, 'Mini'),
            ],
          ),
        ),
      ),
    );
  }
}

class OrderItemDisplay extends StatelessWidget {
  final String itemType;
  final int quantity;

  const OrderItemDisplay(this.quantity, this.itemType, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(255, 255, 0, 115),
      width: 210.0,
      height: 210.0,
      alignment: Alignment.center,
      child: Text(
        '$quantity $itemType sandwich(es): ${List.filled(quantity, '🥪').join()}',
        textAlign: TextAlign.center,
      ),
    );
  }
}
