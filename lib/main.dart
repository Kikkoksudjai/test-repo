import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Temperature Checker',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TemperatureForm(),
    );
  }
}

class TemperatureForm extends StatefulWidget {
  @override
  _TemperatureFormState createState() => _TemperatureFormState();
}

class _TemperatureFormState extends State<TemperatureForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController chiangMaiController = TextEditingController();
  final TextEditingController chiangRaiController = TextEditingController();
  final TextEditingController lamphunController = TextEditingController();

  String chiangMaiStatus = '';
  String chiangRaiStatus = '';
  String lamphunStatus = '';
  String result = '';

  void validateInput() {
    setState(() {
      chiangMaiStatus = _isNumeric(chiangMaiController.text) ? 'Correct' : 'Incorrect';
      chiangRaiStatus = _isNumeric(chiangRaiController.text) ? 'Correct' : 'Incorrect';
      lamphunStatus = _isNumeric(lamphunController.text) ? 'Correct' : 'Incorrect';

      if (_isNumeric(chiangMaiController.text) &&
          _isNumeric(chiangRaiController.text) &&
          _isNumeric(lamphunController.text)) {
        double chiangMaiTemp = double.parse(chiangMaiController.text);
        double chiangRaiTemp = double.parse(chiangRaiController.text);
        double lamphunTemp = double.parse(lamphunController.text);
        double averageTemp = (chiangMaiTemp + chiangRaiTemp + lamphunTemp) / 3;
        result = 'Pass\nAverage Temperature: ${averageTemp.toStringAsFixed(2)} °C';
      } else {
        result = 'Not pass';
      }
    });
  }

  bool _isNumeric(String str) {
    if (str.isEmpty) {
      return false;
    }
    return double.tryParse(str) != null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Temperature Checker'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              _buildTemperatureField(chiangMaiController, 'Temperature in Chiang Mai (°C)', chiangMaiStatus),
              SizedBox(height: 10),
              _buildTemperatureField(chiangRaiController, 'Temperature in Chiang Rai (°C)', chiangRaiStatus),
              SizedBox(height: 10),
              _buildTemperatureField(lamphunController, 'Temperature in Lamphun (°C)', lamphunStatus),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: validateInput,
                child: Text('Submit'),
              ),
              SizedBox(height: 20),
              Text(
                result,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTemperatureField(TextEditingController controller, String label, String status) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        suffixText: status,
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(),
        ),
      ),
      keyboardType: TextInputType.numberWithOptions(decimal: true),
    );
  }
}