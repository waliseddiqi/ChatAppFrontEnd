import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'UI/Signin.dart';
import 'UI/email_verification.dart';
import 'core/connectivity_model.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider(
      create: (context) => ConnectivityService().connectionStatusController.stream,
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
        title: 'Flutter App',
        theme: ThemeData(

        primarySwatch: Colors.blue,
   
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    ));
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);


  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {



  @override
  Widget build(BuildContext context) {

    return Scaffold(
     
      body: MailVerfication()
 
    );
  }
}
