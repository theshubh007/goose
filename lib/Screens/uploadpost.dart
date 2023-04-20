import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goose/Utils/Colorconstant.dart';
import 'package:multiple_images_picker/multiple_images_picker.dart';
import 'package:path_provider/path_provider.dart';

class Uploadpost extends StatefulWidget {
  const Uploadpost({super.key});

  @override
  State<Uploadpost> createState() => _UploadpostState();
}

class _UploadpostState extends State<Uploadpost> {
  final formkey = GlobalKey<FormState>();
  TextEditingController titlecontroller = TextEditingController();
  TextEditingController descriptioncontroller = TextEditingController();
  TextEditingController pricecontroller = TextEditingController();
  TextEditingController categorycontroller = TextEditingController();
  CollectionReference usercollection =
      FirebaseFirestore.instance.collection('UserFiles');
  User? user = FirebaseAuth.instance.currentUser;
  bool uploading = false;
  String _selectedCategory = "Household";
  final List<String> _categoryList = [
    "Household",
    "Electronics",
    "Clothing",
    "Books",
    "Sports",
    "Other"
  ];

  List<File> _imageFiles = [];

  Future<void> _pickImages() async {
    try {
      List<Asset> images = await MultipleImagesPicker.pickImages(
        maxImages: 4,
        enableCamera: true,
        selectedAssets: [],
        materialOptions: const MaterialOptions(
          actionBarColor: "#FF4081",
          actionBarTitle: "Select Images",
          allViewTitle: "All Photos",
          useDetailsView: false,
          selectCircleStrokeColor: "#000000",
        ),
      );
      if (images.isNotEmpty) {
        List<File> files = [];
        for (Asset image in images) {
          final data = await image.getByteData();
          final file =
              File('${(await getTemporaryDirectory()).path}/${image.name}');
          await file.writeAsBytes(data.buffer.asUint8List());
          files.add(file);
        }
        setState(() {
          _imageFiles = files;
        });
      }
    } catch (e) {
      print(e);
    }
  }

  Future<List<String>> uploadFiles(List<File> files) async {
    List<Future<String>> futures = [];
    for (File file in files) {
      Reference storageRef = FirebaseStorage.instance
          .ref()
          .child(user!.uid)
          .child(file.path.split('/').last);

      UploadTask uploadTask = storageRef.putFile(file);
      futures.add(uploadTask
          .whenComplete(() => print('Uploaded ${file.path.split('/').last}'))
          .then((_) => storageRef.getDownloadURL()));
    }
    List<String> urls = await Future.wait(futures);
    return urls;
  }

