import 'dart:io';
import 'package:chat_app/UI/offline_page.dart';
import 'package:chat_app/UI/signin_orsignup.dart';
import 'package:chat_app/UI/signin_page.dart';
import 'package:chat_app/delay_page.dart';
import 'package:chat_app/hive/chat_model.dart';
import 'package:chat_app/models/authmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'UI/email_confirmation.dart';
import 'UI/email_verification.dart';
import 'UI/user_signup_page.dart';
import 'core/connectivity_model.dart';
import 'core/enums.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

void main() {
 
 
  runApp(MyApp());
  inithive();
}

void inithive()async{
   var path=await path_provider.getApplicationDocumentsDirectory();
  Hive..init(path.path)..registerAdapter(ChatModelHiveAdapter());
   await Hive.openBox('testBox');
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
          StreamProvider<ConnectivityStatus>(create: (context) => ConnectivityService().connectionStatusController.stream),
          ChangeNotifierProvider<AuthModel>(create: (context) => AuthModel()),
        ],
          child: MaterialApp(
            routes: {
               '/emailConfirmation': (context) => EmailConfirmation(),
            },
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



PageController pageController= new PageController();
bool _isdelayfinised=false;
void delaypageduration(){
  new Future.delayed(const Duration(seconds: 2), () {
  setState(() {
  _isdelayfinised=true;
  });
 
});
}
/*void deleteprofes()async{
  SharedPreferences prefs=await SharedPreferences.getInstance();
  prefs.clear();
}*/

@override
  void initState() {
    // TODO: implement initState
    delaypageduration();
    super.initState();
    
    
  }
  
  @override
  Widget build(BuildContext context) {
     Size size=MediaQuery.of(context).size;
     var connectionStatus = Provider.of<ConnectivityStatus>(context);
     var authstatus=Provider.of<AuthModel>(context);
     authstatus.checkAuth();
   return connectionStatus == ConnectivityStatus.Offline?OfflinePage():
     Scaffold(
     
      body:
      Container(
        width: size.width,
            height: size.height,
        child: AnimatedCrossFade(
          crossFadeState:!_isdelayfinised?CrossFadeState.showFirst:CrossFadeState.showSecond,
          duration: Duration(milliseconds: 700),
          firstChild: DelayPage(),
          secondChild:  Container(
            width: size.width,
            height: size.height,
            child:   
            authstatus.auth==Auth.Authicated?Container(color: Colors.red,):
               SignIn(pageController: pageController,mainContext: context,),
          ) ,
        ),
      )
    
    
 
    );
  }
}
