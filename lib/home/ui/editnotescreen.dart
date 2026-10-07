import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:sqflite_course/home/ui/homescreen.dart';
import 'package:sqflite_course/sqldb.dart';

class Editnotescreen extends StatefulWidget {
  final id;
  final note;
  final title;
  const Editnotescreen({super.key,required this.id,required this.note,required this.title});

  @override
  State<Editnotescreen> createState() => _EditnotescreenState();
}

class _EditnotescreenState extends State<Editnotescreen> {
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

  Future<int> saveEditedNote() async{
    
    if (formKey.currentState!.validate()) {
      String title = titleController.text;
      String note = noteController.text;
      int response=await sqldb.updateData(
       """
        UPDATE notes SET 
        note ="${noteController.text}", 
        title="${titleController.text}"
        WHERE id=${widget.id}
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
  void initState() {
    titleController.text=widget.title;
    noteController.text=widget.note;
    super.initState();
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
          title: Text("Edit Note"),
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
                    onPressed:() => saveEditedNote(),
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