import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goose/Utils/Colorconstant.dart';
import 'package:linear_progress_bar/linear_progress_bar.dart';

class Signuppage extends StatefulWidget {
  const Signuppage({super.key});

  @override
  State<Signuppage> createState() => _SignuppageState();
}

class _SignuppageState extends State<Signuppage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmpasswordController = TextEditingController();
  bool _visiblepassword = true;
  bool _visibleconfirmpassword = true;
  bool _rememberMe = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colorconstant.backgroundblack,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            Get.back();
                          },
                          icon: const Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                          )),
                      const SizedBox(width: 20),
                      Container(
                        width: 200,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey,
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(
                              20.0), // Set the border radius
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20.0),
                          child: LinearProgressBar(
                            maxSteps: 6,
                            currentStep: 2,
                            progressColor: Colorconstant.tomatored,
                            backgroundColor: Colors.grey,
                            valueColor: AlwaysStoppedAnimation<Color>(
                                Colorconstant.tomatored),
                            semanticsLabel: "Label",
                            semanticsValue: "Value",
                            minHeight: 10,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      const Text("Create an account",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                              fontWeight: FontWeight.bold)),
                      const SizedBox(width: 8),
                      Image.asset(
                        "assets/padlock.png",
                        height: 30,
                        width: 30,
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text("Username",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold)),
                              TextFormField(
                                controller: nameController,
                                style: const TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                  hintText: "Fun display name",
                                  hintStyle:
                                      const TextStyle(color: Colors.grey),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colorconstant.tomatored),
                                  ),
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Please enter your name";
                                  }
                                  return null;
                                },
                              ),
                            ],
                          ),
                          const SizedBox(height: 25),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text("Email",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold)),
                              TextFormField(
                                controller: emailController,
                                style: const TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                  hintText: "abc@gmail.com",
                                  hintStyle:
                                      const TextStyle(color: Colors.grey),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colorconstant.tomatored),
                                  ),
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Please enter your email";
                                  }
                                  final emailRegex = RegExp(
                                      r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                                  if (!emailRegex.hasMatch(value)) {
                                    return 'Please enter a valid email';
                                  }
                                  return null;
                                },
                              ),
                            ],
                          ),
                          const SizedBox(height: 25),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text("Password",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold)),
                              TextFormField(
                                controller: passwordController,
                                obscureText: !_visiblepassword,
                                style: const TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                  hintText: "********",
                                  hintStyle:
                                      const TextStyle(color: Colors.grey),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colorconstant.tomatored),
                                  ),
                                  suffixIcon: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _visiblepassword = !_visiblepassword;
                                      });
                                    },
                                    child: _visiblepassword
                                        ? Icon(
                                            Icons.visibility,
                                            color: Colorconstant.tomatored,
                                          )
                                        : Icon(
                                            Icons.visibility_off,
                                            color: Colorconstant.tomatored,
                                          ),
                                  ),
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Please enter your password";
                                  }
                                  return null;
                                },
                              ),
                            ],
                          ),
                          const SizedBox(height: 25),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text("Confirm Password",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold)),
                              TextFormField(
                                controller: confirmpasswordController,
                                obscureText: !_visibleconfirmpassword,
                                style: const TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                  hintText: "********",
                                  hintStyle:
                                      const TextStyle(color: Colors.grey),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colorconstant.tomatored),
                                  ),
                                  suffixIcon: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _visibleconfirmpassword =
                                            !_visibleconfirmpassword;
                                      });
                                    },
                                    child: _visibleconfirmpassword
                                        ? Icon(
                                            Icons.visibility,
                                            color: Colorconstant.tomatored,
                                          )
                                        : Icon(
                                            Icons.visibility_off,
                                            color: Colorconstant.tomatored,
                                          ),
                                  ),
                                ),
                                validator: (value) {
                                  if (value != passwordController.text) {
                                    return "Confirm password does not match with password";
                                  }
                                  return null;
                                },
                              ),
                            ],
                          ),

                          //checkbox remember me
                          const SizedBox(height: 20),
                          Row(
                            children: [
                              Checkbox(
                                value: _rememberMe,
                                fillColor: MaterialStateProperty.all<Color>(
                                    Colorconstant.tomatored),
                                onChanged: (value) {
                                  setState(() {
                                    _rememberMe = value!;
                                  });
                                },
                                activeColor: Colorconstant.tomatored,
                              ),
                              const Text(
                                "Remember me",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ]),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 100,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colorconstant.highgrey,
          // borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: 300,
              height: 50,
              decoration: BoxDecoration(
                color: Colorconstant.tomatored,
                borderRadius: BorderRadius.circular(20),
              ),
              child: TextButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    await registerNewUser(context);
                  }
                },
                child: const Text(
                  "Continue",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ),
      ),
      // bottomNavigationBar:
    );
  }

  Future<void> registerNewUser(BuildContext context) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
    try {
      CollectionReference usercollection =
          FirebaseFirestore.instance.collection('UserFiles');
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: emailController.text, password: passwordController.text)
          .then((result) {
        usercollection.doc(result.user!.uid).set({
          "name": nameController.text,
          "email": emailController.text,
          "password": passwordController.text,
        }).then((value) {
          Navigator.pop(context);
          Get.offAllNamed("navigatorpage");
        });
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == "email-already-in-use") {
        Navigator.pop(context);
        Get.snackbar("allert", 'The account already exists for that email.',
            snackPosition: SnackPosition.TOP, backgroundColor: Colors.red);
      } else if (e.code == "invalid-email") {
        Navigator.pop(context);
        Get.snackbar("allert", 'The email address is badly formatted.',
            snackPosition: SnackPosition.TOP, backgroundColor: Colors.red);
      } else {
        Navigator.pop(context);
        Get.snackbar("allert", e.message.toString(),
            snackPosition: SnackPosition.TOP, backgroundColor: Colors.red);
      }
    } catch (e) {
      Navigator.pop(context);
      Get.snackbar(
        "Allert",
        e.toString(),
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
      );
    }
  }
}
