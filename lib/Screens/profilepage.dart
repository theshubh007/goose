import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goose/Utils/Colorconstant.dart';

class Profilepage extends StatefulWidget {
  const Profilepage({super.key});

  @override
  State<Profilepage> createState() => _ProfilepageState();
}

class _ProfilepageState extends State<Profilepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colorconstant.backgroundblack,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  const Topbar(),
                  const SizedBox(
                    height: 20,
                  ),
                  const profileimage_widget(),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Next_slide(Icons.person, Colorconstant.mehndigreen,
                        Colorconstant.parrotgreen, "Personal Information"),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Switch_slide(
                        Icons.notifications,
                        Colorconstant.shadyyellow,
                        Colorconstant.yellow,
                        "Push Notifications",
                        "Receive alerts for bid activity"),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Switch_slide(
                        Icons.email,
                        Colorconstant.shadyblue,
                        Colorconstant.blue,
                        "Subscribe to Emails",
                        "Receive marketing emails"),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Next_slide(Icons.info, Colorconstant.shadybrown,
                        Colorconstant.brown, "Language"),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Next_slide(
                        Icons.verified_user,
                        Colorconstant.mehndigreen,
                        Colorconstant.parrotgreen,
                        "Change Password"),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Next_slide(Icons.logout, Colorconstant.shadyred,
                        Colorconstant.tomatored, "Logout"),
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  Row Switch_slide(IconData icon, Color bgcolor, Color iconcolor, String text1,
      String text2) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            CircleAvatar(
              backgroundColor: bgcolor,
              child: Icon(
                icon,
                color: iconcolor,
                size: 25,
              ),
            ),
            const SizedBox(
              width: 35,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(text1,
                    style: const TextStyle(color: Colors.white, fontSize: 20)),
                const SizedBox(
                  height: 5,
                ),
                Text(text2,
                    style: const TextStyle(color: Colors.white, fontSize: 12)),
              ],
            ),
          ],
        ),
        Switch(
          value: true,
          onChanged: (value) {},
          activeColor: Colorconstant.tomatored,
        ),
      ],
    );
  }

  Row Next_slide(IconData icon, Color bgcolor, Color iconcolor, String text) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            CircleAvatar(
              backgroundColor: bgcolor,
              child: Icon(
                icon,
                color: iconcolor,
                size: 25,
              ),
            ),
            const SizedBox(
              width: 35,
            ),
            Text(text,
                // textAlign: TextAlign.left,
                style: const TextStyle(color: Colors.white, fontSize: 20)),
          ],
        ),
        const Icon(Icons.navigate_next, color: Colors.white, size: 28.0),
      ],
    );
  }
}

class profileimage_widget extends StatelessWidget {
  const profileimage_widget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      const CircleAvatar(
        radius: 50,
        backgroundImage: AssetImage("assets/strw.png"),
      ),
      Positioned(
        bottom: 0,
        right: 0,
        child: CircleAvatar(
          radius: 15,
          backgroundColor: Colorconstant.tomatored,
          child: const Icon(
            Icons.edit,
            color: Colors.white,
          ),
        ),
      ),
    ]);
  }
}

class Topbar extends StatelessWidget {
  const Topbar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            )),
        const Text(
          "Profile Settings",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
      ],
    );
  }
}
