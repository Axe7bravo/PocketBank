import 'package:flutter/material.dart';
import 'package:pocket_banking/widgets/mpesa_access_token.dart';
import 'package:pocket_banking/widgets/send_money_button.dart';

// Defining the SendMoneyPage class
class SendMoneyPage extends StatefulWidget {
  const SendMoneyPage({super.key});

  @override
  _SendMoneyPageState createState() => _SendMoneyPageState();
}

class _SendMoneyPageState extends State<SendMoneyPage> {
  // Controllers to manage the input fields
  final TextEditingController recipientController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  final TextEditingController recipientNumber = TextEditingController();

  // Form key to manage validation
  final _formKey = GlobalKey<FormState>();

  // Payment method options (replace with actual data)
  final List<String> paymentMethods = ['M-Pesa', 'Bank Transfer'];
  String selectedPaymentMethod = 'M-Pesa';

  // Favorite switch value
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Send Money'),
        backgroundColor: Colors.teal,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.green, Colors.teal],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Recipient name field
                TextFormField(
                  controller: recipientController,
                  decoration: const InputDecoration(
                    labelText: 'Recipient\'s Name',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the recipient\'s name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),

                // Input field for recipient's number
                TextFormField(
                  controller:
                      recipientNumber, // Connect the controller to the input field
                  decoration: const InputDecoration(
                    labelText:
                        'Recipient\'s Number', // Label displayed in the input field
                    border:
                        OutlineInputBorder(), // Outline border style for the input field
                  ),
                  keyboardType: TextInputType
                      .phone, // Show numeric keyboard for phone number input
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the recipient\'s number'; // Error if the field is empty
                    }
                    if (!RegExp(r'^\d{12}$').hasMatch(value)) {
                      return 'Please enter a valid 12-digit phone number'; // Ensure valid phone number
                    }
                    return null; // No error if the field is valid
                  },
                ),
                const SizedBox(height: 16.0), // Add space between the fields

                // Amount field
                TextFormField(
                  controller: amountController,
                  decoration: const InputDecoration(
                    labelText: 'Amount',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter an amount';
                    }
                    if (double.tryParse(value) == null ||
                        double.parse(value) <= 0) {
                      return 'Please enter a valid amount greater than 0';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20.0),

                // Payment method dropdown
                DropdownButtonFormField<String>(
                  value: selectedPaymentMethod,
                  items: paymentMethods.map((method) => 
                    DropdownMenuItem<String>(
                      value: method,
                      child: Text(method),
                    )
                  ).toList(),
                  onChanged: (value) => setState(() => selectedPaymentMethod = value!),
                  decoration: const InputDecoration(
                    labelText: 'Payment Method',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16.0),

                // Favorite switch
                Row(
                  children: [
                    Text('Favorite'),
                    Switch(
                      value: isFavorite,
                      onChanged: (value) => setState(() => isFavorite = value),
                    ),
                  ],
                ),
                const SizedBox(height: 20.0),

                // Send Money button
                SendMoneyButton( // Replace the previous ElevatedButton
                  text: 'Send Money',
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      String recipient = recipientController.text;
                      String amount = amountController.text;
                      String number = recipientNumber.text;

                      // Get M-Pesa access token
                      String? accessToken = await getMpesaAccessToken();

                      if (accessToken != null) {
                        // Initiate payment
                        await initiateMpesaSTKPush(
                          accessToken: accessToken,
                          recipient: number,
                          amount: amount,
                        );

                        // Show success message
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('Sending $amount to $recipient'),
                        ));
                      } else {
                        // Show error message
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('Failed to get access token'),
                        ));
                      }
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}