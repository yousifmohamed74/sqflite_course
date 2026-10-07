import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:sqflite_course/home/ui/addnotesscreen.dart';
import 'package:sqflite_course/home/ui/editnotescreen.dart';
import 'package:sqflite_course/sqldb.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  Sqldb sqldb=Sqldb();
  bool isloading=true;
  List allNotes=[];

  Future <List<Map>> readData()async{
    ////way 1
    List<Map> response =await sqldb.readData("SELECT * FROM notes");
    ////way 2
    //List<Map> response =await sqldb.read("notes");
    allNotes.addAll(response);
    isloading=false;
    if(mounted){
      setState(() {
        
      });
    }
    return response;
  }

  @override
  void initState() {
    readData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => Addnotesscreen(),));
      }, child: Icon(Icons.add),),

      appBar: AppBar(
        centerTitle: true,
        title: Text("Notes"),
        backgroundColor: Colors.blue,
      ),
      
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            // SizedBox(
            //   height: 50,
            //   width: double.infinity,
            //   child: MaterialButton(
            //     color: Colors.red,
            //     textColor: Colors.white,
            //     onPressed: () async {
            //       sqldb.deleteMyDataBase();

            //       log("Data Base Deleted");
            //     },
            //     child: const Text("Delete All Notes"),
            //   ),
            // ),

            const SizedBox(height: 10),

            Expanded(
              child: 
              isloading?
              Center(child: CircularProgressIndicator(),):
              
                 ListView.builder(
                    itemCount: allNotes.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: ListTile(
                          title: Text(
                            allNotes[index]["title"] ?? "No Title",
                            style: const TextStyle(
                              color: Colors.red,
                            ),
                          ),
                          subtitle: Text(
                            allNotes[index]["note"] ?? "No Note",
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(onPressed: ()async{
                                Navigator.push(context, MaterialPageRoute(builder: (context) => Editnotescreen(id: allNotes[index]['id'],note: allNotes[index]['note'],title: allNotes[index]['title'],),));
                              }
                              , icon: Icon(Icons.edit,color: Colors.blue,)),
                              IconButton(onPressed: ()async{
                                ////way 1
                                // int response=await sqldb.deleteData("DELETE FROM notes WHERE id=${allNotes[index]["id"]}");
                                ////way 2
                                int response=await sqldb.delete("notes","id=${allNotes[index]['id']}");
                                if(response>0){
                                  log("note deleted");
                                  setState(() {
                                    allNotes.removeWhere((element) => element['id']==allNotes[index]['id'],);
                                  });
                                }
                              }
                              , icon: Icon(Icons.delete,color: Colors.red,)),
                            ],
                          ),
                        ),
                      );
                    },
                 ),
                
              
            ),
          ],
        ),
      ),
    
    );
  }
}


/*
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
    
*/ 