  Future<void> uploadPostData(BuildContext context) async {
    if (formkey.currentState!.validate()) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      );
      try {
        List<String> urlList = await uploadFiles(_imageFiles);
        WriteBatch batch = FirebaseFirestore.instance.batch();
        DocumentReference postRef =
            usercollection.doc(user!.uid).collection("Posts").doc();
        batch.set(postRef, {
          "title": titlecontroller.text,
          "description": descriptioncontroller.text,
          "price": pricecontroller.text,
          "category": _selectedCategory,
          "timestamp": DateTime.now(),
          "urlList": urlList,
        });
        await batch.commit();
        Navigator.pop(context);
        Get.snackbar("Done", "Post Uploaded Successfully",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.green,
            colorText: Colors.white,
            duration: const Duration(seconds: 3));
        cleareverything();
      } catch (e) {
        Navigator.pop(context);
        Get.snackbar("Error", "Something went wrong,try again later",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            colorText: Colors.white,
            duration: const Duration(seconds: 3));
      }
    }
  }

  void cleareverything() {
    setState(() {
      titlecontroller.clear();
      descriptioncontroller.clear();
      pricecontroller.clear();
      categorycontroller.clear();
      _imageFiles = [];
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colorconstant.backgroundblack,
      body: SingleChildScrollView(
        child: SafeArea(
            child: Column(
          children: [
            const post_head(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: Form(
                  key: formkey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Title",
                              style: TextStyle(color: Colors.white)),
                          const SizedBox(height: 7),
                          TextFormField(
                            controller: titlecontroller,
                            style: const TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                                hintText: "Steel Water Bottle",
                                fillColor: Colorconstant.highgrey,
                                filled: true,
                                hintStyle: TextStyle(
                                    color: Colorconstant.hintfontcolorhigh),
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 8.0, horizontal: 16.0),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide:
                                        const BorderSide(color: Colors.white)),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide:
                                        const BorderSide(color: Colors.white))),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Please enter a title";
                              }
                              return null;
                            },
                          )
                        ],
                      ),
                      const SizedBox(height: 15),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Category*",
                              style: TextStyle(color: Colors.white)),
                          const SizedBox(height: 7),
                          Container(
                            decoration: BoxDecoration(
                                color: Colorconstant.highgrey,
                                borderRadius: BorderRadius.circular(10)),
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                isExpanded: true,
                                hint: const Text('Please choose a location'),
                                value: _selectedCategory,
                                style: TextStyle(
                                    color: Colorconstant.hintfontcolorhigh,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                                dropdownColor: Colorconstant.highgrey,
                                items: _categoryList.map((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                                onChanged: (val) {
                                  setState(() {
                                    _selectedCategory = val!;
                                  });
                                },
                              ),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 15),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Description",
                              style: TextStyle(color: Colors.white)),
                          const SizedBox(height: 7),
                          TextFormField(
                            controller: descriptioncontroller,
                            style: const TextStyle(color: Colors.white),
                            minLines: 4,
                            maxLines: 45,
                            decoration: InputDecoration(
                                hintText:
                                    """Describe the condition of the item and terms of \nbuying... \n"slightly used, almost new" \n"pickup on weekends only"   """,
                                fillColor: Colorconstant.highgrey,
                                filled: true,
                                hintStyle: TextStyle(
                                    color: Colorconstant.hintfontcolorhigh),
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 8.0, horizontal: 16.0),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide:
                                        const BorderSide(color: Colors.white)),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide:
                                        const BorderSide(color: Colors.white))),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Please enter a description";
                              }
                              return null;
                            },
                          )
                        ],
                      ),
                      const SizedBox(height: 15),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Price*",
                              style: TextStyle(color: Colors.white)),
                          const SizedBox(height: 7),
                          TextFormField(
                            controller: pricecontroller,
                            keyboardType: TextInputType.number,
                            style: const TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                                hintText: "\$70",
                                fillColor: Colorconstant.highgrey,
                                filled: true,
                                hintStyle: const TextStyle(color: Colors.white),
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 8.0, horizontal: 16.0),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide:
                                        const BorderSide(color: Colors.white)),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide:
                                        const BorderSide(color: Colors.white))),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Please enter a price";
                              }
                              return null;
                            },
                          )
                        ],
                      ),
                      const SizedBox(height: 15),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Photos",
                              style: TextStyle(color: Colors.white)),
                          const SizedBox(height: 10),
                          _imageFiles.isEmpty
                              ? const Placeholder(
                                  fallbackHeight: 60,
                                  fallbackWidth: 100,
                                )
                              : Wrap(
                                  spacing: 8.0,
                                  runSpacing: 5.0,
                                  children: List.generate(
                                    _imageFiles.length,
                                    (index) => Stack(
                                      children: [
                                        Image.file(
                                          _imageFiles[index],
                                          width: 100,
                                          height: 100,
                                          fit: BoxFit.cover,
                                        ),
                                        Positioned(
                                          top: -3,
                                          right: 0,
                                          child: GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                _imageFiles.removeAt(index);
                                              });
                                            },
                                            child: Container(
                                              width: 24,
                                              height: 24,
                                              decoration: BoxDecoration(
                                                color: Colorconstant.highgrey,
                                                borderRadius:
                                                    BorderRadius.circular(6),
                                              ),
                                              child: const Icon(
                                                Icons.close,
                                                color: Colors.white,
                                                size: 20,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),

                          const SizedBox(height: 10),
                          InkWell(
                            onTap: () async {
                              await _pickImages();
                            },
                            child: Container(
                              height: 50,
                              width: 350,
                              decoration: BoxDecoration(
                                  color: Colorconstant.highgrey,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(10))),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Icon(Icons.add_box, color: Colors.white),
                                  SizedBox(width: 5),
                                  Text("Add Photo",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold)),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),
                      Container(
                        height: 80,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colorconstant.highgrey,
                          // borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          children: [
                            Center(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  width: 150,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: TextButton(
                                    onPressed: () {
                                      cleareverything();
                                    },
                                    child: Text(
                                      "Discard",
                                      style: TextStyle(
                                          color: Colorconstant.tomatored,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Center(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  width: 150,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    color: Colorconstant.tomatored,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: TextButton(
                                    onPressed: () async {
                                      await uploadPostData(context);
                                    },
                                    child: const Text(
                                      "Create Post",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  )),
            )
          ],
        )),
      ),
    );
  }
}

class post_head extends StatelessWidget {
  const post_head({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
      child: Row(
        children: [
          Image.asset("assets/postheadicon.png", height: 40, width: 40),
          Column(
            children: const [
              Text("Sell an Item",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold)),
              SizedBox(height: 4),
              Text("Herald Towers",
                  style: TextStyle(color: Colors.white, fontSize: 12)),
            ],
          ),
        ],
      ),
    );
  }
}
