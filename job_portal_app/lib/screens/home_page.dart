// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:job_portal_app/screens/show_list.dart';
import 'package:job_portal_app/widgets/app_colors.dart' as appcolors;
import 'package:job_portal_app/widgets/job_upload.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.all(15),
          padding: EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    "Welcome Home",
                    style: GoogleFonts.poppins(
                      color: Colors.grey.withOpacity(0.9),
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Spacer(),
                  Stack(
                    children: [
                      Icon(
                        Icons.notifications_none_outlined,
                        size: 30,
                      ),
                      Positioned(
                        top: 0,
                        right: 3,
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.red,
                          ),
                          padding: EdgeInsets.all(4),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Image.asset(
                    "assets/images/avatar.png",
                    width: 40,
                    height: 40,
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Client Name",
                style: GoogleFonts.poppins(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              SizedBox(
                child: Container(
                  padding: EdgeInsets.all(14),
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/images/search_bg.png"),
                          fit: BoxFit.fill),
                      borderRadius: BorderRadius.circular(20)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 12),
                      Text(
                        "Search the job your looking for",
                        style: GoogleFonts.poppins(
                            color: Colors.white, fontSize: 14),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextField(
                        decoration: InputDecoration(
                            hintText: "Search",
                            hintStyle: GoogleFonts.poppins(color: Colors.grey),
                            prefixIcon: Icon(
                              Icons.search_rounded,
                              color: Colors.grey,
                            ),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide.none),
                            contentPadding: EdgeInsets.zero,
                            fillColor: Colors.white,
                            filled: true),
                      ),
                      SizedBox(
                        height: 45,
                      )
                    ],
                  ),
                ),
              ),
              BottomHome(),
              Spacer(),
              Center(
                  child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: appcolors.starColor,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => JobUpload()));
                  },
                  child: Icon(
                    Icons.add,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
              )),
            ],
          ),
        ),
      ),
    );
  }
}
