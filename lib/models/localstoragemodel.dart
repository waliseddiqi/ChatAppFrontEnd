import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Localstoragemodel extends ChangeNotifier{
String userid;
String username;


Future setlocals()async{
  SharedPreferences prefs=await SharedPreferences.getInstance();
userid= prefs.getString("userid");
username=prefs.getString("username");
notifyListeners();
}



}