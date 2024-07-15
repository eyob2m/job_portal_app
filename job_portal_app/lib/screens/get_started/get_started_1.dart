// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:job_portal_app/screens/get_started/get_started_2.dart';

class GetStarted1 extends StatelessWidget {
  const GetStarted1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(top: 30),
              height: 300,
              padding: EdgeInsets.all(40),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  image: DecorationImage(
                      image: AssetImage("assets/images/interview.jpg"))),
            ),
            SizedBox(height: 35),
            Column(
              children: [
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/images/google_logo.png",
                        width: 50,
                      ),
                      SizedBox(
                        width: 50,
                      ),
                      Image.asset(
                        "assets/images/linkedin_logo.png",
                        width: 50,
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Image.asset(
                  "assets/images/airbnb_logo.png",
                  width: 50,
                )
              ],
            ),
            SizedBox(
              height: 25,
            ),
            Text(
              "Explore countless job listings!",
              style: GoogleFonts.poppins(
                  fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 200),
            Container(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => GetStarted2()));
                  },
                  child: Text(
                    "Next",
                    style: GoogleFonts.poppins(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
                Icon(Icons.arrow_forward)
              ],
            ))
          ],
        ),
      ),
    );
  }
}
