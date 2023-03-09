import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_php/crud.dart';
import 'package:flutter_php/linkapi.dart';
import 'package:flutter_php/main.dart';
import 'package:image_picker/image_picker.dart';

class AddNotes extends StatefulWidget {
  const AddNotes({super.key});

  @override
  State<AddNotes> createState() => _AddNotesState();
}

class _AddNotesState extends State<AddNotes> with Crud {
  File? myfile;
  final TextEditingController notetitle = TextEditingController();
  final TextEditingController noteContent = TextEditingController();
  GlobalKey<FormState> formstate = new GlobalKey<FormState>();

  AddNotes() async {
    if (myfile == null)
      Dialog(
        child: Text("kadjgfjhfhksdfhjs"),
      );
    if (formstate.currentState!.validate()) {
      var res = await postwithfile(
          add,
          {
            "title": notetitle.text,
            "content": noteContent.text,
            "userid": sharedPref.getString("id")
          },
          myfile!);
      print(res);
      if (res["status"] == "success") {
        Navigator.of(context).pushReplacementNamed("home");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add notes"),
      ),
      body: Container(
          padding: EdgeInsets.all(8),
          child: Form(
            key: formstate,
            child: ListView(
              children: [
                TextFormField(
                  controller: notetitle,
                  validator: (val) {
                    if (val!.length > 100) {
                      return "note title can't be larger than 100";
                    }
                    if (val.length < 2) {
                      return "note title can't be smaller than 2";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    hintText: "title",
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 1,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: noteContent,
                  validator: (val) {
                    if (val!.length > 100) {
                      return "note content can't be larger than 100";
                    }
                    if (val.length < 2) {
                      return "note content can't be smaller than 2";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    hintText: "content",
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 1,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                    onPressed: () async {
                      await AddNotes();
                    },
                    child: Text("add Note")),
                SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                    onPressed: () async {
                      showModalBottomSheet(
                          context: context,
                          builder: (context) => Container(
                                height: 100,
                                child: Column(
                                  children: [
                                    InkWell(
                                      onTap: () async {
                                        final XFile? xfile = await ImagePicker()
                                            .pickImage(
                                                source: ImageSource.gallery);
                                        myfile = File(xfile!.path);
                                        setState(() {});
                                      },
                                      child: Container(
                                        width: double.infinity,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child:
                                              Text("Upload image From Gallery"),
                                        ),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () async {
                                        final XFile? xfile = await ImagePicker()
                                            .pickImage(
                                                source: ImageSource.camera);
                                        myfile = File(xfile!.path);
                                        setState(() {});
                                        print(myfile);
                                      },
                                      child: Container(
                                        width: double.infinity,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child:
                                              Text("Upload image From Camera"),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ));
                    },
                    child: Text(
                      "upload Note image",
                      style: TextStyle(
                          color: myfile == null ? Colors.white : Colors.red),
                    ))
              ],
            ),
          )),
    );
  }
}
