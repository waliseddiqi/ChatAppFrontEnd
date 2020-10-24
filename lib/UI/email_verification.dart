import 'package:chat_app/api.dart';
import 'package:flutter/material.dart';

class MailVerfication extends StatefulWidget{
  @override
  _MailVerficationState createState() => _MailVerficationState();
}

class _MailVerficationState extends State<MailVerfication> {
  @override

  API api=new API();
  TextEditingController emailfield=new TextEditingController();

  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
   return Scaffold(
     body: Center(

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
              api.sendEmail(emailfield.text.toString()).then((value) => {
                print(value)
              });
            }),
          )
          
         ],
       ),
     ),

   ); 
   
   
   
 }
}