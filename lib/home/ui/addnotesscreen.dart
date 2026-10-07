import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:sqflite_course/home/ui/homescreen.dart';
import 'package:sqflite_course/sqldb.dart';

class Addnotesscreen extends StatefulWidget {
  const Addnotesscreen({super.key});

  @override
  State<Addnotesscreen> createState() => _AddnotesscreenState();
}

class _AddnotesscreenState extends State<Addnotesscreen> {
  Sqldb sqldb=Sqldb();
  // Form key
  final formKey = GlobalKey<FormState>();

  // Controllers
  final titleController = TextEditingController();
  final noteController = TextEditingController();

  @override
  void dispose() {
    titleController.dispose();
    noteController.dispose();
    super.dispose();
  }

  Future<int> saveNote() async{
    
    if (formKey.currentState!.validate()) {
      String title = titleController.text;
      String note = noteController.text;
      int response=await sqldb.insertData(
       """
        INSERT INTO notes ('note','title') VALUES ('$note','$title')
       """
      );
      log(response.toString());
      if(response>0){
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => Homescreen(),),(route) => false,);
      }
      return response;
    }
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("ADD Notes"),
          backgroundColor: Colors.blue,
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Container(
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  // Title
                  TextFormField(
                    controller: titleController,
                    decoration: const InputDecoration(
                      labelText: 'Title',
                      hintText: 'Enter note title',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a title';
                      }
                      return null;
                    },
                  ),
          
                  const SizedBox(height: 20),
          
                  // Note
                  TextFormField(
                    controller: noteController,
                    maxLines: 5,
                    decoration: const InputDecoration(
                      labelText: 'Note',
                      hintText: 'Enter your note',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a note';
                      }
                      return null;
                    },
                  ),
          
                  const SizedBox(height: 20),
          
                  ElevatedButton(
                    onPressed:() => saveNote(),
                    child: const Text('Save Note'),
                  ),
                ],
              ),
            
            ),
          ),
        )
      ),
    );
  }
}