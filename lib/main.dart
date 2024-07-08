import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _infoText = 'Informe seus dados!';

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    weightController.dispose();
    heightController.dispose();
    super.dispose();
  }

  void _resetFields() {
    setState(() {
      weightController.text = "";
      heightController.text = "";
      _infoText = 'Informe seus dados!';
      _formKey = GlobalKey<FormState>();
    });
  }

  void _calculateBMI() {
    if (_formKey.currentState!.validate()) {
      double weight = double.parse(weightController.text);
      double height = double.parse(heightController.text) / 100;
      double bmi = weight / (height * height);

      setState(() {
        _infoText = _getBMIResult(bmi);
      });
    }
  }

  String _getBMIResult(double bmi) {
    if (bmi < 18.6) {
      return 'Abaixo do peso (${bmi.toStringAsPrecision(3)})';
    } else if (bmi >= 18.6 && bmi < 24.9) {
      return 'Peso Ideal (${bmi.toStringAsPrecision(3)})';
    } else if (bmi >= 24.9 && bmi < 29.9) {
      return 'Levemente Acima do Peso (${bmi.toStringAsPrecision(3)})';
    } else if (bmi >= 29.9 && bmi < 34.9) {
      return 'Obesidade Grau I (${bmi.toStringAsPrecision(3)})';
    } else if (bmi >= 34.9 && bmi < 39.9) {
      return 'Obesidade Grau II (${bmi.toStringAsPrecision(3)})';
    } else {
      return 'Obesidade Grau III (${bmi.toStringAsPrecision(3)})';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculadora de IMC'),
        centerTitle: true,
        backgroundColor: Colors.green,
        actions: <Widget>[
          IconButton(
            onPressed: _resetFields,
            icon: Icon(Icons.refresh),
          )
        ],
      ),
      backgroundColor: Colors.blueGrey,
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(10, 0.0, 10, 0.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Icon(Icons.person_outline, size: 120.0, color: Colors.blueGrey),
              _buildTextFormField(
                label: 'Peso (kg)',
                controller: weightController,
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Insira seu Peso!';
                  }
                  return null;
                },
              ),
              _buildTextFormField(
                label: 'Altura (cm)',
                controller: heightController,
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Insira sua Altura!';
                  }
                  return null;
                },
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                child: Container(
                  height: 50,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                    ),
                    onPressed: _calculateBMI,
                    child: const Text(
                      'Calcular',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
              Text(
                _infoText,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 15.0),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextFormField({
    required String label,
    required TextEditingController controller,
    required FormFieldValidator<String>? validator,
  }) {
    return TextFormField(
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.white),
      ),
      textAlign: TextAlign.center,
      style: TextStyle(color: Colors.white, fontSize: 25.0),
      controller: controller,
      validator: validator,
    );
  }
}
