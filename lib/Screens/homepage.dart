import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goose/Utils/Colorconstant.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  CollectionReference usercollection =
      FirebaseFirestore.instance.collection('UserFiles');
  User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colorconstant.backgroundblack,
        appBar: AppBar(
          backgroundColor: Colorconstant.highgrey,
          title: const Text("Welcome to goose!!!"),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.search),
            ),
            IconButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
                Get.offAllNamed("/loginpage");
              },
              icon: const Icon(Icons.logout),
            ),
          ],
        ),
        body: StreamBuilder(
          stream: usercollection
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .collection("Posts")
              .snapshots(),
          builder: (context, snapshot) {
            // print(snapshot.data!.docs.length);
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return const Center(child: Text("Error"));
            } else if (snapshot.data == null || snapshot.data!.docs.isEmpty) {
              return Center(
                  child: Text("No data Available \nFirstly upload a post...",
                      style: TextStyle(
                          color: Colorconstant.tomatored, fontSize: 20)));
            } else {
              return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (BuildContext context, int index) {
                    String imgurl = snapshot.data!.docs[index]["urlList"][0];
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                        tileColor: Colorconstant.highgrey,
                        leading: Image.network(
                          imgurl,
                          height: 100,
                          width: 100,
                          fit: BoxFit.cover,
                        ),
                        title: Text(snapshot.data!.docs[index]["title"],
                            style: TextStyle(color: Colorconstant.tomatored)),
                        subtitle: Text(
                            snapshot.data!.docs[index]["description"],
                            style: const TextStyle(color: Colors.white)),
                      ),
                    );
                    return null;
                  });
            }
          },
        ));
  }
}
