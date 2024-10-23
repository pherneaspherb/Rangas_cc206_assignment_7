import 'package:flutter/cupertino.dart'; // for cupertino
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  double sum = 0;
  double difference = 0;
  double product = 0;
  double quotient = 0.0;

  // TextEditingController for every operation's input fields
  final TextEditingController firstAddNumController = TextEditingController();
  final TextEditingController secondAddNumController = TextEditingController();
  final TextEditingController firstSubNumController = TextEditingController();
  final TextEditingController secondSubNumController = TextEditingController();
  final TextEditingController firstMulNumController = TextEditingController();
  final TextEditingController secondMulNumController = TextEditingController();
  final TextEditingController firstDivNumController = TextEditingController();
  final TextEditingController secondDivNumController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Rangas, John Pher Loyd S. // Calculator // Unit 5"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // row of addition
            _buildOperationRow(
              firstNumController: firstAddNumController,
              secondNumController: secondAddNumController,
              operation: '+',
              result: '$sum',
              icon: Icons.add, // addition icon
              onCalculate: () => _calculateSum(),
              onClear: () => _clearInputs(firstAddNumController, secondAddNumController, () => setState(() => sum = 0)), // this is to clear input fieldss
            ),
            const SizedBox(height: 20),

            // row of subtraction
            _buildOperationRow(
              firstNumController: firstSubNumController,
              secondNumController: secondSubNumController,
              operation: '-',
              result: '$difference',
              icon: Icons.remove, // subtraction icon
              onCalculate: () => _calculateDifference(),
              onClear: () => _clearInputs(firstSubNumController, secondSubNumController, () => setState(() => difference = 0)), // this is to clear input fieldss
            ),
            const SizedBox(height: 20),

            // row of multiplication
            _buildOperationRow(
              firstNumController: firstMulNumController,
              secondNumController: secondMulNumController,
              operation: '×',
              result: '$product',
              icon: Icons.clear, // multiplication icon
              onCalculate: () => _calculateProduct(),
              onClear: () => _clearInputs(firstMulNumController, secondMulNumController, () => setState(() => product = 0)), // this is to clear input fieldss
            ),
            const SizedBox(height: 20),

            // row of division
            _buildOperationRow(
              firstNumController: firstDivNumController,
              secondNumController: secondDivNumController,
              operation: '÷',
              result: "${quotient.toStringAsFixed(2)}", // two decimal places
              icon: CupertinoIcons.divide, 
              onCalculate: () => _calculateQuotient(),
              onClear: () => _clearInputs(firstDivNumController, secondDivNumController, () => setState(() => quotient = 0.0)), // this is to clear input fieldss
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

Row _buildOperationRow({ // to build each operation row
  required TextEditingController firstNumController,
  required TextEditingController secondNumController,
  required String operation,
  required String result,
  required IconData icon,  // icon for each operation
  required VoidCallback onCalculate,  // calculation function
  required VoidCallback onClear,  // clear function
}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      // First number input
      Expanded(
        child: TextField(
          controller: firstNumController,
          decoration: const InputDecoration(labelText: "First Number"),
          keyboardType: TextInputType.number,
        ),
      ),
      // Operation symbol
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Text(
          operation,
          style: const TextStyle(fontSize: 20),
        ),
      ),
      // Second number input
      Expanded(
        child: TextField(
          controller: secondNumController,
          decoration: const InputDecoration(labelText: "Second Number"),
          keyboardType: TextInputType.number,
        ),
      ),
      // IconButton for calculating
      IconButton(
        icon: Icon(icon),  // Icon from the parameter
        onPressed: onCalculate,
      ),
      // Total result
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0), // for its spacing
        child: Text(
          "=",
          style: const TextStyle(fontSize: 20),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(right: 16.0), // exxtra space
        child: Text(
          result,
          style: const TextStyle(fontSize: 24),
        ),
      ),
      // used ElevatedButton
      ElevatedButton(
        onPressed: onClear,
        child: const Text("Clear"),
      ),
    ],
  );
}


  // Function to calculate sum
  void _calculateSum() {
    setState(() {
      double firstAddNum = double.tryParse(firstAddNumController.text) ?? 0;
      double secondAddNum = double.tryParse(secondAddNumController.text) ?? 0;
      sum = firstAddNum + secondAddNum;
    });
  }

  // difference
  void _calculateDifference() {
    setState(() {
      double firstSubNum = double.tryParse(firstSubNumController.text) ?? 0;
      double secondSubNum = double.tryParse(secondSubNumController.text) ?? 0;
      difference = firstSubNum - secondSubNum;
    });
  }

  // product
  void _calculateProduct() {
    setState(() {
      double firstMulNum = double.tryParse(firstMulNumController.text) ?? 0;
      double secondMulNum = double.tryParse(secondMulNumController.text) ?? 0;
      product = firstMulNum * secondMulNum;
    });
  }

  // quotient
  void _calculateQuotient() {
    setState(() {
      double firstDivNum = double.tryParse(firstDivNumController.text) ?? 0;
      double secondDivNum = double.tryParse(secondDivNumController.text) ?? 1; // To avoid division by 0
      quotient = firstDivNum / secondDivNum;
    });
  }

  // Function to clear the input and reset the result
  void _clearInputs(TextEditingController firstController, TextEditingController secondController, VoidCallback resetResult) {
    setState(() {
      firstController.clear();
      secondController.clear();
      resetResult();
    });
  }
}
