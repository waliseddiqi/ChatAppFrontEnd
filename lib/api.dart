import 'dart:convert';

import 'package:http/http.dart' as http;


class API{

  
Future<http.Response> disconnectUser (String username,id)async{
  var url = 'http://192.168.137.1:5000/user/disconnect';
  var body={"username":username,"id":id};
    Map<String,String> headers = {'Accept': 'application/json',"Content-type": "application/json"};
return await http.post(Uri.encodeFull(url),body: jsonEncode(body),headers: headers);
}

Future<http.Response> getUsers ()async{
  var url = 'http://192.168.137.1:5000/user/getUsers';
  
    Map<String,String> headers = {'Accept': 'application/json',"Content-type": "application/json"};
return await http.get(Uri.encodeFull(url),headers: headers);
}



Future<http.Response> verifyEmail(String code,String email)async{
var url="http://192.168.137.1:5000/verifyEmail/";
Map<String,String> headers = {'Accept': 'application/json',"Content-type": "application/json"};
  var body={"email":email,"code":code};
return await http.post(Uri.encodeFull(url),body: jsonEncode(body),headers: headers);

}


Future<http.Response> sendEmail(String email)async{
var url="http://192.168.137.1:5000/sendEmail/";
Map<String,String> headers = {'Accept': 'application/json',"Content-type": "application/json"};
  var body={"email":email};
return await http.post(Uri.encodeFull(url),body: jsonEncode(body),headers: headers);

}

Future<http.Response> signIn(String email,String password)async{
var url="http://192.168.137.1:5000/userauth/signin/";
Map<String,String> headers = {'Accept': 'application/json',"Content-type": "application/json"};
  var body={"email":email,"password":password};
return await http.post(Uri.encodeFull(url),body: jsonEncode(body),headers: headers);

}

Future<http.Response> signUp(String email,String password)async{
var url="http://192.168.137.1:5000/userauth/signup/";
Map<String,String> headers = {'Accept': 'application/json',"Content-type": "application/json"};
  var body={"email":email,"password":password};
return await http.post(Uri.encodeFull(url),body: jsonEncode(body),headers: headers);

}





}