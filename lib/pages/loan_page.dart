import 'package:flutter/material.dart';

class LoanPage extends StatelessWidget {
  final TextEditingController _amountController = TextEditingController();

  LoanPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Loan Overview', style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.blueAccent,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.lightBlue, Color.fromARGB(255, 50, 122, 245)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                'Current Loan Balance: \$5,000',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              const SizedBox(height: 10),
              const Text(
                'Total Loan Amount: \$10,000',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
              const SizedBox(height: 10),
              const Text(
                'Interest Rate: 5%',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
              const SizedBox(height: 10),
              const Text(
                'Payment Schedule: Monthly',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
              const SizedBox(height: 20),
              const Text(
                'Apply for a Loan',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              TextField(
                controller: _amountController,
                decoration: const InputDecoration(
                  labelText: 'Enter Loan Amount',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Handle loan application logic
                  final amount = _amountController.text;
                  _showLoanConfirmation(
                      context, amount); // Show confirmation dialog
                }, // Button text
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pinkAccent,
                  foregroundColor: Colors.white,
                ),
                child: Text('Apply for Loan'), // Button color
              ),
              const SizedBox(height: 20),
              const Text(
                'Loan History',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              // Dummy data for loan history
              Expanded(
                child: ListView(
                  children: const [
                    ListTile(
                      title: Text('Loan Application - \$2,000', style:TextStyle(color: Colors.white)),
                      subtitle: Text('Status: Approved', style: TextStyle(color: Colors.white70),),
                    ),
                    ListTile(
                      title: Text('Loan Application - \$1,000', style:TextStyle(color: Colors.white)),
                      subtitle: Text('Status: Pending', style: TextStyle(color: Colors.white70),),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showLoanConfirmation(BuildContext context, String amount) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Loan Application'),
          content: Text('You have applied for a loan of \$$amount.'),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
          ],
        );
      },
    );
  }
}
