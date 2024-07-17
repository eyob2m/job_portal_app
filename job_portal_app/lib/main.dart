import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:job_portal_app/screens/get_started/get_started_1.dart';
import 'package:job_portal_app/screens/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Forum App",
        home: HomePage());
  }
}
