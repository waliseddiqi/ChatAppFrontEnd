import 'package:chat_app/UI/email_verification.dart';
import 'package:chat_app/core/enums.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../api.dart';
import 'chat_main.dart';

class SignIn extends StatefulWidget{
      final PageController pageController;
      final BuildContext mainContext;
  const SignIn({Key key, this.pageController, this.mainContext}) : super(key: key);
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

GlobalKey<ScaffoldState> _globalKey=new GlobalKey<ScaffoldState>();
 Size size;
String _email="";
String _password="";

API api=new API();




 final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
String _emailFieldValidator(String name){
    if(name==null||name==""){
      return "Please Enter your name";
    }
  }
String _passwordFieldValidator(String name){
    if(name==null||name==""){
      return "Please Enter your name";
    }
  }
  bool _isValidForm() {
    final FormState form = _formKey.currentState;
    if (form.validate()) {
      
      form.save();
      return true;
    }
    return false;
  }
  void _validateAndSubmit() async {

    if (_isValidForm()) {
        api.signIn(_email, _password).then((value) => {
          if(value.statusCode==200){
            //print("Login successfully")
           _globalKey.currentState.showSnackBar(
             SnackBar(
               elevation: 10,
               backgroundColor: Colors.green,
               duration: Duration(seconds: 1),
               content: Text("Login successfully"))
           ).closed.then((value) => {
             Navigator.push(context, MaterialPageRoute(builder: (context)=>ChatMain()))
           })
           
          }
          else if(value.statusCode==401){
            //print("Wrong password")
             _globalKey.currentState.showSnackBar(
             SnackBar(
               elevation: 10,
               backgroundColor: Colors.redAccent,
              
               content: Text("Incorrect Password or Email"))
           )
          }
          else{
            //print("user does not exits")
             _globalKey.currentState.showSnackBar(
             SnackBar(
               elevation: 10,
               backgroundColor: Colors.yellow,
           
               content: Text("User does not exits",style: TextStyle(color: Colors.black),))
           )
          }
          //if empty then user doesnt exits
          //if false wrong password
          //if true then everything alright
          //else nothing there should an error from server or database
        });
       
      }}
  @override
  Widget build(BuildContext context) {
   size=MediaQuery.of(context).size;
      var connectionStatus = Provider.of<ConnectivityStatus>(context);
      return Scaffold(
        key: _globalKey,
       body: SingleChildScrollView(
              child: Center(

           child: Form(
             key: _formKey,
                        child: Column(
             
               children: [
                 Container(
                   margin: EdgeInsets.only(top: size.height/6),
                   child: Text("Sign in",style: TextStyle(fontSize:size.height/26,fontWeight: FontWeight.w700),)),
                 Row(
                   children: [
                     Container(
                       margin: EdgeInsets.only(top: size.height/10,left: size.width/9),
                       child: Text("Email address",style: TextStyle(fontSize:size.height/45,fontWeight: FontWeight.w500))),
                   ],
                 ),
                 Container(
                   margin: EdgeInsets.only(top: size.height/45),
                   width: size.width/1.3,
                   child: TextFormField(
                     onSaved: (email)=>_email=email,
                     //controller: emailfield,
                     validator: _emailFieldValidator,
                     style: TextStyle(fontSize: size.height/45),
                    decoration: InputDecoration(
                      hintText: "Enter Email",
                      
                    
                    ),
                   ),
                 ),
                 Row(
                   children: [
                     Container(
                       margin: EdgeInsets.only(top: size.height/15,left: size.width/9),
                       child: Text("Password",style: TextStyle(fontSize:size.height/45,fontWeight: FontWeight.w500))),
                   ],
                 ),
                 Container(
                   margin: EdgeInsets.only(top: size.height/45),
                   width: size.width/1.3,
                   child: TextFormField(
                     onSaved: (password)=>_password=password,
                     //controller: emailfield,
                     obscureText: true,
                     validator: _passwordFieldValidator,
                     style: TextStyle(fontSize: size.height/45),
                    decoration: InputDecoration(
                      hintText: "Enter Password",
                      
                    
                    ),
                   ),
                 ),
                 GestureDetector(
                 child: Container(
                      margin: EdgeInsets.only(top: size.height/160,left: size.width/2.22),
                        child: Text("Forgot Password ?",style: TextStyle(fontSize: size.height/50,fontWeight: FontWeight.w600)),
                   ),
                 ),
                Container(
                  margin: EdgeInsets.only(top: size.height/18),
                  width: size.height/4.4,
                  height: size.height/13,
                
                  child: RaisedButton(
                   shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(size.height/15),
                   
                  ),
                    color: Colors.blueAccent,
                    child: Text("Sign in",style:TextStyle(color: Colors.white) ,),
                    onPressed: (){
                      _validateAndSubmit();
                    /*api.sendEmail(emailfield.text.toString()).then((value) => {
                      if(value.statusCode==200){
                        
                       //   Navigator.push(context, MaterialPageRoute(builder: (context)=>EmailConfirmation()))
                      }
                              
                    });*/
                  // widget.pageController.jumpToPage(1);
                  //
                  
                  }),
                ),
                 GestureDetector(
                 child: Container(
                      margin: EdgeInsets.only(top: size.height/14),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Don't have an account?",style: TextStyle(fontSize: size.height/45,fontWeight: FontWeight.w600)),
                            InkWell(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>MailVerfication(mainContext:widget.mainContext,)));
                              },
                              child: Text(" Sign up here",style: TextStyle(fontSize: size.height/45,fontWeight: FontWeight.w600,color: Colors.blue))),
                          ],
                        ),
                   ),
                 ),
                 
               ],
             ),
           ),
         ),
       ),

     
   ); 
  }
}