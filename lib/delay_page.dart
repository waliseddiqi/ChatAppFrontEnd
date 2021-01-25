import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DelayPage extends StatelessWidget{



  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    return  Scaffold(
          body: Center(
              child: Container(
              height: size.height/2,
              width: size.width/1.5,
              decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage("./assets/logo.jpeg"),fit: BoxFit.contain)
              ),
        ),
            
      ),
    );
  }
}