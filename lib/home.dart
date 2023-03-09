import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_php/crud.dart';
import 'package:flutter_php/edit.dart';
import 'package:flutter_php/linkapi.dart';
import 'package:flutter_php/main.dart';
import 'package:flutter_php/model.dart';

import 'cardcomponent.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with Crud {
  late NoteModel note;
  getNotes() async {
    var response = await postRequest(view, {"id": sharedPref.getString("id")});
    print(response);
    return response;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        actions: [
          IconButton(
              onPressed: () {
                sharedPref.clear();
                Navigator.of(context)
                    .pushNamedAndRemoveUntil("login", (route) => false);
              },
              icon: Icon(Icons.exit_to_app))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed("add");
        },
        child: Icon(Icons.add),
      ),
      body: Container(
        padding: EdgeInsets.all(8),
        child: ListView(children: [
          FutureBuilder(
              future: getNotes(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data!['status'] == "fail") {
                    return Text("failed");
                  }
                  return ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: snapshot.data['data'].length,
                      itemBuilder: (context, i) {
                        note = NoteModel.fromJson(snapshot.data['data'][i]);
                        return CardNotes(
                            image: "$linkImage/${note.noteImage}",
                            ontap: () async {
                              var res = await postRequest(delete, {
                                "noteid": snapshot.data['data'][i]["note_id"]
                                    .toString(),
                                "imagename": snapshot.data['data'][i]
                                        ["note_image"]
                                    .toString()
                              });
                              if (res['status'] == "success") {
                                Navigator.of(context)
                                    .pushReplacementNamed("home");
                              }
                            },
                            ontap2: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => EditNote(
                                        notes: {
                                          "id": snapshot.data['data'][i]
                                              ["note_id"],
                                          "title": snapshot.data['data'][i]
                                              ["note_title"],
                                          "content": snapshot.data["data"][i]
                                              ["note_content"],
                                          "image": snapshot.data["data"][i]
                                                  ["note_image"]
                                              .toString()
                                        },
                                      )));
                            },
                            title: "${note.noteId}",
                            content: "${note.noteContent}");
                      });
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: Text("Loading ...."),
                  );
                }
                return Container();
              })
        ]),
      ),
    );
  }
}
