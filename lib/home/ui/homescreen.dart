import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:sqflite_course/sqldb.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  Sqldb sqldb=Sqldb();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            MaterialButton( 
              color: Colors.red,
              textColor: Colors.white,           
              onPressed: ()async{
                int response=await sqldb.insertData("INSERT INTO 'notes' ('note') VALUES ('note one')");
                log("Response of insert data : ${response.toString()}");
              },
              child: Text("Insert Data"),
            
            ),
        
            MaterialButton( 
              color: Colors.red,
              textColor: Colors.white,           
              onPressed: ()async{
                List<Map> response=await sqldb.readData("SELECT * FROM 'notes' ");
                log(response.toString());
              },
              child: Text("Read Data"),
            
            ),

             MaterialButton( 
              color: Colors.red,
              textColor: Colors.white,           
              onPressed: ()async{
                int response=await sqldb.deleteData("DELETE FROM 'notes' Where id=1 ");
                log(response.toString());
              },
              child: Text("Delete Data"),
            
            ),

            MaterialButton( 
              color: Colors.red,
              textColor: Colors.white,           
              onPressed: ()async{
                int response=await sqldb.updateData("UPDATE 'notes' SET 'note'='note four' WHERE id =4");
                log(response.toString());
              },
              child: Text("Update Data"),
            
            ),
          ],
        ),
      ),
    );
  }
}