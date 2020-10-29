import 'package:chat_app/UI/email_confirmation.dart';
import 'package:chat_app/api.dart';
import 'package:chat_app/core/connectivity_model.dart';
import 'package:chat_app/core/enums.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'offline_page.dart';

class MailVerfication extends StatefulWidget{
  final PageController pageController;

  const MailVerfication({Key key, this.pageController}) : super(key: key);
  @override
  _MailVerficationState createState() => _MailVerficationState();
}

class _MailVerficationState extends State<MailVerfication> {
  @override

  API api=new API();
  TextEditingController emailfield=new TextEditingController();

  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
      var connectionStatus = Provider.of<ConnectivityStatus>(context);
  
   return Scaffold(
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
               Container(
                 margin: EdgeInsets.only(top: size.height/45),
                 width: size.width/1.3,
                 child: TextFormField(
                   controller: emailfield,
                   style: TextStyle(fontSize: size.height/45),
                  decoration: InputDecoration(
                    hintText: "Enter Email",
                    
                  
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
                  onPressed: (){
                  /*api.sendEmail(emailfield.text.toString()).then((value) => {
                    if(value.statusCode==200){
                        
                    }

                  });*/
                
                //Navigator.push(context, MaterialPageRoute(builder: (context)=>EmailConfirmation()));
                 widget.pageController.jumpToPage(1);
                }),
              )
              
             ],
           ),
         ),
       ),

     
   ); 
   
   
   
 }
}