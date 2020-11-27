import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DelayPage extends StatelessWidget{



  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    return Scaffold(
          body: Container(
            height: size.height,
            width: size.width,
            child: Center(
              child: Container(
              height: size.height/4,
              width: size.width/3,
              color: Colors.red,
      ),
            ),
          ),
    );
  }
}