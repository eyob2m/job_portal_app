// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:job_portal_app/widgets/app_colors.dart' as appcolors;

class BottomHome extends StatefulWidget {
  const BottomHome({super.key});

  @override
  State<BottomHome> createState() => _BottomHomeState();
}

class _BottomHomeState extends State<BottomHome> {
  final tabList = <String>["All", "Recent", "Featured"];
  var selected = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(vertical: 20),
        height: 26,
        child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    selected = index;
                  });
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 34),
                  decoration: BoxDecoration(
                      color: selected == index
                          ? appcolors.primaryColor.withOpacity(0.3)
                          : Colors.white,
                      border: Border.all(
                          color: selected == index
                              ? appcolors.primaryColor
                              : appcolors.primaryColor.withOpacity(0.2)),
                      borderRadius: BorderRadius.circular(20)),
                  child: Text(
                    tabList[index],
                    style: GoogleFonts.poppins(fontSize: 14),
                  ),
                ),
              );
            },
            separatorBuilder: (_, index) {
              return SizedBox(
                width: 10,
              );
            },
            itemCount: tabList.length));
  }
}
