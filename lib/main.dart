import 'package:flutter/material.dart';
import 'dart:math';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BMI Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BMICalculator(),
    );
  }
}

class BMICalculator extends StatefulWidget {
  @override
  _BMICalculatorState createState() => _BMICalculatorState();
}

class _BMICalculatorState extends State<BMICalculator> {
  TextEditingController nameController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  TextEditingController valueController = TextEditingController();
  String gender = 'Male';
  String result = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BMI Calculator'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Your Fullname'),
            ),
            SizedBox(height: 10),
            TextField(
              controller: heightController,
              decoration: InputDecoration(labelText: 'height in cm: 170'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 10),
            TextField(
              controller: weightController,
              decoration: InputDecoration(labelText: 'Weight in KG'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 10),
            TextField(
              controller: valueController,
              readOnly: true,
              decoration: InputDecoration(labelText: 'BMI Value'),
              enabled: false,
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Radio(
                  value: 'Male',
                  groupValue: gender,
                  onChanged: (value) {
                    setState(() {
                      gender = value!;
                    });
                  },
                ),
                Text('Male'),
                SizedBox(width: 10),

                Radio(
                  value: 'Female',
                  groupValue: gender,
                  onChanged: (value) {
                    setState(() {
                      gender = value!;
                    });
                  },
                ),
                Text('Female'),
                SizedBox(width: 10),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                calculateBMI();
              },
              child: Text('Calculate BMI and Save'),
            ),
            SizedBox(height: 20),
            Center(
              child: Text(result),
            ),
          ],
        ),
      ),
    );
  }

  void calculateBMI() {
    String name = nameController.text;
    double height = double.parse(heightController.text);
    double weight = double.parse(weightController.text);

    double bmi = weight / pow((height/ 100),2);
    String bmiGender = _getBMIGender(bmi);

    setState(() {
      result = '''
      
        $gender $bmiGender
      ''';
      valueController.text = bmi.toString();
    });

    TextField(
      controller: valueController,
      style: TextStyle(
        fontWeight: FontWeight.bold,
      ),
    );
  }

  String _getBMIGender(double bmi) {
    //male
    if (gender == 'Male') {
      if (bmi < 18.5) {
        return 'Underweight. Careful during strong wind!';
      } else if (bmi >= 18.5 && bmi < 24.9) {
        return 'That’s ideal! Please maintain';
      } else if (bmi >= 25 && bmi < 29.9) {
        return 'Overweight! Work out please';
      } else {
        return 'Whoa Obese! Dangerous mate!';
      }
    }
    else {
      //female
      if (bmi < 16) {
        return 'Underweight. Careful during strong wind!';
      } else if (bmi >= 16 && bmi < 22) {
        return 'That’s ideal! Please maintain';
      } else if (bmi >= 22 && bmi < 27) {
        return 'Overweight! Work out please';
      } else {
        return 'Whoa Obese! Dangerous mate!';
      }
    }
  }
}