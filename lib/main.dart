import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: BudgetScreen(),
    );
  }
}


class BudgetScreen extends StatefulWidget {
  @override
  _BudgetScreenState createState() => _BudgetScreenState();
}

class _BudgetScreenState extends State<BudgetScreen> {
  double _totalBudget = 1000.0;
  double _currentSpending = 300.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BudgetBuddy'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Total Budget: \$$_totalBudget',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            Text(
              'Current Spending: \$$_currentSpending',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _navigateToAddSpending();
              },
              child: Text('Add Spending'),
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToAddSpending() async {
    double newSpending = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddSpendingScreen()),
    );

    if (newSpending != null) {
      setState(() {
        _currentSpending += newSpending;
      });
    }
  }
}

class AddSpendingScreen extends StatelessWidget {
  final TextEditingController _spendingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Spending'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _spendingController,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(labelText: 'Enter Spending Amount'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                double newSpending =
                    double.tryParse(_spendingController.text) ?? 0.0;
                Navigator.pop(context, newSpending);
              },
              child: Text('Add Spending'),
            ),
          ],
        ),
      ),
    );
  }
}
