// ignore_for_file: prefer_const_constructors, use_super_parameters, library_private_types_in_public_api, avoid_print

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:job_portal_app/widgets/app_colors.dart' as appcolors;

class BottomHome extends StatefulWidget {
  const BottomHome({Key? key}) : super(key: key);

  @override
  _BottomHomeState createState() => _BottomHomeState();
}

class _BottomHomeState extends State<BottomHome> {
  List<dynamic> jobs = [];
  final tabList = ["All", "Recent", "Featured"];
  var selectedTab = 0;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      var response = await http.get(
        Uri.parse("http://192.168.158.34:80/api/getjobs"),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json"
        },
      );

      if (response.statusCode == 200) {
        var responseData = jsonDecode(response.body);
        setState(() {
          jobs = responseData["jobs"];
        });
        print("Successful");
        print(jobs);
      } else {
        print("Failed to fetch data");
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 30),
            height: 26,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: tabList.length,
              separatorBuilder: (_, Index) {
                return SizedBox(
                  width: 8,
                );
              },
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedTab = index;
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 35),
                    decoration: BoxDecoration(
                      color: selectedTab == index
                          ? appcolors.primaryColor.withOpacity(0.3)
                          : Colors.white,
                      border: Border.all(
                        color: selectedTab == index
                            ? appcolors.primaryColor
                            : appcolors.primaryColor.withOpacity(0.2),
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      tabList[index],
                      style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: selectedTab == index
                              ? FontWeight.w500
                              : FontWeight.w300),
                    ),
                  ),
                );
              },
            ),
          ),
          buildJobList(jobs),
        ],
      ),
    );
  }

  Widget buildJobList(List<dynamic> jobList) {
    print(jobList);
    if (jobList.isEmpty) {
      return Container(
        child: Text("No jobs available"),
      );
    }
    return SizedBox(
      height: 400,
      child: ListView.separated(
        padding: EdgeInsets.symmetric(vertical: 10),
        itemCount: jobList.length,
        itemBuilder: (context, index) {
          var job = jobList[index];
          return ListTile(
            title: Text(
              job["company_name"],
            ),
            subtitle: Text(job["title"]),
          );
        },
        separatorBuilder: (context, index) => Divider(),
      ),
    );
  }
}
