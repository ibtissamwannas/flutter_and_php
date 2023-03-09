import 'package:flutter/material.dart';

class NoteModel {
  String? noteId;
  String? noteTitle;
  String? noteContent;
  String? noteImage;
  String? notesUsers;

  NoteModel(
      {required this.noteId,
      required this.noteTitle,
      required this.noteContent,
      required this.noteImage,
      required this.notesUsers});

  NoteModel.fromJson(Map<String, dynamic> json) {
    noteId = json['note_id'];
    noteTitle = json['note_title'];
    noteContent = json['note_content'];
    noteImage = json['note_image'];
    notesUsers = json['notes_users'];
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['note_id'] = this.noteId;
  //   data['note_title'] = this.noteTitle;
  //   data['note_content'] = this.noteContent;
  //   data['note_image'] = this.noteImage;
  //   data['notes_users'] = this.notesUsers;
  //   return data;
  // }
}
