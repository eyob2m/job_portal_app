// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors, avoid_print, sized_box_for_whitespace, prefer_const_literals_to_create_immutables

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:job_portal_app/widgets/constants.dart';

class JobList extends StatefulWidget {
  const JobList({super.key});

  @override
  State<JobList> createState() => _JobListState();
}

class _JobListState extends State<JobList> {
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  List<dynamic> jobs = [];
  Future<void> fetchData() async {
    try {
      var response = await http.get(
        Uri.parse('${url}getjobs'),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        setState(() {
          jobs = jsonData["jobs"];
        });
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print('Error: $e');
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemBuilder: (context, index) {
          var job = jobs[index];
          return Container(
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            margin: EdgeInsets.only(top: 25),
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      job["company_name"],
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.bold, fontSize: 17),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Icon(
                      Icons.location_on_outlined,
                      size: 20,
                    ),
                    Text(job["location"]),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "Position: ",
                      style: GoogleFonts.poppins(
                          color: Colors.black.withOpacity(0.5)),
                    ),
                    Text(
                      job["title"],
                      style: GoogleFonts.poppins(fontWeight: FontWeight.w500),
                    ),
                  ],
                )
              ],
            ),
          );
        },
        separatorBuilder: (context, index) => SizedBox(height: 15),
        itemCount: jobs.length);
  }
}
