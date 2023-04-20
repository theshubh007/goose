import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goose/Utils/Colorconstant.dart';

class Loginpage extends StatefulWidget {
  const Loginpage({super.key});

  @override
  State<Loginpage> createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colorconstant.backgroundblack,
      body: SafeArea(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
            const Image(height: 180, image: AssetImage("assets/girlicon.png")),
            const SizedBox(height: 20),
            const Text("Let's get you in",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),

            //continue with google button
            Container(
              width: 300,
              height: 40,
              decoration: BoxDecoration(
                  color: Colorconstant.highgrey,
                  borderRadius: BorderRadius.circular(20)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Image(height: 25, image: AssetImage("assets/google.png")),
                  SizedBox(width: 10),
                  Text("Continue with google",
                      style: TextStyle(color: Colors.white, fontSize: 15)),
                ],
              ),
            ),
            const SizedBox(height: 20),


            //continue with facebook button
            Container(
              width: 300,
              height: 40,
              decoration: BoxDecoration(
                  color: Colorconstant.highgrey,
                  borderRadius: BorderRadius.circular(20)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Image(height: 25, image: AssetImage("assets/facebook.png")),
                  SizedBox(width: 10),
                  Text("Continue with Facebook",
                      style: TextStyle(color: Colors.white, fontSize: 15)),
                ],
              ),
            ),
            const SizedBox(height: 20),

            //divider with or
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 140,
                  height: 1,
                  color: Colors.white,
                ),
                const SizedBox(width: 10),
                const Text("or",
                    style: TextStyle(color: Colors.white, fontSize: 15)),
                const SizedBox(width: 10),
                Container(
                  width: 140,
                  height: 1,
                  color: Colors.white,
                ),
              ],
            ),
            const SizedBox(height: 20),



            //signup with email button
            Container(
              width: 300,
              height: 40,
              decoration: BoxDecoration(
                  color: Colorconstant.tomatored,
                  borderRadius: BorderRadius.circular(20)),
              child: const Center(
                child: Text("Sign in With Email",
                    style: TextStyle(color: Colors.white, fontSize: 15)),
              ),
            ),

            //don't have an account? Sign up
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Don't have an account?",
                    style: TextStyle(color: Colors.white, fontSize: 15)),
                const SizedBox(width: 10),
                InkWell(
                  onTap: () {
                    //navigate to signup page
                    Get.toNamed("signuppage");
                  },
                  child: SizedBox(
                    height: 30,
                    child: Center(
                      child: Text("Sign up",
                          style: TextStyle(
                              color: Colorconstant.tomatored,
                              fontSize: 15,
                              fontWeight: FontWeight.bold)),
                    ),
                  ),
                ),
              ],
            ),
          ])),
    );
  }
}
