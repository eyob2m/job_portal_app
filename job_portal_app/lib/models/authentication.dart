// ignore_for_file: avoid_print, prefer_const_constructors

import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:job_portal_app/screens/home_page.dart';
import 'package:job_portal_app/screens/login_page.dart';
import 'package:job_portal_app/widgets/constants.dart';

class AuthenticationController extends GetxController {
  final isRegLoading = false.obs;
  final isLogLoading = false.obs;
  final regerrorMessages = {}.obs;
  final logerrorMessages = {}.obs;

  final token = ''.obs;
  final box = GetStorage();

  void clearRegErrorMessages() {
    regerrorMessages.clear();
  }

  void clearLogErrorMessages() {
    logerrorMessages.clear();
  }

  Future register({
    required String name,
    required String username,
    required String email,
    required String password,
  }) async {
    try {
      isRegLoading.value = true;
      var data = jsonEncode({
        "name": name,
        "username": username,
        "email": email,
        "password": password,
      });
      var response = await http.post(Uri.parse('${url}register'),
          headers: {
            'Accept': 'application/json',
            "Content-Type": "application/json"
          },
          body: data);
      if (response.statusCode == 201) {
        isRegLoading.value = false;
        token.value = json.decode(response.body)["token"];
        box.write("token", token.value);
        regerrorMessages.clear();
        Get.offAll(() => LoginPage());
        print('Registration successful');
      } else if (response.statusCode == 422) {
        var errors = json.decode(response.body)['errors'];
        regerrorMessages.value = errors.map((key, value) {
          return MapEntry(key, (value as List<dynamic>).join(' '));
        });
      } else {
        var responseData = json.decode(response.body);
        regerrorMessages.clear();
        responseData['errors'].forEach((key, value) {
          regerrorMessages[key] = value[0];
        });
        isRegLoading.value = false;
        print({response.body});
      }
    } catch (e) {
      isRegLoading.value = false;
      print(e.toString());
    }
  }

  Future login({
    required String username,
    required String password,
  }) async {
    try {
      isLogLoading.value = true;
      var data = jsonEncode({
        "username": username,
        "password": password,
      });
      var response = await http.post(Uri.parse('${url}login'),
          headers: {
            'Accept': 'application/json',
            "Content-Type": "application/json"
          },
          body: data);
      if (response.statusCode == 200) {
        token.value = json.decode(response.body)["token"];
        box.write("token", token.value);
        logerrorMessages.clear();
        Get.offAll(() => (HomePage()));
        print('Login successful');
      } else if (response.statusCode == 401) {
        logerrorMessages.clear();
        logerrorMessages["general"] = "Invalid credentials";
        isLogLoading.value = false;
        print('Invalid credentials');
      }
    } catch (e) {
      isLogLoading.value = false;
      print(e.toString());
    }
  }
}
