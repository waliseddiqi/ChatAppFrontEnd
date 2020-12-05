import 'package:chat_app/core/enums.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../api.dart';

class AuthModel extends ChangeNotifier{

Auth auth=Auth.NotAuthicated;
Future<Response> sendAuthreq(){
  API api=new API();
return  api.checkauth();
}


void checkAuth()async{
  SharedPreferences prefs=await SharedPreferences.getInstance();
 String token= prefs.getString("token");

  if(token==null||token==""){
    auth=Auth.NotAuthicated;
    notifyListeners();
  }
  else{
    sendAuthreq().then((value){
      if(value.statusCode==200){
       auth=Auth.Authicated;
        notifyListeners();
      }else{
      auth=Auth.NotAuthicated;
       notifyListeners();
      }
    });

  }


}


}