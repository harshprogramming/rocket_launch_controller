import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rocket Launch',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const CounterWidget(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class CounterWidget extends StatefulWidget {
  const CounterWidget({super.key});

  @override
  State<CounterWidget> createState() => _CounterWidgetState();
}

class _CounterWidgetState extends State<CounterWidget> {
  int _counter = 0;
  bool _launched = false;


  void _setCounter(int value) {
    setState(() {
      _counter = value.clamp(0, 100);
      if (_counter < 100) _launched = false;
    });
  }

  Color _statusColor() {
    if (_counter == 0) return Colors.red;
    if (_counter > 50) return Colors.green;
    return Colors.orange;
  }

  @override
  Widget build(BuildContext context) {
    final isMax = _counter >= 100;
    final isMin = _counter <= 0;

    return Scaffold(
      appBar: AppBar(title: const Text('Rocket Launch Controller')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.blue.shade200),
              ),
              child: Column(
                children: [
                  Text(
                    _counter == 100 ? 'LIFT OFF!' : '$_counter',
                    style: TextStyle(fontSize: 56, fontWeight: FontWeight.w700, color: _statusColor()),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Fuel',
                    style: TextStyle(color: Colors.blueGrey.shade600),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            Slider(
              min: 0,
              max: 100,
              value: _counter.toDouble(),
              onChanged: (double v) => _setCounter(v.toInt()),
              activeColor: Colors.blue,
              inactiveColor: Colors.red,
            ),

            const SizedBox(height: 12),

            Wrap(
              alignment: WrapAlignment.center,
              spacing: 12,
              runSpacing: 12,
              children: [
                ElevatedButton.icon(
                  onPressed: isMax ? null : () => _setCounter(_counter + 1),
                  label: const Text('Ignite +1'),
                ),
                ElevatedButton.icon(
                  onPressed: isMin ? null : () => _setCounter(_counter - 1),
                  label: const Text('Decrement -1'),
                ),
                OutlinedButton.icon(
                  onPressed: _counter == 0 ? null : () => _setCounter(0),
                  label: const Text('abort'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
