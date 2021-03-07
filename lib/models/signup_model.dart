import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../api.dart';

class SignUpModel extends ChangeNotifier{

  API api=new API();

  String name = "";
  String age = "";
  File file;
  String notificationId = "";
  String email = "";
  String password = "";

  Future validateAndSubmit() async {

   
        /* socketConnect=new SocketConnect();
         user.gender=_gender;
   
         print(user.gender);
      socketConnect.emitUserSignup(user.name,user.age);*/
        
        SharedPreferences prefs=await SharedPreferences.getInstance();
        String notificationid=prefs.getString("notificationId");
        print(notificationid);
        if(file!=null){
          api.signupUser(name, age,file,notificationid).then((value)async{
            if(value.statusCode==200){
              var parsed=json.decode(value.body);
            
              print(parsed);
              prefs.setString("username", parsed["username"]);
              prefs.setString("userid", parsed["userid"]);
              _authSignUp(email,password,name,parsed["userid"],notificationId).then((value) => {

            }).catchError((onError)=>{
              
            });
            }
            else{
            
            print("couldnt create user");
            
            }
      });}
      else{
          SharedPreferences prefs=await SharedPreferences.getInstance();
          String notificationid=prefs.getString("notificationId");
          print(notificationid);
          api.signupUserwithOutImage(name, age,notificationid).then((value)async{
            if(value.statusCode==200){
            var parsed=json.decode(value.body);
       
            print(parsed);
            prefs.setString("username", parsed["username"]);
            prefs.setString("userid", parsed["userid"]);
          //auth signup
          //after general signup datas saved put userid in personal infos in database
            await _authSignUp(email,password,name,parsed["userid"],notificationId).then((value) => {

            }).catchError((onError)=>{

            });
            }else{
       
            print("couldnt create user");
            }
      });

      }
     
      }


      Future _authSignUp(String email,String password,String username,String userid,String notificationid){
              //auth signup
          //after general signup datas saved put userid in personal infos in database
              api.signUp(email, password,username,userid,notificationid).then((value)async{
              var parsed=json.decode(value.body);
              print(parsed);
              SharedPreferences prefs=await SharedPreferences.getInstance();
              prefs.setString("token", parsed["token"]);
       
       // print(parsed["token"]);
          });
      }
      
      










}