import 'dart:convert';
import 'dart:math';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;
import 'package:paint_app/screens/colors.dart';
import 'package:paint_app/screens/gradient_background.dart';
import 'package:paint_app/screens/Authentication/login_screen.dart';
import 'package:paint_app/screens/Authentication/wraper.dart';
import 'package:http/http.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  TextEditingController fullName = TextEditingController();
  TextEditingController phone = TextEditingController();

 Future<void> SignUp(String fullName, String email, String password, String phoneNumber,String confirmPassword) async {
  try {
    final bodyJson = jsonEncode({
      'fullName': fullName,
      'phone': phoneNumber,
      'email': email,
      'password': password,
    });
    print("Request body JSON: $bodyJson");

    final response = await http.post(
      Uri.parse("https://kkd-backend-api.onrender.com/api/user/signup"),
      headers: {'Content-Type': 'application/json'},
      body: bodyJson,
    );

    print("HTTP status: ${response.statusCode}");
    print("Raw response: ${response.body}");

    final responseData = jsonDecode(response.body);
    print("Parsed responseData: $responseData");

    if ((response.statusCode == 200 || response.statusCode == 201)&& responseData["success"] == true) {
      print("Account created successfully");
      Get.offAll(() => const WrapperState());
    } else {
      print("Signup failed: ${responseData["message"]}");
      Get.snackbar("Signup Failed", responseData["message"] ?? "Unknown error",
          backgroundColor: Colors.red, colorText: Colors.white);
    }
  } catch (e) {
    print("Exception: $e");
    Get.snackbar("Error", e.toString(),
        backgroundColor: Colors.red, colorText: Colors.white);
  }
}


  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: GradientBackground(
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: size.height -
                    MediaQuery.of(context).padding.top -
                    MediaQuery.of(context).padding.bottom,
              ),
              child: IntrinsicHeight(
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),
                      Text(
                        "Sign Up",
                        style: TextStyle(
                            color: AppColors.fontcolor,
                            fontSize: 28,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "Create Your Account",
                        style: TextStyle(
                          color: AppColors.fontcolor,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 30),

                      // Full Name
                      _buildLabel("Full Name"),
                      TextFormField(
                        controller: fullName,
                        decoration: _inputDecoration("Enter your full name"),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter your name";
                          }
                          return null;
                        },
                      ),

                      const SizedBox(height: 15),

                      // Email
                      _buildLabel("Email Address"),
                      TextFormField(
                        controller: email,
                        decoration: _inputDecoration("Enter your email"),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter your email";
                          } else if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                            return "Enter a valid email";
                          }
                          return null;
                        },
                      ),

                      const SizedBox(height: 15),

                      // Mobile Number
                      _buildLabel("Mobile Number"),
                      TextFormField(
                        controller: phone,
                        keyboardType: TextInputType.phone,
                        decoration:
                            _inputDecoration("Enter your mobile number"),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter your mobile number";
                          } else if (value.length < 10) {
                            return "Enter a valid number";
                          }
                          return null;
                        },
                      ),

                      const SizedBox(height: 15),

                      // Password
                      _buildLabel("Create Password"),
                      TextFormField(
                        controller: password,
                        obscureText: true,
                        decoration: _inputDecoration("Enter your password"),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter password";
                          } else if (value.length < 6) {
                            return "Password must be at least 6 characters";
                          }
                          return null;
                        },
                      ),

                      const SizedBox(height: 15),

                      // Confirm Password
                      _buildLabel("Confirm Password"),
                      TextFormField(
                        controller: confirmPassword,
                        obscureText: true,
                        decoration: _inputDecoration("Confirm your password"),
                        validator: (value) {
                          if (value != password.text) {
                            return "Passwords do not match";
                          }
                          return null;
                        },
                      ),

                      const Spacer(),

                      // Sign Up Button
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              final f = fullName.text.trim();
                              final e = email.text.trim();
                              final p = password.text.trim();
                              final ph = phone.text.trim();
                              final cp = confirmPassword.text.trim();

                              print("Submitting signup:");
                              print("fullName: '$f'");
                              print("email: '$e'");
                              print("password: '$p'");
                              print("phoneNumber: '$ph'");
                              print("confirmPassword: '$cp'");
                              await SignUp(f, e, p, ph, cp);
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.ButtonBackground,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                          ),
                          child: const Text(
                            "Sign Up",
                            style: TextStyle(fontSize: 15, color: Colors.white),
                          ),
                        ),
                      ),

                      const SizedBox(height: 15),

                      // Login Redirect
                      Center(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const LoginScreen()),
                            );
                          },
                          child: const Text.rich(
                            TextSpan(
                              text: "Already have an account? ",
                              children: [
                                TextSpan(
                                  text: "[Login]",
                                  style: TextStyle(
                                      color: Colors.blue,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Helper Widgets
  Widget _buildLabel(String label) => Text(
        label,
        style: TextStyle(
            color: AppColors.fontcolor,
            fontSize: 18,
            fontWeight: FontWeight.bold),
      );

  InputDecoration _inputDecoration(String hint) => InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      );
}
