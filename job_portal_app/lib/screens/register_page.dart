// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:job_portal_app/models/authentication.dart';
import 'package:job_portal_app/screens/login_page.dart';
import 'package:job_portal_app/widgets/input_widget.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final AuthenticationController _authenticationController =
      Get.put(AuthenticationController());

  void _validateAndRegister() async {
    _authenticationController.clearRegErrorMessages();
    bool hasError = false;

    if (_nameController.text.trim().isEmpty) {
      _authenticationController.regerrorMessages['name'] = '*name';
      hasError = true;
    }
    if (_usernameController.text.trim().isEmpty) {
      _authenticationController.regerrorMessages['username'] = '*username';
      hasError = true;
    }
    if (_emailController.text.trim().isEmpty) {
      _authenticationController.regerrorMessages['email'] = '*email';
      hasError = true;
    }
    if (_passwordController.text.trim().isEmpty) {
      _authenticationController.regerrorMessages['password'] = '*password';
      hasError = true;
    }

    if (!hasError) {
      await _authenticationController.register(
        name: _nameController.text.trim(),
        username: _usernameController.text.trim(),
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Register Page",
                  style: GoogleFonts.poppins(
                      fontSize: size * 0.080, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 30),
                Obx(() {
                  return Column(
                    children: [
                      InputWidget(
                        errorText:
                            _authenticationController.regerrorMessages['name'],
                        hintText: "Name",
                        controller: _nameController,
                        obscureText: false,
                      ),
                      SizedBox(height: 15),
                      InputWidget(
                        errorText: _authenticationController
                            .regerrorMessages['username'],
                        hintText: "Username",
                        controller: _usernameController,
                        obscureText: false,
                      ),
                      SizedBox(height: 15),
                      InputWidget(
                        errorText:
                            _authenticationController.regerrorMessages['email'],
                        hintText: "Email",
                        controller: _emailController,
                        obscureText: false,
                      ),
                      SizedBox(height: 15),
                      InputWidget(
                        errorText: _authenticationController
                            .regerrorMessages['password'],
                        hintText: "Password",
                        controller: _passwordController,
                        obscureText: true,
                      ),
                      SizedBox(height: 30),
                      _authenticationController.isRegLoading.value
                          ? const CircularProgressIndicator()
                          : ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.black,
                                  elevation: 0,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 19, vertical: 12)),
                              onPressed: _validateAndRegister,
                              child: Text(
                                "Register",
                                style: GoogleFonts.poppins(
                                    fontSize: size * 0.040,
                                    color: Colors.white),
                              ),
                            ),
                      SizedBox(height: 8),
                      TextButton(
                        onPressed: () {
                          Get.off(() => LoginPage());
                          _authenticationController.clearRegErrorMessages();
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.arrow_back),
                            Text(
                              "Back to login",
                              style: GoogleFonts.poppins(
                                  fontSize: size * 0.040, color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
