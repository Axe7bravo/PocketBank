import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pocket_banking/pages/dashboard.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late double deviceHeight, deviceWidth;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool _showSuccessMessage = false;
  


  @override
  Widget build(BuildContext context) {
    deviceHeight = MediaQuery.of(context).size.height;
    deviceWidth = MediaQuery.of(context).size.width;

return Scaffold(
      appBar: AppBar( 

        shadowColor: Colors.blue,
        title: const Text('Login to PocketWallet', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color.fromARGB(255, 23, 125, 228),
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
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center, 

              children: [
                // Centerthe circular image
                Center(
                  child: SizedBox(
                    height: deviceHeight * 0.25,
                    width: deviceHeight * 0.25, // Adjust width if needed
                    child: ClipOval(
                      child: Image.asset(
                        'assets/images/logo.png',
                        fit: BoxFit.cover, // Adjust fit as needed
                      ),
                    ),
                  ),
                ),
                const Text(
                  'Login',
                  style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                SizedBox(height: deviceHeight * 0.03),

                // Email field
                TextFormField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    labelText:  'Email',
                    labelStyle:  TextStyle(color: Colors.white),
                    border: OutlineInputBorder(
                       borderSide: BorderSide(color: Colors.white),
                    ),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                ),
                SizedBox(height: deviceHeight * 0.03),

                // Password field
                TextFormField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                    labelStyle:  TextStyle(color: Colors.white),
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    return null;
                  },
                ),
                SizedBox(height: deviceHeight * 0.03),

                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      try {
                        UserCredential userCredential = await _auth.signInWithEmailAndPassword(
                          email: emailController.text.trim(),
                          password: passwordController.text.trim(),
                        );
                        setState(() {
                          _showSuccessMessage = true;
                        });

                        Future.delayed(const Duration(seconds: 2), () {
                          setState(() {
                            _showSuccessMessage = false;
                          });
                          Navigator.pushReplacement(
                            context,
                            PageRouteBuilder(
                              pageBuilder: (context, animation, secondaryAnimation) =>
                                  const DashboardPage(),
                              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                                return FadeTransition(
                                  opacity: animation,
                                  child: child,
                                );
                              },
                            ),
                          );
                        });
                      } on FirebaseAuthException catch (e) {
                        // Handle error during sign-in
                        String errorMessage;
                        if (e.code == 'user-not-found') {
                          errorMessage = 'No user found for that email.';
                        } else if (e.code == 'wrong-password') {
                          errorMessage = 'Wrong password provided for that user.';
                        } else {
                          errorMessage = 'An error occurred. Please try again.';
                        }
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(errorMessage)),
                        );
                      }
                    }
                  },
                  child: const Text('Login'),
                ),
                SizedBox(height: deviceHeight * 0.03),

                AnimatedOpacity(
                  duration: const Duration(milliseconds: 500),
                  opacity: _showSuccessMessage ? 1.0 : 0.0,
                  child: const Text('Login Successful!', style: TextStyle(color: Color.fromARGB(255, 250, 252, 250))),
                ),

                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/register');
                  },
                  child: const Text('Don\'t have an account? Register here', style: TextStyle(color: Color.fromARGB(255, 250, 252, 250))),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}