import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(MaterialApp(
    theme: ThemeData.light(),
    darkTheme: ThemeData.dark(),
    themeMode: ThemeMode.system,
    home: BalokCalculator(),
  ));
}

class BalokCalculator extends StatefulWidget {
  @override
  _BalokCalculatorState createState() => _BalokCalculatorState();
}

class _BalokCalculatorState extends State<BalokCalculator> {
  final TextEditingController _panjangController = TextEditingController();
  final TextEditingController _lebarController = TextEditingController();
  final TextEditingController _tinggiController = TextEditingController();
  String _volume = '';
  String _luasPermukaan = '';

  void _hitungBalok() {
    String panjangInput = _panjangController.text;
    String lebarInput = _lebarController.text;
    String tinggiInput = _tinggiController.text;

    double? panjang = double.tryParse(panjangInput);
    double? lebar = double.tryParse(lebarInput);
    double? tinggi = double.tryParse(tinggiInput);

    if (panjang == null ||
        lebar == null ||
        tinggi == null ||
        panjang <= 0 ||
        lebar <= 0 ||
        tinggi <= 0) {
      _showErrorDialog();
      return;
    }

    setState(() {
      double volume = panjang * lebar * tinggi;
      double luasPermukaan =
          2 * (panjang * lebar + panjang * tinggi + lebar * tinggi);
      _volume = volume.toStringAsFixed(2);
      _luasPermukaan = luasPermukaan.toStringAsFixed(2);
    });
  }

  void _showErrorDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Input tidak valid'),
        content:
            Text('Masukkan nilai panjang, lebar, dan tinggi yang positif.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Kalkulator Balok')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _panjangController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Panjang'),
            ),
            TextField(
              controller: _lebarController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Lebar'),
            ),
            TextField(
              controller: _tinggiController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Tinggi'),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _hitungBalok,
              child: Text('Hitung'),
            ),
            SizedBox(height: 16.0),
            Text(
              'Volume: $_volume',
              style: TextStyle(fontSize: 24),
            ),
            Text(
              'Luas Permukaan: $_luasPermukaan',
              style: TextStyle(fontSize: 24),
            ),
          ],
        ),
      ),
    );
  }
}
