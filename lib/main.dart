import 'dart:io';
import 'package:chat_app/UI/chat_main.dart';
import 'package:chat_app/UI/offline_page.dart';
import 'package:chat_app/UI/signin_orsignup.dart';
import 'package:chat_app/UI/signin_page.dart';
import 'package:chat_app/constants.dart';
import 'package:chat_app/delay_page.dart';
//import 'package:chat_app/hive/chat_model.dart';
import 'package:chat_app/models/authmodel.dart';
import 'package:chat_app/models/current_state.dart';
import 'package:chat_app/models/local_chat.dart';
import 'package:chat_app/models/local_message.dart';
import 'package:chat_app/models/local_messages.dart';
import 'package:chat_app/models/local_users.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:onesignal/onesignal.dart';
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

 // setUpLocator();
  runApp(MyApp());

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

bool checked=false;

PageController pageController= new PageController();
bool _isdelayfinised=false;
void delaypageduration(){
  new Future.delayed(const Duration(seconds: 2), () {
  setState(() {
  _isdelayfinised=true;
  });
 
});
}

  Future<String> getPlayerId() async {
    var status = await OneSignal.shared.getPermissionSubscriptionState();
    var playerId = status.subscriptionStatus.userId;
    //print ("initUniqueIdentifierState >> playerId " + playerId );
    return playerId;
  } 



void initSignal()async{
  SharedPreferences prefs=await SharedPreferences.getInstance();
  OneSignal.shared.init("6e2a85ef-dee5-42f4-945d-46e4e4c72463");
OneSignal.shared.setNotificationOpenedHandler((OSNotificationOpenedResult result) {
  // will be called whenever a notification is opened/button pressed.
});

getPlayerId().then((value){
prefs.setString("notificationId", value);
print(value);
});
}

void checkAuth()async{
SharedPreferences prefs=await SharedPreferences.getInstance();
prefs.clear();
}

bool isboxOpen=false;
void inithive()async{
   var path=await path_provider.getApplicationDocumentsDirectory();
  Hive..init(path.path)..registerAdapter(LocalChatAdapter());
  Hive..init(path.path)..registerAdapter(LocalMessageAdapter());
  Hive..init(path.path)..registerAdapter(LocalMessagesAdapter());

   await Hive.openBox(chat_Box);
   await Hive.openBox(messages_Box);
   setState(() {
     isboxOpen=true;
   });
}

@override
  void initState() {
   // checkAuth();
   inithive();
    delaypageduration();
    super.initState();
    initSignal();
   /// initgetit();
  }
//localUserStorage
 /* void saveNotificationId(String notificationId){
    LocalUsers localUsers=new LocalUsers();
    localUsers.notificationId=notificationId;
    localUsers.userId="";
    localUsers.userName="";
    var box =  Hive.box(localUserStorage);
    box.put("user",localUsers);
  }*/

  @override
  Widget build(BuildContext context) {
     Size size=MediaQuery.of(context).size;
     var connectionStatus = Provider.of<ConnectivityStatus>(context);
      var authstatus=Provider.of<AuthModel>(context);
     if(!checked){
     
     authstatus.checkAuth();
     checked=true;
     }
      
   return connectionStatus == ConnectivityStatus.Offline?OfflinePage():
   !isboxOpen?DelayPage():  Scaffold(
     
      body:
      Container(
        width: size.width,
        height: size.height,
        child: 
          Container(
            width: size.width,
            height: size.height,
            child:   
            authstatus.auth==Auth.Authicated?ChatMain():
               SignIn(pageController: pageController,mainContext: context,),
          ) ,
        ),
      
    
    
 
    );
  }
}
