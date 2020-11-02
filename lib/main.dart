import 'package:chat_app/UI/offline_page.dart';
import 'package:chat_app/UI/signin_orsignup.dart';
import 'package:chat_app/UI/signin_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


import 'UI/email_confirmation.dart';
import 'UI/email_verification.dart';
import 'UI/user_signup_page.dart';
import 'core/connectivity_model.dart';
import 'core/enums.dart';

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


  @override
  Widget build(BuildContext context) {
     var connectionStatus = Provider.of<ConnectivityStatus>(context);
   return connectionStatus == ConnectivityStatus.Offline?OfflinePage():
     Scaffold(
     
      body:PageView(
        controller: pageController,
        physics: NeverScrollableScrollPhysics(),
        children: [
          SigninOrSignup(pageController: pageController,),
           SignIn(pageController: pageController,),
           MailVerfication(pageController: pageController,),
           EmailConfirmation(pageController: pageController,),
           UserSignUpPage()
        ],
      )
 
    );
  }
}
