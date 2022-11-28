import 'package:flutter/material.dart';
import 'package:flutter_project_week8/db/provider/play_listsong.dart';
import 'package:flutter_project_week8/properites/settings/widgets/share_this_app.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class ScreenSetting extends StatelessWidget {
  const ScreenSetting({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          "Settings",
          style: TextStyle(color: Colors.white, fontSize: 25),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const Icon(
            Icons.settings,
            color: Colors.white,
            size: 200,
          ),
          const Text(
            "Version:1.0.0",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(25),
            child: Column(
              children: [
                ListTile(
                  onTap: () {
                    emails();
                  },
                  leading: const Icon(
                    Icons.mail,
                    color: Colors.white,
                    size: 25,
                  ),
                  title: const Text(
                    "Contact Us",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                ListTile(
                  onTap: () {
                    emails();
                  },
                  leading: const Icon(
                    Icons.message,
                    color: Colors.white,
                    size: 25,
                  ),
                  title: const Text(
                    "Feedback",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                ListTile(
                  onTap: () {
                    sharethisApp(context);
                  },
                  leading: const Icon(
                    Icons.share,
                    color: Colors.white,
                    size: 25,
                  ),
                  title: const Text(
                    "Share this App",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                ListTile(
                  // onTap: () {},
                  leading: const Icon(
                    Icons.lock,
                    color: Colors.white,
                    size: 25,
                  ),
                  title: const Text(
                    "Privacy Policy",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                ListTile(
                  leading: const Icon(
                    Icons.star_outline,
                    color: Colors.white,
                    size: 25,
                  ),
                  title: const Text(
                    "Rate the App",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                ListTile(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text("Reset App"),
                          content: const Text(
                              "Are you sure you want to reset the app?"),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text("Cancel"),
                            ),
                            TextButton(
                              onPressed: () {
                                Provider.of<PlayListDb>(context, listen: false)
                                    .appReset(context); 
                              },
                              child: const Text("Reset"),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  leading: const Icon(
                    Icons.restore,
                    color: Colors.white,
                    size: 25,
                  ),
                  title: const Text(
                    "Reset App",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                ListTile(
                  leading: Icon(
                    Icons.info,
                    color: Colors.white,
                    size: 25,
                  ),
                  title: Text(
                    "About Developer",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> emails() async {
    // ignore: deprecated_member_use
    if (await launch('mailto:ajmalvaliyapeediyekkal4004@gmail.com')) {
    } else {
      throw "Try Again";
    }
  }

  Future<void> privacyPolicy() async {
    // ignore: deprecated_member_use
    if (await launch('mailto:ajmalvaliyapeediyekkal4004@gmail.com')) {
    } else {
      throw "Try Again";
    }
  }

  Future<void> ratetheApp() async {
    final url = 'mailto:ajmalvaliyapeediyekkal4004@gmail.com';

    // ignore: deprecated_member_use
    if (await launch(url)) {
    } else {
      throw "Try Again";
    }
  }

  Future<void> aboutDeveloper() async {
    final url = 'mailto:ajmalvaliyapeediyekkal4004@gmail.com';
    // ignore: deprecated_member_use
    if (await launch(url)) {
    } else {
      throw "Try Again";
    }
  }
}
