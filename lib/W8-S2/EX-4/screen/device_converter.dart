import 'package:flutter/material.dart';

class DeviceConverter extends StatefulWidget {
  const DeviceConverter({super.key});

  @override
  State<DeviceConverter> createState() => _DeviceConverterState();
}

class _DeviceConverterState extends State<DeviceConverter> {
  final BoxDecoration textDecoration = BoxDecoration(
    color: Colors.pink[50],
    borderRadius: BorderRadius.circular(12),
  );
  final TextEditingController _dollarController = TextEditingController();
  String _selectCurrency = 'Euro';
  double _convertedAmount = 0.0;
  final Map<String, double> _exchangeRates = {
    'Euro': 0.85,
    'Riels': 4100.0,
    'Dong': 23000.0,
  };

  void _convertCurrency() {
    double dollarAmount = double.tryParse(_dollarController.text) ?? 0.0;
    setState(() {
      _convertedAmount = dollarAmount * (_exchangeRates[_selectCurrency] ?? 1.0);
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Converter', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),),
        backgroundColor: Colors.pink[300],
      ),
      body: Container(
        color: Colors.pink[100],
        padding: const EdgeInsets.all(40.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Icon(
                Icons.money,
                size: 60,
                color: Colors.white,
              ),
              const Center(
                child: Text(
                  "Converter",
                  style: TextStyle(color: Colors.white, fontSize: 30),
                ),
              ),
              const SizedBox(height: 50),
              const Text("Amount in dollars:"),
              const SizedBox(height: 10),
              TextField(
                controller: _dollarController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  prefix: const Text('\$ '),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.white, width: 1.0),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  hintText: 'Enter an amount in dollar',
                  hintStyle: const TextStyle(color: Colors.white),
                ),
                style: const TextStyle(color: Colors.white),
              ),
              const SizedBox(height: 30),
              DropdownButton<String>(
                value: _selectCurrency,
                onChanged: (String? newValue) {
                  setState(() {
                    _selectCurrency = newValue!;
                    _convertCurrency();
                  });
                },
                underline: Container(
                  height: 2,
                  color: Colors.pink[300],
                ),
                items: _exchangeRates.keys.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              const SizedBox(height: 30),
              const Text(
                "Amount in selected device:",
                style: TextStyle(color: Colors.white),
              ),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: textDecoration,
                child: Text(
                  '$_convertedAmount',
                  style: const TextStyle(color: Colors.black),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
