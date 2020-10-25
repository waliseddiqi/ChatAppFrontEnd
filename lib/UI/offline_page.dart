import 'package:flutter/material.dart';


class OfflinePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    return Scaffold(
        body: Container(
            height: double.infinity,
            width: double.infinity,
            decoration: new BoxDecoration(
               color: Color(0xff1a1a1a)
            ),
            child: Stack(
              children: <Widget>[
                
                Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          width: size.width/1.5,
                          height: size.height/3,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage("assets/nointernet.gif"),
                            fit: BoxFit.fill
                            )
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "No Internet Connection",
                            style: TextStyle(color: Colors.white70, fontWeight: FontWeight.w600, fontSize: 24),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 48.0),
                          child: Text(
                            "Please check your internet connect",
                            style: TextStyle(color: Colors.white70, fontWeight: FontWeight.w600, fontSize: 24),
                            textAlign: TextAlign.center,
                          ),
                        )
                      ],
                    )
                ),
              ],
            )
        )
    );
  }
}
