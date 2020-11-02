import 'package:flutter/material.dart';

class SigninOrSignup extends StatefulWidget{
    final PageController pageController;

  const SigninOrSignup({Key key, this.pageController}) : super(key: key);
  @override
  _SigninOrSignupState createState() => _SigninOrSignupState();
}

class _SigninOrSignupState extends State<SigninOrSignup> {
  @override
  Widget build(BuildContext context) {
   Size size=MediaQuery.of(context).size;
   return Scaffold(
     body: Center(
       child: Container(
         child: Column(
           mainAxisAlignment: MainAxisAlignment.center,
           children: [
             Container(
                     margin: EdgeInsets.only(top: size.height/16),
                    width: size.height/4,
                    height: size.height/15,
                    child: MaterialButton(
            
            color: Colors.blueAccent,
            child: Text("Sign up",style:TextStyle(color: Colors.white) ,),
            onPressed: (){
           
                   widget.pageController.jumpToPage(2);
            //Navigator.push(context, MaterialPageRoute(builder: (context)=>ChatMain()));
                  
                    }),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: size.height/15),
                    child: Text("OR",style: TextStyle(fontSize: size.height/25,fontWeight: FontWeight.w600),),),
                   Container(
                     margin: EdgeInsets.only(top: size.height/12),
                    width: size.height/4,
                    height: size.height/15,
                    child: MaterialButton(
            
            color: Colors.blueAccent,
            child: Text("Sign in",style:TextStyle(color: Colors.white) ,),
            onPressed: (){
           
              widget.pageController.jumpToPage(1);
            //Navigator.push(context, MaterialPageRoute(builder: (context)=>ChatMain()));
                  
                    }),
                  ),
           ],
         ),
       ),
     ),
   );
  }
}