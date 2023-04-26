import 'dart:async';
import 'package:flutter/material.dart';
import 'package:pr_gallary_app/views/screens/tabpage.dart';

class Splash_screen extends StatefulWidget {
  const Splash_screen({Key? key}) : super(key: key);

  @override
  State<Splash_screen> createState() => _Splash_screenState();
}

class _Splash_screenState extends State<Splash_screen> {



  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 8),
            ()=>Navigator.pushReplacement(context,
            MaterialPageRoute(builder:
                (context) => TabPage()
            )
        )
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        color: Colors.black,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              alignment: Alignment.center,
              height: 80,
              width: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: Colors.white,width: 2),
                color: Colors.blue[900],
                image: DecorationImage(image: AssetImage("assets/images/logo.jpeg",)),
              ),),
          ],
        ),
      ),
    );
  }
}