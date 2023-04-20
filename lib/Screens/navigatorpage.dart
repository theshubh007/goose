import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goose/Screens/homepage.dart';
import 'package:goose/Screens/profilepage.dart';
import 'package:goose/Utils/Colorconstant.dart';

class Navigatorpage extends StatefulWidget {
  const Navigatorpage({super.key});

  @override
  State<Navigatorpage> createState() => _NavigatorpageState();
}

class _NavigatorpageState extends State<Navigatorpage> {
  List pages = [
    const Homepage(),
    const Profilepage(),
    const Profilepage(),
    const Profilepage(),
  ];
  int currindex = 0;
  void ontap(int index) {
    setState(() {
      currindex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currindex],
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colorconstant.grey,
        onPressed: () {
          Get.toNamed("/uploadpost");
        },
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colorconstant.tomatored,
          unselectedItemColor: Colors.white,
          backgroundColor: Colorconstant.highgrey,
          showUnselectedLabels: true,
          showSelectedLabels: true,
          onTap: ontap,
          currentIndex: currindex,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Discover"),
            BottomNavigationBarItem(icon: Icon(Icons.category), label: "Items"),
            BottomNavigationBarItem(
                icon: Icon(Icons.auto_awesome), label: "Services"),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
          ]),
    );
  }
}
