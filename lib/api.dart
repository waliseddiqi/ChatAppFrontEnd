import 'dart:convert';
import 'dart:io';

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

Future<http.Response> signupUser(String username,String age,File file,String notifiactionid)async{
  var url =devurl+'/user/signupuser';
  var data=file.readAsBytesSync();
     String base64=base64Encode(data);
     String format=file.path.split("/").last.split(".").last;
  var body={"username":username,"age":age,"format":format,"image":base64,"notificationId":notifiactionid};
    Map<String,String> headers = {'Accept': 'application/json',"Content-type": "application/json"};
  return await http.post(Uri.encodeFull(url),body: jsonEncode(body),headers: headers);
}
Future<http.Response> signupUserwithOutImage(String username,String age,String notificationid)async{
  var url =devurl+'/user/signupuserWithOutImage';

  var body={"username":username,"age":age,"notificationId":notificationid};
    Map<String,String> headers = {'Accept': 'application/json',"Content-type": "application/json"};
  return await http.post(Uri.encodeFull(url),body: jsonEncode(body),headers: headers);
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


//updateProfilePhoto
Future<http.Response> updateProfilePhoto({String userid,File file})async{
  var url =devurl+'/user/updateProfilePhoto';
  var data=file.readAsBytesSync();
     String base64=base64Encode(data);
     String format=file.path.split("/").last.split(".").last;
  var body={"userid":userid,"format":format,"image":base64};
    Map<String,String> headers = {'Accept': 'application/json',"Content-type": "application/json"};
  return await http.post(Uri.encodeFull(url),body: jsonEncode(body),headers: headers);
}





Future<http.Response> signIn
(String email,String password)async{
  var url=devurl+"/userauth/signin/";
  Map<String,String> headers = {'Accept': 'application/json',"Content-type": "application/json"};
  var body={"email":email,"password":password};
  return await http.post(Uri.encodeFull(url),body: jsonEncode(body),headers: headers);  

}

Future<http.Response> signUp(String email,String password,String username,String userid,String notificationId)async{
  var url=devurl+"/userauth/signup/";
  var body={"email":email,"password":password,"username":username,"userid":userid,"notificationId":notificationId};
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