import 'package:chat_app/UI/email_confirmation.dart';
import 'package:chat_app/api.dart';
import 'package:chat_app/core/connectivity_model.dart';
import 'package:chat_app/core/enums.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'offline_page.dart';

class MailVerfication extends StatefulWidget{

  final BuildContext mainContext;
  const MailVerfication({Key key, this.mainContext}) : super(key: key);
  @override
  _MailVerficationState createState() => _MailVerficationState();
}

class _MailVerficationState extends State<MailVerfication> {
  @override

  API api=new API();
  TextEditingController emailfield=new TextEditingController();

    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _isValidForm() {
    final FormState form = _formKey.currentState;
    if (form.validate()) {
      
      form.save();
      return true;
    }
    return false;
  }

  String _email="";
   String _emailvalidator(String email){
    if(email==null||email==""){
      return "Please Enter an email";
    }
  }

void sendemail(BuildContext context)async{
  SharedPreferences prefs=await SharedPreferences.getInstance();
  
  if (_isValidForm()) {
  prefs.setString("email", _email);
  /*api.sendEmail(_email.toString()).then((value) => {
  if(value.statusCode==200){
    
                       
      }
                            
    });*/
    }
}

  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
       var connectionStatus = Provider.of<ConnectivityStatus>(context);
   return connectionStatus == ConnectivityStatus.Offline?OfflinePage():
  Scaffold(
       body: SingleChildScrollView(
              child: Center(

           child: Column(
           
             children: [
               Container(
                 margin: EdgeInsets.only(top: size.height/6),
                 child: Text("Sign up",style: TextStyle(fontSize:size.height/26,fontWeight: FontWeight.w700),)),
               Row(
                 children: [
                   Container(
                     margin: EdgeInsets.only(top: size.height/4.5,left: size.width/9),
                     child: Text("Email address",style: TextStyle(fontSize:size.height/45,fontWeight: FontWeight.w500))),
                 ],
               ),
               Form(
                 key: _formKey,
                    child: Container(
                   margin: EdgeInsets.only(top: size.height/45),
                   width: size.width/1.3,
                   child: TextFormField(
                     validator: _emailvalidator,
                     onSaved: (email)=>_email=email,
                     style: TextStyle(fontSize: size.height/45),
                    decoration: InputDecoration(
                      hintText: "Enter Email",
                      
                    
                    ),
                   ),
                 ),
               ),
              Container(
                margin: EdgeInsets.only(top: size.height/6),
                width: size.height/4,
                height: size.height/15,
                child: MaterialButton(
                  
                  color: Colors.blueAccent,
                  child: Text("Send",style:TextStyle(color: Colors.white) ,),
                  onPressed: ()async{
                    sendemail(context);
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>EmailConfirmation(
                    email:emailfield.text ,
                    mainContext: widget.mainContext,)));  
                    ///navigator should be inside  sendmail if status code check 
                    ///for now it is just for testing
                    
                  //     
                  /*
                */
                
                }),
              )
              
             ],
           ),
         ),
       ),

     
   ); 
   
   
   
 }
}