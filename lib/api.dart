import 'dart:convert';

import 'package:chat_app/constants.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';


class API{


final Map<String,String> headers = {'Accept': 'application/json',"Content-type": "application/json"};


Future<http.Response> disconnectUser (String username,id)async{
  var url = devurl+'/user/disconnect';
  var body={"username":username,"id":id};
    Map<String,String> headers = {'Accept': 'application/json',"Content-type": "application/json"};
return await http.post(Uri.encodeFull(url),body: jsonEncode(body),headers: headers);
}

Future<http.Response> getUsers ()async{
  var url =devurl+'/user/getUsers';
  
    Map<String,String> headers = {'Accept': 'application/json',"Content-type": "application/json"};
return await http.get(Uri.encodeFull(url),headers: headers);
}



Future<http.Response> verifyEmail(String code,String email)async{
  var url=devurl+"/verifyEmail/";
  Map<String,String> headers = {'Accept': 'application/json',"Content-type": "application/json"};
  var body={"email":email,"code":code};
  return await http.post(Uri.encodeFull(url),body: jsonEncode(body),headers: headers);

}


Future<http.Response> sendEmail(String email)async{
  var url=devurl+"/sendEmail/";
  Map<String,String> headers = {'Accept': 'application/json',"Content-type": "application/json"};
  var body={"email":email};
  return await http.post(Uri.encodeFull(url),body: jsonEncode(body),headers: headers);

}

Future<http.Response> signIn(String email,String password)async{
  var url=devurl+"/userauth/signin/";
  Map<String,String> headers = {'Accept': 'application/json',"Content-type": "application/json"};
  var body={"email":email,"password":password};
  return await http.post(Uri.encodeFull(url),body: jsonEncode(body),headers: headers);  

}

Future<http.Response> signUp(String email,String password,String username)async{
  var url=devurl+"/userauth/signup/";
  var body={"email":email,"password":password,"username":username};
  return await http.post(Uri.encodeFull(url),body: jsonEncode(body),headers: headers);

}
Future<http.Response> checkauth()async{
  var url=devurl+"/userauth/checkauth";
  SharedPreferences prefs=await SharedPreferences.getInstance();
  String token= prefs.getString("token");
  var body={"token":token};
  return await http.post(Uri.encodeFull(url),body: jsonEncode(body),headers: headers);

}





}