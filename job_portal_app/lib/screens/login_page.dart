// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers, sized_box_for_whitespace, unused_element

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:job_portal_app/models/authentication.dart';
import 'package:job_portal_app/screens/register_page.dart';
import 'package:job_portal_app/widgets/input_widget.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthenticationController _authenticationController =
      Get.put(AuthenticationController());

  void _validateAndLogin() async {
    _authenticationController.clearLogErrorMessages();
    bool hasError = false;
    if (_usernameController.text.trim().isEmpty) {
      _authenticationController.logerrorMessages["username"] = "*username";
      hasError = true;
    }
    if (_passwordController.text.trim().isEmpty) {
      _authenticationController.logerrorMessages["password"] = "*password";
      hasError = true;
    }

    if (!hasError) {
      await _authenticationController.login(
          username: _usernameController.text.trim(),
          password: _passwordController.text.trim());
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
                  "Login Page",
                  style: GoogleFonts.poppins(
                      fontSize: size * 0.080, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 30),
                Obx(() {
                  return Column(
                    children: [
                      InputWidget(
                        errorText: _authenticationController
                            .logerrorMessages["username"],
                        hintText: "Username",
                        controller: _usernameController,
                        obscureText: false,
                      ),
                      SizedBox(height: 15),
                      InputWidget(
                        errorText: _authenticationController
                            .logerrorMessages["password"],
                        hintText: "Password",
                        controller: _passwordController,
                        obscureText: true,
                      ),
                    ],
                  );
                }),
                SizedBox(height: 15),
                Obx(() {
                  if (_authenticationController.logerrorMessages['general'] !=
                      null) {
                    return Text(
                      _authenticationController.logerrorMessages['general']!,
                      style: GoogleFonts.poppins(color: Colors.red),
                    );
                  }
                  return Container();
                }),
                SizedBox(height: 10),
                _authenticationController.isLogLoading.value
                    ? const CircularProgressIndicator()
                    : ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            elevation: 0,
                            padding: EdgeInsets.symmetric(
                                horizontal: 19, vertical: 12)),
                        onPressed: _validateAndLogin,
                        child: Text(
                          "Login",
                          style: GoogleFonts.poppins(
                            fontSize: size * 0.040,
                            color: Colors.white,
                          ),
                        ),
                      ),
                SizedBox(height: 8),
                TextButton(
                  onPressed: () {
                    Get.off(() => RegisterPage());
                    _authenticationController.clearLogErrorMessages();
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Register",
                        style: GoogleFonts.poppins(
                            fontSize: size * 0.040, color: Colors.black),
                      ),
                      Icon(Icons.arrow_forward)
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
