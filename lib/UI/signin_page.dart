import 'dart:convert';


import 'package:chat_app/UI/email_verification.dart';
import 'package:chat_app/components/loading_indicator.dart';
import 'package:chat_app/core/enums.dart';
import 'package:chat_app/core/locator.dart';
import 'package:chat_app/models/current_state.dart';
import 'package:chat_app/models/signin_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../api.dart';
import '../main.dart';
import 'chat_main.dart';
class SignIn extends StatelessWidget {
   final PageController pageController;
      final BuildContext mainContext;

  const SignIn({Key key, this.pageController, this.mainContext}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (contextx)=>SignInModel(),
          child: Scaffold(
      
      
        body: SignInPage(pageController: pageController,mainContext: mainContext,),
      ),
    );
  }
}
class SignInPage extends StatefulWidget{
      final PageController pageController;
      final BuildContext mainContext;
  
  const SignInPage({Key key, this.pageController, this.mainContext}) : super(key: key);
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignInPage> {

GlobalKey<ScaffoldState> _globalKey=new GlobalKey<ScaffoldState>();
 Size size;
String _email="";
String _password="";
CurrentState currentState=new CurrentState();
API api=new API();

@override
  void initState() {
   
    super.initState();
  }


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
  void _validateAndSubmit(SignInModel signInModel) async {

    if (_isValidForm()) {
    
      signInModel.signIn(_email, _password, context).then((value){
          if(signInModel.signInState==SignInState.Success){
       _globalKey.currentState.showSnackBar(
             SnackBar(
               elevation: 10,
               backgroundColor: Colors.green,
               duration: Duration(seconds: 1),
               content: Text("Login successfully"))
           ).closed.then((value) => {
             Navigator.push(context, MaterialPageRoute(builder: (context)=>ChatMain()))
           });
      }
      else if(signInModel.signInState==SignInState.Failed){
       _globalKey.currentState.showSnackBar(
             SnackBar(
               elevation: 10,
               backgroundColor: Colors.redAccent,
              
               content: Text("Incorrect Password or Email"))
           );
      }
      else if(signInModel.signInState==SignInState.UserNotExits){
        _globalKey.currentState.showSnackBar(
             SnackBar(
               elevation: 10,
               backgroundColor: Colors.yellow,
           
               content: Text("User does not exits",style: TextStyle(color: Colors.black),))
           );
      }
      }).catchError((onError)=>{
        print(onError)
      });
     
    
     
 
       
      }
      
      }
  @override
  Widget build(BuildContext context) {
   size=MediaQuery.of(context).size;
        
      SignInModel model = Provider.of<SignInModel>(context,listen: false);
      var connectionStatus = Provider.of<ConnectivityStatus>(context);
      return
             Scaffold(
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
               
                 child: LoadingIndicator(
                   presentState: model.currentState.presentState,
                   child: RaisedButton (
            color: Colors.blueAccent,
           shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(size.height/15),
           
                   ),
            
            child: Text("Sign in",style:TextStyle(color: Colors.white) ,),
            onPressed: (){
             
                  
              _validateAndSubmit(model);
            /*api.sendEmail(emailfield.text.toString()).then((value) => {
              if(value.statusCode==200){
                
               //   Navigator.push(context, MaterialPageRoute(builder: (context)=>EmailConfirmation()))
              }
                      
            });*/
                   // widget.pageController.jumpToPage(1);
                   //
                   
                   }),
                 ),
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