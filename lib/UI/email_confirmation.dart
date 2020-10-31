import 'package:chat_app/UI/user_signup_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../api.dart';

class EmailConfirmation extends StatefulWidget{
  final String email;
    final PageController pageController;
  const EmailConfirmation({Key key, this.email, this.pageController}) : super(key: key);
  @override
  _EmailConfirmationState createState() => _EmailConfirmationState();
}

class _EmailConfirmationState extends State<EmailConfirmation> with SingleTickerProviderStateMixin {
 AnimationController _animationController;
 Animation<int> animation;
 int _verificationTime=100;
 Duration _verificationDuration;
 TextEditingController codefield=new TextEditingController();
 GlobalKey<ScaffoldState> _globalKey=new GlobalKey<ScaffoldState>();
  API api=new API();
  @override
  void initState() { 
     _animationController=AnimationController(vsync: this,duration: Duration(seconds: _verificationTime));
    _animationController.forward();
    animation=StepTween(
      begin: _verificationTime, // THIS IS A USER ENTERED NUMBER
      end: 0,
    ).animate(_animationController)..addListener(() {setState(() {
      _verificationDuration=new Duration(seconds: animation.value);
    });});
    
    super.initState();
    
  }
   @override
  void dispose() { 
    if(_animationController!=null){
      _animationController.dispose();
    }
     
    super.dispose();
  }
  
   @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: (){
        widget.pageController.jumpToPage(0);
      },
          child: Scaffold(
        key:_globalKey ,
        body: SingleChildScrollView(
                child: Center(
            child: Column(
             
              children: [
                Container(
                  margin: EdgeInsets.only(right: size.width/5,top: size.height/3),
                  child: Text("Verification Code",style:TextStyle(fontSize: size.height/25,fontWeight: FontWeight.w600)),
                ),
                Container(
                  margin: EdgeInsets.only(left: size.width/10,top: size.height/25),
                  child: Text("Please enter the verification code sent to "+"${widget.email}",style: TextStyle(color: Colors.grey),),
                ),
                Container(
                  margin: EdgeInsets.only(top: size.height/20),
                  width: size.width/1.3,
                  child: TextFormField(
                    controller: codefield,
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
                   child: Row(
                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                     children: [
                       Container(
                        
                         child: Text("0${_verificationDuration==null?0:_verificationDuration.inMinutes}:${_verificationDuration==null?0:_verificationDuration.inSeconds.remainder(60)<10?0:""}${_verificationDuration==null?0:_verificationDuration.inSeconds.remainder(60)}",style: TextStyle(fontSize: size.height/20),),

                       ),
                       Container(
                 width: size.height/4,
                height: size.height/15,
                child: MaterialButton(
                        
                        color: Colors.blueAccent,
                        child: Text("${animation.value<=0?"Re-send":"Continue"}",style:TextStyle(color: Colors.white) ,),
                        onPressed: (){
                          widget.pageController.jumpToPage(2);
                          //Navigator.push(context, CupertinoPageRoute(builder: (context)=>UserSignUpPage()));
                             
                       /* if(animation.value==0){
                       api.sendEmail(widget.email).then((value) => {
                          print(value)
                        });
                        }
                        else{
                         //control verification
                         api.verifyEmail(codefield.text.toString(),"walisediqi3@gmail.com").then((value){
                         if(value.statusCode==200){
                           _globalKey.currentState.showSnackBar(SnackBar(content: Text("Account activated with"+ "${widget.email}")));
                         
                         }
                         else{
                           _globalKey.currentState.showSnackBar(SnackBar(content: Text("Failed to verify account")));
                         }

                         } );

                        }*/
                        
                }),
              ),
                     ],
                   ),
                 )
              ],
            ),
          ),
        ),
      ),
    );
  }
}