import 'package:flutter/material.dart';

void main() => runApp(const TempConverterApp());

class TempConverterApp extends StatelessWidget {
  const TempConverterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //debugShowCheckedModeBanner: false,
      title: 'Temperature Converter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const TemperatureConverter(),
    );
  }
}

class TemperatureConverter extends StatefulWidget {
  const TemperatureConverter({super.key});

  @override
  _TemperatureConverterState createState() {
    return _TemperatureConverterState();
  }
}

class _TemperatureConverterState extends State<TemperatureConverter> {
  final TextEditingController _celsiusController = TextEditingController();
  final TextEditingController _fahrenheitController = TextEditingController();
  final List<String> _conversionHistory = [];

  void _convertCelsiusToFahrenheit() {
    double? celsius = double.tryParse(_celsiusController.text);
    if (celsius != null) {
      double fahrenheit = (celsius * 9 / 5) + 32;
      _fahrenheitController.text = fahrenheit.toStringAsFixed(2);
      _addToHistory('${celsius.toStringAsFixed(2)} °C to ${fahrenheit.toStringAsFixed(2)} °F');
    }
  }

  void _convertFahrenheitToCelsius() {
    double? fahrenheit = double.tryParse(_fahrenheitController.text);
    if (fahrenheit != null) {
      double celsius = (fahrenheit - 32) * 5 / 9;
      _celsiusController.text = celsius.toStringAsFixed(2);
      _addToHistory('${fahrenheit.toStringAsFixed(2)} °F to ${celsius.toStringAsFixed(2)} °C');
    }
  }

  void _addToHistory(String conversion) {
    setState(() {
      _conversionHistory.insert(0, conversion);
      if (_conversionHistory.length > 3) {
        _conversionHistory.removeLast(); // Keep only the last 3 entries
      }
    });
  }

  void _resetFields() {
    setState(() {
      _celsiusController.clear();
      _fahrenheitController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Temperature Converter',
          style: TextStyle(
            fontStyle: FontStyle.normal,
            fontSize: 27,
            color: Colors.white,
            letterSpacing: 2.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _celsiusController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Celsius',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
                'To',
              style: TextStyle(
                  fontWeight: FontWeight.w900,
                fontSize: 24,
              ),
            ),
            TextField(
              controller: _fahrenheitController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Fahrenheit',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: _convertCelsiusToFahrenheit,
                  child: const Text('Convert to Fahrenheit'),
                ),
                ElevatedButton(
                  onPressed: _convertFahrenheitToCelsius,
                  child: const Text('Convert to Celsius'),
                ),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _resetFields,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red, // Red background for reset button
              ),
              child: const Text(
                  'Reset',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Conversion History:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: _conversionHistory.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(_conversionHistory[index]),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _celsiusController.dispose();
    _fahrenheitController.dispose();
    super.dispose();
  }
}
