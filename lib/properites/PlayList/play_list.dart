import 'package:flutter/material.dart';
import 'package:flutter_project_week8/db/provider/play_listsong.dart';
import 'package:flutter_project_week8/main.dart';
import 'package:flutter_project_week8/properites/PlayList/play_list_detailspage.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../../Models/play_list_model.dart';

class PlayListWidget extends StatelessWidget {
  PlayListWidget({super.key});
  final nameController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<PlayListDb>(context, listen: false).getAllPlayList();
    });
    return Consumer<PlayListDb>(builder: (context, newValue, _) {
      return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: const Text(
            "PLAYLISTS",
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SafeArea(
            child: Hive.box<PlayListerModel>(PLAYLIST_DB_NAME).isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Lottie.asset("assets/play_List.json"),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          "Add Your PlayList",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        )
                      ],
                    ),
                  )
                : GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 4,
                            mainAxisSpacing: 5),
                    itemCount: newValue.playListNotifier.length,
                    itemBuilder: (context, index) {
                      final data = newValue.playListNotifier.toList()[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) {
                              return PlayListDetailsWidget(
                                  playList: data, folderIndex: index);
                            }),
                          );
                        },
                        child: SizedBox(
                            child: Card(
                          color: Colors.transparent,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Expanded(
                                child: Lottie.asset(
                                  "assets/play_List.json",
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                  left: 8,
                                  right: 8,
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: 4,
                                      child: SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              data.name,
                                              style: const TextStyle(
                                                color: Colors.white60,
                                                fontWeight: FontWeight.bold,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: IconButton(
                                        icon: const Icon(
                                          Icons.delete_outline,
                                          color: Colors.pink,
                                        ),
                                        onPressed: () {
                                          showDialog(
                                            context: context,
                                            builder: (context) {
                                              return AlertDialog(
                                                title: const Text(
                                                  "Delete PlayList",
                                                ),
                                                content: const Text(
                                                  "Are you sure you want to delete this playlist?",
                                                ),
                                                actions: <Widget>[
                                                  TextButton(
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    child: const Text("No"),
                                                  ),
                                                  TextButton(
                                                      onPressed: () {
                                                        newValue.playlistDelete(
                                                            index);
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                      child: const Text("Yes")),
                                                ],
                                              );
                                            },
                                          );
                                        },
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )),
                      );
                    },
                  ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          splashColor: Colors.red,
          onPressed: () async {
         await   showDialog(
              context: context,
              builder: (BuildContext context) {
                return Dialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      20.0,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height * 0.25,
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Center(
                            child: Text(
                              "Create Your PlayList",
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Form(
                            key: _formKey,
                            child: Center(
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width * 0.6,
                                child: TextFormField(
                                  controller: nameController,
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "PlayList Name",
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Please enter Playlist name";
                                    } else {
                                      return null;
                                    }
                                  },
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              SizedBox(
                                width: 100.0,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.red,
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text("Cancel"),
                                ),
                              ),
                              SizedBox(
                                width: 100.0,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.green,
                                  ),
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      whenButtonClicked(context);
                                      Navigator.of(context).pop();
                                    }
                                  },
                                  child: const Text(
                                    "Save",
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          },
          child: const Icon(Icons.add),
        ),
      );
    });
  }

  Future<void> whenButtonClicked(context) async {
    final name = nameController.text;
    if (name.isEmpty) {
      return;
    } else {
      final music = PlayListerModel(name: name, songIds: []);
      Provider.of<PlayListDb>(context, listen: false).playListAdd(music);
      nameController.clear();
    }
  }
}
