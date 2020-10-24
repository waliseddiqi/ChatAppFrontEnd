import 'package:flutter/material.dart';

class EmailConfirmation extends StatefulWidget{
  @override
  _EmailConfirmationState createState() => _EmailConfirmationState();
}

class _EmailConfirmationState extends State<EmailConfirmation> {
  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
              child: Center(
          child: Column(
           
            children: [
              Container(
                margin: EdgeInsets.only(right: size.width/5,top: size.height/3),
                child: Text("Verification Code",style:TextStyle(fontSize: size.height/25,fontWeight: FontWeight.w600)),
              ),
              Container(
                margin: EdgeInsets.only(top: size.height/20),
                width: size.width/1.3,
                child: TextFormField(
                  maxLength: 6,
                  keyboardType: TextInputType.number,
                  style: TextStyle(letterSpacing: size.height/35,fontSize: size.height/15
                  ,decoration: TextDecoration.none),
                 decoration: InputDecoration(
                   hintText: "Enter Code",
                   hintStyle: TextStyle(fontSize: size.height/35,letterSpacing: 0)
                 ),
                ),
              ),
               Container(
              margin: EdgeInsets.only(top: size.height/6),
              width: size.height/4,
              height: size.height/15,
              child: MaterialButton(
                
                color: Colors.blueAccent,
                child: Text("Continue",style:TextStyle(color: Colors.white) ,),
                onPressed: (){
                /*api.sendEmail(emailfield.text.toString()).then((value) => {
                  print(value)
                });*/
                
              }),
            )
            ],
          ),
        ),
      ),
    );
  }
}