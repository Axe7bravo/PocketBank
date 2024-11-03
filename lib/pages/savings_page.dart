import 'package:flutter/material.dart';

class SavingsPage extends StatelessWidget {
  const SavingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Savings', style: TextStyle(color: Colors.white),),
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
        child: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Total Savings:',
                style: TextStyle(fontSize: 24, color: Colors.white70),
              ),
              SizedBox(height: 10),
              Text(
                '\$10,000.00', // Example savings amount
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold,color: Colors.white70 ),
              ),
              // Additional savings information can go here
            ],
          ),
        ),
      ),
    );
  }
}
