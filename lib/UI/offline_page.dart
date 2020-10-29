import 'package:flutter/material.dart';

class OfflinePage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Text(
          "Please Check your Internet Connection",textAlign: TextAlign.center
          ,style: TextStyle(fontSize: 35,color: Colors.white,fontWeight: FontWeight.w700,),
        ),
      ),
    );
  }
}