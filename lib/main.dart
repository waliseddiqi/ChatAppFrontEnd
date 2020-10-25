import 'package:chat_app/UI/offline_page.dart';
import 'package:chat_app/core/connectivity_model.dart';
import 'package:chat_app/core/locator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'UI/Signin.dart';
import 'core/enums.dart';

void main() {
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider(
      create: (context) => ConnectivityService().connectionStatusController.stream,
          child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(

          primarySwatch: Colors.blue,
   
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);


  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>  with WidgetsBindingObserver {

@override
  void initState() {
   WidgetsBinding.instance.addObserver(this);
    super.initState();
  }
  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
var connectionStatus = Provider.of<ConnectivityStatus>(context);
   if(connectionStatus==ConnectivityStatus.Offline){
     return OfflinePage();
   }
    return Scaffold(
      
   
      body: 
      Signin()
 
    );
  }
}
