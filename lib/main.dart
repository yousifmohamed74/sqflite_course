import 'package:flutter/material.dart';
import 'package:sqflite_course/home/ui/homescreen.dart';


void main() async{
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {    
    return MaterialApp(    
      debugShowCheckedModeBanner: false,  
      theme: ThemeData(        
        colorScheme: .fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const Homescreen(),
    );
  }
}
